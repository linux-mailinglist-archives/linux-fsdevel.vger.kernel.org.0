Return-Path: <linux-fsdevel+bounces-55041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56375B069B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 01:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7652A17B2FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 23:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B752D3A93;
	Tue, 15 Jul 2025 23:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PY12zLz7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC92262FD3
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 23:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620602; cv=none; b=tRVJGulY3OLSvZkaIfQGgoUUS2MCBor7Yj4USyRE0OwqP+L35Zz/aRd02f97MTQFS+jU5xL4nK+kjHYDcVu7KrupPHHm/wDAI570P3cewpVeC1dCFHIYD5PuwKmMBLBMVZRF8vJlQWrhTo56Dqrjow2UC7I7lJitHOePtJoJiaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620602; c=relaxed/simple;
	bh=ojsONraykAW73nHFhU3JR6gIK5F+2qzAE3NHVXM9K1o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gg/cco9QsLiwGkaxS5KDshrbzVCgdOKJy3Kd4eVVCvqeVAUsFNV5Q/AQM/Wgq4NGgx8QKLOotauavLC5o/eC/ztvfEIVHKgV7H3TKLuakNzQjODPnjIYXTtkgnoJOQ80H5N3nCjRGHZesqRG932oLg1SdDQohu+OMKVQ4v4eG4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PY12zLz7; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-41b9e3c8bd4so733947b6e.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 16:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752620599; x=1753225399; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uVPOIdRXltuwUh+ovIsPk+9c5IV4XN6F0lzLlze081U=;
        b=PY12zLz7XbgUIJ0jnzV4J+G4gATelRhx0W7ggppvUvzVRa88eAtija2wL2iDSfbdJF
         1o1YV+yJjeV0w5XBK0GX8cHLgkZoriJbzlguNAk4VoJWJNoKWkixN34UoP4oO+pO5ETn
         yB/lcEpOMwszSux5wXtPA4SqDwp84c4dGmYQ9QakeFu8m4xvkkxtmjQhSKvqJp1zb0x1
         VDA4EhQAaZULUVk6ixmiv/MBvlWo1eNCWHVjLPCiVRcobpGhE/1cU7RWpj6KsatsRTe8
         /O209DUhoxXARr7FS/HWif/XXIOqEobCTaDhpqHeOziX3iGHTBEZ1r5/tzdJxdwpnHsY
         4xaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752620599; x=1753225399;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVPOIdRXltuwUh+ovIsPk+9c5IV4XN6F0lzLlze081U=;
        b=EtNs6ZkW65djFfGdHq/qFqtoZlpBciYs50NfCHO31q5dV+uukbkPZgw8BW1/nFrbyO
         Q3bIkSNTt6OGwX9x9+Ufo783aKr5FswdcFaSbU5pKpYgouWSKpw56LvnUckJRxJEJEwX
         B0qVYpFqCyAB+fS6a+1blxcGs5yPH7mJ99YJ+7q3txWrZj9AzCxMaeP9URIVVCPPbuNK
         brhZnpV6F7SOIZuEL6JLxDAENPjLp2AhFVRjdiHiMOGN4eOj8VKFvTDqkyFZEEdPEcCv
         6bgOZhhYvhy2M32s/Ba0bqV2XxFOL9uBAbEkNsl2ud6yhJg73U7G1oEYMSgNGkwdaGVs
         b9kQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7f71eZCU2+7IdRWok4YGY6drqm29FIbwrkP3H1q4vPEXhV95rkpNAjoiX81pD5v416j5BygxqCdo1x3bk@vger.kernel.org
X-Gm-Message-State: AOJu0YwpXN3W101EmHDgIcmxAl4mz+vog1JOadVWBG0QtdK6P9vt1n8t
	dWVscvefgTWXuBUCP8d3RpNq3IUzZVwswj0SW+fSjxFebvjqx7Wh6a7yWYdpTeN422A=
X-Gm-Gg: ASbGncsP29Wr7P+gSCrP/uj83bX5RWD1S4TnstvsZSwCpFfAYqnp9LaMiZOihXt9fBr
	aSLnGC8C82nuvNLilGG4FfJ6BCCeHbyu/nzACZBklfdj1h/ZY3SmCdNFmp32tos9Oi5Ss4uqeOd
	iXuy3o35PgpfqWVqOpQapNDlNkGfzHxCDD0XlFcGshwmCnh3Rce0P2AcfCGSRBv/0/O0FA6X9Dv
	/6SwFQIwA+8C1uKLeE4LfdnbULWE1aEynfHIRrKZXhYEfuj0T34yA7+sHKcK9qMPjObquw6B0fo
	V338Rmi64ruTbwXnvMdI1U3/GdRYQem9ITxqepYSpf22BEaGN4O2HRzFZN1NqyeQGB9u6PbSjh0
	6odQjwe7LHxkPvfQ9NyKHBRRLoiy1
X-Google-Smtp-Source: AGHT+IFURZ/gT+RRgf6lI5IpEJOCthv+wsSYmy36S+x0hFRqDxCmnWN11VfQnBagXrYe5WyxizT1LQ==
X-Received: by 2002:a05:6808:14c7:b0:3fe:af08:65b5 with SMTP id 5614622812f47-41cf0abe5admr693504b6e.37.1752620599527;
        Tue, 15 Jul 2025 16:03:19 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:9b4e:9dd8:875d:d59])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-613d9f14472sm1859238eaf.29.2025.07.15.16.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 16:03:18 -0700 (PDT)
Date: Tue, 15 Jul 2025 18:03:17 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] fs: tighten a sanity check in file_attr_to_fileattr()
Message-ID: <baf7b808-bcf2-4ac1-9313-882c91cc87b2@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The fattr->fa_xflags is a u64 that comes from the user.  This is a sanity
check to ensure that the users are only setting allowed flags.  The
problem is that it doesn't check the upper 32 bits.  It doesn't really
affect anything but for more flexibility in the future, we want to enforce
users zero out those bits.

Fixes: be7efb2d20d6 ("fs: introduce file_getattr and file_setattr syscalls")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/file_attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 17745c89e2be..12424d4945d0 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -136,7 +136,7 @@ EXPORT_SYMBOL(copy_fsxattr_to_user);
 static int file_attr_to_fileattr(const struct file_attr *fattr,
 				 struct file_kattr *fa)
 {
-	__u32 mask = FS_XFLAGS_MASK;
+	__u64 mask = FS_XFLAGS_MASK;
 
 	if (fattr->fa_xflags & ~mask)
 		return -EINVAL;
-- 
2.47.2


