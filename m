Return-Path: <linux-fsdevel+bounces-58858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 510ECB32388
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 22:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69AE03B47A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 20:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3752D6E47;
	Fri, 22 Aug 2025 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="Ni6YtuKW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA632877CA
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 20:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755894030; cv=none; b=bVrTzaEgaLQIvdfWgucTKbBnElEy9wxX82u59kg9b04DjYX9ITI8Hq+7jJ2Y81cP5y49oxvq/e94dKZ9ltNJZhjLB+OtYUONXytg7mAlmJf2lCdXm/fKx6kP9LEPjEwgROO6aEA+x2Cmkj3G9kBus0FXogCl3SgVCsndBihM1n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755894030; c=relaxed/simple;
	bh=G81RmIspA5Gf94EIvfvkDkJfrPk8hCd8P9jWaaMeGsI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fNCb82jf6bhLhgYbDIpF1IdGYxQmgqYXQhXrQMmv3Tdh3oFG7HctfLmNX7cZOgpsgzIhVBo5/wxq9bHDCD4H1visyJ8G1Ge9Z0eNU4aXnJQ9nMENRqFRnKOHSk+pEzHOWjPuQtWOCsezl4pxSLAdA7ZQmtAoEh+9mC/ANeUNEkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=Ni6YtuKW; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-70d9a65c1e1so9205266d6.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 13:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1755894027; x=1756498827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5VVrR0tor91nTC7Z7dC1Io357v0ym5S2eHEJvpA9m/o=;
        b=Ni6YtuKWVWOBFEO67StYLdha81fFo/SVdyPZUZ4ISdWfYZjKnW0Y0bWss9Yc62bN7/
         rv7QE3y71fr34Pwt2s7Ep+qk/x+e4DRLwgUwAuL+CzIqtScOcbnYDAdBVecjelWACRTI
         ROD/+AWnv2AA/wmnjjr7z7HW7OwIuH4hA4GoAQTOwZ56zUffr8ipPQA7Bt+hoaJiL3Ox
         v3I0ohBibiK5VUwP8/mipQwJghdfMXSQ9L/oTRGp/9n4TieWeHB5fs3lXidTTTMnQ+Gv
         k5/CY8epVBoglLiUJCgza+O3XMp2ZPL/r2dHIlQzRX9X1wwan5q+QMpBikUUheYog21Q
         kUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755894027; x=1756498827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5VVrR0tor91nTC7Z7dC1Io357v0ym5S2eHEJvpA9m/o=;
        b=jpmHmwOE5G/hkXIKBerb3mxfxPMTOlKa55ul29B1kM/nTR2RTbcJ7Ld8ukVBU0qYXQ
         x8Lx47LjpQjPPEiq7SFr6yM/FVP4YS2K7fpkDxfNvvu/4Cvsr/xhvLFeA/qjE2me4LL+
         hzJGAqwmb6SbmgGfpzaA/fzwY0WQR/fQtGMMTVurGN6au5qoS5652AavC/nygLLfQ8t8
         7ATvca747yk4R3vkGKeFiDueNjl9mdU3aT6fYkfyGxvbYWFKBtLPFhpIg0/kN7LLBMiP
         +lDH/v13xPB4wcJcnR1WGmKfQfu1uHRQ8DSxGATYjwZX4s8QKF23gvfslMIy81ULvwry
         IcGw==
X-Gm-Message-State: AOJu0YwU8pxZXxDJ4lBktw8cOyaEye1KMI6ZzpvoAAJrGXMnqlx0YNfy
	ArkZAKRjEjuA5Zpf2DnY6OWsMEzPtQ6OsS02mGJn56OshAbniByr/0mNBJVV25q9taQ=
X-Gm-Gg: ASbGncu1qSqmCYFja1YhuejUN+3FohOvq/AO6I9QxSuFMM3qm1p/ZYff4V0r9YIdLaR
	pvbCmrf6T7bA5rHRYeHvofXuL/CxQT+KpkWGVMeDmrCePzzG9jpSO+PBSO8t+f84bR3vCavrupY
	yLuPQBPihXz91QPieYaSUM9b2WsKrv6t+FDzp8ewy7XXZkMl9V1LEl0Fn3l0sD0NMyqsVvnkZfY
	Yar07rqrg3AL0u9wwJ8QBdNPQ/CL7F+NYl0gnqqz8dalMjlvrwkgvsG6a2bEFeq2X/WAj6PVDMa
	Jgmr2YkR5dBk5ZKp37WLpaBMTy0eo9Z4ZEVtXypu4oswiEKvVJNcVRFElErzxqd4m0/UfpISTdn
	C5Z8CRBe/AnsLuaTeO1uLxE8xD+RyD1AYPwJTNw==
X-Google-Smtp-Source: AGHT+IG9fHvPf0SDRt1sbc752CVvp11neSM4sh4uLqYoAsIebToFTRvuDKIrr/GAsS1JEqbXZQVtpQ==
X-Received: by 2002:a05:6214:2525:b0:704:a0cd:f597 with SMTP id 6a1803df08f44-70d97254b09mr56266286d6.21.1755894027384;
        Fri, 22 Aug 2025 13:20:27 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da714dc98sm4944206d6.12.2025.08.22.13.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 13:20:26 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH v4 0/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Fri, 22 Aug 2025 16:20:09 -0400
Message-Id: <20250822202010.232922-1-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for reading / writing to the exfat volume label from the
FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls.

Implemented in similar ways to other fs drivers, namely btrfs and ext4,
where the ioctls are performed on file inodes.

v4:
Implement allocating a new cluster when the current dentry cluster would
be full as a result of inserting a volume label dentry.
v3:
Add lazy-loading of volume label into superblock.
Use better UTF-16 conversions to detect invalid characters.
If no volume label entry exists, overwrite a deleted dentry,
or create a new dentry if the cluster has space.
Link: https://lore.kernel.org/all/20250821150926.1025302-1-ethan.ferguson@zetier.com/
v2:
Fix endianness conversion as reported by kernel test robot
Link: https://lore.kernel.org/all/20250817003046.313497-1-ethan.ferguson@zetier.com/
v1:
Link: https://lore.kernel.org/all/20250815171056.103751-1-ethan.ferguson@zetier.com/

Ethan Ferguson (1):
  exfat: Add support for FS_IOC_{GET,SET}FSLABEL

 fs/exfat/exfat_fs.h  |   5 +
 fs/exfat/exfat_raw.h |   6 ++
 fs/exfat/file.c      |  88 +++++++++++++++++
 fs/exfat/super.c     | 224 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 323 insertions(+)

-- 
2.34.1


