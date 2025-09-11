Return-Path: <linux-fsdevel+bounces-60893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79D9B52959
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 08:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E0CE56135B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 06:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC5F26658A;
	Thu, 11 Sep 2025 06:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrnw5fXA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504AF25C822;
	Thu, 11 Sep 2025 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757573832; cv=none; b=f9qlsxN4KCkWjXZoiRydyZaVv9i4/9fhYDwxaWRmGgR8IAHaMa+dMgfd7Oy3o3966YvCamCK41Z3GHfX9McRKNuZWhmCTpF6DoK/6BIWOmZ0wAAnauU1HsinJ45JXrz5SJCm9wOoZz37+H16U4PD/BcEBDfaHwtujCSiyyhgbeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757573832; c=relaxed/simple;
	bh=5qxNxBaHIECN2bWWSlQ1Iok4Vh/OVqjxMD+R+PAgb0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RY2rigIQ52bZS9mCXxxxXPx697b6BsEWiXn6yKzO0UOFw0NdFxiXxGNTCUjFdTQT1CUYAsD6aIla2o8tzN+ZidPaQfRqWHTcmlvx0FHCv4fKNqOQ2q2/9JFMt/rvEPcaf9ghgzlGP1foqtqY/c6jjbnzl+SBnstfD27INSdPVcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrnw5fXA; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3e751508f21so243814f8f.0;
        Wed, 10 Sep 2025 23:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757573829; x=1758178629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6lHQVZXfr/Fsekd1rj68rPNkBJl9XCkWnPIsU6k6HNw=;
        b=nrnw5fXAzpI5d0ZDvphyVCNIvHe6JSJMrQ82RdJ6B0hdZjtbuQfPoO+KDmvGno63fC
         qdes32xL49HpHORyGCTlfjcsHEOFN1F+h5J3f7FLZc/Ug3NgvZamFc2EV6km11Iyf5OL
         jZolRuPpmYcd0IlhUBoU6q3+ILnlLjPV+a1eoV0iMi4Xh8ORYqZPyS7MWpW3477avJzr
         qvIanaWvTH0EFJFXYc6oVzmcMituUCatuSmY7OCW+YS6MD1xLyDloe/zgSmpXhSKIEWi
         BvtDzmm7FFQBoL6CeMZzJ6fyfqWlghC9ZTyXtwWOO+yX+uHTvBo3mrkziGuvjehkgmkj
         fLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757573829; x=1758178629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6lHQVZXfr/Fsekd1rj68rPNkBJl9XCkWnPIsU6k6HNw=;
        b=JZXLVA+TvA0/6nUf6KOppmJ9UzqE5sKdaOg3HbqsKUu/l2hPUo1gMgxZYTyBSaWmnS
         CyfDxAHAsOFqEaLCwCX7Xb142wP2MpHqRgbncoKaY7VoKjwjMEIzktfKWr1Gb8FA7S2N
         teOVrsYN2jK7CXlIG767Bw8u3ROs2YsGluwqZmn9uaCfD4HALzADd6TWDOH/xIJmmtNo
         OuzHw3s4U3CFnrT2raB8JRZ8lhTr/TPL5owxNaAXKvnE8TwTOCuh5p9JD2MKPWHXk9JE
         IonUJsgk0RkDGUlE6myB2abAiqYm2h3HXwqYvUOcoQ5Pbr31IrDb2mhEtd0iEsW42l+D
         Acxg==
X-Forwarded-Encrypted: i=1; AJvYcCVboXUhjogID1m+IrOVnVjpCo5t9OZcxcDHRTSN0OOch1haCIq465uHnS+QJxKHfUN2WAjtjIfm0rQS3s3I@vger.kernel.org, AJvYcCWhU2Ehxq/m2ke+0NhPQ7ZpPJAtITEw/33u+Joqd6TpIRVWLSv9hjWUuCIj5LY0brnpxZ5pz2e5GGS7IBMi@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3XyxSXgxATtfeXhSzcIKexKDTITdlUAFoM85n2bUp/wq0prTB
	qnxG183+cipeloXwMWsBTq54bpSn8wO+vWzpehmh5KGJiJBFDNBaQ+usyAiLRg==
X-Gm-Gg: ASbGnctGSSB8AfYoMEQ0f8MrbPKRaKnHSRdPvKc/zPpuNXDUZvqqqNYhAVgQPItft7x
	bByBtffA6udnKVdIIBkNXhT9KSakWvyQt7npxBexGg7T6PyIWtZNRtxZn77gnzq6W1lo3HwK8Xc
	mYHdN+iljQFgr1Jl4MoYZiTfyLj065reZFuww1bb2XxfG9qLXogmvTK7FshcWQRPNfDG/mxd2/K
	A89akUdNJVRUgRQSMO5cnJ/BdAHBbZoz3lSd3VW9tVCpZCe/fFHGMKhWbGOxldROOD7tJnILBVK
	ewNvxe99hRI5qCBllZE1I7bgp8evgGggSiqOVFXhSlXV6u0owkvEDERoZGfkPVK3W8yHgCOZh75
	FbcoA0YKA4g3no9B8Ae7HNwiOoh83K/XI5d05LVB6/gm6AMi4oZQ=
X-Google-Smtp-Source: AGHT+IF+5VBBFKxjhiSQ+XH3RsoloRZLOVgcz/iCiOCu06pqDLFS++X03tFj7mQ67sSWgLPZ80dQ7w==
X-Received: by 2002:a5d:5f87:0:b0:3e0:a5a2:eca8 with SMTP id ffacd0b85a97d-3e64ca74175mr15692042f8f.54.1757573828481;
        Wed, 10 Sep 2025 23:57:08 -0700 (PDT)
Received: from f.. (cst-prg-67-222.cust.vodafone.cz. [46.135.67.222])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760775880sm1258254f8f.2.2025.09.10.23.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 23:57:07 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	david@fromorbit.com,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] fs: expand dump_inode()
Date: Thu, 11 Sep 2025 08:56:41 +0200
Message-ID: <20250911065641.1564625-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds fs name and few fields from struct inode: i_mode, i_opflags,
i_flags, i_state and i_count.

All values printed raw, no attempt to pretty-print anything.

Compile tested on i386 and runtime tested on amd64.

Sample output:
[   23.121281] VFS_WARN_ON_INODE("crap") encountered for inode ffff9a1a83ce3660
               fs pipefs mode 10600 opflags 0x4 flags 0x0 state 0x38 count 0

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

v2:
- use 0x for hex values
- add i_count

generated against master, cosmetic changes are needed against the
vfs-6.18.inode.refcount.preliminaries branch.

 fs/inode.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 01ebdc40021e..95fada5c45ea 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2911,10 +2911,18 @@ EXPORT_SYMBOL(mode_strip_sgid);
  *
  * TODO: add a proper inode dumping routine, this is a stub to get debug off the
  * ground.
+ *
+ * TODO: handle getting to fs type with get_kernel_nofault()?
+ * See dump_mapping() above.
  */
 void dump_inode(struct inode *inode, const char *reason)
 {
-       pr_warn("%s encountered for inode %px", reason, inode);
+	struct super_block *sb = inode->i_sb;
+
+	pr_warn("%s encountered for inode %px\n"
+		"fs %s mode %ho opflags 0x%hx flags 0x%x state 0x%x count %d\n",
+		reason, inode, sb->s_type->name, inode->i_mode, inode->i_opflags,
+		inode->i_flags, inode->i_state, atomic_read(&inode->i_count));
 }
 
 EXPORT_SYMBOL(dump_inode);
-- 
2.43.0


