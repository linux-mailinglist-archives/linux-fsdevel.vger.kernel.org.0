Return-Path: <linux-fsdevel+bounces-59238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F6CB36E12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED3D460646
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B835135206F;
	Tue, 26 Aug 2025 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="J1abHhTc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4711434A32D
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222859; cv=none; b=sD8eSxzNh8WMRVAB9OJWzg07+1EEsu9ErjMC5FQZV3FEAdz20/Qo3qcCLmROZwH6pTWVPt+PCpn8sYhGYX4vgiYPMM3/F3BkQc0IynPc1eOYGdLnQNvPoSoPDwRl1/tjqsP7pWZ1V8ELM+UeLzeCMCAIqPZsgGgQbcNxuGHM6x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222859; c=relaxed/simple;
	bh=v4+k47Nq015FWctgvCs9vsg/V/TA5kz2ykNqZmvSZkA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqEeTOrQ2BHrLIY1ueacXUv7Z2uxE0cVw/AmF+GF45cfhBLMOsKcCozA3720PjM5ap2Thi90YnH5kAmPwaZWZe6SkHfSomM7c9jrixEOUcStqeAn/H+oVHPBHNK58ajHiKOo8ShqsSkuRwKl8Rax22dP7+NgEnccvvwjvHALmBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=J1abHhTc; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d603a269cso43792457b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222856; x=1756827656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6DuEK+Kk5sFprszwTHehPZviexNLAjFi3s4jagEjiXI=;
        b=J1abHhTclwAwQu8lYot9DKOf/qKsH15+PFnfdRNUhoNOoj18/RMTkG4rzHRkO3TRgc
         pkPVxOXYql/DSGoIRaOyuI8SHTwF2kajtLGOP7VZHhA3nFFCMo80UcAJrhBtQzMY/mX7
         yXHoK/Kmp1vO0OyCYu3VvZBlSIEmhq6s6yGEIaMAX98eacvCjLc9j+mpWmIjKarcaDPz
         pzS4T0EYzm6SD0WVHSAIp6pxtcrPDL2AHacYY7WEn1Bc67OCZbiOxR110BRAYuuh2mqc
         9JoBiYeKIoLq7/lz8lCNUu2YXmt+uI8qPrTW5qbREQLWLccvYibIFImUV/Twco6fU/bV
         Sv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222856; x=1756827656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DuEK+Kk5sFprszwTHehPZviexNLAjFi3s4jagEjiXI=;
        b=xBEh/NASZdyA5DYQEiPtnaCa3mVAUnmlNkc5NSJPEY8qSi0dA25NZVGN6o/4jenSQf
         ni67hZcpO9GX+gH/7AM66QHawoco8AbbSn6W2lcwm3Ceb6wWrEHRqhAUJ2VPlWLYBhTO
         Yly9l/ENxkeYTa/nE1UlSiqxA9B7IbnyXtmpMLDqRwvByokbXqyC6aVhwj6IhpSMkn35
         nP79tLpJnH/yLl/v6/E7/d5zcQ+g6W8Snkf9VdtyAH4uA2GfEQ2TBk8CjOHzd+D2raBJ
         Wp/Pdh+zU1D/6D1Fd2u1blt60451qQvlVEdaRw2h7F2Z0p0xYs443c7j3sCgFiXYYRyQ
         k6IA==
X-Gm-Message-State: AOJu0YztkhxO73KSGlHB0paTuY4Tbi4VdenIETcb2PhQo1QVizj9j8uT
	ndAg7YtyWPZy0+GaARaSR9XXWVo/Zs1E+KOl/pkN+mZNFUDAaU50SSGKt3dZyFsukc70zSV78Ka
	0UwK8
X-Gm-Gg: ASbGnct2hm6qaqqQclLxk7QuBLv4VNXuE0iwsnDvQ/hayYHq22gQmFhzBSq1uulN5iV
	Yd4HiLLSnguNngB/FFf1Eq4lBofPcABPTzuKlgS0Bh3oDqjbmVE/CV9BADFYA/hroxQbA7E7Ar/
	trH14tKz4uf8eSbVpXG76UUjuWa8NNQDgNohZL93jiVxaYhwVRLMPMAYYpn6/5FLvfQqT0+RRXr
	tgDkTA/ToxRZI7f0+nT6SYxX4+wRRSC8DqPDynZKyLkTvtAkQfUe3u03wXr1JCHss/V/dEY56cc
	R8n76AymbPSMGw2XfSnlvOv/PHkwtaWDuIeQblXxD2JGgGCLQkzX7PRh/D5EJUYWd2tcarMJtoN
	U+KafGPXrH7oRIct3f9EO87Qp+hnMWH+lvMqMRW59ab5rD63bQ0oyzEj1TSegyk5xvanz8g==
X-Google-Smtp-Source: AGHT+IF1MI08diNCyXnNMWWu/+8R5wdOAhVg7UNfF70XcvUlTFYcLCsm4IxLYoWA+0GC1XqTbbEzGA==
X-Received: by 2002:a05:690c:c0b:b0:720:631:e778 with SMTP id 00721157ae682-7200631f13bmr110723557b3.30.1756222855550;
        Tue, 26 Aug 2025 08:40:55 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18821e5sm25322837b3.44.2025.08.26.08.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:40:54 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 05/54] fs: hold an i_obj_count reference in wait_sb_inodes
Date: Tue, 26 Aug 2025 11:39:05 -0400
Message-ID: <94e7ea33eef40e407b2bef6a200c9474472bc778.1756222465.git.josef@toxicpanda.com>
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

In wait_sb_inodes we need to hold a reference for the inode while we're
waiting on writeback to complete, hold a reference on the inode object
during this operation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fs-writeback.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index b6768ef3daa6..acb229c194ac 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2704,6 +2704,7 @@ static void wait_sb_inodes(struct super_block *sb)
 			continue;
 		}
 		__iget(inode);
+		iobj_get(inode);
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
 
@@ -2717,6 +2718,7 @@ static void wait_sb_inodes(struct super_block *sb)
 		cond_resched();
 
 		iput(inode);
+		iobj_put(inode);
 
 		rcu_read_lock();
 		spin_lock_irq(&sb->s_inode_wblist_lock);
-- 
2.49.0


