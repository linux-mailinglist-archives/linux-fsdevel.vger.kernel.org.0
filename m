Return-Path: <linux-fsdevel+bounces-44021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D62A60F34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 11:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FF197A8175
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 10:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF6B1FAC37;
	Fri, 14 Mar 2025 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWrB2J5W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E451FA272;
	Fri, 14 Mar 2025 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948838; cv=none; b=pnwxzkRLCJdPdFmEHDMyIMUDRlVhudpctvIL83FBfXocCCBO3roDkSeCz4g0pvb2yelfn8/495ao63QMlYtdLWrVmK1Gib4lcWNBhq0u7Ai0ccjx1RLEvmFPHIfRio1LjjkhUpkc7dd8badyBfJvd53VPB+4V56zoy2SndghMzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948838; c=relaxed/simple;
	bh=YlYthM0JFQWS1iQTNWlFWMbsRCG12+fXikfUX1iQQ6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GmAyE/lypCUNCN0HNz4rb7w6ZpgqWu4kZbrI1qJSzSmQBrIOXIynQYdGaUsFk27VJkner2P6bV0ZdRJOHCNqR+TzvDi6yg+N9kNycXIaO2z4wue9L4/nCgwH2oMwKow54PPsNPJ7tGuUDlWvu4t7+zW725lEPeWliPLxjFY+hVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWrB2J5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C253C4CEE3;
	Fri, 14 Mar 2025 10:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741948838;
	bh=YlYthM0JFQWS1iQTNWlFWMbsRCG12+fXikfUX1iQQ6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tWrB2J5WPJg3XnR++pcyP5dwbwdGFcowYP+rfTpaUR624Pq5yDyvrD5zWN8XwK8aS
	 CHMraz9Rh/aFyoOMPccKmg6hzhA9IbCCH4ty+1CGNIYtnr9/HmElVpzbDaoeown5Kd
	 B7/+NgN0Vzco0jSmMKDpfEMYCnAahnsQCPM9Q1mP62o5JWnYRcqpPfWP8hL0yu7X74
	 6FgGxoAH/N+q9TGGZ7E1qCLm4x0yDRZYvUVa5BrMf1EEV41nq2QVEWF8xZXy+B54jP
	 dIfagmcKxjeS/E7FPeqlbQhwETIafy/rEIOkpvWs+8uzwvCkHYqq+LVVo9XNtZQerw
	 i/zlKFoQVq3xQ==
From: Christian Brauner <brauner@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] exportfs: remove locking around ->get_parent() call.
Date: Fri, 14 Mar 2025 11:40:29 +0100
Message-ID: <20250314-robust-bauzeit-5b57cf99eff0@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <174190497326.9342.9313518146512158587@noble.neil.brown.name>
References: <174190497326.9342.9313518146512158587@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393; i=brauner@kernel.org; h=from:subject:message-id; bh=YlYthM0JFQWS1iQTNWlFWMbsRCG12+fXikfUX1iQQ6A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRfYV/gfP7Us+pedoVDnAsfvcqWvab56n2OQMz3T0+PT uCeu7thakcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEfi1lZFgq0mM8gY91/f30 l4uYWzi9Gf6ctNU6MMU3dB7Pua1HPn9jZJhiOadAqy5Z70Fj2ux3wexZDTe+/N5YzqKW67rozRL V17wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 14 Mar 2025 09:29:33 +1100, NeilBrown wrote:
> The locking around the ->get_parent() call brings no value.
> We are locking a child which is only used to find an inode and thence the
> parent inode number.  All further activity involves the parent inode
> which may have several children so locking one child cannot protect the
> parent in any useful way.
> 
> The filesystem must already ensure that only one 'struct inode' exists
> for a given inode, and will call d_obtain_alias() which contains the
> required locking to ensure only one dentry will be attached to that
> inode.
> 
> [...]

Applied to the vfs-6.15.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.misc

[1/1] exportfs: remove locking around ->get_parent() call.
      https://git.kernel.org/vfs/vfs/c/64a56f635aae

