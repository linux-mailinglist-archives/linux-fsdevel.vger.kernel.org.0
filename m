Return-Path: <linux-fsdevel+bounces-58646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC50FB3063E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF093A4FAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654F338B65D;
	Thu, 21 Aug 2025 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="PFgN+rvT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6257537216F
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807631; cv=none; b=ZP+Vv82mMh5NSRQzuXNk3ygZGiTSNRi4byxBJvyBDBNuCNndopaOHqNNuCWIupgjH8P5O/UfBq/meTtDSM22YMBz5QM7LwyxLJQuy+ES6+OFSuqy4uSqMm/mquZBRDMjX2XbQLleGMBtbNHF6FaLjEcs5XPEuPNratXe1GRYqlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807631; c=relaxed/simple;
	bh=mSQpopMs8dImzlrX65dFzEQHkhmtgotammgYg2xJShw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZprldVLMXAHLCL5OJ01Kp5B1BgUkny+SfcvJLu1w+Fos0bzS4qJbUwLaSpDb0efyCeDXlRxQfflVggXmAkwhjsDj3jcwdoGF40bKEAjCUPT6plAdCCEnpct1v16bC8pvy1OgZPD+jLYYi5VZiBnixJaMaDmdtuQouq2Cmrqna8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=PFgN+rvT; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d5fb5e34cso14481007b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807629; x=1756412429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2mDquPBH/1dSQpXa532hRheL3YkOl1FWy6w71RzklVE=;
        b=PFgN+rvTFe6Jh697lf1YTLQHfjBouKpYVk5go+U5yPIR+7t8W/QQirX8BnnzjA/2Zt
         pGbo48pXs8xgFv+9nqMMvAgc7fagC0nm5kpfiFDxh2iyzjorNfO03gJ0MymoxwNo6QYZ
         wuO0kcqeePoAJWFDfn/WoFTCsgBliTkAI3l/7wSjB8/hFzEejaCxEFu92HtcP8aSsCkt
         fFTuULHPPIsgGlOA5KpRaaCi3ree7O+Az5uX1aToadK6O/gKSoZPu7U9gNJjpvqDRx4j
         wrshbWQFUNwI3CI80xtd/UF4eJXWKNPtBRCxg0N58mdztawSIzjMvKAt90cc8IGmBrfn
         lMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807629; x=1756412429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mDquPBH/1dSQpXa532hRheL3YkOl1FWy6w71RzklVE=;
        b=s9mgB6GZo8QEwHjAyyQ5IKLkijqFqyL9ZnZpSX5S+/vFdHOcXUevCJKNoj8FJbGEG6
         5gmR4Zqd4HLxyBelrIxHe+MZeSGnPKD6wbUIKvJEH3qkOp3XDdjTTH9a2kzIBK917H1W
         T2hkhAd8AQP95lW82MH20N6z/BkJnaqa7BMGLH4iJANRrontM/G2RBARDik/8qC5OGIJ
         a4vKdOcqexfjKpP0oZJ+iHApY9DJ2+KVEoau+79UKNXVQxJqi7JK4SU82fZkj6xZg7wN
         suo/LJDhCkEblj0HZd/KLpKwOzgPs67A7BsndP7rknhnTldVoDTM3lk9PlzXXTwG9olC
         xmrw==
X-Gm-Message-State: AOJu0YxRbhifUv4hTAsz0y1odc6SXkY1xWk7uzyAgqRA5l6tJBh5XML5
	S3+eDsR121+2wJTCmKeAQ6PJ5xP791Gjs/z3VA+CPYhFIIrh0AztgG4ro5leRPFpYrl7owsna9r
	azdaY6fl1AA==
X-Gm-Gg: ASbGncvys0EwLzzjUT2jpIq5/tIS1D2XmZ9QJu5X5Z3g3mkZHM5e7dnH1ZiIdqiHX68
	OQIxGT92IxkHW2Df+HJ4DgaCh5Dv4S1KOK1iPIEcZzLHZmVTHK28vkbSbfaForCbI0I5qDYcohY
	IIkUZxZpLxgx96Ex7G4S0w0bep/fa5KVah71RRgUbQU3igYmGFlHS3iFye6k68dUEZXei9cuL6/
	IpKW/Y8LFhgJXIid6LGIxDtnq0NQdNv3nyc/4IhmVfd4rv5S0TPMfZfrHfwWC6TOpcqkaHKY8w1
	1AwokISPdh7SqwgIMNsoLooqzLyBFHnEELHN3iKDgFxMMQEGikpzgcJpa6MmIDf1Z6S2U2+stbT
	clq/8RGiFn/YPZwTNQ/aunC05BxijZxS4blwNz7xhoP48w44iuxN2fAAGj27NVpzSEzloJw==
X-Google-Smtp-Source: AGHT+IFlxiZ33ZFGeY0+eRtjwiN/2t7a7T8FkZf43ZiG6zuU4o9brNEc8ITMkGpER2WpFIGqL1aG9Q==
X-Received: by 2002:a05:690c:370a:b0:71f:9a36:d336 with SMTP id 00721157ae682-71fc9fb83c0mr40822927b3.25.1755807628850;
        Thu, 21 Aug 2025 13:20:28 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fa24e97bbsm19766127b3.68.2025.08.21.13.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:28 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 09/50] fs: hold an i_obj_count reference while on the sb inode list
Date: Thu, 21 Aug 2025 16:18:20 -0400
Message-ID: <000670325134458514c4600218ddce0243060378.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are holding this inode on a sb list, make sure we're holding an
i_obj_count reference while it exists on the list.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 7e506050a0bc..12e2e01aae0c 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -630,6 +630,7 @@ void inode_sb_list_add(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 
+	iobj_get(inode);
 	spin_lock(&sb->s_inode_list_lock);
 	list_add(&inode->i_sb_list, &sb->s_inodes);
 	spin_unlock(&sb->s_inode_list_lock);
@@ -644,6 +645,7 @@ static inline void inode_sb_list_del(struct inode *inode)
 		spin_lock(&sb->s_inode_list_lock);
 		list_del_init(&inode->i_sb_list);
 		spin_unlock(&sb->s_inode_list_lock);
+		iobj_put(inode);
 	}
 }
 
-- 
2.49.0


