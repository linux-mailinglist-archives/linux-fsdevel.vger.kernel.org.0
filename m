Return-Path: <linux-fsdevel+bounces-63100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C847BABF09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 09:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0911926683
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 07:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0262C11C9;
	Tue, 30 Sep 2025 07:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dklnDDVg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659A92C0F87
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759219130; cv=none; b=f3Lavob6wirK9a4xdnkT3Pv4ncELJ1qXfnIJ+rGsafFwLY0AXVYSJRUD6gF2aalFoON9lAP7UBxZE2e87aEvbv219n9EFmKRtpeAlVm8Xf1sZJIPlRMMhIie+J+pzQdCNpol4YqVr8joz8r1mdKCrmg6dFWRxQuRyD7olBJpL/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759219130; c=relaxed/simple;
	bh=GW0+t7xjQhqLAlZvuCH2wFM1HzLxDXq+6ZhGCWe3SNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y251rgh4srlaJ0KwOjs2wgiKYFTv6lXEWINp9u+VZLjl/uUXAjjO/RWRLAV1hYBhSdwsK5+9UN1vSdsuaOEUUV4ud6SkEvvb7IHF2MOvkmLDuCDPmPO3ZfN7T/cK04DtmdxSbtgdtJrUKtAEZHp0IxEvaLujSmO9KXw4/1IAnSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dklnDDVg; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3b27b50090so500444466b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 00:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759219127; x=1759823927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tdLjLEy0U0fuaZSofLkGJRFfTbY7z9ZRmrdaFEYCljA=;
        b=dklnDDVgYKA85Rr7+3/jwHGln3VPS0ttkTDCk27L66JX5qndCzYAXP6de+DxZz+9l5
         QJShijegUtztNrDYHVfbCMjUAy1aT92iyC1/V6BW7s08QXu4xfspPl74LYsMGkk11MFH
         +vxJxixnaXVpOfxl5dvrMSCoaKE5qO4ek6htQ5lT5zvxLuAlMMCQPajAP7fcqzPEgqHy
         2ghC1WEuu8/tUp5TjsAN30IosSxh7JiskKjNWK6ERuG5fYrX2bDbI4ANWZ7jZO76HN1h
         xYdLEFNCG07EEjsCwDrEU6YekH5AwAjmTADNfJSZhCd/LEOwnG/MMhqmCUefftGHOmBv
         pArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759219127; x=1759823927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tdLjLEy0U0fuaZSofLkGJRFfTbY7z9ZRmrdaFEYCljA=;
        b=spWXV1OYMXu295MI/BaDXo/Yx1I3vP7VNpZ0LYle8OvyByjZN3u/6NMdQbuxQYs4rD
         TsHTgOkAuOJb+45q/Q5J6CCPwbzH9tEEkXHrV3kaLZzsIF0v6hKTXDQBbBTEHbupf04r
         /SWPwSNvNvmVW7+/pOMcVKxjJFrhqutXhJjsP7FYbFpmHoR8HKH7/+AeqU330Bv8C+z0
         yEBl/B2I+lTBpeVroPvc+cIaRG+bMNQBbUAxCUdWDwiZkt4SjYBl28kTkzV1hu9AC+1H
         gL96BzBYgfNxWe5aBCOfs3tj+624ltyEeEFR19nMos7uuK/Vg+ZKbTJ1tv6mbmvBSvjI
         7VBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJAiShgn+Ic7aFi3AjeImbiGNbRss5WT5AZNSMdm+9WLDuDuuwH0YIwpbSILCEd8jKq1rZsTsyIFfYUsi3@vger.kernel.org
X-Gm-Message-State: AOJu0YzGrLDl4vwy8Ws0cXXOe7pVL1aziJSKEG6giiPWVgOZzOaZLpb+
	GaojuK8wHm12MI9WrmHIU/uSYjz16c8do8azXxCUb1HC2NdvBZJ0HiEN
