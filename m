Return-Path: <linux-fsdevel+bounces-41528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE844A3128C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 18:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5650C1678FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 17:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4089262159;
	Tue, 11 Feb 2025 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnA1ngJj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F146F26BD8E;
	Tue, 11 Feb 2025 17:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739294197; cv=none; b=Tyqha+A80of4tA4U9/bbAKj4xSAoZ25u6OibVvhW2irMchqvmeOhy6aj8YkZJLRigK+jB/ciKG1MLJBYM2OSIZAQLnWH5Vi2xZkLwoBv9RGEfGlFWJRV6t1NunTzeyzQf/akE2sFT7/8PsblJyKgM5skQX673cevYyKUhFLepQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739294197; c=relaxed/simple;
	bh=V5BQs0P48+6MWPIv4S53HLzKacnkBGkCqskb4wYwqkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IdZBPsxsOu+ioWdKi8+So+qSG+ev9hxS4Gq/wqXUDFZIurZShHkYyWerhWwTZNhhPKdOsEQwtOi5VoKeZttnsXMMu2djVGPsaTPJ6kJvXVPr50rZG20QwUHLnuzGJmpvhccQnUWiFbxlhJ9fjbfG7seWdHiEtN6rLY6mLYsWLQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnA1ngJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97679C4CEDD;
	Tue, 11 Feb 2025 17:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739294196;
	bh=V5BQs0P48+6MWPIv4S53HLzKacnkBGkCqskb4wYwqkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HnA1ngJjFsWe1a5PalgDDV9WuOjuq8bGdFcjS3pJ5YXErGitYFB5c3uBy+9YM3cA7
	 ub/TfhTq+2KNdru9d6FQRIH13RUFCz5hY9fMWKQQ6nePPYVIEBH89+bMho/dNt5cdc
	 8xSromMcsq2/SQci33TonO4JqeZBqayDbnGE4Z9MM1F4IR8FwzZsCWlkgWEAEb03LS
	 4KYICFHkx8I+DGURtu2pAqfn25LjOUZ6mKolbdA3kLPzxHtI4LWoH456Vrnc0pp/X9
	 iO2HXJp/IlxI9aY/qVGe0ByqMj+7MIgHTHg2X2qdW1Bt/+4BnrnwrBfQW23SQ9U/Qt
	 9R4R/hJZDl4/g==
From: Christian Brauner <brauner@kernel.org>
To: Zicheng Qu <quzicheng@huawei.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	jlayton@kernel.org,
	axboe@kernel.dk,
	joel.granados@kernel.org,
	tglx@linutronix.de,
	viro@zeniv.linux.org.uk,
	hch@lst.de,
	len.brown@intel.com,
	pavel@ucw.cz,
	pengfei.xu@intel.com,
	rafael@kernel.org,
	tanghui20@huawei.com,
	zhangqiao22@huawei.com,
	judy.chenhui@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	linux-pm@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] acct: don't allow access to internal filesystems
Date: Tue, 11 Feb 2025 18:15:58 +0100
Message-ID: <20250211-work-acct-v1-0-1c16aecab8b3@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250210-unordnung-petersilie-90e37411db18@brauner>
References: <20250210-unordnung-petersilie-90e37411db18@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20250211-work-acct-a6d8e92a5fe0
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1363; i=brauner@kernel.org; h=from:subject:message-id; bh=V5BQs0P48+6MWPIv4S53HLzKacnkBGkCqskb4wYwqkg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSvbr34XdY75LKqXuUhtrTAag7+zi+9yvKHpLOa9llvv /FQaG9jRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQC5jD8z5/2Tir5jfHOiU+O yVf8vjArac/xa5feR7MncPAwV0yt+MfwP/vbrDk7Z1rHpxw5UfzzapDNBh2ZeSsnzp7KyuyyPLU +nBEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

In [1] it was reported that the acct(2) system call can be used to
trigger a NULL deref in cases where it is set to write to a file that
triggers an internal lookup.

This can e.g., happen when pointing acct(2) to /sys/power/resume. At the
point the where the write to this file happens the calling task has
already exited and called exit_fs() but an internal lookup might be
triggered through lookup_bdev(). This may trigger a NULL-deref
when accessing current->fs.

This series does two things:

- Reorganize the code so that the the final write happens from the
  workqueue but with the caller's credentials. This preserves the
  (strange) permission model and has almost no regression risk.

- Block access to kernel internal filesystems as well as procfs and
  sysfs in the first place.

This api should stop to exist imho.

Link: https://lore.kernel.org/r/20250127091811.3183623-1-quzicheng@huawei.com [1]

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (2):
      acct: perform last write from workqueue
      acct: block access to kernel internal filesystems

 kernel/acct.c | 134 ++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 84 insertions(+), 50 deletions(-)
---
base-commit: af69e27b3c8240f7889b6c457d71084458984d8e
change-id: 20250211-work-acct-a6d8e92a5fe0


