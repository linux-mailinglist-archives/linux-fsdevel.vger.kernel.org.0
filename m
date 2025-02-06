Return-Path: <linux-fsdevel+bounces-41058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F9AA2A6BA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 12:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61AB51888EE9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 11:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE0F22688E;
	Thu,  6 Feb 2025 11:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brz7HLWx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DF0218EA8
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Feb 2025 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839943; cv=none; b=Pv0quPqT7W/0chFcdaAw15quyI6UwjlZ+/QPBA5DawjQ4fqOFTfDirVyGd70OGZHYJY+d+5GYA8mPW0WUr++gtDFOhtOPlzvZM6wanFsUoaRIkjfyF3H6Kss4hM+RYgRS7qEyEXxALtB5gKiNrzJsM7eoLHjs8cZxtddWdlO2BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839943; c=relaxed/simple;
	bh=G8oVewC5c5s2GSrSFUfZW20V8b4T5If/SjQX+4ESXA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDpA5621NkIaqBGRUlZAGQ36DJ2+GrQUo8vSOQcC8bNjLE0nbhLVMCwCHTDRfVAyuOKRhp689invblEZTYFElo8/fDA6qlbRP7kRsYQJPvK9tROnLATazXJGEp7H07drTb1PKX3l57AhXwLX1OPvZWQcyeMJYL9afr0vCh8WFVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brz7HLWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F6FC4CEDD;
	Thu,  6 Feb 2025 11:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738839942;
	bh=G8oVewC5c5s2GSrSFUfZW20V8b4T5If/SjQX+4ESXA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=brz7HLWxUwZExYiAmAGMixFcXhFfNTgzCQ8bimhuZx20Mm6Rrb4Bgd87AgQiA+Dfo
	 xJ8IbYGl+aOC06Pwa3P7tNYImJ6p0i0vTSB9lu3Q9kEybfjelHq8HW8Vb7O3OTplq6
	 KLgdGaflId4oRfThzwh+P0oVSbEPn4DBSuE3awBVzBMSv2Sae+nzSaDNveI03/DSue
	 E7WtCAUg9VhHHiTKS1Ut+0b8CTAZIFPTT5CxN/Lh0mjXRJ5w1qz771MRGcFYiCvyjb
	 EJesT2VuflW8c3bx5ylDp7ZWo9kcqvpEwDLM63mf98s7/R2ZLCna0FrO2tVrXJTzL+
	 uYeXXJXV0qE9w==
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	neilb@suse.de,
	ebiederm@xmission.com,
	kees@kernel.org,
	tony.luck@intel.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] fs: last of the pseudofs mount api conversions
Date: Thu,  6 Feb 2025 12:04:49 +0100
Message-ID: <20250206-spekulant-worin-acebea11146c@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205213931.74614-1-sandeen@redhat.com>
References: <20250205213931.74614-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1568; i=brauner@kernel.org; h=from:subject:message-id; bh=G8oVewC5c5s2GSrSFUfZW20V8b4T5If/SjQX+4ESXA4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQvmV5furBzfVv9vD0sszW2qq/OfHBdtdK2NWvxqhMLe bauijBq7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIUy8jw96foc/L5m5Q5n7i 8DDUeKaYbbX32+y9JTe/MPxMu2xxL4Phf/r9Qu1UlXwLLo/PKpsYHzfNO/Tl3TEmzcxpZ1mY927 vYgcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 05 Feb 2025 15:34:28 -0600, Eric Sandeen wrote:
> Notes:
> 
> pstore used mount_single, which used to transparently do a
> remount operation on a fresh mount of an existing superblock.
> The new get_tree_single does not do this, but prior discussion
> on fsdevel seems to indicate that this isn't expected to be a
> problem. We can watch for issues.
> 
> [...]

Looks good to me. Thanks for enabling us to get rid of a bunch of code.

---

Applied to the vfs-6.15.mount.api branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.mount.api branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.mount.api

[1/4] pstore: convert to the new mount API
      https://git.kernel.org/vfs/vfs/c/f584714cffb9
[2/4] vfs: Convert devpts to use the new mount API
      https://git.kernel.org/vfs/vfs/c/cc0876f817d6
[3/4] devtmpfs: replace ->mount with ->get_tree in public instance
      https://git.kernel.org/vfs/vfs/c/cb0e0a8bf4e1
[4/4] vfs: remove some unused old mount api code
      https://git.kernel.org/vfs/vfs/c/bdfa77e7c6bf

