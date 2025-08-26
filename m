Return-Path: <linux-fsdevel+bounces-59274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3351B36E7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1A3D7A5A79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC0434F48A;
	Tue, 26 Aug 2025 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="A5otpevE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64AC34F464
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222910; cv=none; b=XGE2AdrInsJ1v9iqA1YpQmgHjKIjEgVvwM98ZMzbk+3dYHE2Ui7xkou+9Jk25CXjxAEkLODBs1oU2rhVR8vx0lof0IXkRSDiYNjk3n4bgMfbfwQgKc1aj0m3RxbwBt6zqbzpcyYv3c9BNW5UejE/3f5vhDATVOfg8LwIvky3SrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222910; c=relaxed/simple;
	bh=m+sUlUspLqIWAgATvlSwBwWt4KCBlddh6LFbQXfkBEM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TB+L5Kr9y5cfZ3JLFRJ0v5LJS57segoCzhY6tp38IfJ8tbuHYAmupExymmMZtky4F/SXqW8mGlkkycGMOx1BwH5kTgkfavYYX+hw8W9OPrFbT6INsQ1T5ykzYPVCEtQAxm/hP+xPzoAL01PVWqHdrnaOkrGBSg2CmJLA2xP8Acc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=A5otpevE; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d60504788so47008417b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222907; x=1756827707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=alkILxWqr/LmCgOsh2PuAUd8yboXHrvMnPHss+yxiwA=;
        b=A5otpevEudPAs2Kt9rfSBPzBPiuKCs+hcdFzHIZEMFDr1jJwHa8At7JaBTOxPGWb7l
         v1kQmy5SiVNZl1bbfjo2pzkMkzWV2dwJIYb/bzQbs8u2KncqvyNeBR9NfrC3YF4NX0xH
         j+l/FRJvAzTa8zz77CZLmsunLOGJWALjzm/ykm21a2+bG+U4e3uIQ0uh8oAQSk1nZhBG
         7ilc5GnvNR88mBjDCc7Rso17LapQx/KfqTobIwQ+V7GXSCNK3muZ9YPvBTcSVQMgf0Jk
         bJp8gbWdBuKgm80egAPoot3L8ezkAw7lKXN195FwxZP90Noa62N0NOxbxXwH/l62alv7
         23Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222907; x=1756827707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alkILxWqr/LmCgOsh2PuAUd8yboXHrvMnPHss+yxiwA=;
        b=RJcaeUeKExIijbJF9hqyhikkW6LOXeONOQYqxlEXRbKW9+g02juoziUwowcKQS3PDG
         SRFYLV0jgo2oE4orswstWh9n4EBw9hCNaMF+caWlb6NlvCqtHFgOlaR93MxXReWymR5j
         JwN86Q2uXPUFCN4CIj7JPVNE1EtgcQb1WeGYSL95sq6LJ4tjUjvvoJ7Jt1meDfxjmlyB
         uwr1+KcOEoSx58JKN8zofK7Eibjsw1o0uLR0BswzVbc3p1W20E9Qb9lc7ZMZZYytF5/e
         /2E5ukdKgCCNfXImkGzWkg3RQOqleBZ1gpDIxvWPBCrLMmr0p+9RnCeyMSmHV83u7xYO
         BvkA==
X-Gm-Message-State: AOJu0YwGapMnV3i5t+iC4HlVdOBtvWbKlq1HrGGcRFEHWFBvpIgsNJh3
	EhEvRCRo9z2SDRTi7G8oSvTxT46WPH6Cda3JP2Z1HOHfd1AF87pIksvyYLOygv+B/5h+yutcDJe
	A8yrR
X-Gm-Gg: ASbGncuNz9ftujbCb1KQTJUmhVc6GX4y1KOcOnbjuk+raV+C9pEckcZDsql9u3DsPSd
	ucA2BmTjIaOzHrn0IX8bIfQpnU0pau3Fjsf2V5tg7hfzYPTPKBPkb7Ht7vGGA+bpYCsUa33ryIj
	vsivg+shxGRB5CHR0zytLa8aAoyucquSMZbFSs9X5fZ3DerdueWtn/nASsL2UR6DhmX+8vtdYJy
	VitwRTAgZnT+7VYqyVaRV8g+CtVXivzT4rQHMQE56Vn/WHLdjk8HTIKxxenII6R+YPS5OM27Fxb
	oT2CqHpgPEIA8UYS9xdPbLev458dh8y8atTlCqH/vtZQsBduo0IiKRMpCE/t+CEI9EyLieRNWLD
	EDivSZRlL2pFsMC6ISLczr1YCkGDbB0VMUmr4ES0UEurJU9McyzubfpLIdsZYopbQ+MRAyA==
X-Google-Smtp-Source: AGHT+IHEY7UiuwZsDzTPmXSQVgcvtXTUxA/hqZfermlmHJkxzpNIVBJ6NmVxvNzn0Yu9TKer1jXgcw==
X-Received: by 2002:a05:690c:5:b0:71a:42a3:7b47 with SMTP id 00721157ae682-71fdc10b936mr194714767b3.0.1756222907406;
        Tue, 26 Aug 2025 08:41:47 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18b4198sm25314047b3.66.2025.08.26.08.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:46 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 40/54] notify: remove I_WILL_FREE|I_FREEING checks in fsnotify_unmount_inodes
Date: Tue, 26 Aug 2025 11:39:40 -0400
Message-ID: <2d97e6a9ac8347779762684ddd720fa8ec53a7c7.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
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
index 46bfc543f946..25996ad2a130 100644
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
-		if (!icount_read(inode)) {
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


