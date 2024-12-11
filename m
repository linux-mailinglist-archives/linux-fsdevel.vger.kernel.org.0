Return-Path: <linux-fsdevel+bounces-37097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D693E9ED810
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 22:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5430281365
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 21:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547A220C030;
	Wed, 11 Dec 2024 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="y+5nP3QY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B031D88D3;
	Wed, 11 Dec 2024 21:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733951089; cv=none; b=V6o05D+g/tt0LZqRZJaC+qPRZPSqGyTbyKiV2dCuz9dJTFS+W0+hhjLwqNOd+crjHdNCd/zr+zILjEYyIRCBKmkHSkTo6hrbonK2sdx3M8RFR1008z+EaOUPS6pAJYeHZZfHQU5sut/zZfvAiw2bR+aeqxDCpjneFo8gk2OsEZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733951089; c=relaxed/simple;
	bh=WI81K0IRhvS0cIvzKIoFClUG4rorxMB2odxnrP9cOFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFK2C4XX/8c3YF4GOycZOo1ZSW9c0POJEyOnF9d6vfhp/raqaNl639G3mA18ylqXAiIQSZ1gHtXxMmYpryw0WXTF5dYhkHrU1rdE5883aLAqaI4ZtBqlLAzggn/tShr50bFgnJO8OyYZCjd8TznDeAGpfmnkpZ5RYCK9tp6PlrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=y+5nP3QY; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 9D1C414C1E1;
	Wed, 11 Dec 2024 22:04:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1733951079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DlVkfk0rJ4LeWz9ql6yoaPE0Ei1VM+gQ/8uRLa2OXOQ=;
	b=y+5nP3QY7x5hvzAES3PzKJOKXhuW5jq7hRI8yRO6Y9qckm0cws3QbXUrGfo0aZitLRJQyw
	IVIR5F4NK/6MItL/FbXOD2JZY6awJNJKqsEU5CuhqLp3saJmVX1+fOw9hX5hB7BvvIG6EF
	4IzfP1/KU5D5h8Pu5MVgalPf/g+RY9PP1Xnot6m4gKZumfBgEZr6RlcQJyi7QcS3CEem06
	KONIS41SP8koC4SWNFO6D/Wu0VOv4rU1d2BIXSkmXagUKAHHLq9CiH9VJc1e4j+azEHwUX
	WWmC6yc/7JEUeSeg/ybCqa/sWsTDcXP0hJT3MtBJ92Lr1vcapVFJUdYdA3YsCw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 7c6a0dba;
	Wed, 11 Dec 2024 21:04:32 +0000 (UTC)
Date: Thu, 12 Dec 2024 06:04:17 +0900
From: asmadeus@codewreck.org
To: Leo Stone <leocstone@gmail.com>
Cc: syzbot+03fb58296859d8dbab4d@syzkaller.appspotmail.com, ericvh@gmail.com,
	ericvh@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com,
	lucho@ionkov.net, syzkaller-bugs@googlegroups.com,
	torvalds@linux-foundation.org, v9fs-developer@lists.sourceforge.net,
	v9fs@lists.linux.dev, viro@zeniv.linux.org.uk,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Seth Forshee <sforshee@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Alloc cap limit for 9p xattrs (Was: WARNING in
 __alloc_frozen_pages_noprof)
Message-ID: <Z1n-Ue19Pa_AWVu0@codewreck.org>
References: <675963eb.050a0220.17f54a.0038.GAE@google.com>
 <20241211200240.103853-1-leocstone@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211200240.103853-1-leocstone@gmail.com>

Leo Stone wrote on Wed, Dec 11, 2024 at 12:02:40PM -0800:
> syzbot creates a pipe and writes some data to it. It then creates a v9fs
> mount using the pipe as transport. The data in the pipe specifies an ACL
> of size 9 TB (9895604649984 bytes) for the root inode, causing kmalloc
> to fail.

grmbl.

Sorry about that, there's been some paches ages ago to either cap xattrs
allocations to XATTR_SIZE_MAX, KMALLOC_MAX_SIZE, look into
vfs_getxattr_alloc or just flag the alloc __GFP_NOWARN:
https://lore.kernel.org/all/20240304-xattr_maxsize-v1-1-322357ec6bdf@codewreck.org/T/#u

and it was left forgotten because no decision was taken on something I
don't have time to think about

I've re-added everyone involved in Ccs, let's pick one and be done with
it.

Christian Schoenebeck's suggestion was something like this -- I guess
that's good enough for now and won't break anything (e.g. ACLs bigger
than XATTR_SIZE_MAX), so shall we go with that instead?

I don't care but let's get something in this cycle, the first patch is
almost one year old and this is ridiculous...

diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
index 8604e3377ee7..97f60b73bf16 100644
--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -37,8 +37,8 @@ ssize_t v9fs_fid_xattr_get(struct p9_fid *fid, const char *name,
 	if (attr_size > buffer_size) {
 		if (buffer_size)
 			retval = -ERANGE;
-		else if (attr_size > SSIZE_MAX)
-			retval = -EOVERFLOW;
+		else if (attr_size > KMALLOC_MAX_SIZE)
+			retval = -E2BIG;
 		else /* request to get the attr_size */
 			retval = attr_size;
 	} else {

--
Dominique,
sleepy

