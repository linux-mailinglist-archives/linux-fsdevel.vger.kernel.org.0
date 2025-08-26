Return-Path: <linux-fsdevel+bounces-59280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E10B36EBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D37F1BA8CC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9F137288F;
	Tue, 26 Aug 2025 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="c5I2z7r9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82204350820
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222919; cv=none; b=c+yMjP3Rv63kniYelwvaHzXSnKcPqu859MBGeqSNLr+wg1z0Bu1JwTPkbVYC49W8lchVVcVtMPDDneaXtBETA/+mzsxlXDMB1DXkGkzeHa8iKBws38LfKaGXLaOy4PvM9zhysM86yeKUrvKolXEc2iZLY2vKlZaNaWG3lJWHo+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222919; c=relaxed/simple;
	bh=tkUhaR2Wdt5kCnisT2HbbJH/eYzoHj1oGz3hiKRRSd0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRxz66Uk+0QJTXhx2IxHqCXQt1M0PodPLCkt9I+sjNAC+Etp/VitKqCzOsNtMEDpXerlYDhRhCb2IwScpqJ+kY2tC3AnxG9C84fOs6oyp0IzFCADKi1xPhQtnS48XLdWkxAm5hkRfEEZBNH8QMozpdv8DE1AuNP9ijbuOOA9hUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=c5I2z7r9; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d60150590so42820577b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222916; x=1756827716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=afAll3Ztw+chy5iK2sURo8W26thUm5pr0Qhfoj2rvnQ=;
        b=c5I2z7r9VVzoxl68ES1Z25gV+d6w6eJYv/6Bxlte/oj+84QvjtChOCwiegislYCmfg
         XFUBdiMCkmH3DimoO3xk+iXCCb/LektHh3tcGXDDRWBIL90wQjdtXCZ5uE/cs0KWovWF
         /eNoBYpC+RCgDGJS7HqroABXV8u6Hj3uQtFDPUdszi8bmi0c+UWIY918xSW1pjOTwKw4
         KJrsLIgxJ+FOcFyyrHaGWcFeEd8/FQ+AHBsDoI/zuInW9+lwZGnESZc9wMLr0NzhrIQC
         33lUYMb++s0q1v8cBpgCZ0fMEfZaZsQt+Wf2K5ERzoSXXY1peHTavVx/0Jr57qARt/X2
         C+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222916; x=1756827716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afAll3Ztw+chy5iK2sURo8W26thUm5pr0Qhfoj2rvnQ=;
        b=Wcup+ESiJCmJTJCS+fdzjk7OkvI6rp/IByCHtupoyFVuyVsPFQIqEiYbceI+3YtQwV
         GUTDaRZ4OSrJUNWOswr+7qNZoiycyvKjcMt/gUrnwIMoIlFxdhL964C32h+nHeSf36to
         SXUpLXcaqiFG1UF+j1pq+5dOeyRXFvpV5/3UTUz5GF+7M2k40R+KZeNGQmbPBwOJStmc
         0IuScON/7At78h+7e/5lsxrE20hj42PEeiXLhEMZpuvxYpovH/ozcgMO+5H1RkToMIxB
         bNGbRfAuVbmH2VGuv9syDS6gZSa44/YECOt9uxRtBHEimN1GmOnPZV3vIIOO220P7hRS
         EuGw==
X-Gm-Message-State: AOJu0Yx4eHOoyBKl+WBP5OhVwUcggji0hFNSFHTgG5qomucdGdUlCYKR
	MoIuHNENUhkgUe5zde4OdqVrBFsiHdUzZlIncmN7uZOqm/0bzs4UgmmzGbm0uLPGAQAWQnwJGMJ
	TiudJ
X-Gm-Gg: ASbGncuIJUeeMNLfC5W8XUj+f0tgO7BDjgKzhxhsMXzYoDAxEFjvvdB4vVJhsy2nadM
	kCvGl8fdfVQtnWOEl4mntOnzT8m4D1Z3tIayBsf3tRG0DcGi2rnm74YnQeyzAB13RsAId5d7qMz
	45d7GN5wWdottWlEfN4ox9l05pxXjktiTIjGFZE1yMp0FptATJWEIxFBdLc4pe/LxhbdK85KYll
	FEbYDw6kTWQsFRtGyQgC8upX9HpYxpmRAHvqIDYfVEMWRBxSD0dCa7e8iaLHj+kT2vikX77XwDb
	QvL/mMpj98slvLbaxpV6Z0YXXCGQ8rHG2IT5cNIiKKzVBrlSRC6Uo41MX7ztuRQU3bysunti7wX
	lokLdtmju2d7p9J3yublJZHMhopbj0fi9bhqYtTOQaooCkcdprvUzE4rOvTo=
X-Google-Smtp-Source: AGHT+IGcJ0F+Yu8LKKYT4wPl7uuybVV1LKhPL6NkeZN/ZOA11iSP+ko8POCF1twTXQouIMsAmh++wg==
X-Received: by 2002:a05:690c:3348:b0:721:3bd0:d5ba with SMTP id 00721157ae682-7213bd0d69dmr13183867b3.41.1756222916060;
        Tue, 26 Aug 2025 08:41:56 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18e31acsm24874707b3.67.2025.08.26.08.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:55 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 46/54] ext4: remove reference to I_FREEING in orphan.c
Date: Tue, 26 Aug 2025 11:39:46 -0400
Message-ID: <5e023690acf2ba9a94f12a5d703bb6c66ec99723.1756222465.git.josef@toxicpanda.com>
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

We can use the i_count refcount to see if this inode is being freed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/ext4/orphan.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index 524d4658fa40..9ef693b9ad06 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -107,7 +107,8 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 	if (!sbi->s_journal || is_bad_inode(inode))
 		return 0;
 
-	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
+	WARN_ON_ONCE(!(inode->i_state & I_NEW) &&
+		     icount_read(inode) > 0 &&
 		     !inode_is_locked(inode));
 	/*
 	 * Inode orphaned in orphan file or in orphan list?
@@ -236,7 +237,8 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
 	if (!sbi->s_journal && !(sbi->s_mount_state & EXT4_ORPHAN_FS))
 		return 0;
 
-	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
+	WARN_ON_ONCE(!(inode->i_state & I_NEW) &&
+		     icount_read(inode) > 0 &&
 		     !inode_is_locked(inode));
 	if (ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE))
 		return ext4_orphan_file_del(handle, inode);
-- 
2.49.0


