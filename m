Return-Path: <linux-fsdevel+bounces-25244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C29494A435
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 11:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD30A1C215AE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 09:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCEF1CCB3F;
	Wed,  7 Aug 2024 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNdpQQsi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FA08F77;
	Wed,  7 Aug 2024 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022529; cv=none; b=AutCCBdAD+z5/ujMshOc1HdY68M1SOndTeCy9xn+qyvTyOu7wx/OnEdFLmfigVg9JuJSPOFh7X6taxwAFYMVIzv0ZnlvrnlFWkjCG8LGxWp+De5lfwjYp6aLZUWB5kDKjm11sx809a38/I+z//t1Crp7s3W+q8mH+GBXkfXN8ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022529; c=relaxed/simple;
	bh=cZ3VkXgVBmluAFlA02SV7pyCSpnRwx+5eeUl4yS+j1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D46DCbhVxyss5LFCiM96T9lc7hXtW/W5Jgzkem9//6P70KzWtQ1eXKCGobI3SSOaEG8iGmGDqA9DGD3QuojSozN5zuXjF3djpdufcUg7HHcAGSARX4CfR8vu8IY8+PkgRmAWnZ8B2YWngmXFw+sad4mhZVUwEf1i2izQP5s9qVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNdpQQsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F8EC32782;
	Wed,  7 Aug 2024 09:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723022529;
	bh=cZ3VkXgVBmluAFlA02SV7pyCSpnRwx+5eeUl4yS+j1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oNdpQQsixDcpe3nDsWogzlCIFKWURXxMcM3UeV+N/qFY06C2pTEDaZ6sET8OonO0s
	 QzD5wWBxerHg7NG3lEiA7xwOmpgMoR+NSxpNyNtpy4JaXLpDi5RxU14jQMVUocBQE3
	 2tbfcq/sbK51ZFyL3VRWUJWZsE9L4ZZPlF5MwA9wFnFsC6a2i7CBuMb+Mlkbzfv/Ug
	 etsv3UIpp+3j4PwD3btJXBwDKvlPMwFCaQDCNVrfn0dsb2IKdRifPYosyUhGDwh9Iu
	 qe2nl2UmZJJMtXVRrxPEkFna4rgJCZ3xu5kfVRzytnqTiVOfQ9J8W6aoK/MwlyOHm9
	 FOSDi1+FNulug==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	jlayton@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] vfs: dodge smp_mb in break_lease and break_deleg in the common case
Date: Wed,  7 Aug 2024 11:22:02 +0200
Message-ID: <20240807-antworten-magie-4bc046eb5137@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806172846.886570-1-mjguzik@gmail.com>
References: <20240806172846.886570-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130; i=brauner@kernel.org; h=from:subject:message-id; bh=cZ3VkXgVBmluAFlA02SV7pyCSpnRwx+5eeUl4yS+j1s=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRtttn1TMJXaZXKlLuqN/acVNrHctQ0/uT6/Qm18bOvv Zt9YF3c0o5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJfPrN8D//7XeJaNVll5nW r5jozPVDUnl9duqh+belN3xfIBvsNpGb4a/wthVnHt3o9XUuzPStW92br9If+knbr3zH0oyKsJf C3/gB
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 06 Aug 2024 19:28:46 +0200, Mateusz Guzik wrote:
> These inlines show up in the fast path (e.g., in do_dentry_open()) and
> induce said full barrier regarding i_flctx access when in most cases the
> pointer is NULL.
> 
> The pointer can be safely checked before issuing the barrier, dodging it
> in most cases as a result.
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] vfs: dodge smp_mb in break_lease and break_deleg in the common case
      https://git.kernel.org/vfs/vfs/c/e23ee5db10d3

