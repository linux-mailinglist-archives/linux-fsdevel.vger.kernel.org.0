Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6210631116F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 20:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbhBESCg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 13:02:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39170 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233212AbhBEPWo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612544545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2q18CzBcxJvAu8Vj/9Xv+8eYOiYLfIpMMBqp/lRA8Jc=;
        b=IDrxZfcNiZD0hDja8hPAhsKhWkuqBTlxZ0+c7WVhrwiqhS3ISNphI5YicgYwsdnX+FFjnr
        AIPKgHu+b37wY7rNX11/uWdxovShduqHor/J79vUS2bzK80MI1ZZUpdOQ1d7Q1yVpQyASg
        Quc5jO1pqDb/jhV8hzoXlFWHjnckao4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-Ui2ao1J7MTWjBnKX2-SeOQ-1; Fri, 05 Feb 2021 12:02:24 -0500
X-MC-Unique: Ui2ao1J7MTWjBnKX2-SeOQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD1AE100A625;
        Fri,  5 Feb 2021 17:02:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D00E1A353;
        Fri,  5 Feb 2021 17:02:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cachefs@redhat.com, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Upcoming for next merge window: fscache and netfs lib
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 05 Feb 2021 17:02:14 +0000
Message-ID: <2522190.1612544534@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Linus,

To apprise you in advance, I'm intending to submit a pull request for a
partial modernisation of the fscache I/O subsystem, which can be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/=
?h=3Dfscache-next

The main parts of it are:

 (1) Institute a helper library for network filesystems.  The first stage of
     this handles ->readpage(), ->readahead() and part of ->write_begin() on
     behalf of the netfs, requiring the netfs to provide a vector to perfor=
m a
     read to some part of an inode.

     This allows handling of the following to be (at least partially) moved
     out of all the network filesystems and consolidated in one place:

	- changes in VM vectors (Matthew Wilcox's Grand Plans=E2=84=A2;-)
	  - transparent huge page support
	- shaping of reads
	  - readahead expansion
	  - fs alignment/granularity (ceph, pnfs)
	  - cache alignment/granularity
	- slicing of reads
	  - rsize
	  - keeping multiple read in flight	} Steve French would like
	  - multichannel distribution		} but for the future
	  - multiserver distribution (ceph, pnfs)
	  - stitching together reads from the cache and reads from the network
	- saving data read from the server into the cache
	- retry/reissue handling
	  - fallback after cache failure
     	- short reads
	- fscrypt data decryption (Jeff Layton is considering for the future)

 (2) Add an alternate cache I/O API for use with the netfs lib that makes u=
se
     of kiocbs in the cache to do direct I/O between the cache files and the
     netfs pages.

     This is intended to replace the current I/O API that calls the backing=
 fs
     readpage op and than snooping the wait queues for completion to read a=
nd
     using vfs_write() to write.  It wasn't possible to do in-kernel DIO wh=
en
     I first wrote cachefiles - and this makes it a lot simpler and more
     robust (and uses a lot less memory).

 (3) Add an ITER_XARRAY iov_iter that allows I/O iteration to be done on an
     xarray of pinned pages (such as inode->i_mapping->i_pages), thereby
     avoiding the need to allocate a bvec array to represent this.

     This is used to present a set of netfs pages to the cache to do DIO on
     and is also used by afs to present netfs pages to sendmsg.  It could a=
lso
     be used by unencrypted cifs to pass the pages to the TCP socket it uses
     (if it's doing TCP) and my patch for 9p (which isn't included here) can
     make use of it.

 (4) Make afs use the above.  It passes the same xfstests (and has the same
     failures) as the unpatched afs client.

 (5) Make ceph use the above (I've merged a branch from Jeff Layton for thi=
s).
     This also passes xfstests.

Dave Wysochanski has a patch series for nfs.  Normal nfs works fine and pas=
ses
various tests, but it turned out pnfs has a problem - pnfs does splitting of
requests itself and sending them to various places, but it needs to coopera=
te
more closely with netfs over this.  He's working on this.

I've given Dominique Martinet a patch for 9p and Steve French a partial pat=
ch
for cifs, but neither of those is going to be ready this merge window eithe=
r.

-~-

Assuming you're willing to take this, should I submit one pull request for =
the
combined lot, or should I break it up into smaller requests (say with a
separate request from Jeff for the ceph stuff).

If we can get the netfs lib in this merge window, that simplifies dealing w=
ith
nfs and cifs particularly as the changes specific to those can go through t=
he
maintainer trees.

Thanks,
David

