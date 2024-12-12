Return-Path: <linux-fsdevel+bounces-37114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D1D9EDC6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 01:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A460E2833C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 00:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC4A17C68;
	Thu, 12 Dec 2024 00:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bi2GheKE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20E512B94;
	Thu, 12 Dec 2024 00:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733962916; cv=none; b=BRZp/gE5KhUMcJE7ZtPRtdJVZub5KvZJKunCoebQ7DwPyQj5o9dlT/cbebPgylFf1+Lw8L3YSflWdQag+wa8ZD737HC9KSsbP+5Dh0ORry0FEC0YJ7Sl+TKht//pczT/UgpIf/mkx2S+pquVKgl2Uqei5L90kZUbFQmCS0YHfGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733962916; c=relaxed/simple;
	bh=uln1aLpbwm/yBjgvBJAUrJVEanXA3yCbq8lbO5GlSlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUGAyk38nrwp4C/MYI2Dc5eV+JKpp0DqsEfoqZ1ClW+9ma4EpSAlGWulwC7r2POGZVSIqIEgerDvUHWMOB75MBA3ez6k81eihny91TgTuMNPehztZJ64ziLqHxV/WYyAWpDlv6FoE6Ble1DhrJCQTVhU6YbRRdXBcd+xdlUyTio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bi2GheKE; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef714374c0so45365a91.0;
        Wed, 11 Dec 2024 16:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733962914; x=1734567714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bketrtpeW6UKdUyWO3MVWt53PVBe2dVx+Pr4cx7LBI=;
        b=Bi2GheKEHxA8VptsjDreSkB9bmjKzaIuqdakkWXysWn9TGuoDwMTvfkp28vVX21e3f
         20YAXohTxlSlmTlG+w0elkkxemUkfeiymWh2s+x8ip8EDpCMRUs5dC+XJ+2zhiCMXgRG
         w794s1F5z+rsSwoNNX1tUk0RMVjZzza9ioqX5sL60IPb8SMIFgWQ+vpced9H7pKz2n0m
         3zjwXBYupQZAaaw8m4KCYXYuCmJTLEU4kPjDG8ngkgJ49bNm4CVXoZRPo4Ts7HyYH0sX
         1WMpOPcnYi6vW3VcL8mjHoL8zib22F8neNk0zYTlIMgrvo8op8F+2aH4Q990jPyHxDbt
         yqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733962914; x=1734567714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bketrtpeW6UKdUyWO3MVWt53PVBe2dVx+Pr4cx7LBI=;
        b=OfRj8Awd38BoPnMEPjTc0MLvrEO8mVmoq6xjyqN09qPTDtGVNt5lAwSdiYipkMMN2R
         olHoEBkGSPTeJAYbtpio0EnKUyJoSYpb1JZ4Qjsrgim2hIHKN0g7TV9L2HaliCnAJkK1
         CN88P3ztFJQ2KcvOnMtun0NxiWer8njJ2YCfce0L6CID/3NTF0D7MgrsQB9H9EbZ6nNj
         WzhSkgm+BtVW1+Lxxzk/NAD8tbz1/TFyt/PVz89MaO7OQunpl1U+WTq0WvBa9ODFhOXx
         18qPv2cPqHAHm7zFyM+bKv3rZfUYOsI3RfJtXxKpb/SzTHcAMftIml/QCvyI5awF78wY
         D6cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVihRW7McZb5tO2Ev1/CDeaSrQ860i6hScbW9pTCG5v2kF7aqFIwCPJbJm12vZbQPzLPqnR9obPX3Sm+yv0@vger.kernel.org, AJvYcCWFbXnmnB4FM7XxwUGxlPNW4wW3V1dyPcK90NNuiXjqDCoM+x/yD4MVd3eGxH60/84kxcv7wKWrBmJhMjTH@vger.kernel.org
X-Gm-Message-State: AOJu0YyMa4EQ5h/Y0CIe3W5FvUhX1AIC2EJsRLQhW7+TZ4S8fF4jDpCt
	qwL6jTRbq/3L8i+6WcjrcaWKjHESTT2VckqWXoaiOiKwRxSJ8bG+
X-Gm-Gg: ASbGncsPp03ZcKsUIt5yeQQLHFAwtf1rYHRZmwh3N0ime7SuhCh9Q6mpQU6T2bu0BCx
	rUZ7PVWx/SHATC91C+ibt+mqU9VIfBsEWORYjqGKiW/v2KSC1x5xvuScQu0UB5YX6FMqmCdm1mq
	LoV4iRJHAhG3X09P73N6Gly8Bj3dNwapppQMX0KHl6Y+yxcW6AryzRDZDBWtSNZwxc+KFgTpo15
	9WTvQ369k7CxtAcjLn0i7gUoq1MCJshLpL83ssiNJCECTTzlhz0IBzvPUIc0BK8hwJsXy3Q
X-Google-Smtp-Source: AGHT+IEIh2pxGWlSntUWbdtNDDz1buQFg4Adw/CcEXsV5276tbuH02ZNbu5Nd1bQ7IEod2fpr1de0Q==
X-Received: by 2002:a17:90b:38cb:b0:2ef:83df:bb3b with SMTP id 98e67ed59e1d1-2f13aba96a6mr1882157a91.8.1733962914123;
        Wed, 11 Dec 2024 16:21:54 -0800 (PST)
Received: from tc.hsd1.or.comcast.net ([2601:1c2:c104:170:a69f:44ab:93c9:b027])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef8d84224bsm8241413a91.42.2024.12.11.16.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 16:21:53 -0800 (PST)
From: Leo Stone <leocstone@gmail.com>
To: syzbot+03fb58296859d8dbab4d@syzkaller.appspotmail.com
Cc: asmadeus@codewreck.org,
	ericvh@gmail.com,
	ericvh@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com,
	lucho@ionkov.net,
	syzkaller-bugs@googlegroups.com,
	torvalds@linux-foundation.org,
	v9fs-developer@lists.sourceforge.net,
	v9fs@lists.linux.dev,
	viro@zeniv.linux.org.uk,
	Leo Stone <leocstone@gmail.com>
Subject: [PATCH] 9p: Limit xattr size to XATTR_SIZE_MAX
Date: Wed, 11 Dec 2024 16:20:22 -0800
Message-ID: <20241212002022.209049-1-leocstone@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <675963eb.050a0220.17f54a.0038.GAE@google.com>
References: <675963eb.050a0220.17f54a.0038.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot triggered a warning in kmalloc by trying to mount a v9fs
filesystem from a pipe, after specifying an ACL size of 9TB for the
root inode in the data written to the pipe.

An xattr larger than XATTR_SIZE_MAX is considered invalid by the VFS
layer anyway. See do_getxattr():
>        } else if (error == -ERANGE && ctx->size >= XATTR_SIZE_MAX) {
>                /* The file system tried to returned a value bigger
>                   than XATTR_SIZE_MAX bytes. Not possible. */
>                error = -E2BIG;
>        }

Reported-by: syzbot+03fb58296859d8dbab4d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=03fb58296859d8dbab4d
Fixes: ebf46264a004 ("fs/9p: Add support user. xattr") 
Signed-off-by: Leo Stone <leocstone@gmail.com>
---
See: https://lore.kernel.org/all/675963eb.050a0220.17f54a.0038.GAE@google.com/T/ 
---
 fs/9p/xattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
+		else if (attr_size > XATTR_SIZE_MAX)
+			retval = -E2BIG;
 		else /* request to get the attr_size */
 			retval = attr_size;
 	} else {
-- 
2.43.0


