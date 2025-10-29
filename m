Return-Path: <linux-fsdevel+bounces-66030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D3EC17A7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 575964F3BEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC832D6619;
	Wed, 29 Oct 2025 00:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXXFCUc+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D4A33993;
	Wed, 29 Oct 2025 00:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699136; cv=none; b=Va0m+mjrEhEcifccics5Ny+v5Zkms+fmq5YuiSioci1sTxId/IFMG9PtPtWZEYMLyrB2eMYyTi4gmUGnF51fATL4LWnIxDvvmQVhOw6xEcLy/9LXOyhrTApWa7y/W3GridFqxOJHHDcuFcJ6WEy3GfFEvraVgp3ayTpvGZGGKJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699136; c=relaxed/simple;
	bh=ukZIDVvKV6DlqTgJOaC6W18vjy2Y2AE+ikr3cW9RDx8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+ir/Q1ZlL9Z1dSOy5lUFFilnhtYiSzqk0lp+ln5JPrZYYDWq6s8W6fKu5uf6Byd/SlC4oJTlcvnasb0D9pT4odV/G8HzvyxLqS12ZjDiup4Y1rDGDAU+HWEiiWSXrrbcBrSIgIlMY/svExo+Uwp6SzIry5CzC7wdyAhJwGMXpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXXFCUc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF641C4CEE7;
	Wed, 29 Oct 2025 00:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699135;
	bh=ukZIDVvKV6DlqTgJOaC6W18vjy2Y2AE+ikr3cW9RDx8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=oXXFCUc+kif9KrjGEbQmFUDWtQkIxHrRF/vlKU+lP15zGH9tnrmUD6HpOx9WGkaPP
	 w/hZ+DS8ddavbrW8gFaOzJd3QMEFeXpTXR6iLfh6iw/oVjKnfqTiA9wOOmjNMPG6Oz
	 FypYIGJRoHsaOAL/9v+gl1dHghjjxZL34GbqH2wgrA/G1WZSGhcwvAVutjQl6RxjbJ
	 ggegI4A0k8dCaFsbFXB/+wryDzMdXV6VzwNzjLDePZ03AaEuSs2qYTie44FSmguAQY
	 /nut3D8quO0SkaHyHzfCyDqRnQ8IICYDurwnRex1xmEblQuuOC3itnHjT5kHhspXMn
	 53lCoE0CCbKag==
Date: Tue, 28 Oct 2025 17:52:15 -0700
Subject: [PATCH 28/31] fuse_trace: support atomic writes with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169810958.1424854.4578540792280744199.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add tracepoints for the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 9852a78eda26d3..ecfb988f86224b 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -327,6 +327,7 @@ TRACE_DEFINE_ENUM(FUSE_I_BTIME);
 TRACE_DEFINE_ENUM(FUSE_I_CACHE_IO_MODE);
 TRACE_DEFINE_ENUM(FUSE_I_EXCLUSIVE);
 TRACE_DEFINE_ENUM(FUSE_I_IOMAP);
+TRACE_DEFINE_ENUM(FUSE_I_ATOMIC);
 
 #define FUSE_IFLAG_STRINGS \
 	{ 1 << FUSE_I_ADVISE_RDPLUS,		"advise_rdplus" }, \
@@ -336,7 +337,8 @@ TRACE_DEFINE_ENUM(FUSE_I_IOMAP);
 	{ 1 << FUSE_I_BTIME,			"btime" }, \
 	{ 1 << FUSE_I_CACHE_IO_MODE,		"cacheio" }, \
 	{ 1 << FUSE_I_EXCLUSIVE,		"excl" }, \
-	{ 1 << FUSE_I_IOMAP,			"iomap" }
+	{ 1 << FUSE_I_IOMAP,			"iomap" }, \
+	{ 1 << FUSE_I_ATOMIC,			"atomic" }
 
 #define IOMAP_IOEND_STRINGS \
 	{ IOMAP_IOEND_SHARED,			"shared" }, \


