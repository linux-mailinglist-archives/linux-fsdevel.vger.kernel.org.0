Return-Path: <linux-fsdevel+bounces-14752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6E187EE67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 18:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B05C9B23E74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 17:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51AB54FA0;
	Mon, 18 Mar 2024 17:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGVJK+OW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928B054BDD;
	Mon, 18 Mar 2024 17:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781607; cv=none; b=ep9tEM8Z2S5vFvWmXWdC1PaFpEsWzAS0+ebtVzc67oeooN7S44oO4ILrAJiTJLenl+VLmDx4xbr+Nz2hY95cvkYlIdJDdVS08jUxT7AB3ZAZfx43Qy9usZvBAAg8ToixK6QBEKyCXuczUm7lmZ2fjQGG8TJHPpp8hY5KTDdE88E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781607; c=relaxed/simple;
	bh=rkLXIQhjJs8ZONvgs1oTCX7R7AyhU004boUxyA16D1I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eath867aZScBdPiknggrb/fW/MdXMV0hsMvwVVCkJLdJEUnzuFZy2NfLBbkvJ/3liEeJ2c1NgxSE7D48XlYoSkay+71fGOsCR1Mi1ZtYMx3wPJGYu+4UO5w/ILNv3h3mKfMrhgfAk/l96b+iyy8PdKGBzBRSF1tb8NjhhNvGSSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGVJK+OW; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33ed5b6bf59so1828381f8f.0;
        Mon, 18 Mar 2024 10:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710781604; x=1711386404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zf950P53M7MTnrf1OEnLcc0B1q3P6vlN/R3XLF0qQAE=;
        b=JGVJK+OWO6Hp8HWaOY1OKPWl7ZQ1loju1nHhiMlhnn3vQlPYox+pli/HdgcdZuUWSK
         i2fF7hsYH51Km1Xz1y7OIIWunnQ+4FyP3aHl7HOx4hb9LVNz7GJpuPYChva3DNvlNI8a
         YYbLgWfS2fNDhqVshOQN6O0bzOEt7lpv4DbiUBpLLhyaaSik/VFdRb2VYq2TX3ECMpzo
         LKVDdiJ+klpLRmfysYIJtONPesSLYWmRhasC6IqMMOqXw1oT4RvmohLEoMYalFRPl1+Q
         GdMNCIWg4BWE9XFegi0ist2cUBuRZomZUeaTKTapxzbPVHhdN+tnti8IYmbRuNDm8wb6
         X/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710781604; x=1711386404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zf950P53M7MTnrf1OEnLcc0B1q3P6vlN/R3XLF0qQAE=;
        b=A5/VEHQAAwVI8u9e5Ofci7IhDbEpDEUCiMUR5ReTrJ+5eZ0RsZU9iVl2GoDlnyo0kp
         plvR5GKVqIgjKBkBPnCKRlPPe1398BjoLCfA1c4wAThoQgHaHWye1/Oeu9MduYCf8yzl
         3FdjBGySX0K1JcDdCw/YNoqRU4hdxA+TsFpr+6Tj9VmvkSmspQWaaIa6V8NxflVm8gL9
         1iXT58bY4zFMSSoigCXfToANA8XgJxzduIBKrE5JxKU1QXmLJLQ99vNPmL/4puK8fRyD
         /gSjoB//BmTQJ5lYH8rbU7LKsTpePx4+AT7ZQ8MZhyPzYoIjX9a+jTMdaWGKlIhojmNn
         WEuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5FcLpoJUPDsJeFD83EwVktELeATazKD9Ks5b8jF8e+9k5P1+uVEdcwmChF+s3b3uHnwQ2sSKwSszIEK0Nm5f0iY9drPl7U0Oe891/BkEZIOV+FAObgYtFhFJPXhIaZGQ8ugaXFJOm9qufiLiehsLjf+rgk/m8A6HJP68SWqFxEKP0zsSkgebSVoQ=
X-Gm-Message-State: AOJu0Yza70vYYYZ/bbcmv3dqo7qZ45KPHjeugTPqqbiCEgjv+izp1vci
	TayNcWa+AROF4f54uI0EMUXvfGFbMzt2oLhp1T6eMPG3a16zTeDlA3bxSbFl
X-Google-Smtp-Source: AGHT+IFu492oBvMD2vBSJo10ZH/1lqAR7gFT8DoP4u6RlcrxDAMuDnpvwMWPFzeuuHK4tJrhHB23NA==
X-Received: by 2002:a5d:4e51:0:b0:33e:90b8:9332 with SMTP id r17-20020a5d4e51000000b0033e90b89332mr8200469wrt.49.1710781603766;
        Mon, 18 Mar 2024 10:06:43 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan (85-250-214-4.bb.netvision.net.il. [85.250.214.4])
        by smtp.gmail.com with ESMTPSA id r15-20020a5d694f000000b0033ec6a1b37esm10294928wrw.8.2024.03.18.10.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 10:06:43 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 6.9-rc1
Date: Mon, 18 Mar 2024 19:06:38 +0200
Message-Id: <20240318170638.1229386-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull overlayfs fixes for 6.9-rc1.

This branch contains only minor fixes.
It has been sitting in linux-next overnight and
it has gone through the usual overlayfs test routines.

The branch merges cleanly with master branch of the moment.

Thanks,
Amir.

----------------------------------------------------------------
The following changes since commit 277100b3d5fefacba4f5ff18e2e52a9553eb6e3f:

  Merge tag 'block-6.9-20240315' of git://git.kernel.dk/linux (2024-03-15 14:55:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes-6.9-rc1

for you to fetch changes up to 77a28aa476873048024ad56daf8f4f17d58ee48e:

  ovl: relax WARN_ON in ovl_verify_area() (2024-03-17 15:59:41 +0200)

----------------------------------------------------------------
overlayfs fixes for 6.9-rc1

- Fix uncalled for WARN_ON from v6.8-rc1

- Fix the overlayfs MAINTAINERS entry

----------------------------------------------------------------
Amir Goldstein (2):
      MAINTAINERS: update overlayfs git tree
      ovl: relax WARN_ON in ovl_verify_area()

 MAINTAINERS            | 2 +-
 fs/overlayfs/copy_up.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