X-Gm-Gg: ASbGncvXZ7BX2OtQfwNKTVDqxNCiEMdm6n7SFeKATEXEGHHvxXhwheLK3KDqX/EfGGG
	jGQOJgLeJRjVsCXQdxL+2p0aFXwFFwIJ1iXgLz7CaBbZ/rW6boCMwZI2U5rJ/1xyzEjnIGF0K+h
	vOQigcucjXRSZGlLIn7GfNrx0y7ciNVGZwElf/sbwPt9DmXKVnHJxuUKXCpDg/WpdC9MAlhmJay
	TJhl/rE1C8cQBJuREOQwOViU6n7unMTRAfAh52MU4M7xSwq/zJFp9UB+xaeJN5HxVbSBtmOodZy
	FAnBolelAC1mXDTYfxlMYuG1IzS9zZC5YkRKk/unCPSIYDOzEWATycs1l9RycqC1/NzdKRazURM
	/5Hiw7a9O1vZBDTJih3OaEWAQ6jCJzq8cJQz3uSjTj4jE0qm/OayWSd5uB7aEbNwHs764CfLdWe
	vdIAZ8dd6VrlO3BQJbYHENiBF0NF+tfX6DzlojDNrcRIYBJJ7/mRbO9mm6h2JkN5GyB2NUHapEn
	Uym
X-Google-Smtp-Source: AGHT+IG74fN0DIkyOhjohxH9Y+ip3FELgnzPQxo8Ns4r1Man0mPD+YCE6s+wO1i6xseHx0QHtnzQkA==
X-Received: by 2002:a17:906:f5a3:b0:b3e:e16a:8ce4 with SMTP id a640c23a62f3a-b3ee18913d0mr757795866b.3.1759219126556;
        Tue, 30 Sep 2025 00:58:46 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (2001-1c00-570d-ee00-b818-b60f-e9a4-67a5.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:b818:b60f:e9a4:67a5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b37b3b46ba0sm905613366b.2.2025.09.30.00.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:58:46 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Gabriel Krisman Bertazi <gabriel@krisman.be>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs updates for 6.18
Date: Tue, 30 Sep 2025 09:57:38 +0200
Message-ID: <20250930075738.731439-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=true
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull overlayfs updates for 6.18.

This branch has been sitting in linux-next for a few weeks,
but I added some RVB last week.

It has gone through the usual overlayfs test routines.

The branch merges cleanly with master branch of the moment.

Note that there is a small change to fs.h in this PR for the
sb encoding helpers.

This change is reviewed by Gabriel and Christian has agreed that I will
merge it through the ovl tree.

Thanks,
Amir.

----------------------------------------------------------------
The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-update-6.18

for you to fetch changes up to ad1423922781e6552f18d055a5742b1cff018cdc:

  ovl: make sure that ovl_create_real() returns a hashed dentry (2025-09-23 12:29:36 +0200)

----------------------------------------------------------------
overlayfs updates for 6.18

- Work by André Almeida to support case-insensitive overlayfs

  Underlying case-insensitive filesystems casefolding is per directory,
  but for overlayfs it is all-or-nothing.  It supports layers where
  all directories are casefolded (with same encoding) or layers where
  no directories are casefolded.

- A fix for a "bug" in Neil's ovl directory lock changes,
  which only manifested itself with casefold enabled layers
  which may return an unhashed negative dentry from lookup.

----------------------------------------------------------------
Amir Goldstein (1):
      ovl: make sure that ovl_create_real() returns a hashed dentry

André Almeida (9):
      fs: Create sb_encoding() helper
      fs: Create sb_same_encoding() helper
      ovl: Prepare for mounting case-insensitive enabled layers
      ovl: Create ovl_casefold() to support casefolded strncmp()
      ovl: Ensure that all layers have the same encoding
      ovl: Set case-insensitive dentry operations for ovl sb
      ovl: Add S_CASEFOLD as part of the inode flag to be copied
      ovl: Check for casefold consistency when creating new dentries
      ovl: Support mounting case-insensitive enabled layers

 fs/overlayfs/copy_up.c   |   2 +-
 fs/overlayfs/dir.c       |  29 ++++++++++-
 fs/overlayfs/inode.c     |   1 +
 fs/overlayfs/namei.c     |  17 ++++---
 fs/overlayfs/overlayfs.h |   8 +--
 fs/overlayfs/ovl_entry.h |   1 +
 fs/overlayfs/params.c    |  15 ++++--
 fs/overlayfs/params.h    |   1 +
 fs/overlayfs/readdir.c   | 126 +++++++++++++++++++++++++++++++++++++++--------
 fs/overlayfs/super.c     |  64 +++++++++++++++++++++++-
 fs/overlayfs/util.c      |   6 +--
 include/linux/fs.h       |  27 +++++++++-
 12 files changed, 254 insertions(+), 43 deletions(-)

