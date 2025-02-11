Return-Path: <linux-fsdevel+bounces-41498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D58A300D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 02:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D89618876DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 01:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B22262D22;
	Tue, 11 Feb 2025 01:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tx26SiBD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13089262D12;
	Tue, 11 Feb 2025 01:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237550; cv=none; b=jWgsoNbIR3VH7PdHFgXpE+FEnmYUsPaPc9f8AxUv265zXOQfL6efh5XlXyaPy4vVbOjLGazLLTKJAvRPWJfOMF571xvNlqNbqc5an/a2u9Dlo6TfgPjysKwLts6FwiK8mRfPPbK9J0hCjAhYiCy6YZFijHZFF05/zrcecXdi7Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237550; c=relaxed/simple;
	bh=fi9sok8uRHoSDwsKMWEFvuDphmLaYqudoAKawlvNK9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f5bP7eYw9r54WNiSY10FCfzPYHkb18B7r1VUC+CrfxVQbl3sfYoj++Q9HgfJL3RTHXkB1RIkmglMVSnuHhInGDNws4QCczddIV2pQQVpiidD0WfsE0nzCTxUB4PTN/FjFCumA6kqi6XdZp1uoaPqpPbjDoQtMXH0k8d++HDG1v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tx26SiBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB441C4CED1;
	Tue, 11 Feb 2025 01:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237549;
	bh=fi9sok8uRHoSDwsKMWEFvuDphmLaYqudoAKawlvNK9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tx26SiBDZXAV2Sq6gvtwuyjn1UEk6EPluQ6xFikHnFfH+1SxSqOdJucSAMuvRA7Rv
	 GubiSvEJIIMTQ7x/kApDppUmLwpiCzXNCvoPpbcZj76Y4HKQQ77ClZklJTrkQO3dzA
	 Avl64qGHgGJklKMU6302Q3DJ+KvAOS2VNeAFgnH52kx1odbwymF3Deu6cfc5ZHl7el
	 M8xwwYqPMghiVdLUbCmUPwjBYfkz75pohKBebdUPOxv9TimSM6CsZr8I1XJjBUes6Y
	 U7oQcbWFjhsvVc5KzSC9psGQq9prbWHBSfrZEkSutQwaDCWE58mrSJM2PHoIc5bFfC
	 n1w+uwMk9AoLg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brahmajit Das <brahmajit.xyz@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 11/11] vboxsf: fix building with GCC 15
Date: Mon, 10 Feb 2025 20:32:06 -0500
Message-Id: <20250211013206.4098522-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250211013206.4098522-1-sashal@kernel.org>
References: <20250211013206.4098522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.128
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
index 74952e58cca06..48f33d4994dc8 100644
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


