Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2D2A16280B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 15:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgBROXK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 09:23:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29689 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726546AbgBROXJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582035787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yanaYNgQLH0uUtud3acbkiI6ejUUQwCJBKP2V2ns7X8=;
        b=MXSKRDwEMF60TiOky73pvdM5NbpTpiCe1muuMvEq+lFHzRCsMpZC4zGFmv+irnNpeOr4DH
        0f3J7FkmGHOFj/mdMYbTUv4sLBdl4TXxP8YT9Rp0ajAJIqkrv/FT1YRJtYFqwvv7w+nXs4
        l2l5qNatGTsjXOUt4ywcDbmdsX+6OWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-BocrCsN1P4KXbaY1-CgJdQ-1; Tue, 18 Feb 2020 09:23:02 -0500
X-MC-Unique: BocrCsN1P4KXbaY1-CgJdQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CA66107ACC5;
        Tue, 18 Feb 2020 14:23:00 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CAD0100164D;
        Tue, 18 Feb 2020 14:22:59 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 00/12] Enable per-file/directory DAX operations V3
References: <20200213190156.GA22854@iweiny-DESK2.sc.intel.com>
        <20200213190513.GB22854@iweiny-DESK2.sc.intel.com>
        <20200213195839.GG6870@magnolia>
        <20200213232923.GC22854@iweiny-DESK2.sc.intel.com>
        <CAPcyv4hkWoC+xCqicH1DWzmU2DcpY0at_A6HaBsrdLbZ6qzWow@mail.gmail.com>
        <20200214200607.GA18593@iweiny-DESK2.sc.intel.com>
        <x4936bcdfso.fsf@segfault.boston.devel.redhat.com>
        <20200214215759.GA20548@iweiny-DESK2.sc.intel.com>
        <x49y2t4bz8t.fsf@segfault.boston.devel.redhat.com>
        <x49tv3sbwu5.fsf@segfault.boston.devel.redhat.com>
        <20200218023535.GA14509@iweiny-DESK2.sc.intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Tue, 18 Feb 2020 09:22:58 -0500
In-Reply-To: <20200218023535.GA14509@iweiny-DESK2.sc.intel.com> (Ira Weiny's
        message of "Mon, 17 Feb 2020 18:35:36 -0800")
Message-ID: <x49zhdgasal.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ira Weiny <ira.weiny@intel.com> writes:

> Yep...  and a long weekend if you are in the US...  I ran the test with V4 and
> got the panic below.
>
> Is this similar to what you see?  If so I'll work on it in V4.  FWIW with '-o

Yes, precisely.

> dax' specified I don't see how fsstress is causing an issue with my patch set.
> Does fsstress attempt to change dax states?  I don't see that in the test but
> I'm not real familiar with generic/013 and fsstress.

Not that I'm aware of, no.

> If my disassembly of read_pages is correct it looks like readpage is null which
> makes sense because all files should be IS_DAX() == true due to the mount option...
>
> But tracing code indicates that the patch:
>
> 	fs: remove unneeded IS_DAX() check
>
> ... may be the culprit and the following fix may work...
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 3a7863ba51b9..7eaf74a2a39b 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2257,7 +2257,7 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>         if (!count)
>                 goto out; /* skip atime */
>  
> -       if (iocb->ki_flags & IOCB_DIRECT) {
> +       if (iocb->ki_flags & IOCB_DIRECT || IS_DAX(inode)) {
>                 struct file *file = iocb->ki_filp;
>                 struct address_space *mapping = file->f_mapping;
>                 struct inode *inode = mapping->host;

Well, you'll have to up-level the inode variable instantiation,
obviously.  That solves this particular issue.  The next traceback
you'll hit is in the writeback path:

[  116.044545] ------------[ cut here ]------------
[  116.049163] WARNING: CPU: 48 PID: 4469 at fs/dax.c:862 dax_writeback_mapping_range+0x397/0x530
...
[  116.134509] CPU: 48 PID: 4469 Comm: fsstress Not tainted 5.6.0-rc1+ #43
[  116.141121] Hardware name: Intel Corporation S2600WFD/S2600WFD, BIOS SE5C620.86B.0D.01.0395.022720191340 02/27/2019
[  116.151549] RIP: 0010:dax_writeback_mapping_range+0x397/0x530
[  116.157294] Code: ff ff 31 db 48 8b 7c 24 28 c6 07 00 0f 1f 40 00 fb 48 8b 7c 24 10 e8 98 fc 29 00 0f 1f 44 00 00 e9 f1 fc ff ff 4c 8b 64 24 08 <0f> 0b be fb ff ff ff 4c 89 e7 e8 fa 87 ed ff f0 41 80 8c 24 80 00
[  116.176036] RSP: 0018:ffffb9b162fa7c18 EFLAGS: 00010046
[  116.181261] RAX: 0000000000000000 RBX: 00000000000001ac RCX: 0000000000000020
[  116.188387] RDX: 0000000000000000 RSI: 00000000000001ac RDI: ffffb9b162fa7c40
[  116.195519] RBP: 0000000000000020 R08: ffff9a73dc24d6b0 R09: 0000000000000020
[  116.202648] R10: 0000000000000000 R11: 0000000000000238 R12: ffff9a73d92c66b8
[  116.209774] R13: ffffe4a09f0cb200 R14: 0000000000000000 R15: ffffe4a09f0cb200
[  116.216907] FS:  00007f2dbcd22b80(0000) GS:ffff9a7420c00000(0000) knlGS:0000000000000000
[  116.224992] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  116.230735] CR2: 00007fa21808b648 CR3: 000000179e0a2003 CR4: 00000000007606e0
[  116.237860] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  116.244990] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  116.252115] PKRU: 55555554
[  116.254827] Call Trace:
[  116.257286]  do_writepages+0x41/0xd0
[  116.260862]  __filemap_fdatawrite_range+0xcb/0x100
[  116.265653]  filemap_write_and_wait_range+0x38/0x90
[  116.270579]  xfs_setattr_size+0x2c2/0x3e0 [xfs]
[  116.275126]  xfs_file_fallocate+0x239/0x440 [xfs]
[  116.279831]  ? selinux_file_permission+0x108/0x140
[  116.284622]  vfs_fallocate+0x14d/0x2f0
[  116.288374]  ksys_fallocate+0x3c/0x80
[  116.292039]  __x64_sys_fallocate+0x1a/0x20
[  116.296139]  do_syscall_64+0x55/0x1d0
[  116.299806]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  116.304856] RIP: 0033:0x7f2dbc21983b
[  116.308435] Code: ff ff eb ba 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 8d 05 25 0e 2d 00 49 89 ca 8b 00 85 c0 75 14 b8 1d 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 5d c3 0f 1f 40 00 41 55 49 89 cd 41 54 49 89

That's here:

        /*
         * A page got tagged dirty in DAX mapping? Something is seriously
         * wrong.
         */
        if (WARN_ON(!xa_is_value(entry)))
                return -EIO;

Cheers,
Jeff

