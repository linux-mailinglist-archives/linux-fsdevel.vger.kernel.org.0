Return-Path: <linux-fsdevel+bounces-58675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCCFB306D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6BD3AC840
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4CF39192A;
	Thu, 21 Aug 2025 20:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Noh6+6O1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F65374416
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807676; cv=none; b=h1KbxgNowThrGsfUlxw4/+oeaemHR6IkpPxhl6Aqp20BDo2R48clnZMwu/mze0v39ha3SL01wPe3lXSHWJpbaq5ytGbyRryGzw4BJJAxtPILYXzUNV+GTXD2rP5ZHPCVsDBvWsoESRs1Z6wcYFukYES8nccobXCb+nVXUA8yCAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807676; c=relaxed/simple;
	bh=ncJFwZEJnrUj8IpeTHtrl/YVsygglgXTHVy3Yq69xu8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXd5v7nxaotWySR26HRVxmTJVSxZXmHqn8yCK1P7jJ1HFlWbtzvRCDpUJvbHjIbMmY6OT2P9PhHFVr/6eucwJ7TPGjt5f/0SehzRbhj00quelRhL4VNZSOiGIw4f/HjVqUpJbeHiaJ0Thu7usBzJ0WBKqRqgNBbTKZoKna9vMTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Noh6+6O1; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71e6eb6494eso13049667b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807674; x=1756412474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g58GglhqUUo58s59oHZ910JXpBoXdBxDvcz31WoZTlM=;
        b=Noh6+6O1VBrZag18/Jsw752jC+t2WdDij1ILyT2rRFYsHyJGGN69lGgbCytGxMavtr
         8PVJJOo1qBT5zfZ8d8V4mT/P9JlxUjEpBr/T8Kp2bgvLFm/cFrBhQLYmq77NGUon/G8i
         NV92sSUbhdJFoNO2kTnAApAn7uU1nhUhXKZ8UOcK6JT2suOfRFPdZ99SnS2KgOrgmrTd
         CGl9qjbIhnNwpA/ZnYZyE/SxBFipPIvMLgNB4AhpP1lCkMfQKpIl+G0WdCVMvoJvgfO+
         u25zDuXIF974jlrCUrkp5w865xNa5zoicWgjxUtq9mvNEsUZLEz/xqCNBhfF7Nw6xPgb
         tThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807674; x=1756412474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g58GglhqUUo58s59oHZ910JXpBoXdBxDvcz31WoZTlM=;
        b=CTzZL1QSO4UFGZcTy0ncP56iEMq4M2i04O5LeiSsXocg+6bkRXXczsWZHM/mGJXO1l
         PLSsoCrKksFze6/F9lTB92b03WYpHn1zz8p5SxSlKi99I4Ekwe4k9ov37SkRhIPyLUvd
         a8n50gE+rLcxoUn9PZfuDpmAPaAh9qcz2elZsb34DZxX9+vsUke3gTxVMueo4/x+zrQ6
         iQQUacKt/EiSiptIhGAaZS1GBBHeaE2ZyOCs7DVVpNrBGGYB7RbfvWfg0dPVFNbJZjZS
         0at4izoEHyFlrQbLmCAsG0KdapSWd8aR2LJGncEPtVo0hojiJK8OOhIc6X2ZVcEbvljh
         KQ8w==
X-Gm-Message-State: AOJu0YwuaP7UluG5tuVGPGezOuv8ffy9CEJQGE/dtcDqT6k+DZA2d9h+
	BdbTwh5bx5b6gHnuV0j29K5i7Z+C2AUzge5tT1X5hyL/M5EcgQhFbcKkzbJbQjT0wWvdsn0Y/3S
	qrBL412F6rA==
X-Gm-Gg: ASbGncuEbpl6pBVDqtpj55USP3FBq/4cZvN30cakI8Q1hClTFQhqLaC8itmu1igPkBY
	zNgF3WyW1LKznYZbJfriBgNLYSLR4dqRBEclG6ubw09S8XkTgFi8aXbYbcIT+IBMGs7dyaTJiTV
	yDZDkze2iGNvRMfQ2ZGZlwWCnFs3cPHXeFex1YVO+5obkPFNSiHsQji6O7c6RuRNwyDrxLM5L7I
	/c28hIqLLRLe5PcDChqypxUNFWm6Xbw7VSEVYZEskTjRKaMz0fIAetS2Q+jW57+qiGKb6Nm2i41
	136VptQuxrgKHxiNR4FPfxu0Mzvr5LWrEaqq0/ABmuiD/RcUQ/Omj7VKpA2A2I0LUhuGEWVypWT
	4LOM/8LZjufgFcmZRv4v9IwXuD5uN9xti++dp9UAJjOZo6cu6aJSLSn+Z8IISbt8/By8H9g==
X-Google-Smtp-Source: AGHT+IEqiDcFpm5jVq2WLhuv9tbmk7e+a0LbMcXW6cqI1uIKhRjkqvGvdJzMtVHbr+LWKhC12dhjiA==
X-Received: by 2002:a05:690c:6702:b0:71f:b944:102a with SMTP id 00721157ae682-71fdc5389camr6706207b3.51.1755807673675;
        Thu, 21 Aug 2025 13:21:13 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e84367526sm34113897b3.61.2025.08.21.13.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:12 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 38/50] notify: remove I_WILL_FREE|I_FREEING checks in fsnotify_unmount_inodes
Date: Thu, 21 Aug 2025 16:18:49 -0400
Message-ID: <6fce2524c1614e400f399260b5a2bc5c10d9dacc.1755806649.git.josef@toxicpanda.com>
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

We can now just use igrab() to make sure we've got a live inode and
remove the I_WILL_FREE|I_FREEING checks.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/notify/fsnotify.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 0883696f873d..25996ad2a130 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -46,33 +46,15 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
 
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		/*
-		 * We cannot __iget() an inode in state I_FREEING,
-		 * I_WILL_FREE, or I_NEW which is fine because by that point
-		 * the inode cannot have any associated watches.
-		 */
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) {
+		if (inode->i_state & I_NEW) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-
-		/*
-		 * If i_count is zero, the inode cannot have any watches and
-		 * doing an __iget/iput with SB_ACTIVE clear would actually
-		 * evict all inodes with zero i_count from icache which is
-		 * unnecessarily violent and may in fact be illegal to do.
-		 * However, we should have been called /after/ evict_inodes
-		 * removed all zero refcount inodes, in any case.  Test to
-		 * be sure.
-		 */
-		if (!refcount_read(&inode->i_count)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode))
+			continue;
 		spin_unlock(&sb->s_inode_list_lock);
 
 		iput(iput_inode);
-- 
2.49.0


