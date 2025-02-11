Return-Path: <linux-fsdevel+bounces-41497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F4FA300B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 02:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13FAA18832B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 01:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDF6214804;
	Tue, 11 Feb 2025 01:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/7A2z0O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B454120C473;
	Tue, 11 Feb 2025 01:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237526; cv=none; b=WZmjcwuJFEwdR7LzlOZeAm7M6FWDF0xMgAunW7uSDo2VeEJFqSHdvJV8qshusbrYYaSC/IKj/sLSqcvxmBVfHsOEg/i4mGfffYJ/ta/xVUKMMBf2tWHD6BFb15sP5fN83at2rVEsqdAXeKbOXcY1dTTh8phNpyr8sz6c0Jhl5Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237526; c=relaxed/simple;
	bh=kpsf/jRKTE8KXwYZ9aKwyLXHpFDlUbk8xEBi2W3JKJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k41RZFqSNRUIyCrCemA39dbkxy3cZlN2WuFDmjAIY5mcl6sF6quBwsNPvQn0e6NwwkVMLAziquxvoKvEDY/lEjY/+EGt0ZkTgSRnJNU1sj+VCKUe8ToHekJnt+ZYmQ2UnxcsbqBmzU9uQu65WGcxEmbZJLfcEK5ngVa/TQGSE4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/7A2z0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C1AC4CEDF;
	Tue, 11 Feb 2025 01:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237526;
	bh=kpsf/jRKTE8KXwYZ9aKwyLXHpFDlUbk8xEBi2W3JKJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h/7A2z0O0nDvSsxMuscNoLrkwT5+JhUgyo8lazC4/dNEIzCSx/oz/8U0HBORvYvOv
	 P5Dt7paGsEHQZTa0N8cg9MIgRcum8PJg+h9+g98HlFaKkkbYOKMtdWxQTsD3SbzvoQ
	 RUuB1tI+OAltV5mDJ53V8Ofue2D/tRRorj8KwHl8UkfUzOlQ54qZy4Xd7iogBPMS/d
	 1A2pseou6fzsNpJ8kSLEoYiFd2DUvlKLG637HzfWMidE5V1mNBIGBAlvhTkbpZ4Crz
	 75bj3ClEdfJoCuPqeTB/z9Xpe18UZ/Zt0t33n3ZXqpgDW37oBzgNinfhGOQpd9pSWB
	 SSfUX9Y9x35Eg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brahmajit Das <brahmajit.xyz@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 15/15] vboxsf: fix building with GCC 15
Date: Mon, 10 Feb 2025 20:31:35 -0500
Message-Id: <20250211013136.4098219-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013136.4098219-1-sashal@kernel.org>
References: <20250211013136.4098219-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.76
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
index 9848af78215bf..6e9ebf2321230 100644
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


