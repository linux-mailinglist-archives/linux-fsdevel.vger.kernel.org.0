Return-Path: <linux-fsdevel+bounces-26311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E1A957325
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 20:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 212B4B21959
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 18:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D1C1891CF;
	Mon, 19 Aug 2024 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKMKmdDR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD9A3B1A4
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 18:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091946; cv=none; b=Hy/e52JG6nvswKRo3dZ/cec9B9heAVp+1Ht2n9bTWzdH8Gpk+xts0fTxdoylEqjHJAOUNNhXR3lzwJZ1UWqD9GjWgP+/CVEiyqcCafv//ag7o6nWkirkEH2NuQaOo75Iyupyve+y2TMpRpMaLEQajU7peMrb7Po3bZr57CLoRDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091946; c=relaxed/simple;
	bh=w+L1FDlbuPcFiYcSebz0Cj1WMMd+b2vuRP0d9f7TEuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=clyrNV4BImcWd0qrjKc/14drpoxF7Q0aozOV+fHLWAlS6jEVHT14J+g8lt5JxtESgnoK7kf/9TyjfFr+wGRMB6EprjEdaI//Z9EoUOkSwAWnv2D08L/1Lt6kuJjWenFskvZBXpLQlvGaBJm+gJSJy4a+pYF+vRJ3+QzWRR17SaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKMKmdDR; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6b99988b6ceso12778287b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 11:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724091944; x=1724696744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m+enqg/5HJ4d7oAkVaO5IBapmzdlTvcIOQlKEV5gUJI=;
        b=VKMKmdDRiDQk5RgTaOi3Rl4+fb3FKbSZkX3kgPGNQJFqJOqXvB76xxg+mOQgVmB5LY
         bP7Z55ZadHa7GuzZo+AfLMcxMAYZuzDhKz30p/QzllmYdm5uDmkgxo11pwtPIXJS4b2Y
         /8unNKn4DNkBR6IAXrvUg0TlRo7s9DztHuPd59mHcGcQN3XFEZUZQio6KPGGsUVnNxi9
         62ysKz1VO7PFGh9Kh9ezBtvzIWdw8yV7pvWAgtqNwE2mUtOg6ao/d5hwdnQMvPq2DHHa
         7pCAyas3TtSSyfRXpyVMmGJ4VvOaDIZPWpn4RZnwWngEo3NkE7z4JSpinKZVBdmUEuOZ
         jMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724091944; x=1724696744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+enqg/5HJ4d7oAkVaO5IBapmzdlTvcIOQlKEV5gUJI=;
        b=Va4l3wAipZnnx1U581f56u1JJRE8t6//JJYRrLnR9MGpUhUriWK2lVB0v+DbLIZhBL
         hLSOtBnTHfmAS3/XVLx4vm5744BZ1Cvi2PZx9LR5k1b4tmavZ6/ilQ5bWgQF8MJttSRO
         v7q67Tjs6rp05Aix4QfUjYPRTdjYN7sLQ6Iy3mS7phaKPFQ4i+1vzQnXaRu8c7sSSeZo
         LjNIDRLLF78CrBZcKw+i6QNIwt2yGKkpcDYaIFIUZsqUht8KJW357RqBYHSIjbUi3qjm
         IvevjcCeteEj7Bt8IKqfoERv5lkfJW0iir6b9x1+CTeFT9BUIpi+Aiv5n3I2iHvn/xgw
         HEmA==
X-Forwarded-Encrypted: i=1; AJvYcCX1QRlbHLhPrJ+MEqopjTI+Sn/lOpT4F/reAz+KmvaDsIreXhDQ0xS0Obxo2GX9NMnoymyTguK7UuQneBW+uz4spy5xPP4EFVHHBhMBxA==
X-Gm-Message-State: AOJu0YzmnH/rDAuWZjHGTDlHk3V1Uu5ZM8y8dsL+kcLVyTDVVWoqRooA
	fJzkUsuL0kzfZHLTA0bDa1X22OE7iVkV3jTKYrXF1zo62CvBBVLy
X-Google-Smtp-Source: AGHT+IHmy/cvmk34ieG63B9/bIZBIriDOXqlQNVUhJlIrBGWTh8k7FKcrszn6eOoZLm94TgAY6TvZg==
X-Received: by 2002:a05:690c:3809:b0:6b5:409e:654 with SMTP id 00721157ae682-6b5409e0887mr77230607b3.24.1724091944035;
        Mon, 19 Aug 2024 11:25:44 -0700 (PDT)
Received: from localhost (fwdproxy-nha-003.fbsv.net. [2a03:2880:25ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9d82697csm16320797b3.110.2024.08.19.11.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 11:25:43 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH 1/2] fuse: drop unused fuse_mount arg in fuse_writepage_finish
Date: Mon, 19 Aug 2024 11:24:16 -0700
Message-ID: <20240819182417.504672-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f39456c65ed7..63fd5fc6872e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1769,8 +1769,7 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 	kfree(wpa);
 }
 
-static void fuse_writepage_finish(struct fuse_mount *fm,
-				  struct fuse_writepage_args *wpa)
+static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
 {
 	struct fuse_args_pages *ap = &wpa->ia.ap;
 	struct inode *inode = wpa->inode;
@@ -1829,7 +1828,7 @@ __acquires(fi->lock)
  out_free:
 	fi->writectr--;
 	rb_erase(&wpa->writepages_entry, &fi->writepages);
-	fuse_writepage_finish(fm, wpa);
+	fuse_writepage_finish(wpa);
 	spin_unlock(&fi->lock);
 
 	/* After fuse_writepage_finish() aux request list is private */
@@ -1959,7 +1958,7 @@ static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
 		fuse_send_writepage(fm, next, inarg->offset + inarg->size);
 	}
 	fi->writectr--;
-	fuse_writepage_finish(fm, wpa);
+	fuse_writepage_finish(wpa);
 	spin_unlock(&fi->lock);
 	fuse_writepage_free(wpa);
 }
-- 
2.43.5


