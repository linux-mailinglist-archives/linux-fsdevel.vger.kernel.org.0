Return-Path: <linux-fsdevel+bounces-59272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E97D7B36EB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634AB981E4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E64436CC87;
	Tue, 26 Aug 2025 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="uxi7ohXq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1548C36CC64
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222907; cv=none; b=Hje9r9axjHHy7fYe9teMAV5RcTVkm5elgWSW6t0NmqSVHaNVosaySsTOIQu5DI6uYureAZF3gQ65sfzRzbsX2AyxHQaZeDsQ6+i7E3mt682JepMzNGQNRTbyGngCpTOOqad0nDXysRD3L+MOcVHH6CjbF/dqiuhXmUuFewJu73U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222907; c=relaxed/simple;
	bh=1ynNzpiuwPqZZfc4RXGfh4iGaVDz+/1Rc+r/9GR0kTY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nh2h4FziGNprcY3vGUsnDh6CzyUxpY43BdD6j3rOn7LWpr429Gdr5kario7YXlA1a5MCmhCbNCPSnr6TvK5GmM7a9rYHJHariLQ7lpBtWO9xQpF1+yWFa9Xyqqc7LEk4Wy1MzQoUsf3epp8no2sPmB6bLQUBgMC0TpMPRJp7Lwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=uxi7ohXq; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d71bcac45so45864587b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222905; x=1756827705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7o1UME4c5fAFN/Xhsfm0V4nndfddrm872UrCQizuLdI=;
        b=uxi7ohXqKUcBZO7Ua+hc/ajCXggSTI51qc1be8CHoDfUpzc91NJRWTj/ghdlaZYRf9
         UZg0KXNhymiGudejku1NoA3cYkQKamjzBVlLEFd6DdClC3w5WTOYjiwjrdo2npfRk5se
         rccY1P8OI+uIIFRIpkNDPGmZORCr2dsZ5FwzsD7zEg2OYIpROZqzcWcry128AHtFhHlp
         40XeOJZzb9CJ3Pw9dhXIg7BYAJHGtCSTnyJwArIl0VKn+2nxcrh0YTOXBwxok1KBlNTo
         i6+JRCs2Ohy6I6h+rp+4maxUIdO91tkyGK/4frTy/5B5MYdwS9dXV8z+ZV8yR/zK0Gls
         O3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222905; x=1756827705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7o1UME4c5fAFN/Xhsfm0V4nndfddrm872UrCQizuLdI=;
        b=LwlIww0At+XXVOntpwiZ6YrSEY0QDXx/Njn1PowSMjVGQN1v1kgtAt7SVO5TEgoUYQ
         ZzknhwBMqghMemkzEJmZc5e/Thix+7Dc8DavaxFKtVWI0WgIUCo2xL9S5L64ogK++onV
         S3a/6JKAJ7XUc+hP/5yOSquPcoZmZTAZ6dAjhfRBAj8gCj3LLcsWk8hsl3bFMrh0gQbd
         Pu3PfVhZX3iNecJPxEfcXOALlBu4L3PY5nHv2PpoKm8bgpyE1Hkb3/gzsAA35UIRS0qM
         zwUtkdTUrcK1N66OjVvCUrbHW2HAFcXH20FehHX/PFz6Lw+gkaXi2T1PfJ7W4oF6L8iV
         tbBA==
X-Gm-Message-State: AOJu0Yyi7S2DOLBfeBp+rzuuXLV2vA6qLffX7MPqdKKa+KkcS2IN622n
	PfOXgJ8HAjTHjZm09S1gG1SeUt4MEsloNZ9CYiwaPkNjK1vn4K50w6hg43b3BNxqn+iV1A2lPfA
	JJ8e7
X-Gm-Gg: ASbGncuEj0+TQTyghln8e66xLjxeH9P7AZbNcJ8sAfB6xyniV0N0cvEJVmvWqs+XTV9
	1dc/HRpsHDjj9QMsIh8pXmTLZZxlcA4I8RwMbSBaQPArpGolDL+kr809EPDQG0ITqNYdOHKZDLq
	Xb6rrqsTnoGQPz64GScBjmV7RglcliKZhcqDun2Vpe/crqvNiTucptcS5S9wlIusqhlTgWt1cXx
	9rSjzqBFAd6/oXfGnpYHwc63B8Shd/yQaItB80L8G/f/nk6fkzG1d2zaQRZOkU9HVBadXLh5GCQ
	SV4BBcIp803IYL4sKOTCUOb2pyII89qKifSVAw3rv8GtRIJrsWSxaF7SsfUYhptk3yL1sBkDYTJ
	UP2SsoOoK7ROImag22zuhb7h+BSlt2gzke3Hp/WOlODIoJSbLpWpZslDHt+1k2OTr9DypyNqdeC
	Kfhqyg
X-Google-Smtp-Source: AGHT+IGukatO5Mwgl+iFpY8aNAJGoZlPwkGqVoc2HLHPS4uUtL3IivdATW29hDRBnU0HqwHw9U1Bqg==
X-Received: by 2002:a05:690c:6e93:b0:71c:1de5:5da8 with SMTP id 00721157ae682-71fdc40d339mr188030487b3.36.1756222904483;
        Tue, 26 Aug 2025 08:41:44 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5fbb1a885absm418881d50.4.2025.08.26.08.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:43 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 38/54] gfs2: remove I_WILL_FREE|I_FREEING usage
Date: Tue, 26 Aug 2025 11:39:38 -0400
Message-ID: <45b3bd8bf31cdb07d0b7db55655f66ab49ecc94f.1756222465.git.josef@toxicpanda.com>
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

Now that we have the reference count to check if the inode is live, use
that instead of checking I_WILL_FREE|I_FREEING.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/gfs2/ops_fstype.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index c770006f8889..2b481fdc903d 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1745,17 +1745,26 @@ static void gfs2_evict_inodes(struct super_block *sb)
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 
 	set_bit(SDF_EVICTING, &sdp->sd_flags);
-
+again:
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) &&
-		    !need_resched()) {
+		if ((inode->i_state & I_NEW) && !need_resched()) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode)) {
+			if (need_resched()) {
+				spin_unlock(&sb->s_inode_list_lock);
+				iput(toput_inode);
+				toput_inode = NULL;
+				cond_resched();
+				goto again;
+			}
+			continue;
+		}
 		spin_unlock(&sb->s_inode_list_lock);
 
 		iput(toput_inode);
-- 
2.49.0


