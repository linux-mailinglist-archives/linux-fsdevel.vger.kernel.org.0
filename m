Return-Path: <linux-fsdevel+bounces-73902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 832F2D234F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 09:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A42B3098BD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 08:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313B933FE12;
	Thu, 15 Jan 2026 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CgrlSOPv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0B2335074
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768467322; cv=none; b=W8RwehNu5NFWmCl/qVuOWBw1/mDy9rjWlrQPw591JIA2CjbOXrpRyQ7v2dMG+cmVII1mIE2ySxWLgOVhP3VN0eISj7lcWZj4+gSzE0cmVKTq7aSN1n8eaHf1FRZwMsOXv1OOVbOPWsS/5VJG0pMmDZwJ7Jb4KdEfsfbKeTV1yRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768467322; c=relaxed/simple;
	bh=ffj/jRTGzTCOVYgGqmN2gY/iOTYh7jIS8TI0C1aMKjY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uJcaRCFv8U7rgNUgWTpPhHpZYLkkEVvbPu6l2Pu2Bq5QTnwit5W/s+qUPavkjjBNsks6j+0bkSUpqpPex40QBvGD3au39W+Z+ikHWJY/EUpWLF4YRd+SdPf7wMrbnlbwRJWp6nTLI10CrPq8k2xHaLcbqT2hXaImm3m+zsEDwdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CgrlSOPv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768467320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=np0kZryYhlNwz2DI8X6SSdFuDYHtUMZFO1fEp73uKrI=;
	b=CgrlSOPvCvovLxqOLqbuGREzVimL3MonOaEsZCBPcSiRgde7L5xIQUJBGfcoC07jRVAbIu
	yYGsOzRuSBAvkrDlblPOhRZm7hHY66o/sov0SInp6w+MLZ5+a4wEx04IjidQOG4OGHRZqT
	CwdyEMIIvH/jAzFhfepY6bDoIIoha3E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-xk91a9JvM1ioxjdG4pfkiA-1; Thu,
 15 Jan 2026 03:55:16 -0500
X-MC-Unique: xk91a9JvM1ioxjdG4pfkiA-1
X-Mimecast-MFC-AGG-ID: xk91a9JvM1ioxjdG4pfkiA_1768467315
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FFB21954B0C;
	Thu, 15 Jan 2026 08:55:15 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.45.224.202])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 129EE1955F22;
	Thu, 15 Jan 2026 08:55:12 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,  linux-api@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Al Viro <viro@zeniv.linux.org.uk>,  David
 Howells <dhowells@redhat.com>,  DJ Delorie <dj@redhat.com>
Subject: Re: O_CLOEXEC use for OPEN_TREE_CLOEXEC
In-Reply-To: <20260114-alias-riefen-2cb8c09d0ded@brauner> (Christian Brauner's
	message of "Wed, 14 Jan 2026 17:03:17 +0100")
References: <lhupl7dcf0o.fsf@oldenburg.str.redhat.com>
	<20260114-alias-riefen-2cb8c09d0ded@brauner>
Date: Thu, 15 Jan 2026 09:55:10 +0100
Message-ID: <lhuwm1ji7bl.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

* Christian Brauner:

> On Tue, Jan 13, 2026 at 11:40:55PM +0100, Florian Weimer wrote:
>> In <linux/mount.h>, we have this:
>> 
>> #define OPEN_TREE_CLOEXEC      O_CLOEXEC       /* Close the file on execve() */
>> 
>> This causes a few pain points for us to on the glibc side when we mirror
>> this into <linux/mount.h> becuse O_CLOEXEC is defined in <fcntl.h>,
>> which is one of the headers that's completely incompatible with the UAPI
>> headers.
>> 
>> The reason why this is painful is because O_CLOEXEC has at least three
>> different values across architectures: 0x80000, 0x200000, 0x400000
>> 
>> Even for the UAPI this isn't ideal because it effectively burns three
>> open_tree flags, unless the flags are made architecture-specific, too.
>
> I think that just got cargo-culted... A long time ago some API define as
> O_CLOEXEC and now a lot of APIs have done the same.

Yes, it looks like inotify is in the same boat.

> I'm pretty sure we can't change that now but we can document that this
> shouldn't be ifdefed and instead be a separate per-syscall bit. But I
> think that's the best we can do right now.

Maybe add something like this as a safety measure, to ensure that the
flags don't overlap?

diff --git a/fs/namespace.c b/fs/namespace.c
index c58674a20cad..5bbfd379ec44 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3069,6 +3069,9 @@ static struct file *vfs_open_tree(int dfd, const char __user *filename, unsigned
 	bool detached = flags & OPEN_TREE_CLONE;
 
 	BUILD_BUG_ON(OPEN_TREE_CLOEXEC != O_CLOEXEC);
+	BUILD_BUG_IN(!(O_CLOEXEC & OPEN_TREE_CLONE));
+	BUILD_BUG_ON(!((AT_EMPTY_PATH | AT_NO_AUTOMOUNT | AT_RECURSIVE | AT_SYMLINK_NOFOLLOW) &
+		       (O_CLOEXEC | OPEN_TREE_CLONE)));
 
 	if (flags & ~(AT_EMPTY_PATH | AT_NO_AUTOMOUNT | AT_RECURSIVE |
 		      AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLONE |
@@ -3100,7 +3103,7 @@ static struct file *vfs_open_tree(int dfd, const char __user *filename, unsigned
 
 SYSCALL_DEFINE3(open_tree, int, dfd, const char __user *, filename, unsigned, flags)
 {
-	return FD_ADD(flags, vfs_open_tree(dfd, filename, flags));
+	return FD_ADD(flags & O_CLOEXEC, vfs_open_tree(dfd, filename, flags));
 }
 
 /*

(Completely untested.)

Passing the mix of flags to FD_ADD isn't really future-proof if FD_ADD
ever recognizes more than just O_CLOEXEC.

Thanks,
Florian


