Return-Path: <linux-fsdevel+bounces-6655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 403F781B2EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 10:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2E441F232F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 09:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2E84CB24;
	Thu, 21 Dec 2023 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUruLXbA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345F64C61C;
	Thu, 21 Dec 2023 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3365d38dce2so524494f8f.1;
        Thu, 21 Dec 2023 01:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703152454; x=1703757254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3EdDjfRr1Z95XMpF/pCDgr07FcadpSW8aFW18DXa3bc=;
        b=gUruLXbAAxj4UshdlKKZ7dLSCeYo9oK2QzbXigJBi2w0hHQwEI3OhGTz8dDvgtdhUg
         K7u49VKAFdFoMhlL+LY7VXnSqWr1HmZuub/4Xqx3hCva8feIQKxbw3cBCW0AilZeRhmS
         ILPs6x3dYXk6MKtcUyJsLqzHtdZypC2NM7wWdLg5D3stS9zvs8pWKGlncrlhPy+2BfGl
         VE6Fgxzz5z5LBrZRdsV8RKSz5HMydOImV2smwQJ6eAh4rsLfvAfWRq0fZ+arL3Vlzt9n
         MRl02jMpWtcFP8GpTeC77t34kmarDWasZKQ3s04HmwzcimdHvvUbvE3IK9I4N91KCJ/S
         NxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703152454; x=1703757254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3EdDjfRr1Z95XMpF/pCDgr07FcadpSW8aFW18DXa3bc=;
        b=of1ktQG2mgWbLdtF3ItAspUhfnq9/NHn6PsrFxXL4DXRixpdv6W/FdV9PVl5bfNb46
         6k26o00uohx4XCmT3VcEIue2YKWkm40FNITwbLF9pzyw0IObFdp+CF/hYE9Q3Do6ZAaY
         o2fblvpr3OifGk2RsIOJDANCQOP4eXCJdcpeALAUBRhnX46egcV2CtzQ07hhYEiKntav
         cO81HsMXoe9u34FUJJ0h3D0TVsfK8eP038VAWIM03PTg4GwBD50nDDdFeBFN/Or1oJkA
         aC60aZsQLiFmRumN68TJyTdcAKr1Osjw1tf+ewWNtJflxw/E5Pl+KQtLQz58k7075FQ7
         YbTg==
X-Gm-Message-State: AOJu0Yxru7PslQcyLIPm5/IjkGjaH7mId8WKiLv84gXq0W2sCvpqzAgb
	uSkkeX11QSYxOlp3dKX1a9c=
X-Google-Smtp-Source: AGHT+IG47Vo8nNhQd71Fsc+Zr4F3DaX30yD1vFQG5dYeQ4AYTLaL1xfcbjw0ldktAnCd4/Ur+pgHBQ==
X-Received: by 2002:a5d:428d:0:b0:333:4bd9:88 with SMTP id k13-20020a5d428d000000b003334bd90088mr503700wrq.51.1703152454194;
        Thu, 21 Dec 2023 01:54:14 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f5-20020adff8c5000000b003367dad4a58sm1628082wrq.70.2023.12.21.01.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 01:54:13 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [RFC][PATCH 0/4] Intruduce stacking filesystem vfs helpers
Date: Thu, 21 Dec 2023 11:54:06 +0200
Message-Id: <20231221095410.801061-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christian,

These patches essentially just lift some overlayfs code to common
file fs/backing_file.c.

They are based on vfs.rw and overlayfs-next branches.

The motivation is (per Miklos' request) to reuse common stacking code
for the FUSE passthrough patches that I am shaping up for upstream.

I have been testing those patches with my fuse-backing-fd development
branch [1] for quite some time and I think both you and Miklos gave
a conceptual ACK to some version of this work, but the patches were
never publicly posted.

I am aiming the FUSE passthough work for the 6.9 dev cycle and I was
contemplating whether I should queue these up for 6.8 merge window to
give them time to mature before 6.9 merge window.

If I do that, would you preffer to take these patches via the vfs tree
or will you be ok with me including them in the overlayfs PR for 6.8?

Miklos,

Are you ok with including this in overlayfs PR for 6.8?

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fuse-backing-fd

Amir Goldstein (4):
  fs: prepare for stackable filesystems backing file helpers
  fs: factor out backing_file_{read,write}_iter() helpers
  fs: factor out backing_file_splice_{read,write}() helpers
  fs: factor out backing_file_mmap() helper

 MAINTAINERS                  |   9 +
 fs/Kconfig                   |   4 +
 fs/Makefile                  |   1 +
 fs/backing-file.c            | 324 +++++++++++++++++++++++++++++++++++
 fs/open.c                    |  38 ----
 fs/overlayfs/Kconfig         |   1 +
 fs/overlayfs/file.c          | 245 ++++----------------------
 fs/overlayfs/overlayfs.h     |   8 +-
 fs/overlayfs/super.c         |  11 +-
 include/linux/backing-file.h |  42 +++++
 include/linux/fs.h           |   3 -
 11 files changed, 423 insertions(+), 263 deletions(-)
 create mode 100644 fs/backing-file.c
 create mode 100644 include/linux/backing-file.h

-- 
2.34.1


