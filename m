Return-Path: <linux-fsdevel+bounces-70549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B307C9EAB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 11:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F9AF4E047D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 10:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3B22E92C3;
	Wed,  3 Dec 2025 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYESD3Pg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484A22E8DFA;
	Wed,  3 Dec 2025 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764756910; cv=none; b=UmTfJjCflp4IdVGLLp1M7JzsQZ9t2RlqdVyDlXWFCKXCBduRX2vi1mUeRiAAJlGOF/CyNNkF0znVGabyoLp3UkJAxqBVl4u/oXFuyvQzYuwstFwgxpYScKSkRILx58s1i7/uNYPDBzQ0Qmbq9f1xVTZpA59wNxJ4WvsQC4RTzZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764756910; c=relaxed/simple;
	bh=4o5KzcrgR7wCves+21Wu1u0dZ3xcZjAnI1rWHUx2mIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C2zFy+oUZ3XX6YtJbRKJ1DenMuF/EY52F8K3hr4kGPVaToRWaaHKSAyvP+kl5AbdfVOJ/bFMPxW4fMGhWA1kWxjouxRAXBJbc8iINPLldDhXbfJMBhWc+ybTFxr4HwrqMPqwypdYUIE1sukaxTFTUyZtlVsI0/+ZpYDEi0yq5pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYESD3Pg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FD1C113D0;
	Wed,  3 Dec 2025 10:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764756909;
	bh=4o5KzcrgR7wCves+21Wu1u0dZ3xcZjAnI1rWHUx2mIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dYESD3PgAJ5QCJK5JXngwoPSNz2NyUnAhU0C9AMDaDpv0tIScD89R+Pr+/lZhTjjy
	 Qpx5rYrFVCw4FrpPshhrdVrJCe3kMprtdcZyK/GJyRb+ezER02bqfS2bzpSqJz+jgj
	 y/wobs4GItambY4hVbFjhDTfl42eQn6heEWE5xHJ5nE9L14XlHlRDMkOD/cVw/RecC
	 PScUyHrQZicAg5WBGyhIjJCmcnwCxbGYRdCye3HNHEAXS4tjjNOHR0PsRRJelDrvVM
	 HnPsQUFYNOJlaSPvLCNdd13YWzeMSmBarNhU+YgoQe7RpVFrI1UsNjbOdiDMpCAZwy
	 tjhBH4lrQY/xw==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: assert on I_FREEING not being set in iput() and iput_not_last()
Date: Wed,  3 Dec 2025 11:15:03 +0100
Message-ID: <20251203-zeitig-zapfhahn-fe29a9944d47@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251201132037.22835-1-mjguzik@gmail.com>
References: <20251201132037.22835-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=846; i=brauner@kernel.org; h=from:subject:message-id; bh=4o5KzcrgR7wCves+21Wu1u0dZ3xcZjAnI1rWHUx2mIg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQa8K4IteZzupbn4pfnU/u1qEY+W61F78s3QabjLMxPD 2bWOP/rKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmMijnYwM16d1dPnv6tOWEdZ8 0TqT5QdPSMyD5/FHVD58nvFs7Wu7aYwMK0SdOBh7a2ZcXDXbqSPJ/UPVrL7eblH1SlulKbN4d/f yAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 01 Dec 2025 14:20:37 +0100, Mateusz Guzik wrote:
> 


Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] fs: assert on I_FREEING not being set in iput() and iput_not_last()
      https://git.kernel.org/vfs/vfs/c/aa8aba61d4e1

