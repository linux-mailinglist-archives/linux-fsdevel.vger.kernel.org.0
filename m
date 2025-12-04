Return-Path: <linux-fsdevel+bounces-70637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4F2CA2F41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 10:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CE44301739A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 09:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0CD33BBA9;
	Thu,  4 Dec 2025 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPbvh290"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50AA330B14;
	Thu,  4 Dec 2025 09:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764839562; cv=none; b=kk7HcODxk0JfG2pzVMHmXSWGvc2IOvXhN5HXU17SU3rVCUMjInEyzvzap3aXJhyQjo5zs9qkgSBD0dLlN4XagL8zPCMcBnHbtmkSj6uSwzzSzymBxB/oy1Yi/W8xyeBatZd6NFYWiFPNkCPmKKfYFuD+feToFFb1hDacEi/o3QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764839562; c=relaxed/simple;
	bh=+v5iS8F+w0gFCrZNCijc2op1OHvTWTBEqjPGxj3ePVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arVQgTQ78lWOrvyZcD8hBmozLqk3hS7+pLaSD17cBbA1a1kouap8Ote5RYCV9ko3v24gcmThd8vOCP5Fl/mjTpfZpDmnJ4X2Kb+JHKIdrjPcTRQr6cNNBsWtDvOeM1Fr+uZZaKREX7AARMf4da9dzvCiWZmSyW1MttfxyxITzGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPbvh290; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F314C4CEFB;
	Thu,  4 Dec 2025 09:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764839562;
	bh=+v5iS8F+w0gFCrZNCijc2op1OHvTWTBEqjPGxj3ePVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rPbvh290+eqciYYr7NHzkYxo7kyMqqnJ5nELdCsiL9nK5/t6mMssFOxervrng+dpR
	 5PqQNOs59tZZqTxg/FHqZYnAq/RMhWlQtThEROBdDEB0BILj9ng9J+EB2jlUqWMolm
	 vi3JjWwhbje3YBnntubuqBFMPf1HQSFNzdDgriDp+VCj1D3Fqw04oFenpbcNkCmoGi
	 FRCpbp0f15ZGmyKgYH+wx02IeJ91CgkOGDMyMiYZZ1pvXVOKQe87fqZukofiyF1pBL
	 /c1NJEwG/mxcAhFjVYi6cmAMoxtwOT/juL8lInjM0OBLgNGNvjg0dEPPRmWRAOjkjG
	 S1MGtj6Iyq7/A==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: annotate cdev_lock with __cacheline_aligned_in_smp
Date: Thu,  4 Dec 2025 10:12:35 +0100
Message-ID: <20251204-stachelschwein-artig-573eb345b0ab@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251203095508.291073-1-mjguzik@gmail.com>
References: <20251203095508.291073-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=brauner@kernel.org; h=from:subject:message-id; bh=+v5iS8F+w0gFCrZNCijc2op1OHvTWTBEqjPGxj3ePVY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQaBrROuCn86dbTZcI35E/52fq5vreUtXjTNH//ObvVf zyUZl860lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARl3eMDAvta9NsdzsZSKyY dT0xzaatcMq7tRWZu8/mCN57+3+jvTvDP51mb/G5as9lLucH7Z+5tex/59IJztuWKTKIV/h8kbM K4AIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 03 Dec 2025 10:55:08 +0100, Mateusz Guzik wrote:
> No need for the crapper to be susceptible to false-sharing.
> 
> 

Applied to the vfs-6.20.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.20.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.20.misc

[1/1] fs: annotate cdev_lock with __cacheline_aligned_in_smp
      https://git.kernel.org/vfs/vfs/c/6913380839e5

