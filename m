Return-Path: <linux-fsdevel+bounces-58643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB9DB30632
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300E9AE6FCD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2648E37217E;
	Thu, 21 Aug 2025 20:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="H7FCKGiV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C1F371E90
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807627; cv=none; b=N2ccOuCoOJX9WZXsz3+Wmsuwuxc7yJ5Qtq5TsF/5PQzf/lxWoPMTCBPxyrGerHiDjxYNSWRkg9BmBWz1TbaxSUqZWcAPvcQltKznBfBioah2MRLjv/FVNC+8ii9P8cMZ4fpx49FUbGfg1oU4/AW/VBhnOSkMg8JrMjB9O33hrYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807627; c=relaxed/simple;
	bh=VW5j9pCOlroZhl/lnWfntKbo6qQXfaDKec+FJlQf3TY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+Z8Ce/Jt8OFU8hZGVbDKNFm6aHY0tAm5R3FyNJoVKtr07oq7Syp7Xb1cdghHlaZ6fYL1hwHNGoSGUTuzjPTiaBRIEbUSFjJNZGdrjvbmFWxDhj1P+twNNJUsvB66oXCnBVslKgUBTJ6PZsei3TZTHaLpOEFj5gs3yuTdx9CwLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=H7FCKGiV; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d6051afbfso12417237b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807625; x=1756412425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VojWusNxgTfPnzlXh9Aw6r7SNSzmMD9Pubt2ZgZyin4=;
        b=H7FCKGiV9rPYtCdu1AbEOsJUd95oOwUHPt1VmyGHmjWdnwvzkiS2bRI1st3t+RaPEl
         3tlBu43SDBy9odOfNZaf4AOI6KR8fiL92bOuK2e3ZCzgbgXtMVRWWoW+snti4LeXgn7M
         nekQEGJnhGcExHdqIX5MM2qG4vHtigNNWlZA2sp4UIeY8ZgEvBfMN915r3q4dZfbOIGY
         Wv0jaxoLJApbEafnU76CRw39tUvjeYtb/1JvoZAu9tZxgbISevZCV+f5vM0MFUIghNrF
         coiLsBoF7bmf8F7HMD008zpv6aN+HQCEsiS0eutPQUyrGqZGWEhpEOL7ZuvhVU5QGMLl
         A1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807625; x=1756412425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VojWusNxgTfPnzlXh9Aw6r7SNSzmMD9Pubt2ZgZyin4=;
        b=Gt5ufhgWy3ZRCbKK9BIuWeek06OVSrA7iOmxMjKwiFlQ44m38PyWl5Mwdw8HG16XJL
         THjpiZ2PQwVMLa7BYrzVBnTXYHGa+Ct/+FAeK0uhr3j0PMtfcG2ZEcxO/LDm1BX+MLFW
         OSNC13b+tRW6mM2halcAWg7BzM5y/w2W6SYccwOkZU/Apv0DPquYZJSE3XrJT3b539vc
         0OKzh126g5x+xGM1yyLDEAQAkpG3gZ2NfnINoU39taId687tey7H+ayydYQLrWZle6Dq
         SxSvS9fgX5Wr9km+52ta044burxE36AQnbNU0mgWXRA1AV3Nj00G9Blv3P46wL+F9DEh
         /vHQ==
X-Gm-Message-State: AOJu0Yz4m5ScQQjHEfzoBtu7mNWJI6Hi0tdCF6t39FshP0GMUP50ryTM
	rnd0V07/DD6+4Biri/dsd+1+dJPoAMdtlShkwSBuC5m3kEUKb9ICHSniQEuaSm/e/LxfoEryKjN
	ZEjF9hJGPBQ==
X-Gm-Gg: ASbGncsWi5EB94y96gQv2UTlsqDR7LEswaTFSh17olvu6Ls0Ihibmi3Zms/SdkrNnQJ
	IS/ovt0yBVEauNZlup85kv1rr6YLmVvviwwAIfb3S8FyPzOMOgTMCtNyKLwLiYikK/c0g2wE76Q
	aYD7tbiR+O9LcRG+YX7ynAM0+8uOtrT4npa2H168VaJQcbkk+lCeABrPyC49mblp28Zu7OssLcZ
	/N4DWqO+k1JrBF0XjfJbnepLrtMMnOrOIBKO8SSDSKWWAEJVv3WWLD7U584I+NxH+ejKVu2GAGL
	XhausAfJmD5szxqZR+ERuu9C68qIBlZhFJpgmv5pkNlQcBkxb3BSvU/OUEbO8PJrlK/Y0Ovgl5l
	cHKy2iwn64BwyX7m4viTLUeMSlr9Jj5n0nEBB53OMBP52FEyE3E7lRVq6qco=
X-Google-Smtp-Source: AGHT+IF8JBW4Xh52SDVildob/BUomhJ9K4wuNU15xnoWWWlqqaOPm3Y7fskuJegwPAQeudlS8EK8SA==
X-Received: by 2002:a05:690c:680c:b0:71f:b944:1034 with SMTP id 00721157ae682-71fdc530ce2mr6839237b3.49.1755807624618;
        Thu, 21 Aug 2025 13:20:24 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fdbedffd8sm1165897b3.5.2025.08.21.13.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:23 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 06/50] fs: hold an i_obj_count reference in writeback_sb_inodes
Date: Thu, 21 Aug 2025 16:18:17 -0400
Message-ID: <1a7d1025914b6840e9cc3f6e10c6e69af95452f5.1755806649.git.josef@toxicpanda.com>
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

We drop the wb list_lock while writing back inodes, and we could
manipulate the i_io_list while this is happening and drop our reference
for the inode. Protect this by holding the i_obj_count reference during
the writeback.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fs-writeback.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 24fccb299de4..2b0d26a58a5a 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1977,6 +1977,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 			trace_writeback_sb_inodes_requeue(inode);
 			continue;
 		}
+		iobj_get(inode);
 		spin_unlock(&wb->list_lock);
 
 		/*
@@ -1987,6 +1988,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 		if (inode->i_state & I_SYNC) {
 			/* Wait for I_SYNC. This function drops i_lock... */
 			inode_sleep_on_writeback(inode);
+			iobj_put(inode);
 			/* Inode may be gone, start again */
 			spin_lock(&wb->list_lock);
 			continue;
@@ -2035,10 +2037,9 @@ static long writeback_sb_inodes(struct super_block *sb,
 		inode_sync_complete(inode);
 		spin_unlock(&inode->i_lock);
 
-		if (unlikely(tmp_wb != wb)) {
-			spin_unlock(&tmp_wb->list_lock);
-			spin_lock(&wb->list_lock);
-		}
+		spin_unlock(&tmp_wb->list_lock);
+		iobj_put(inode);
+		spin_lock(&wb->list_lock);
 
 		/*
 		 * bail out to wb_writeback() often enough to check
-- 
2.49.0


