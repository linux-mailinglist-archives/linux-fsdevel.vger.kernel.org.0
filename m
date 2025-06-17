Return-Path: <linux-fsdevel+bounces-51934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AD2ADD2F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 17:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D597401DE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A142F2ED17A;
	Tue, 17 Jun 2025 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhQNR3n5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073D81E573F
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175127; cv=none; b=GO9lyTQXTz70c+DeH3bdXb4R8xsjRazlFYIUIifsTD74+JjWHIqrpSbe2uS3UPPDcHne/UyZi8qDPnoTlzujpH48z0dzjdYDWp8tHvHX0yVuZDnaTfPb+/2JVm2ua2z3pXV/oj2rQ38lGVADCRhplyBGZS1Qb0RIEB6Ab+skkq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175127; c=relaxed/simple;
	bh=UHJw0+IWD87G0xSJs3wlAUiSuj8RNBznHlUR4CGwtZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PTMQ0ObPoQNgOoBXmMDVq0Ln1Qevl1ffGH3t079rPqLkXCZuAc/yiv/3mmWUcK8Ty5iXK9RwCdRCpkQ6Es2nOz3xe10MSl9ytfJypxOdPQ2Q9yvo7ZhHCwyV5pXiIplqzATIhl5lDcmLk0cMwxgNGl2zSvMgB6Jx3Md4jnGp1uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhQNR3n5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49573C4CEE7;
	Tue, 17 Jun 2025 15:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750175126;
	bh=UHJw0+IWD87G0xSJs3wlAUiSuj8RNBznHlUR4CGwtZQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KhQNR3n5B4PQhX835+GoF+oSe8EYAUbNEitABfFE/Dzhv5v5RreFj2NssApATek5G
	 +YUYff0zJYKCJK/2A0edNDPhzGmmSDyphsQ+uKPkUaqtWBmnsPxgvrh/3BYDcrVqGM
	 WraNs7oH/MfMt3N650WLr9bcbD4HCiJQcUjnl5luNkcFRCMDNvCU4I7qFGBy4F5WAa
	 OU5/zK5Z9WVk0kRZ31Y0z3nmak9TpooxrEEUuk2ioG0Tljdilpmk3EohT9ikX8Tg4y
	 erbzfDbO4Rj1wiBAcq1Uzpz1HPwW1nF6lOnJvzvYm13tW2O5cJMJjuWPJ32HufP7km
	 ScbQ4QGPQRC6g==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 17 Jun 2025 17:45:11 +0200
Subject: [PATCH RFC 1/7] libfs: prepare to allow for non-immutable pidfd
 inodes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-work-pidfs-xattr-v1-1-d9466a20da2e@kernel.org>
References: <20250617-work-pidfs-xattr-v1-0-d9466a20da2e@kernel.org>
In-Reply-To: <20250617-work-pidfs-xattr-v1-0-d9466a20da2e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=588; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UHJw0+IWD87G0xSJs3wlAUiSuj8RNBznHlUR4CGwtZQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQE9k5IDxTOClhgeJVpxeGOINGr/+Lji08yTTwaM6tsd
 /DZv69jOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyyo7hf0mU2eo3qxcnzftq
 EddlVtG8c7F3mU8x34pohYKNFvsTixj+JxeaCTnl2OwsfJvxeffCFOYVaZVWcdE17lkTYls+tC1
 jAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Allow for S_IMMUTABLE to be stripped so that we can support xattrs on
pidfds.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/libfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index f496373869fb..9098dc6b26f9 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -2162,7 +2162,6 @@ static struct dentry *prepare_anon_dentry(struct dentry **stashed,
 
 	/* Notice when this is changed. */
 	WARN_ON_ONCE(!S_ISREG(inode->i_mode));
-	WARN_ON_ONCE(!IS_IMMUTABLE(inode));
 
 	dentry = d_alloc_anon(sb);
 	if (!dentry) {

-- 
2.47.2


