Return-Path: <linux-fsdevel+bounces-45940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732D0A7F907
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 11:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA4A16FE47
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 09:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFE62641E9;
	Tue,  8 Apr 2025 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VO99WYQf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4478720B815;
	Tue,  8 Apr 2025 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744103407; cv=none; b=SUzRVyM205FTqRk6zqhkRSval6Q3hyD3z38XsYDq4pnxf99Ua0djj6tn0dSqnvfqmQF3Fv3RECQa7eYT5CFhW66ddPANmgX6oFxGaRr+X0Eq707//aE4a7UzewaXoXwSwH4dZQp4Y9atZJqZjQ6E5XafogequyiIrXLTA85+S+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744103407; c=relaxed/simple;
	bh=Z4T2PTHsE4Uthlj+pxngsTdjfyYFz4NTg4R+azU7Sy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEYBiWIp7PJvhsWWtGPfVQ9o2V3nsKMDXtQFyqk9zUjyI/Tu46INVnLqYcs/rSh7IN6OcZnnkTpe2ZV9BOUJWLKBRkvscfS30NEU3IKNRM1ju1/zIDsGS6RQN3LOw09bbMNCWZxUsXciz128R1rnvloo+YJNDALGy9mJpQy5ERk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VO99WYQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32067C4CEE8;
	Tue,  8 Apr 2025 09:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744103406;
	bh=Z4T2PTHsE4Uthlj+pxngsTdjfyYFz4NTg4R+azU7Sy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VO99WYQfnsdLH1oyz9g3cf1c+xZbDvvWCtWgya/NJWTm4mO5keb5c5xlSR00MBk/B
	 jmYYOY7okfNL15X/MzBWRHnjsJUFFge5DFk6Zx0l7lkx1DUAxTl1ZCW4ZXCv0F2MS4
	 jFKaBCqmy70A1C5MwtTi6RIgNa6f+2jyoEOLpaUudXwleUJyJo970D5f710qMfefDg
	 vpJ2aoZWG0+3MTdrRl572rKAS+zBsc9spCno0VHXIK7Xvrg3ziMm3mJdUm+dPhiIuW
	 LaYG97yePX02moHa5cdQbkIgqfvC8D+0kqcVPsW6g7t0hdd0ljaR8Sp5XV5zTc2VSJ
	 H6nmiV59RolRQ==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: unconditionally use atime_needs_update() in pick_link()
Date: Tue,  8 Apr 2025 11:09:58 +0200
Message-ID: <20250408-marginal-sehnt-4b20d3a08153@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250408073641.1799151-1-mjguzik@gmail.com>
References: <20250408073641.1799151-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=974; i=brauner@kernel.org; h=from:subject:message-id; bh=Z4T2PTHsE4Uthlj+pxngsTdjfyYFz4NTg4R+azU7Sy0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR/ef5iecHdtjf7zhsvyF6t5ymcnHsq+Sdrun1CR2ZWa KXu7R1cHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP5nM7wv2bv/p1Ri2cy8lW9 6anZ7R+RyaVp1rB40vVs6SNM05V6XzD84fZov6+22fhq/u4V7+pnP1ufMnfShC03JLfXzzC5kiA ziRcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 08 Apr 2025 09:36:41 +0200, Mateusz Guzik wrote:
> Vast majority of the time the func returns false.
> 
> This avoids a branch to determine whether we are in RCU mode.
> 
> 

Applied to the vfs-6.16.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.misc

[1/1] fs: unconditionally use atime_needs_update() in pick_link()
      https://git.kernel.org/vfs/vfs/c/e45960c279b0

