Return-Path: <linux-fsdevel+bounces-59270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D413B36EA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45DB3364916
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB6836C097;
	Tue, 26 Aug 2025 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="pwylTXvZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EE736934B
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222904; cv=none; b=dZyZA0ITpuCAuzEfmvfas7V8jKdwFdKrNGepJ8WVVum5lM2IRRkwPglklf4MQfvbXzzqSB7JC9bX55BNi2/3mXFdP20ZyioNtDMnNLYjkGiux80ey1SFcdx0QhmQlwPvyjguHFlfKrHc2+018kkG8SUL4XL1bHOW+IDsIvzuP5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222904; c=relaxed/simple;
	bh=I8tiOyv+oMFkzRzMCj4c/X0bwN+yK3mHwtJz9daUlt4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMD4051V6Dw10nwfuZ7KQKGx4udiEOXBFEiY1fvUIf9Bf4zyVv6J6FGlemKAHqFL0hB5qoQbbovARa2eHvleK7Ev3lNbkmQsyhNsJIIRlbPR+1YQO57JJONIMKkHQXtgXic/91nh8oMI/5xq455pU+5rvVAWI/S6jngyRgDnP4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=pwylTXvZ; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71fd1f94ad9so46391837b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222902; x=1756827702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7tCn6brW2Zw7rSbRSTNv27z2ReNHNSMYcuiTIB2+/A=;
        b=pwylTXvZIek9rC+cjh+rUvWRMGRxPPKY/12OEde/F2n52BIvEfVk77wjSelJ03Ul8H
         Fve2hGzxBxhUJFEt/rUiBuMfdMC6mi2cUiTUlzlrLLkHgntPWMVE3CUuMiVWHw30gei/
         i8eVFnU9D+j2N12TcTZ5rawZJM9V+zQZW/pypw7vN22u+JOca8YudhpXRMn7GaRToIyu
         3mnNOd7oTCK8GUXVM4Be0GqypQlFAfwyKMfR8ksNkOixcU0XAUIfg0IawAQ3nPEdtwxI
         my7ELj73tIKtEytDRIhjG3qWe+kRGCAnI0ry9llwWvEn730sFEOM1iYClkG9EfzB1On7
         ua6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222902; x=1756827702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7tCn6brW2Zw7rSbRSTNv27z2ReNHNSMYcuiTIB2+/A=;
        b=TfeOrRMqTVjmDaWdqzpAdJ3i+ks8nrMntTC0fwfPc8YGeahOraUbsL1OcJek8wibVK
         V3AS9v889HhwCP+RRhw+wC+1hWJqVAlYQs27wdPEodCGURqn2ORKhcBAgr3J8+TtSLFF
         FWmOWrlWTpGjpQik4HQqxhgAExPm3i0YFTFkSNcCUh+zTMkhrija3V7yi7B/ctnTAYCV
         2JOi0hI3zmUb3tMhsryMMaUfBQNjo7Si4p74S1deiIXOnjIk57Yst/1I3vd1YMycAUp3
         75zOnthY0klhyzfZFg8EiLIJee9Tq8/cwXpi4Qun1zs11Ys0Doq+YvqvQSYBMaZbb7tb
         pJkw==
X-Gm-Message-State: AOJu0YwfqH3l9NLMTjMCkTIkNAAwjjx2IojAC0J7465GLCtRsxXxJGHJ
	8dUATe4Qd8mKXpMOBgElmZ9G1pTSGYU97ZYgy+xzmMkpfIrmqzExqZNP2yDelFGhtG40+IHu1SM
	ftIba
X-Gm-Gg: ASbGnct2nHDVTn3aJxHlK4jCdIirkv6FYjwChR2RL/sZE9r3JQdu2wmnZ56GrRxZBmw
	vE13Xhwt9xRJWXUmytASp3PoYBGr9jRMMWJ06HjCucMX6S1CbTObSh83t2S4+6tI8U4mdD/LWFt
	lms/KARlHjiRip+CGCDaNpVpJ3sHJa0EWYn86P2ozkJA7W68pSkEV46/k2ih5zz434x3zYQKIhh
	foNzTl+py9jr18gL3Et/6D3LgXxLgM9x6LNBO7lDnaM98Gz/wLXp16JVsIMCSSwNfDpsxL4TY+H
	ZY28YB+rXJuS77vGKSbEcr8QyWXgJvve8l/80yn23J96DrDybBIrvjD+AbEGU/+2lWQ18Tn1ANK
	3bgIIxHARgQemBa4wVwq8qT579rkb74zeU33J0fueIsoqTO5ax/zOv4oL4lk=
X-Google-Smtp-Source: AGHT+IGBAJPmxte5sNeC5FD2oABugwlxmnWPA9F/dg7GKYcMncBw9P2DHou91Bjzh8qPzrObW8jwHQ==
X-Received: by 2002:a05:690c:4889:b0:71f:f24f:ccd9 with SMTP id 00721157ae682-71ff24fcd8amr158166887b3.36.1756222901377;
        Tue, 26 Aug 2025 08:41:41 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18fc8f4sm25008697b3.77.2025.08.26.08.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:40 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 36/54] ext4: stop checking I_WILL_FREE|IFREEING in ext4_check_map_extents_env
Date: Tue, 26 Aug 2025 11:39:36 -0400
Message-ID: <716903e50725460894cd1b2591f9bb2cac90a2e2.1756222465.git.josef@toxicpanda.com>
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

Instead check the refcount to see if the inode is alive.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..2c777b0f225b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -425,7 +425,7 @@ void ext4_check_map_extents_env(struct inode *inode)
 	if (!S_ISREG(inode->i_mode) ||
 	    IS_NOQUOTA(inode) || IS_VERITY(inode) ||
 	    is_special_ino(inode->i_sb, inode->i_ino) ||
-	    (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) ||
+	    ((inode->i_state & I_NEW) || !icount_read(inode) ||
 	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
 	    ext4_verity_in_progress(inode))
 		return;
-- 
2.49.0


