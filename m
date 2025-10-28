Return-Path: <linux-fsdevel+bounces-65886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0169C139AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 09:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1E61881C04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 08:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E186F2DEA7E;
	Tue, 28 Oct 2025 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsSiVYwB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F082D8791;
	Tue, 28 Oct 2025 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641188; cv=none; b=eE9Bf2q+wIFmdhcIxQkoUlQVrZMR62o6yjVF7bvNHBYgtOkdZB2ASMR7MqciQF04R1HsCURrLadciLcR7e+bwd3xNnXxl5AVgvoJWhxXMJw0m5IbCOcyaE4MEmZiQPK2pJop4TXBzOE0hOa/TINDLy9W1+2QKCSD/aAxxpF2Im0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641188; c=relaxed/simple;
	bh=w3mtdowJsCvEuLqwOzwn6IjUjzAdTS1pCL4gwDenbjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q+ZesuKzt9ivMueIxyDDuLUupaxVm6U9PfNsC+buAG7bBm/m4C2n3cgiWL7ys31mh6MuiPCQbfyPtuRL1BaGfEIyQxWwaCB3gkqnS2ou4M5NgwIqwrkHwTBzjoe6zBxEVwrO9TAyccmp2khwjEzK7n5Sp4VEiUDLjH6PvWoHPG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsSiVYwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A93C4CEFF;
	Tue, 28 Oct 2025 08:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761641188;
	bh=w3mtdowJsCvEuLqwOzwn6IjUjzAdTS1pCL4gwDenbjo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NsSiVYwBlzvdK6Rq2oeeLyKzJqBBz9CPvNFsXiPidXOihnwm2mNE+Nazae5wx+QWg
	 cl16T+P0+pdMB7gsW/Uv1Dh6UIeL0fp3uKtHn1Rk03aXC1x9eTb1JCSZU7IJcYaeYn
	 UPX0b4VOS7ttsQVbNp0VlV7DdxfSVcYB74wFjsXDPdmeBEcTgnUfjkTY7YgnS4im3Z
	 FiFTiu5egObCgDB/LH7yyUGjbmiAzC/z3nM2MYiuvG3Y5lsU8Af5UZqfrfyb91qvZw
	 evT1rvN4uemhiwRPCy8cgv9yD48Sp6UXxSvQcD5gJL3VfVKehGo9h61p0v3/0kmqzs
	 Ca/bVbwGpt1ww==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Oct 2025 09:45:51 +0100
Subject: [PATCH 06/22] pidfs: prepare to drop exit_info pointer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-work-coredump-signal-v1-6-ca449b7b7aa0@kernel.org>
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
 Aleksa Sarai <cyphar@cyphar.com>, 
 Yu Watanabe <watanabe.yu+github@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Luca Boccassi <luca.boccassi@gmail.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1742; i=brauner@kernel.org;
 h=from:subject:message-id; bh=w3mtdowJsCvEuLqwOzwn6IjUjzAdTS1pCL4gwDenbjo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQyNB0slj56964GC+vVa39brUqWn1L9yTBr5dNn/wU5r
 TO2yC+f3lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRGcsYGT79mtxuNrtUzdxa
 1PnbAbGy1abVTbtNlx8+cbXF7MGUIl1Ghq0yiZv05Dn3nvd53e4+RUtv6/kbvwyLPQKPmVz6dsV
 DlhsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

There will likely be more info that we need to store in struct
pidfs_attr. We need to make sure that some of the information such as
exit info or coredump info that consists of multiple bits is either
available completely or not at all, but never partially. Currently we
use a pointer that we assign to. That doesn't scale. We can't waste a
pointer for each mulit-part information struct we want to expose. Use a
bitmask instead.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 204ebd32791a..0fad0c969b7a 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -49,7 +49,12 @@ struct pidfs_exit_info {
 	__u32 coredump_mask;
 };
 
+enum pidfs_attr_mask_bits {
+	PIDFS_ATTR_BIT_EXIT	= 0,
+};
+
 struct pidfs_attr {
+	unsigned long attr_mask;
 	struct simple_xattrs *xattrs;
 	struct pidfs_exit_info __pei;
 	struct pidfs_exit_info *exit_info;
@@ -333,8 +338,8 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 
 	attr = READ_ONCE(pid->attr);
 	if (mask & PIDFD_INFO_EXIT) {
-		exit_info = READ_ONCE(attr->exit_info);
-		if (exit_info) {
+		if (test_bit(PIDFS_ATTR_BIT_EXIT, &attr->attr_mask)) {
+			smp_rmb();
 			kinfo.mask |= PIDFD_INFO_EXIT;
 #ifdef CONFIG_CGROUPS
 			kinfo.cgroupid = exit_info->cgroupid;
@@ -663,7 +668,8 @@ void pidfs_exit(struct task_struct *tsk)
 	exit_info->exit_code = tsk->exit_code;
 
 	/* Ensure that PIDFD_GET_INFO sees either all or nothing. */
-	smp_store_release(&attr->exit_info, &attr->__pei);
+	smp_wmb();
+	set_bit(PIDFS_ATTR_BIT_EXIT, &attr->attr_mask);
 }
 
 #ifdef CONFIG_COREDUMP

-- 
2.47.3


