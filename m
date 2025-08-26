Return-Path: <linux-fsdevel+bounces-59241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B3FB36E26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9BF38E0405
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE10352FC3;
	Tue, 26 Aug 2025 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Qx7xDk2Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97973352FC5
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222864; cv=none; b=qRtX5EUmN9oDCGyj5rFRYqQFFrzP6n3MoBWXJvRokEd60u+9aYqcYfz41B0NkZ9aVwFzBKNsRjPdC5p84zfoy6Wp3YVP1ybtjsHdmcRt4nwFVmMCIoGADtwYVMr32SIq5PCoimk6H3YCpA5ECktbBdO1dxCB3zvb6wmIdiArY5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222864; c=relaxed/simple;
	bh=vb3lgatLL22BxERk9/b+lCqLtXz3W8a2P/7Gr1XM4H4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNAToFhPV0rxoYgTnNynmuBnHLGW9viPbrkaq1ZlFIHKpI5YadXBtPd0P9msp+/QhrD9NJDwnl5hAEm97dXD5R83FefKS/IhgH2nIC7vkqiUXXEltnEjXifNS/wj1UbQ7L2lTyOXzE748dsxPv0xsqFUYhRd55fJ/AiYIsFxBfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Qx7xDk2Z; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d603acc23so45327407b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222860; x=1756827660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TgvK09Ne5Aq6jRiEthgDjLIcJNkO/NakbksX6k8jf14=;
        b=Qx7xDk2ZZPH1b2wholEdBMKOO4Ugu9Bjzye6rSVT7PbRbJhUDERheM1oMAZR0k/jb/
         5/Ibffdz2WOiGrC1l3dKTc90rfmIvV16iXNw4tariDYGqhLaFGiq1ncqlrMYhPstSKMn
         8uHzstew7KMfdNxZUpzdGP/NKJ/b632/2eOdAN+cjiZIEkIDzorxXRMpjkz3wAAbkxFk
         v7Enw8MxdFr3Z6m/qKrTGIJ0yacWeiLBz6n3rchwtE3PiPZDqsW8msDwatxNMAEBNcsF
         G7MJv/v29W1PMa6Y3gg0MSmN1x3vnPgKWv0KUs/LE0rrjU9/jkwmxvkBiAWEE32429m4
         FtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222860; x=1756827660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgvK09Ne5Aq6jRiEthgDjLIcJNkO/NakbksX6k8jf14=;
        b=DuV3vi0ADxGE6YyQDOAINtDvaxO9LbwiQiAY7i2AghSNA2x+9xUKnKcgvYYSiq+8cH
         zmZ0SWr3dZ0PLATu7FI/gdOl+p+M8inb0ibyi2xH9lilfZtOk09GKtjAFws7FrqyVGLq
         19h1MjOdd/Cqz4mBCOdCZiRpoHgW5GN4XybQ0hwnMKsAEBnvHKx9hOBKL+a88EVnNpFB
         HJdmUQ63Z2BEu9/LP720h156e4wemJbIWMZZhIdx8+GZ8XcXTXXQv7ev4oRVGHMF4AAk
         V29nMf6Js5yI8nYUUI2jmKbcRYyDGfxsu26UUMP7u0wkwFZb75K82Cqer868RiLXyqnJ
         bm2w==
X-Gm-Message-State: AOJu0Yw4N6bMe4lftoX54u9AGS9zDOkF1VjF+URebLBS0ypNQomgV7D5
	Aeb3QeVepavMk8yxWENAkreC9m2InDQCSB32wvZuYyN8fb7IX1oYUAzksnkd15xcsTXk3O4w2Lv
	RosST
X-Gm-Gg: ASbGnctXOUHespWVUEJVVRSsGWbeEOAD47ORPbfZyY1DUPGLdMOHOHkFJo4dF7GhP8c
	oPXwH5g3n2Rx8itZBGyJnD//JvEkqVIwGBL2K+osXCQTly0HkowU1+r1SzNcI81ANLYwsZLb2FK
	6y1nTD9ckW5WBiVLAT+fFqeYhOXtJkFwbZeGZOvZ2Z8cpezMlc9WIrnHJnuzETu8s24t5Kt1eiI
	x1baBELkjOBOAtlC1yqmBrWdwye1gSCaIJObPtH9LP/3aYHI9UhzfBrd2qlEvxVyM9NMeyjvL+H
	nNrlMZKl1zdvt23AGtKQF4+bIH20BacBedh1wgwUva3IZwf4PRPVoPTfpVmc1lTODKyZXJX9oFG
	6L1Jx6vi0n5LdN//HHd+v/BBvzX3DRL17t0YvDH7YyjxCjvVW9U30MzVMAaE=
X-Google-Smtp-Source: AGHT+IFHc0cd1vBL1NZ56pvHPXho4UE/Yj/BshipiSC1BWzt1LmJ0zTyz+AzopKHLGkL4tZhqzzqxw==
X-Received: by 2002:a05:690c:6108:b0:720:2af3:fad6 with SMTP id 00721157ae682-7202af3fbebmr100372157b3.17.1756222860145;
        Tue, 26 Aug 2025 08:41:00 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff17339fdsm25180647b3.21.2025.08.26.08.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:40:59 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 08/54] fs: hold an i_obj_count reference in writeback_sb_inodes
Date: Tue, 26 Aug 2025 11:39:08 -0400
Message-ID: <1e555c73564393129833d550965e3175c142bb84.1756222465.git.josef@toxicpanda.com>
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

We drop the wb list_lock while writing back inodes, and we could
manipulate the i_io_list while this is happening and drop our reference
for the inode. Protect this by holding the i_obj_count reference during
the writeback.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fs-writeback.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index cf7fab59e4d5..773b276328ec 100644
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


