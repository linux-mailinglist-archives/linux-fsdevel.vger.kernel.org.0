Return-Path: <linux-fsdevel+bounces-58680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4742FB306E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299EF188D839
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3EF374276;
	Thu, 21 Aug 2025 20:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="mHgOvNMB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D960C392192
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807684; cv=none; b=jneluIpfwk6jppLC4oxkq8+U4Mvup3Y+VsfMr6hvTYqQTSAZWPK5/KbegrJscxh63t17dEjI/1nuITY5YcPf7kKUqP9rlR//J7ICIq/7+jiGDSMOnMYHPDRHptdtMq03Umw9MOdZEyxPSYlJZEPvbhHF56HMzjidHU13rBIQf4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807684; c=relaxed/simple;
	bh=dcsAxEHT5Jq2nRSpkM5+vx6RORRZ4KO+wi+OUDbhG0Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epWfTDXXq7PVuQu9U9m3ICs1cOcr2Pq0GLb2chhQAPPOhpJxA8xh6QG725JK59PoFL9XCoYNbSEygZ8RD2VRC7F+3w/rxd75AzN7krdDNMgPdZoIZAYWt8Qx7I6tMYLf0/cB86O9kbczmx4+hOlW+ahVFS2HKDRHgBFgD/sEPyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=mHgOvNMB; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d603a9cfaso11272007b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807681; x=1756412481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AHd+4Vz7kPVwWP6qqpZo346lGeZ1ejCBP7K3x1LyEEE=;
        b=mHgOvNMBzYdTWyof322s66jOucc2q08/MzV/xZ6yIs68LuEQFsPDQiKpgqruUbkZVZ
         QJLfgykxXhhEo7I5B70Qd/tJbXqZFpoqO7VYZEDp6/EcYsuRR73OTOK0EXx7qqrfcOkJ
         0lDLZNuvSklFEAkeYMR0KAI3xpEShNzf+uNRLP+J6b/cTnn7NE5jeQWcghM/02+jNR2K
         RvfJH4vOJlZn7E4OfDJmJvvctBKIzcD5AimKMQdJvO6VqjqVgtpLbVr+5Bvx4abTDvPQ
         k7I3dkzfPrcJTSyxLEeA8Y8IWZN9kE4yqly0AxznwrI2MH5zHV+wgurMMKRXk8QSMtma
         FwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807681; x=1756412481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHd+4Vz7kPVwWP6qqpZo346lGeZ1ejCBP7K3x1LyEEE=;
        b=tzWRhIqCHl4PRdLWCGwFAX8Gfg/uUcxqT670gCHSYzbgBIfcn+N90UdFDJYWqOXTJU
         y9W8EtTkxCKulPLJrvlccXZfpb2L86bnzC9CtjePwiMNifHU21+WfUKGhmjSi9vV2PsW
         ukHgJLInFHguwEgQvFiOXXDZ1Ktoawx6Yo2yDK7kybvFMmot+Ut8mhFvDEeTLvlf9q/c
         ESAIolo2ZXVCqGivuZ/aIYooPwSQq5DHyPrG4kFW7+HDaIszUTzOzPCsEaE/1r9IENVm
         tXTMHsCQ2edMRk3QoFrgVuKFt/KLpAd4eGZhamOINXM21ChFyXWE/oxtvOTYa3a4QlZ3
         WHvA==
X-Gm-Message-State: AOJu0YybXIb7x7Krzfz9q3EKcfVMeHZxfedS4Yo6T7RFYviSKSRHQcEO
	nGVCK2H0WJNKuYAWEkmIfdhnlGRfG1iCdaopEkdGtbi+lMIDmkszeHu65JR4SElP5xtJGIEVpsi
	y4/mlJODNVQ==
X-Gm-Gg: ASbGncueAc4GexT66XNhyb/FQALe8h2YjnkW0Mgaf2JZz5ZDby+ceRku+EOwiovZghL
	BnIoiHpNvFYrjjHoqEwxVSLRfipryhscb/ZFEOCxMYyUTVMzLqBKP6BU5VAsjFYr46rlDUrrZO/
	ylTe1SjBE/J/yyzjJYr1TDPL6v4AIuHf/dQcP9Of2fC8dGO5YWiwkoIsk5GIoltgZlQ4tkqnyTk
	L4EcSCEQlElOxE5pWHGiMgFzurKIQ63DZ6SwosnzJtBE4GSJt+Tf9wFVl4v/+XaKWn3YUuBt8q4
	/oXLeoOBS9V7Osm8CnfxxWWz+jBXANoCCZ0uQ/PSFDc2iThYTKLQXsIBg21FFCntN5RK+U5s6H8
	ARvwRzS0AobdnWZxLkoD+XAgGL1wwTDx3qW9euAdCt1jMxytyYUIfJw+6OdRzdLdrV7VINQ==
X-Google-Smtp-Source: AGHT+IEzo0QXY9VIuY4baShzyB2YhjsCyUBZU5mUEwfUAhGbJD1bAOOlVU8KN48xmuT/FokHR6oSiw==
X-Received: by 2002:a05:690c:9a11:b0:71a:a9c:30de with SMTP id 00721157ae682-71fdc418f92mr7089417b3.41.1755807681418;
        Thu, 21 Aug 2025 13:21:21 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71f96ec62cfsm24521717b3.22.2025.08.21.13.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:20 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 43/50] ext4: remove reference to I_FREEING in inode.c
Date: Thu, 21 Aug 2025 16:18:54 -0400
Message-ID: <ed4673380176f640f0d33201387999207dc1426a.1755806649.git.josef@toxicpanda.com>
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

Instead of checking I_FREEING, simply check the i_count reference to see
if this inode is going away.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/ext4/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 7674c1f614b1..3950e19cf862 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -199,8 +199,8 @@ void ext4_evict_inode(struct inode *inode)
 	 * For inodes with journalled data, transaction commit could have
 	 * dirtied the inode. And for inodes with dioread_nolock, unwritten
 	 * extents converting worker could merge extents and also have dirtied
-	 * the inode. Flush worker is ignoring it because of I_FREEING flag but
-	 * we still need to remove the inode from the writeback lists.
+	 * the inode. Flush worker is ignoring it because the of the 0 i_count
+	 * but we still need to remove the inode from the writeback lists.
 	 */
 	if (!list_empty_careful(&inode->i_io_list))
 		inode_io_list_del(inode);
@@ -4581,7 +4581,7 @@ int ext4_truncate(struct inode *inode)
 	 * or it's a completely new inode. In those cases we might not
 	 * have i_rwsem locked because it's not necessary.
 	 */
-	if (!(inode->i_state & (I_NEW|I_FREEING)))
+	if (!(inode->i_state & I_NEW) && refcount_read(&inode->i_count) > 0)
 		WARN_ON(!inode_is_locked(inode));
 	trace_ext4_truncate_enter(inode);
 
-- 
2.49.0


