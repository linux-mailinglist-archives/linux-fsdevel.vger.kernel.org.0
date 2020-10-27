Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1D329A874
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 10:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896269AbgJ0Jwo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 05:52:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41450 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2896055AbgJ0Jvo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603792303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rrv3C5Vep+wn0rySiLlJrRnX0hreOKaKWDeUz2ECss4=;
        b=C9gXSNCIbf5ce9sTr53R23I0nspkYAbEhOC75ZdWb530sQpxLgNS/77SnbfAAQe4YWCIwV
        NkS/ta/o0m9rtjaTaF8StLlQVsCgC1tnUBeWGOYJHnu4u7g1IdomovqzxowjkeEVkLPTPl
        UbBCwper0XTm4MYaqlous2m8Z2dnwzs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-rgOUAKfoPsulfa3-RIkuKw-1; Tue, 27 Oct 2020 05:51:39 -0400
X-MC-Unique: rgOUAKfoPsulfa3-RIkuKw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C11C1074645;
        Tue, 27 Oct 2020 09:51:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 163CC19646;
        Tue, 27 Oct 2020 09:51:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <3088368.1603790984@warthog.procyon.org.uk>
References: <3088368.1603790984@warthog.procyon.org.uk> <20200827150030.282762-3-hch@lst.de> <20200827150030.282762-1-hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 02/10] fs: don't allow splice read/write without explicit ops
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3155817.1603792294.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 27 Oct 2020 09:51:34 +0000
Message-ID: <3155818.1603792294@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> > default_file_splice_write is the last piece of generic code that uses
> > set_fs to make the uaccess routines operate on kernel pointers.  It
> > implements a "fallback loop" for splicing from files that do not actua=
lly
> > provide a proper splice_read method.  The usual file systems and other
> > high bandwith instances all provide a ->splice_read, so this just remo=
ves
> > support for various device drivers and procfs/debugfs files.  If splic=
e
> > support for any of those turns out to be important it can be added bac=
k
> > by switching them to the iter ops and using generic_file_splice_read.
> =

> Hmmm...  this causes the copy_file_range() syscall to fail with EINVAL i=
n some
> places where before it used to work.
> =

> For my part, it causes the generic/112 xfstest to fail with afs, but the=
re may
> be other places.
> =

> Is this a regression we need to fix in the VFS core?  Or is it something=
 we
> need to fix in xfstests and assume userspace will fallback to doing it i=
tself?

That said, for afs at least, the fix seems to be just this:

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 395075d7fe02..2bc6adfe351a 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -33,6 +33,7 @@ const struct file_operations afs_file_operations =3D {
 	.write_iter	=3D afs_file_write,
 	.mmap		=3D afs_file_mmap,
 	.splice_read	=3D generic_file_splice_read,
+	.splice_write	=3D iter_file_splice_write,
 	.fsync		=3D afs_fsync,
 	.lock		=3D afs_lock,
 	.flock		=3D afs_flock,

David

