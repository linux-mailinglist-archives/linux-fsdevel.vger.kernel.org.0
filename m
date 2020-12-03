Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3B82CD8AD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 15:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbgLCOM5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 09:12:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46991 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726318AbgLCOM5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:12:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607004689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GcnOI0m9SqcjJYsZ5V6OUFjXtmVpOmCdcIaYgIDWnfQ=;
        b=EHciwmPHl1SCq0AlSiNOeBgTacUB0t7B4HMCtDPCPB1G68veJT6ysWH34vu4C5ZO4SgfPW
        cUtclP3a0vpYSy/7PC51lg5fBG5Aq4q2c5hdyCFNizJzkiWU3YVBWyu+6Aj4j9lOOcFsdJ
        ZOm0STbl7+PM9izXxdiJnSqq4vP3+eA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-FRuE2rnFPxOBYSZsCMRKvw-1; Thu, 03 Dec 2020 09:11:25 -0500
X-MC-Unique: FRuE2rnFPxOBYSZsCMRKvw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 366CB1006C98;
        Thu,  3 Dec 2020 14:11:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-159.rdu2.redhat.com [10.10.112.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 826085DA30;
        Thu,  3 Dec 2020 14:10:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
cc:     dhowells@redhat.com, jlayton@redhat.com,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        dchinner@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com
Subject: Problems doing DIO to netfs cache on XFS from Ceph
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <914679.1607004656.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 03 Dec 2020 14:10:56 +0000
Message-ID: <914680.1607004656@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

We're having a problem making the fscache/cachefiles rewrite work with XFS=
, if
you could have a look?  Jeff Layton just tripped the attached warning from
this:

	/*
	 * Given that we do not allow direct reclaim to call us, we should
	 * never be called in a recursive filesystem reclaim context.
	 */
	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
		goto redirty;

The chain of events is the following:

 (1) Ceph is asked to do an ordinary write by userspace.  It calls the fsc=
ache
     netfs_write_begin() helper to read the region it's going to modify so
     that the cache can be preloaded.

 (2) In this case, the cache already has it, so cachefiles_read() dispatch=
es
     an async DIO read to the backing filesystem (in this case XFS).

 (3) iomap, on behalf of XFS, flushes the pagecache attached to the backin=
g
     inode, which appears to be populated, causing do_writepages() to run.

 (4) The XFS write-out eventually wends its way to iomap_do_writepage(), w=
hich
     complains about NOFS being set and cancels the write.

Now, I'm doing:

	old_nofs =3D memalloc_nofs_save();
	ret =3D call_read_iter(file, &ki->iocb, iter);
	memalloc_nofs_restore(old_nofs);

in cachefiles_read() to prevent the cache causing writeout in the netfs to
occur.  Possibly overriding NOFS here is overkill and is only really neces=
sary
in cachefiles_write() - which can be called from netfs writeback.
cachefiles_read() should only be called from netfs ->readpage(), ->readahe=
ad()
and ->write_begin() and maybe a workqueue in the case that the cache retur=
ns a
short read.

Note that I'm only doing async DIO reads and writes, so I was a bit surpri=
sed
that XFS is doing a writeback at all - but I guess that IOCB_DIRECT is
actually just a hint and the filesystem can turn it into buffered I/O if i=
t
wants.

Thanks,
David
---
 WARNING: CPU: 6 PID: 7412 at fs/iomap/buffered-io.c:1465 iomap_do_writepa=
ge+0x76a/0x8b0
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-1.fc33 04=
/01/2014
 RIP: 0010:iomap_do_writepage+0x76a/0x8b0
 Code: 89 f5 41 89 c7 48 83 7d 48 00 0f 85 6e fb ff ff 48 8b 44 24 48 48 8=
d 5c 24 48 48 39 d8 0f 84 5b fb ff ff 0f 0b e9 54 fb ff ff <0f> 0b e9 76 f=
f ff ff 0f 0b e9 64 fb ff ff 0f 0b e9 9a fb ff ff 0f
 RSP: 0018:ffffb19b4155f6e0 EFLAGS: 00010206
 RAX: 0000000000440100 RBX: ffffb19b4155f7a8 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: ffffb19b4155f940 RDI: ffffd1e484446740
 RBP: ffffb19b4155f868 R08: ffffffffffffffff R09: 0000000000030360
 R10: 0000000000000002 R11: 0000000000000006 R12: ffff8a5108ad4d30
 R13: 0000000000002a9a R14: ffffb19b4155f7b0 R15: ffffd1e484446740
 FS:  00007f6ff479d740(0000) GS:ffff8a542fb80000(0000) knlGS:0000000000000=
000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000fc02a8 CR3: 000000013b218000 CR4: 00000000003506e0
 Call Trace:
  ? page_referenced_one+0x150/0x150
  ? __mod_memcg_lruvec_state+0x21/0xe0
  ? clear_page_dirty_for_io+0xf1/0x240
  write_cache_pages+0x186/0x3d0
  ? iomap_readahead+0x1b0/0x1b0
  ? blk_mq_submit_bio+0x2ee/0x4f0
  ? elv_rb_del+0x1f/0x30
  ? deadline_remove_request+0x55/0xb0
  ? dd_dispatch_request+0x151/0x210
  iomap_writepages+0x1c/0x40
  xfs_vm_writepages+0x56/0x70 [xfs]
  do_writepages+0x28/0xa0
  ? xfs_iunlock+0xa3/0xe0 [xfs]
  ? wbc_attach_and_unlock_inode+0xb5/0x140
  __filemap_fdatawrite_range+0xa7/0xe0
  filemap_write_and_wait_range+0x3d/0x90
  __iomap_dio_rw+0x149/0x490
  iomap_dio_rw+0xe/0x30
  xfs_file_dio_aio_read+0xb9/0x100 [xfs]
  xfs_file_read_iter+0xba/0xd0 [xfs]
  cachefiles_read+0x1ee/0x3f0 [cachefiles]
  ? netfs_subreq_terminated+0x240/0x240 [netfs]
  netfs_read_from_cache+0x70/0x80 [netfs]
  netfs_rreq_submit_slice+0x169/0x310 [netfs]
  netfs_write_begin+0x4e4/0x6a0 [netfs]
  ? ceph_put_fmode+0x43/0xd0 [ceph]
  ceph_write_begin+0x141/0x250 [ceph]
  generic_perform_write+0xaf/0x190
  ceph_write_iter+0xab6/0xc90 [ceph]
  ? _cond_resched+0x16/0x40
  ? __ceph_setattr+0x895/0x960 [ceph]
  ? new_sync_write+0x108/0x180
  new_sync_write+0x108/0x180
  vfs_write+0x1bc/0x270
  ksys_write+0x4f/0xc0
  do_syscall_64+0x33/0x40
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

