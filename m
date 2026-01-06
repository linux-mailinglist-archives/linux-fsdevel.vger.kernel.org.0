Return-Path: <linux-fsdevel+bounces-72554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98082CFB4B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 23:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2C38303A082
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 22:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810312EBB89;
	Tue,  6 Jan 2026 22:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvKK++SP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD7315CD7E;
	Tue,  6 Jan 2026 22:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767739949; cv=none; b=HNhhCU4L0Pd9R8fcMgtNdU0jYVUmAPRtivcWEIscdS0rhGtjttwmtuY5XdhpEmIE5M5oVG93La24NPOGtt1DvABUlCYDcMRNpUfXIu3dHUCJaI3HScC+G8Dkp5YHL4Sd1ZHpmu8zehagMXj1EYZRvFHT+ikUkaNHxt9nHETFYGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767739949; c=relaxed/simple;
	bh=uhjnuB+qAOsqFciG/EEclMWaqY8V5Z2znhMqlXlghJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PSlMwebw5wyXZ8Me7Beri0KYpH/+tKrU+Gs1SzcswpEYIZMnKPjOe7BSBS28ZzkuDS+mRI79RfSdh0WCrhi21A3bfuTFjQDLE3jRrsWnM04UwjwTS2YNG9Fcjt88C3/LabIzbIZ14ne310MqX1mmwiAbvoSsX893mLgx8C4T0Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvKK++SP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0DFC116C6;
	Tue,  6 Jan 2026 22:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767739948;
	bh=uhjnuB+qAOsqFciG/EEclMWaqY8V5Z2znhMqlXlghJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YvKK++SPc3UN/RiPiHIG1fkGp2iiiyAskXBMuvr6pABuJD0QEouKWdVBdqUz9VNlz
	 wu83FyHIC/fYjfPmuCh9t47an9Z/jHYmhM0IlRjDMPVecB4TAxtlwAGtTsqqx5N8Gk
	 cIdWI/hzulCcFsuW2dnsWyFzoWcxi4/VhDqUJXXSby553kpOlwf5gT5yQJhB9nnHEE
	 YZKP2wlmyhSyqNbP8GKAtR+P3ROqTChDiGr8JIuZdVv3veEuGB8ZkvZ6EdjQtvyuUO
	 I7bTdGYdNOE/vMqI1PsgwuGPOxFAB13B+93VXHg8IocUIvi9Vmkn6c5tOyDhHUdWHC
	 KSZCR4vpAgUIw==
From: Christian Brauner <brauner@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jlayton@kernel.org,
	rostedt@goodmis.org,
	kernel-team@meta.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs/namei: Remove redundant DCACHE_MANAGED_DENTRY check in __follow_mount_rcu
Date: Tue,  6 Jan 2026 23:51:49 +0100
Message-ID: <20260106-anreichern-zustehen-bace5beb4cad@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260105-dcache-v1-1-f0d904b4a7c2@debian.org>
References: <20260105-dcache-v1-1-f0d904b4a7c2@debian.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1241; i=brauner@kernel.org; h=from:subject:message-id; bh=uhjnuB+qAOsqFciG/EEclMWaqY8V5Z2znhMqlXlghJs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTGTuJQZvr9VyzPImCNXoKYc6hZlBW3PYOo8071bUGJM 78duCPXUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBHbjwz/HSUdzDbKX1vk8Mlo uanBbb/ADP2Nl3u3un2u9GAWyfizgZHhuXPYZyk387NH9k7h0+QyerBf5w/zOcW9jx6ZRNxUPNj LDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 05 Jan 2026 07:10:27 -0800, Breno Leitao wrote:
> The check for DCACHE_MANAGED_DENTRY at the start of __follow_mount_rcu()
> is redundant because the only caller (handle_mounts) already verifies
> d_managed(dentry) before calling this function, so, dentry in
> __follow_mount_rcu() has always DCACHE_MANAGED_DENTRY set.
> 
> This early-out optimization never fires in practice - but it is marking
> as likely().
> 
> [...]

Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.misc

[1/1] fs/namei: Remove redundant DCACHE_MANAGED_DENTRY check in __follow_mount_rcu
      https://git.kernel.org/vfs/vfs/c/a6b9f5b2f04b

