Return-Path: <linux-fsdevel+bounces-72505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 46382CF8845
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 14:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CA5F3075AC6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 13:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB192330332;
	Tue,  6 Jan 2026 13:27:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE220330644
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767706073; cv=none; b=gEvqnTVCKfm1Pz+cPaKWfae4HqmKAt7TgqwXk/8SFdF0ly+zw0Q7UGBluJyI/1ognBI2Co9rITxN+hAqIjTeha6fUz3h+Zh5+XE1WpTb7zLNqQsJew4TLZScYTik/EflmUdwkrHd4wR8vgluEzDKIAi1DB8tPDTfgA4WWW8joMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767706073; c=relaxed/simple;
	bh=qVudGycKqbPfaGQrtQWqrmhyxZSjXIqRlgT7izNGSKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EF6wvJeio/p5jjG476VZID/nr25Wgecac5Py96qd3Wn/4zA8c+Q2UYKBBgrVf8jZ1OPIetO0t0/72ytNAVfjKsgcIVqmo4nrKOGplcoqa7UhcEAP5G3WIx45URFLVnEjdT+H+r2yaG05o7bspOVWA/iW3jNG5g+9DfYvWFLQhjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29f0f875bc5so13214685ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 05:27:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767706071; x=1768310871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SKLp/eo5/DTa4F8EOOCq1r8QsMncr43hczwzVx6VrGA=;
        b=Ux3ZCmxDwy3NYRIY7gH51cFEZswUNra5vnsvkar74nWxoaF7k7M9mOVba+pQE23eYQ
         Ze9n6km8EyimW/dJk8RMZenuI9R4E5lZMD+IEdFbUS7GJfx2nkIw+wdytn5vltj8VJQ2
         seZVQOzMCihLjra57/Lj7w7oSsZ0XTGY+1VhCvn3h579ybr1pufxePwHjstCG5N0pSYy
         qH43f2h6+oJlhFdDhO3331P552/+V8pQs3kOZ0VKnvFi+g2UmHiNEU/byWvVghehw7yQ
         +lNrNiFUp5ENo76tFupyVZWm1S7k9zn4evuadDzCvs6YA1cl4RPSid8LMQp063km38s5
         zC2Q==
X-Gm-Message-State: AOJu0YzlEOLGfOedwqzkT4lDgLXZIdT/WdRqiL+abxfGaRX4501mL5sS
	ZjCCVrKkkkZdpvPaVEJD/XO8hlWR7eZ2WO+PrZV8XjUCIY1MHBMhFncm
X-Gm-Gg: AY/fxX4OPSusqpc2qbOQHtPsOrn4rn2WambjBz84GZ+Hs36d/o9LBuH+/74F07d9RvG
	3eFRYzquqBCtlyuoxjb3vIPOl1ZTf1+7I3WH8rsZ3/ZMDK27aeAtwtZKLd6anHAmz4RMD63AyS/
	hH8nfEM6JQ0YZW/G9u+nA9BykgxMs0HaA6V8DaltsY0vSPsyJd/Jwn/zKsbriiXeAmNv3ye5LTW
	7l4DgNRBv+p/weJ51BaDma0lev+ghaUqBq/VWbL8vDKMMQXJEcPFhOIelGY6bJK5YD5S2sCG/tS
	p+8pJ1VKDGrghFqbKzdnbOZ0vIqKHhLv/GJdHVCAIiovDE34y+Pj1jO7HB4dkAb6y3Q3SLAoEN3
	MpoKtUEHPloz6j0wyvdzRF4ecPHCYK81rAw9XiKAVPxNOp6ZAItxU8JFsFSDfpsLmg8ucqeIU1G
	y6X5T0klTHgQVl5uA2erO3GHeFDh1Iqp8MEix3
X-Google-Smtp-Source: AGHT+IG5y2stVwRUU8JhQBJ/M9Aub7a2FzVoZyu27EnOLVLJjBy66P8LCzzkbFVlFaMnmX2x8/1DFQ==
X-Received: by 2002:a17:90b:3845:b0:341:d265:1e82 with SMTP id 98e67ed59e1d1-34f5f3331f5mr2458289a91.29.1767706071123;
        Tue, 06 Jan 2026 05:27:51 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc95d5c66sm2409570a12.24.2026.01.06.05.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 05:27:50 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@infradead.org,
	hch@lst.de,
	tytso@mit.edu,
	willy@infradead.org,
	jack@suse.cz,
	djwong@kernel.org,
	josef@toxicpanda.com,
	sandeen@sandeen.net,
	rgoldwyn@suse.com,
	xiang@kernel.org,
	dsterba@suse.com,
	pali@kernel.org,
	ebiggers@kernel.org,
	neil@brown.name,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com,
	jay.sim@lge.com,
	gunho.lee@lge.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v4 14/14] MAINTAINERS: update ntfs filesystem entry
Date: Tue,  6 Jan 2026 22:11:10 +0900
Message-Id: <20260106131110.46687-15-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260106131110.46687-1-linkinjeon@kernel.org>
References: <20260106131110.46687-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself and Hyunchul Lee as ntfs maintainer.
Since Anton is already listed in CREDITS, only his outdated information
is updated here. the web address in the W: field in his entry is no loger
accessible. Update his CREDITS with the web and emial address found in
the ntfs filesystem entry.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 CREDITS     |  4 ++--
 MAINTAINERS | 11 +++++------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/CREDITS b/CREDITS
index 52f4df2cbdd1..4cf780e71775 100644
--- a/CREDITS
+++ b/CREDITS
@@ -80,8 +80,8 @@ S: B-2610 Wilrijk-Antwerpen
 S: Belgium
 
 N: Anton Altaparmakov
-E: aia21@cantab.net
-W: http://www-stu.christs.cam.ac.uk/~aia21/
+E: anton@tuxera.com
+W: http://www.tuxera.com/
 D: Author of new NTFS driver, various other kernel hacks.
 S: Christ's College
 S: Cambridge CB2 3BU
diff --git a/MAINTAINERS b/MAINTAINERS
index a8af534cdfd4..adf80c8207f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18647,12 +18647,11 @@ T:	git https://github.com/davejiang/linux.git
 F:	drivers/ntb/hw/intel/
 
 NTFS FILESYSTEM
-M:	Anton Altaparmakov <anton@tuxera.com>
-R:	Namjae Jeon <linkinjeon@kernel.org>
-L:	linux-ntfs-dev@lists.sourceforge.net
-S:	Supported
-W:	http://www.tuxera.com/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs.git
+M:	Namjae Jeon <linkinjeon@kernel.org>
+M:	Hyunchul Lee <hyc.lee@gmail.com>
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git
 F:	Documentation/filesystems/ntfs.rst
 F:	fs/ntfs/
 
-- 
2.25.1


