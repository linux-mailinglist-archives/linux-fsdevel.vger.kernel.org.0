Return-Path: <linux-fsdevel+bounces-29630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF0897BA51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 11:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192F0281CD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 09:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A4017994F;
	Wed, 18 Sep 2024 09:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8tilcpL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B562110A1C
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726652775; cv=none; b=pVvsiry5v06h7de6YHbDBhWgXwiKDrCbb1BXJxDAt1pea6wRr+Ott5GzkE0SWoNBKpgD172jIceqGK6kmYgu8sa7jC+HZK2VS84Zrdn+pL42vY544hF8wuU44fq58vu0WOZzV479R14v7dOneg4EYFQCjDup787+2mFHA8jQtHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726652775; c=relaxed/simple;
	bh=WQCMpDltgFBN4e3H0huS4+/DfZWbIpDoKz4Hv+EXBXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XveL8mkRtDyBNLx7Vi6FAqDz2sd+rOgpA0z843tEs6AKe7pLLOsWuQ0TQcZZPM5bmaNlOQV4WsceSfA9yF2MEGZ7ILD/q0ZBvNNP5IY/IjnPZdd3RK0f3lRDCR/06E63PjSKVIDZMnfhMQD+w1k2nThOzF/hWzdZ7WeujUyoy/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8tilcpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B33C4CEC3;
	Wed, 18 Sep 2024 09:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726652775;
	bh=WQCMpDltgFBN4e3H0huS4+/DfZWbIpDoKz4Hv+EXBXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M8tilcpLuvo19wEnVMkSRz/dH9h3CsJUcN8a6DNqYRe+M6BulQuM/pk4OHedXiHEt
	 eKbeN2cp538OG2YTZAYeh3fUMVL1Ukgpi2EbT25/BJ9/kqNaP6cP/MDGmaJs6E2Hlv
	 n3xM2r5EIENIEqcKi624LbZxmfmMblnIXO1EMSJKw6vJg9QzTfhFiOCn6qrSBkTKCI
	 Y2mA2CcKUjNsCuZUp5F24+kgo85OwX+1QWupS2xk+1EZJ7k8cYO3gf8aOom2HtihFs
	 7KjLxStFSyBXpwQnRAwfQkPYEMyuvyqD2BkCEo1Ks2v+hkqqaRn/Yu+cVelydxDeJG
	 Xz/rK7c7xcK2g==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Eric Sandeen <sandeen@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 0/5] adfs, affs, befs, hfs, hfsplus: convert to new mount api
Date: Wed, 18 Sep 2024 11:46:06 +0200
Message-ID: <20240918-geblickt-tapir-f7d341aaeaa7@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240916172735.866916-1-sandeen@redhat.com>
References: <20240916172735.866916-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657; i=brauner@kernel.org; h=from:subject:message-id; bh=WQCMpDltgFBN4e3H0huS4+/DfZWbIpDoKz4Hv+EXBXQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS9Wphocub8b2WG1AO53F3Vz8pWHjtr1yG0YlIej1/P9 YcvwoOFO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayt4Phf0z77q9/qxZWrio8 s9nvwrFbMS5dIStvO4aFagtnMSR/jWf4Z2ClbMx0xFHgVFxS602blTkvFnlayT3q1Z5apfmU+91 JHgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 16 Sep 2024 13:26:17 -0400, Eric Sandeen wrote:
> These were all tested against images I created or obtained, using a
> script to test random combinations of valid and invalid mount and
> remount options, and comparing the results before and after the changes.
> 
> AFAICT, all parsing works as expected and behavior is unchanged.
> 
> (Changes since first send: fixing a couple string leaks, added hfs
> and hfsplus.)
> 
> [...]

Applied to the vfs.mount.api.v6.13 branch of the vfs/vfs.git tree.
Patches in the vfs.mount.api.v6.13 branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.mount.api.v6.13

[1/5] adfs: convert adfs to use the new mount api
      https://git.kernel.org/vfs/vfs/c/5fadeed64d27
[2/5] affs: convert affs to use the new mount api
      https://git.kernel.org/vfs/vfs/c/de25e36d83fc
[3/5] befs: convert befs to use the new mount api
      https://git.kernel.org/vfs/vfs/c/c3099e72bf4f
[4/5] hfs: convert hfs to use the new mount api
      https://git.kernel.org/vfs/vfs/c/c87d1f1aa91c
[5/5] hfsplus: convert hfsplus to use the new mount api
      https://git.kernel.org/vfs/vfs/c/3c8fb5d57b49

