Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D3340F618
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 12:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343790AbhIQKp2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 06:45:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50428 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243599AbhIQKp2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 06:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631875446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yjuq7cya6/eyxY3obyZMZVApt3mSJBG4rSl0Zko1nXM=;
        b=dEApWvJwtHf8aDxi7KJ1S3xWjCJ6jl6fjGkDW7Xv+ohGluRQKb+/BB6g+JnmwOSUiFRftk
        ltq1pg6L0Kc25cKXgtqizUCqTrgqxYpjoIF5qcMV2MgLz8PBmaQBgZv6N6vx8LnKDH/4/x
        ObcROL6LpjYEmRFlVbqDAAd386i4Z94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-TEXMi8FGMg6vAtTUIBCiIQ-1; Fri, 17 Sep 2021 06:44:03 -0400
X-MC-Unique: TEXMi8FGMg6vAtTUIBCiIQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B75B1835DE0;
        Fri, 17 Sep 2021 10:44:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C014760583;
        Fri, 17 Sep 2021 10:44:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2315872.1631874463@warthog.procyon.org.uk>
References: <2315872.1631874463@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Could we get an IOCB_NO_READ_HOLE?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2349283.1631875439.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 17 Sep 2021 11:43:59 +0100
Message-ID: <2349284.1631875439@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> Would it be possible to get an IOCB_NO_READ_HOLE flag that causes a read=
 to
> either fail entirely if there's a hole in the file or to stop at the hol=
e,
> possibly returning -ENODATA if the hole is at the front of the file?
> =

> Looking at iomap_dio_iter(), IOMAP_HOLE should be enabled in
> iomap_iter::iomap.type for this?  Is it that simple?

Actually, that's not the right thing.  How about the attached - at least f=
or
direct I/O?

David
---
commit 522d2834f9994b82b1fa1f1eeeb48ede16b327c7
Author: David Howells <dhowells@redhat.com>
Date:   Fri Sep 17 11:33:41 2021 +0100

    iomap: Implement IOCB_NO_READ_HOLE

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 4ecd255e0511..d2309dec27c4 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -18,6 +18,7 @@
  * Private flags for iomap_dio, must not overlap with the public ones in
  * iomap.h:
  */
+#define IOMAP_DIO_NO_READ_HOLE	(1 << 27)
 #define IOMAP_DIO_WRITE_FUA	(1 << 28)
 #define IOMAP_DIO_NEED_SYNC	(1 << 29)
 #define IOMAP_DIO_WRITE		(1 << 30)
@@ -412,6 +413,8 @@ static loff_t iomap_dio_iter(const struct iomap_iter *=
iter,
 	case IOMAP_HOLE:
 		if (WARN_ON_ONCE(dio->flags & IOMAP_DIO_WRITE))
 			return -EIO;
+		if (dio->flags & IOMAP_DIO_NO_READ_HOLE)
+			return dio->size ? 0 : -ENODATA;
 		return iomap_dio_hole_iter(iter, dio);
 	case IOMAP_UNWRITTEN:
 		if (!(dio->flags & IOMAP_DIO_WRITE))
@@ -503,6 +506,8 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *it=
er,
 =

 		if (iter_is_iovec(iter))
 			dio->flags |=3D IOMAP_DIO_DIRTY;
+		if (iocb->ki_flags & IOCB_NO_READ_HOLE)
+			dio->flags |=3D IOMAP_DIO_NO_READ_HOLE;
 	} else {
 		iomi.flags |=3D IOMAP_WRITE;
 		dio->flags |=3D IOMAP_DIO_WRITE;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e7a633353fd2..f4c8ca22531d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -321,6 +321,7 @@ enum rw_hint {
 #define IOCB_NOIO		(1 << 20)
 /* can use bio alloc cache */
 #define IOCB_ALLOC_CACHE	(1 << 21)
+#define IOCB_NO_READ_HOLE	(1 << 22)	/* Don't read from a hole */
 =

 struct kiocb {
 	struct file		*ki_filp;

