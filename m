Return-Path: <linux-fsdevel+bounces-55535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C17B0B82C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 22:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E7EC7A302B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 20:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1E322069A;
	Sun, 20 Jul 2025 20:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="d8Qk+krm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90901EB5F8
	for <linux-fsdevel@vger.kernel.org>; Sun, 20 Jul 2025 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753044873; cv=none; b=WjcJzZsLabTo6kJYKoA2vC5ZEs/q/XCPdcZSGkNKSeUZc1TXvfod9TP8Lqq6/jpm0MgLBJ1L3wiNpMyVsYNnMSPISy8LOnc7xRrAEPNIDEs6QnMLCtfQ4p1ZbHKq9qBqAEVINllypnPwy1VKEeKdEdqMIsKDCwhubah3G/dlnXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753044873; c=relaxed/simple;
	bh=YpBFT7CnkRgcMaY/JKVrm3QKNXnCxs5Rm0+vE43bNOw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SVQA9euYdE5jaVjaIc2Lw3qCWqvk/ug3cD7S6dfpSrCbT80vpTbwUAj36sTujNsWHgutZpQgEv3Qqeu1T2XZE2uFWsIcKOzNErIDpLvslwhoC0dEJWtIkNXmxdmOdgUfKsz+iTbxQUBlteT5oeyzSUDA03hT1t1V/t4cqeksCUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=d8Qk+krm; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=xp67H9jDaZYt1QQOFE0yX1WNudrWgt3f/ci721h1W8Q=; b=d8Qk+krmhxzykDsHMA/tzSFghB
	FgVDfWbhPnq79ICpfsqML/R9sSfqD5aI+Tj32vtmClYc2D6wezm4QpmAf63iJV2wWMtXwo2LXa4fU
	oNJpB5WiQBA8ldlClYuIxoTSkBCkiBB9R9sRzEDnWF8rlc0v2L+0wFs6xDmNvqYoPtUwn6NoafFXo
	2Do+S+TiUS+z23uyUse6eUfGNDc7PDiA+jiUMh8t9DY6mjqVb00UD9505jwlxYWnemyM7LTNLg9Gu
	B1HKKggAg3gHAvQKk4wTiIrnfS+AMXgv9PE4PHfGkae8bBqtzlH16d0sNN+0b4PVHUvg6R36ofm8b
	Su7bGFyQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udb3D-000000004kk-2d8W;
	Sun, 20 Jul 2025 20:54:27 +0000
Date: Sun, 20 Jul 2025 21:54:27 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] fix the regression in ufs options parsing
Message-ID: <20250720205427.GK2580412@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

[in #fixes, will send a pull request tomorrow]
A really dumb braino on rebasing and a dumber fuckup with managing #for-next
    
Fixes: b70cb459890b ("ufs: convert ufs to the new mount API")
Fucked-up-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index eea718ac66b4..6e4585169f94 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -397,7 +397,7 @@ static int ufs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			pr_err("ufstype can't be changed during remount\n");
 			return -EINVAL;
 		}
-                if (!ctx->flavour) {
+                if (ctx->flavour) {
 			pr_err("conflicting ufstype options\n");
 			return -EINVAL;
 		}

