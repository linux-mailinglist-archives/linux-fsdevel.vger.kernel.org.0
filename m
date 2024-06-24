Return-Path: <linux-fsdevel+bounces-22248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5677E9152E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 17:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A24E8B250B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 15:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E10E19D894;
	Mon, 24 Jun 2024 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Pt4hFpqq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BE119D09C
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244244; cv=none; b=S2w7FngF3y464iqznEdet7EaXF/Wc4DJgslCzCohWq3UMTI5pNA6z4mj+31POM4oPERORH3z9NWqFDw8pBxb/P0MVAq73Ac9xcy0DNzp/IAe44QLggMR+OQASVAEznSSlV1De6VZnUNzXpSaqblRsRi4sgFLThifI8Ti/8U8rFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244244; c=relaxed/simple;
	bh=K+A2IEqmBZeJw1GjB89iMPUcRsnzPu0hHoAFUAYhBvw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpeSHTtjXP9Cp9/rC4CqlFko2/GZ8HU0anXbW8zmyoG666DZHaw/TmNmchwbLDif+Py3r6hit+tv8ohSG6hmiS0OSsTMiKwyriGSERW6yJB6utKOpdnFP91ph+ih52VnQfnk4Kh5H/N+xorZE8c7f/FLuejtbolHqLAZWBwYQwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Pt4hFpqq; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-797f2d8b408so301008985a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 08:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719244241; x=1719849041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6flFxXVVqJLCrwleRzZ+Be3V8Fb6aljcx7RgVVG27BY=;
        b=Pt4hFpqqtQFv2cCkoJ+umBpGX8X2V1UZTg4vCpNFvzXnlSnZbRkSuTrI/vkFR0YS4l
         fvn6x/ojHBGw+0EpBUwR3LSwEvhbNpCYQE3md1ezW+4Cvy4hvLiMQWDzMuN+etuTMxbo
         ufjPYWS+GujpL2+nujdjJ5rIVt3f/Zt7u/5sk/3SukZrg+wyqEc6NKDWrC6IpQpS7vAK
         CbWF/1/3D0eJ9+jMG9xC9ChJOHzXwfXI+k03iofL0GAkRN+aDjBp2l3cBLKsULVgrFHb
         A7mFG4hWvUA+2PPI+NDPL0N/RAoMO6TjlaJGopOej2MvDHbsALtPEITzVddUhNSQys2x
         megQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719244241; x=1719849041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6flFxXVVqJLCrwleRzZ+Be3V8Fb6aljcx7RgVVG27BY=;
        b=eA3Yx7lLS+ad6DvUiPhKxrvHjKZssqeflX+7LzGkkN+QuQ+YPVz8R32ZcNbzGuELl8
         N58GipJHaMCvRwQiNls6KWtQImVPU0ICjRxX1rDFOeSeXOpYj7TT0nt6XI/BI+CVTYN2
         Bdf70/zvVwPdef7lcHREDVzXntS5h3zMBG97sbRWpauFjNTXwIMPyRfjzxv8+M3Y+CDF
         7lrJDYm4BmLa36R7NKkxS3Eww+FO2MqzMqzpahoG7UOp4bq6TlCE7oeXdX5kL79zCUFl
         NTd+TWxqCw8ZyrlJMUEilJ0pTl0DuWa9iIIODQKxRYX2VfMMFJu6kWnjqo1mQi/bc0Cw
         SNdA==
X-Gm-Message-State: AOJu0YxcAIG4kLAMciv73F5Q73vFmWnuhXQXXTdeBuDpCMDPoFyYwPdP
	FehIzOKnWlgy4gHwLAUPfyRJs5KjL0Qt0wtA/vRuAKJWjYP0g/1yFwg7JfniE4XIO93lpThlF52
	Z
X-Google-Smtp-Source: AGHT+IEaqtS08rspOq71bml1N+L7TsL4csT1IcVHvWCuQ4XJlL3xpw9EKFakg6+JBoecluoS6QcRVQ==
X-Received: by 2002:a05:620a:318a:b0:795:573d:6192 with SMTP id af79cd13be357-79be702b585mr654482685a.77.1719244241335;
        Mon, 24 Jun 2024 08:50:41 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce91d8bdsm323771985a.76.2024.06.24.08.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:50:41 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	kernel-team@fb.com
Subject: [PATCH 2/8] fs: relax permissions for statmount()
Date: Mon, 24 Jun 2024 11:49:45 -0400
Message-ID: <bf5961d71ec479ba85806766b0d8d96043e67bba.1719243756.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719243756.git.josef@toxicpanda.com>
References: <cover.1719243756.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

It is sufficient to have capabilities in the owning user namespace of
the mount namespace to stat a mount regardless of whether it's reachable
or not.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 253cd8087d4e..45df82f2a059 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4933,6 +4933,7 @@ static int copy_statmount_to_user(struct kstatmount *s)
 static int do_statmount(struct kstatmount *s)
 {
 	struct mount *m = real_mount(s->mnt);
+	struct mnt_namespace *ns = m->mnt_ns;
 	int err;
 
 	/*
@@ -4940,7 +4941,7 @@ static int do_statmount(struct kstatmount *s)
 	 * mounts to show users.
 	 */
 	if (!is_path_reachable(m, m->mnt.mnt_root, &s->root) &&
-	    !ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN))
+	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
 	err = security_sb_statfs(s->mnt->mnt_root);
-- 
2.43.0


