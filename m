Return-Path: <linux-fsdevel+bounces-16327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C9D89B2C5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 17:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D2A2B21968
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 15:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCB53A26E;
	Sun,  7 Apr 2024 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6xon60k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56CB39FF7
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Apr 2024 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712505490; cv=none; b=PzyaFhO5yqSEQPt+iSJ+R9Wxv29v/qc16lGGgsn87/gp+5afK2GLD3l8gpXD7OOmkqMtSs2rlnfXG80nCDXDzsf+ducyH3ip0aowAW+63yvifYMrOUP9XC1y4Da4Hg9JUenrvG+bP2nZnySJTAHDvUHkxjQ3z/BYGwzheq6ahzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712505490; c=relaxed/simple;
	bh=J9r2Eg9Fmt0bS+IU69f54p1/59h6+UKJkYua1d7UoeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J8/mAKuv2xYL9+3ViPhPTSLjxBPUmvZsSi+oxLq5o1NfQsykRQrXuVXa5MIOABW3XjqqOPtN9za00BX6Lvws4pAJuxi9cltIv6A+XUFRauUlsE0lk8gt5t/FA+aOU/tNTN5Amx7R4RaN/RMDK4Mn69GUKoHz2oSG28gXOSvILj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6xon60k; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41663330f9dso1805345e9.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Apr 2024 08:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712505487; x=1713110287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IB1ZlwmzJ9tgfqlF6V/mOsMDkxsL8+TK+8UyhS8ukb4=;
        b=b6xon60kKDb5jDt3MlbTt6as26CP4dDjFWUmr4Su8i2qzFA7mkMj2twkkKtMTPejWs
         ir+3keOSYf8ZWWYqnsp64oTQGlUDWP7HqTu8Du77f1TKKXgEgPJZDvj0ss6OcBzsSEWT
         UEnWnikqrnAMc3n72Vzcg16yWpiIixldDCV2AaM2qxk9KadX+6B4iU1UCwHhHbfTH7JY
         uXzelomoIcbesfcGY8SzlXt8TA4icyJnxh9AaL53JKLu9q8qhoeIp59agvWaZ2l0sCva
         ukqBfIaCpoEoo36r82kZZ6sdR7nmFEDLgTfoLzJNjjoqbgpfR9fSJ3XgqVjvS3ftWneQ
         VdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712505487; x=1713110287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IB1ZlwmzJ9tgfqlF6V/mOsMDkxsL8+TK+8UyhS8ukb4=;
        b=Na3ZYxuVpyRjDWNyXaa4ZDlNJ4raNJhtaVO6c9/eKij31hriVqeRPA1iZVd3/9wJuu
         2W2ZGz6QwhB0iH8eRXwf2ndGuoz08LJObhtFCJjXJqGqaR6EZS20OwPNPN8KvaZyesMx
         mFUvW492cOoC8BixRbWj/LGFXfDYc23I6qPnEu6L+vDxZQ8TQs7+fuAYsmaEIvTO6+r3
         CkYUAjF/0WJeZCzxTY9R9eucNKWH2sMlMNj7LmLl/SI7P+sPFtAb2RQZxR3ZMg0ZVoJY
         iTzYycVYGI6bNAYZViWv10wFsoxm2DKm1iySEo7UApJ6YJPsB0swjKU5f0/2aTfIYDl1
         UYsA==
X-Forwarded-Encrypted: i=1; AJvYcCVe/lOde42Xp12NTixgecjXFJzjYkgxkgyQUYYSWpZGDwGMlgXgNUlHgqVi5hboF3fGJPIwhw/h1WzN3n622wnQQl/oJ1LZrrV8/adFTA==
X-Gm-Message-State: AOJu0Yzk+yxc4WXZGYqy/lMTFTKCFt5gqAmsOS8UCjrE+AKdi8rC+1c4
	/uup3XWaYYGJQ/khYfkyvAv3KnrVgBoN9wBjH3KfUZHImAu5X+4G
X-Google-Smtp-Source: AGHT+IEwLJ91Pu/UNU4uwvgcd5HJ3JjMw2jvy8VdFqoXKOm1tMW+5TzrtWEnC+DEUuzlA7Pdk3YLiw==
X-Received: by 2002:a05:600c:3c98:b0:416:244d:4871 with SMTP id bg24-20020a05600c3c9800b00416244d4871mr5031873wmb.17.1712505487234;
        Sun, 07 Apr 2024 08:58:07 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan (85-250-214-4.bb.netvision.net.il. [85.250.214.4])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600c1d0b00b0041645193a55sm4600171wms.21.2024.04.07.08.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 08:58:06 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] fuse: fix parallel dio write on file open in passthrough mode
Date: Sun,  7 Apr 2024 18:57:57 +0300
Message-Id: <20240407155758.575216-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240407155758.575216-1-amir73il@gmail.com>
References: <20240407155758.575216-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Paralle dio write takes a negative refcount of fi->iocachectr and so
does open of file in passthrough mode.

The refcount of passthrough mode is associated with attach/detach
of a fuse_backing object to fuse inode.

For parallel dio write, the backing file is irrelevant, so the call to
fuse_inode_uncached_io_start() passes a NULL fuse_backing object.

Passing a NULL fuse_backing will result in false -EBUSY error if
the file is already open in passthrough mode.

Allow taking negative fi->iocachectr refcount with NULL fuse_backing,
because it does not conflict with an already attached fuse_backing
object.

Fixes: 4a90451bbc7f ("fuse: implement open in passthrough mode")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/iomode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index 1519f895f0a9..f9e30c4540af 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -89,7 +89,7 @@ int fuse_inode_uncached_io_start(struct fuse_inode *fi, struct fuse_backing *fb)
 	spin_lock(&fi->lock);
 	/* deny conflicting backing files on same fuse inode */
 	oldfb = fuse_inode_backing(fi);
-	if (oldfb && oldfb != fb) {
+	if (fb && oldfb && oldfb != fb) {
 		err = -EBUSY;
 		goto unlock;
 	}
@@ -100,7 +100,7 @@ int fuse_inode_uncached_io_start(struct fuse_inode *fi, struct fuse_backing *fb)
 	fi->iocachectr--;
 
 	/* fuse inode holds a single refcount of backing file */
-	if (!oldfb) {
+	if (fb && !oldfb) {
 		oldfb = fuse_inode_backing_set(fi, fb);
 		WARN_ON_ONCE(oldfb != NULL);
 	} else {
-- 
2.34.1


