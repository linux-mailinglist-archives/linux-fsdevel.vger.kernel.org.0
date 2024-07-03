Return-Path: <linux-fsdevel+bounces-22989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0ABC924CFE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 03:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4BB1F22EAC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 01:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51E05228;
	Wed,  3 Jul 2024 01:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l//i/jtm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C668420E6
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 01:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719968642; cv=none; b=gWtHVQTDhgOZyKEE+J6DgeUzL14iMmpccvEXHfK8WR2SX1kD8N8KdAl3kdie+CGb0aDKEixeuHCkE8AUNBRIt3FBbiNbpx93CeYzQpqfvfQqJOSfzoclXhg8jOMtVNYvOAWe/iRW96llEXmdp8+O/cnr28wuZguruDAUgoxYwHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719968642; c=relaxed/simple;
	bh=0z0ywKwgmVjsmyE4wkcV9Cf6RKxoRxxiMMCEEFH9q2E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s7W8fGof+AZpq5TV1U2EQq/9hldZXV/neBu6qYl/J67NuQGamDSTRLX5w0//RH8GMpJNrTU3vhBAmD72pKjV9l9yXw0fR3w9dvPdF11NEU87tmH1wgUkXhTKYOEYoorBla/6y1NSCFrlfhBMP/vy0xD4mkG7XbHldoqG92MVIJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l//i/jtm; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e023e936ac4so8679514276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jul 2024 18:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719968640; x=1720573440; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gmQhOuyQtK8aybFk6zeOYgJV4p+zvTzkvvCmSb0gD5I=;
        b=l//i/jtmJs+SSTY1ts101rdBxOJvTRN+8H79EmGnQiqWxlfNS1mgH1139f9wZ8Eumc
         o7w/iq680Zxm0sAscHB9Dk+ouqqlaVk4Py6eDPEkgw9V0sCIZyRYlNtUX1nJ2HrKl6QI
         Xi8edTAZJHxZtJZrcK/2MCgp5m6En9xWqAsdCdQ7I4halpX7yOayivWnUdFAzhG1AOKH
         kw2B/xVgK+YJ8jqxDlaNvJDPPdQ+fpB4q1ODwxMnk69YhD3DLUx4tpky48a+tCLZ7Drf
         +h6UgJfr6ox99Devol+O794ry/9yEzibbjMaUYoTJAbYc9/qfqPPJrguczZdd4PP+wZS
         vVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719968640; x=1720573440;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gmQhOuyQtK8aybFk6zeOYgJV4p+zvTzkvvCmSb0gD5I=;
        b=NiSuNqnUaqkG3FS7MTXLI86DuRjw/ENWST2h4KUD+PsFKgE5L2Ysh6ZN9PJdFfBKkr
         WV3cY2iSBTSOYe+RtlQw1WYSOv7MxEPWWOHdPvwAv5P3Yv+bd9ImSZMQ7oY3qY0Ji0V8
         lyamjRNhct33jNPLwJ4CkXmj3ghLRWSuPYey1+MQ9vpOxIXhQbxvzaV8WJobtoIlofHz
         jDIHkdJ1bqd8PQQhBQf0TPgmuPi1zlKCGP2zq7cogdx6qU9rvzD/K+mmV1ZhXk3QtfQU
         GnVvRAxnZvAHcW/AApmrwiXAQsSU5DEhKa9jIpuJh1znv1kFqs/pRHrwYJgIPnHxJxPF
         AteA==
X-Forwarded-Encrypted: i=1; AJvYcCUe7CQfpe3yRXIV6Qp7sGNnK2W2r18bXbx3wA4Gdu9EVX1n9LvWAuOsHajoOvRovJs3Z9Ja5SYiOR+35ENJya314yZjKdkrlCSsJiJaNg==
X-Gm-Message-State: AOJu0Yz6J0lZTZIykad1W42EysNeFJ8Tk+pyrnvZfbwji2oTzk0EsNvR
	DYG1YmpMIy8O1nm5IRcGnoWnSl5O+UMjFK2oesOhfhsVwJFnD2Y7t8X32pxXQXMxGdB5nb+m6bl
	7fA==
X-Google-Smtp-Source: AGHT+IEOXi10M8jsdGwB664dSODsBLBId+OYcSOD47IZRiMP1Os1MZzkX6dBw+gFEGi78FXdBSRyyXWiVM8=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:2ca5:53d1:2309:2615])
 (user=drosen job=sendgmr) by 2002:a05:6902:2c0a:b0:e03:a714:1967 with SMTP id
 3f1490d57ef6-e03a7141bb3mr18408276.5.1719968639737; Tue, 02 Jul 2024 18:03:59
 -0700 (PDT)
Date: Tue,  2 Jul 2024 18:02:15 -0700
In-Reply-To: <20240703010215.2013266-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240703010215.2013266-1-drosen@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240703010215.2013266-2-drosen@google.com>
Subject: [PATCH 1/1] fuse: Keep attributes consistent with Passthrough
From: Daniel Rosenberg <drosen@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"

If writeback cache is enabled, and we attempt to use fuse passthrough,
fuse will invalidate attributes on write, but will then ignore when the
server attempts to update those attributes. Since the kernel is the
arbiter of truth with writeback cache, passthrough holds the
responsibility to keep these values updated.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/fuse/passthrough.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 9666d13884ce..6f63a1a38d7c 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -21,8 +21,19 @@ static void fuse_file_accessed(struct file *file)
 static void fuse_file_modified(struct file *file)
 {
 	struct inode *inode = file_inode(file);
-
-	fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_file *ff = file->private_data;
+	struct file *backing_file = fuse_file_passthrough(ff);
+	struct inode *backing_inode = file_inode(backing_file);
+
+	if (!fc->writeback_cache) {
+		fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
+	} else {
+		inode_set_mtime_to_ts(inode, inode_get_mtime(backing_inode));
+		inode_set_ctime_to_ts(inode, inode_get_ctime(backing_inode));
+		inode->i_blocks = backing_inode->i_blocks;
+		i_size_write(inode, i_size_read(backing_inode));
+	}
 }
 
 ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *iter)
-- 
2.45.2.803.g4e1b14247a-goog


