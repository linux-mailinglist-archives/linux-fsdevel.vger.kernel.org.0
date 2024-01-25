Return-Path: <linux-fsdevel+bounces-8914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49C083C0CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 12:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 909C1B23B29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF2245025;
	Thu, 25 Jan 2024 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z68B0Npc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109CC44363;
	Thu, 25 Jan 2024 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706181796; cv=none; b=YFoSKGYZBpsFqOJebHzGyBk9/b4bNfH1FzuOfI5MW33u0VxJIiJknA1O75NSu6CI6DHfIdlpdfhSaGYw+sLtSpqtvcXQEm4sGdlWALqTYQBvsYgelZbfXr+2s03wJfmzkZXULCVxbm9jCFYW91LOcY41W1Gh5HRsIkt9aa2sZ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706181796; c=relaxed/simple;
	bh=rsXtaAPeZfDh5LSUQclGLopYCeuxqGyApVRH6n1EsQU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xo+VR7omRZFVyT5q98AOglT5sEJ4jNvM7PW/GN1o8wy9/EOgcfTZ4tpZy2euMpTpiV7gE4kTEMgFdlSSipHuMiY67iO9os2D4hTf9WTJc68NhWQtA3vuyQDtFjMfpsmo4PCV8Dk5ELzHULpEgNaLQW1x/twWE7yRNTjWZyettjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z68B0Npc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40eb2f392f0so35372285e9.1;
        Thu, 25 Jan 2024 03:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706181793; x=1706786593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ymw1Lm+bF1xYdAzdzSP190aFmW78XpgqGX09mkj9PoU=;
        b=Z68B0NpcAnQILDDsiR05/vqG8dHt4svQc/FSEnwtTR64MZzw8XrEe7oDpilT3cA7es
         0qYQVXlKDqiwrEaVn09KKLqNxHmZAoR9s77DcNnvx1f4XM4+Df/S9wGSX/OUQKIL315J
         7w3G0FSP/eqQZSGD4kG5qzhriXlNnkx0ueSSMNBAKznlkV6qnVS7oJGMucHDzT9j60UV
         hzrwyJh/P2T6Dw6LA7mP3LW7fBR2Nz6VPCfOBTwcz3+nm4UVZdJgIDJrjQjqD4az+mdT
         nWy7oUsyLJOMx4dZDKm3oj9gcJ83u05HN2MKBEOQ4+y5SXHHi6D+4s9MbVSKIYhoOxTc
         IjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706181793; x=1706786593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ymw1Lm+bF1xYdAzdzSP190aFmW78XpgqGX09mkj9PoU=;
        b=Yc2GEcxy8l63e89YfuSwWSGMoYw7fd8SX4uGrAmZWBIHc4AM//hlrR34Cb6CnRK11b
         Ad5X1qe5xKLQOm/3KxBzagDJPY4eXXnxQD0SvreGSohkf18mCrOSqVKHz2bJ1XGWwvQw
         Cqq4465MeMInBmOjBhMyvl/8+LQrQpdUPD4zqMiLHbLeC+MfvkYlmufP4DHEGGvt/k3d
         ohS60xds2nP6wuAaI6Q/d2N1KSkaIMJrD//tMbs6wEG8EBsFmeUx9zNOx11qCBZWvAzI
         slNu45TU3DUaQgYDXWHPhJtk7TlSdh1KyVAg+su/Ro4aKagEiJ+MD2zESbwqTQFmE5PU
         B4bA==
X-Gm-Message-State: AOJu0Yx9psNt0nX8N76gVqFrmNezutn00AsNcCVpFPVqkB2404eP3Tui
	3ujSNpETnB4UoGsv/EnH45dNQOg1rQJg7IB9hhhNF1Vpkx273f+z
X-Google-Smtp-Source: AGHT+IG8S5kba/Z9bChR71Rj0vGDL4udebeaijAgRBSyWCmp5xoVHPv5bI5GABi5KLMs6neLaPywIw==
X-Received: by 2002:a05:600c:45c9:b0:40e:a00a:b76 with SMTP id s9-20020a05600c45c900b0040ea00a0b76mr394193wmo.21.1706181792961;
        Thu, 25 Jan 2024 03:23:12 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id je5-20020a05600c1f8500b0040d1bd0e716sm2281996wmb.9.2024.01.25.03.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 03:23:12 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 6.8-rc2
Date: Thu, 25 Jan 2024 13:23:08 +0200
Message-Id: <20240125112308.753888-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull overlayfs fixes for 6.8-rc2.

This branch has been sitting in linux-next for a couple of days and
it has gone through the usual overlayfs test routines.

The branch merges cleanly with master branch of the moment.

Thanks,
Amir.

----------------------------------------------------------------
The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes-6.8-rc2

for you to fetch changes up to 420332b94119cdc7db4477cc88484691cb92ae71:

  ovl: mark xwhiteouts directory with overlay.opaque='x' (2024-01-23 12:39:48 +0200)

----------------------------------------------------------------
overlayfs fixes for 6.8-rc2:

- Change in on-disk format for the new "xwhiteouts" feature introduced in v6.7

  The change reduces unneeded overhead of an extra getxattr per readdir.
  The only user of the "xwhiteout" feature is the external composefs tool,
  which has been updated to support the new on-disk format.

  This change is also designated for 6.7.y.

----------------------------------------------------------------
Amir Goldstein (1):
      ovl: mark xwhiteouts directory with overlay.opaque='x'

 Documentation/filesystems/overlayfs.rst | 16 ++++++++--
 fs/overlayfs/namei.c                    | 43 ++++++++++++++++----------
 fs/overlayfs/overlayfs.h                | 23 ++++++++++----
 fs/overlayfs/ovl_entry.h                |  4 ++-
 fs/overlayfs/readdir.c                  |  7 +++--
 fs/overlayfs/super.c                    | 15 ++++++++++
 fs/overlayfs/util.c                     | 53 +++++++++++++++++++--------------
 7 files changed, 110 insertions(+), 51 deletions(-)

