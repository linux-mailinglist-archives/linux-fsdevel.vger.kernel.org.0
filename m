Return-Path: <linux-fsdevel+bounces-63468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F3BBBDBD7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 12:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F3C5934A926
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 10:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9342550CA;
	Mon,  6 Oct 2025 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qt391HRg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F21B23FC5A
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759747458; cv=none; b=m5Nbos+ePCOM5ucHjy16VYdOdzFgRNW5SbCP2pf0VuFC1TMMiV/mJaS5zXfoiYUjWeuKV2HjMDootcGm7H03PLAFd4jHHpAY9blJHh3bj21hkTO4C+T2MmiCS4Z/zwZd2qlyfTyTQJSXh9vnm43+K0Im76Qp5byd0D3nUN5mP0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759747458; c=relaxed/simple;
	bh=hahKFtnDjUwDf9lNbu/ZSVlR5MuF7kKnGEBfXj5TfRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWikeTQpr8xqjHvxog5hdaZTxHrk8uLrMD/M7dKkT4TxIKgt6M9DSrPkEJ1EjfzEWnPwvhGA9qIa2Sy4F5uj5oo0LL8KtggRqOudJw5Tl2Fnt7wpB69WSPI1mMxqlxluZnFXJRSkvzOH3VOHYr02nme1PVDmyXYxqroBBN3+PPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qt391HRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75918C4CEF7;
	Mon,  6 Oct 2025 10:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759747457;
	bh=hahKFtnDjUwDf9lNbu/ZSVlR5MuF7kKnGEBfXj5TfRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qt391HRgW3G0TUSkNuYBooHmZTWxdoRGXPWz38fljuSEoeEIDiKVvLh0w2HejNDgC
	 Eil0W/akuzTqCTX/CSPj0guOJPxYgZjoccPPrzjec4v7gTM3HiCnGqRVVJgCSZT9xJ
	 RkQPB3bYVj/8KdXSkSgGGiHKwREUsNRDue7lEgCQVWxZbUsHQNPx43ppsePunrgCnY
	 jH5fCC6ofjGiGcgkp+qc29q5dcJzj0Mz+gp2qpIqx6E/46bnwLUJETiQJotK+CGUH0
	 LLHqR/zBF0v0i8PoVbljeEgjQo3qp6ZYCeRWq9+tNB6e3M8/fOzai/rf5IlojcLFrC
	 xHnlgPEh64GgA==
From: Christian Brauner <brauner@kernel.org>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: (subset) [PATCH v3 2/2] writeback: Add logging for slow writeback (exceeds sysctl_hung_task_timeout_secs)
Date: Mon,  6 Oct 2025 12:44:06 +0200
Message-ID: <20251006-umwandeln-umtrunk-63d55eb766f5@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250930071829.1898889-1-sunjunchao@bytedance.com>
References: <20250930071829.1898889-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1167; i=brauner@kernel.org; h=from:subject:message-id; bh=hahKFtnDjUwDf9lNbu/ZSVlR5MuF7kKnGEBfXj5TfRA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ8nluZ/Mtizv008Yl3ZY/+mjfjnf7OA1Ul79Z3HuHrF ZXa2h/p1lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRlTqMDF1Ne9+6pp05oR0q 9ZXH+qrKv8lVC15W8Z6bsvV/lGHSvAOMDHNehB6qNnlga3yOf3p5iKxHa2jhx+Nvp8tyW+5S2pc fxg0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 30 Sep 2025 15:18:29 +0800, Julian Sun wrote:
> When a writeback work lasts for sysctl_hung_task_timeout_secs, we want
> to identify that there are tasks waiting for a long time-this helps us
> pinpoint potential issues.
> 
> Additionally, recording the starting jiffies is useful when debugging a
> crashed vmcore.
> 
> [...]

Applied to the vfs-6.19.writeback branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.writeback branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.writeback

[2/2] writeback: Add logging for slow writeback (exceeds sysctl_hung_task_timeout_secs)
      https://git.kernel.org/vfs/vfs/c/51d8f1c7919e

