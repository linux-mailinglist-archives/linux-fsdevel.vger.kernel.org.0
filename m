Return-Path: <linux-fsdevel+bounces-41495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0162FA30053
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 02:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C201885426
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 01:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050781D61A7;
	Tue, 11 Feb 2025 01:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUYSduCS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550431D63DC;
	Tue, 11 Feb 2025 01:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237444; cv=none; b=eo6BcvK5F2E74qGGnEAwDqE2Y/BwPEYnx7hXN4dMPB/Y+81WQQH2aUSILiDn1BGkgoQ66u8pHS9WgswctOB2ExLHCYGRXGfM0XD5oKop5ncYQvPP5Xqbc4Ks0ZLCyvZCk8D0RbrE08AACip8JBt6BLFsTJoaYJg98K92KTmShnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237444; c=relaxed/simple;
	bh=M2o2pjvV6GmDtkDKgCAzdZyI9a4yVUIBYtGJWCHpJkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l6broYhzGjJ/weZkgiXztwdYdyNB0uDIX3F2GCmAGPtQEOzgZ/DvS5PlO8tcy9hPFKEWMMTYaHpJUAlF60lFDLTO8i3/mTslVjsi2KZ9BfsPd9jPf2WUDYOnyP1KimsCWT8sk1aZxBTgFNU0huuboVCbyB+rB5NZuxvWuAwZrw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUYSduCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32F9C4CEDF;
	Tue, 11 Feb 2025 01:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237443;
	bh=M2o2pjvV6GmDtkDKgCAzdZyI9a4yVUIBYtGJWCHpJkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GUYSduCSYbxDGA18RMouxqJVubZ2Ir7QDMEvyow9eJr5xKhLzqky0V4hOCqAW0PZJ
	 QQZ50iUGeYNeDO6L0EgYira+0vi3ZC/7sM/jKVWQL7WW1moQAIJ1yY/rQby/4RPICm
	 4FTRRByfXrh6G4pjFyB2xPJBi/WcDcSmeH3GjWf56H5qiPtbQxBZZs4LyfsxWs5zhh
	 gHuHskfQ61jXuiKT8vxtsV34fUQSnuxiAYYrF1vu8jWuUxYBhwwBScRBFOqCiipoMo
	 S2D3W6dycvXkXF/wCb502i17gj57hWxynOL142Jso3ID/7tWyglD6a67cPuy7HzBWR
	 kXUd7luBHBxqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brahmajit Das <brahmajit.xyz@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 20/21] vboxsf: fix building with GCC 15
Date: Mon, 10 Feb 2025 20:29:53 -0500
Message-Id: <20250211012954.4096433-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211012954.4096433-1-sashal@kernel.org>
References: <20250211012954.4096433-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.2
Content-Transfer-Encoding: 8bit

From: Brahmajit Das <brahmajit.xyz@gmail.com>

[ Upstream commit 4e7487245abcbc5a1a1aea54e4d3b33c53804bda ]

Building with GCC 15 results in build error
fs/vboxsf/super.c:24:54: error: initializer-string for array of ‘unsigned char’ is too long [-Werror=unterminated-string-initialization]
   24 | static const unsigned char VBSF_MOUNT_SIGNATURE[4] = "\000\377\376\375";
      |                                                      ^~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Due to GCC having enabled -Werror=unterminated-string-initialization[0]
by default. Separately initializing each array element of
VBSF_MOUNT_SIGNATURE to ensure NUL termination, thus satisfying GCC 15
and fixing the build error.

[0]: https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wno-unterminated-string-initialization

Signed-off-by: Brahmajit Das <brahmajit.xyz@gmail.com>
Link: https://lore.kernel.org/r/20250121162648.1408743-1-brahmajit.xyz@gmail.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/vboxsf/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index e95b8a48d8a02..1d94bb7841081 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -21,7 +21,8 @@
 
 #define VBOXSF_SUPER_MAGIC 0x786f4256 /* 'VBox' little endian */
 
-static const unsigned char VBSF_MOUNT_SIGNATURE[4] = "\000\377\376\375";
+static const unsigned char VBSF_MOUNT_SIGNATURE[4] = { '\000', '\377', '\376',
+						       '\375' };
 
 static int follow_symlinks;
 module_param(follow_symlinks, int, 0444);
-- 
2.39.5


