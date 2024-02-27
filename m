Return-Path: <linux-fsdevel+bounces-12941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E724D868E1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 11:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2427E1C21925
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 10:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB66139597;
	Tue, 27 Feb 2024 10:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSCXUmlC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187321386CA;
	Tue, 27 Feb 2024 10:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031241; cv=none; b=Tl5vgaJykM6P0AiYzUQsFgLlFyUrknkW45eywJNqOIa5M1LEoXztYl8x+WKgc1lG9DxZB/aqH83nzIAk9SUQqIBumJLiRNtd/RdXstW9RrRvv8fwhtRupu+LCUuNA+3Rhf5Ghz7vuWd6LirPiAHrcH3qcvqjAVkgTcmZPp22Zhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031241; c=relaxed/simple;
	bh=bhXwwrbmoaR8s6z94AmlzJ/t3FDBuvjQY3T2ceYGgys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YVz+YgOJzI82H7Ax53v9wLcfAxSlx2OqTE3d/aAQIQ/jmgVajrW0nyb324biQdFOx3FD/v+0QRZzQLglw8ygFLUaD3c9TsjmPF4mb33B5eLhvhbNOEkuBdMKR/juqBZTlIkD5vQJjmJF6sGdTKdoY4dABW/x7mwo8Xg7+aVA5Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSCXUmlC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B33AC433C7;
	Tue, 27 Feb 2024 10:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709031240;
	bh=bhXwwrbmoaR8s6z94AmlzJ/t3FDBuvjQY3T2ceYGgys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MSCXUmlCVuEz0R/iiP40pW/DYeOKcwFMwUHdB9DOTEcdqiwSxuKl0nNHPDChnF4md
	 7LX+w7191h5WnEy5KQM9wwFcpXC6ZQOnOBp27vZbG7Kj+4pN+3K0DdYEvbQrfPlNJW
	 EQvZBfKYn3jTiUdKjaexh6eYeDKS6+DpGotxy5fDjm+8LQ9NRzOcGueUTme+CDh10B
	 o+vJc4FnJUxVJrshC/vGW+CwgxQ72mc2WcwCtUhgSa3eJq+IRqlndes0ZbkIdTQaUq
	 bSoW1msBpvy5lMF5IVDdKcAlniMECVi1Ai2oXs+d2ZSuvh7SJNgCexxwpihlnCmChL
	 DgiEK+UFRYYOg==
From: Christian Brauner <brauner@kernel.org>
To: jlayton@kernel.org,
	mcgrof@kernel.org,
	akpm@linux-foundation.org,
	jack@suse.cz,
	adobriyan@gmail.com,
	chengming.zhou@linux.dev
Cc: Christian Brauner <brauner@kernel.org>,
	dhowells@redhat.com,
	zhouchengming@bytedance.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com
Subject: Re: [PATCH] proc: remove SLAB_MEM_SPREAD flag usage
Date: Tue, 27 Feb 2024 11:52:48 +0100
Message-ID: <20240227-bares-sanieren-b8acbafb1750@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224135048.829987-1-chengming.zhou@linux.dev>
References: <20240224135048.829987-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022; i=brauner@kernel.org; h=from:subject:message-id; bh=bhXwwrbmoaR8s6z94AmlzJ/t3FDBuvjQY3T2ceYGgys=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTe3S8eGPp/hoPz6YhA1+uPLt9uPcayekunUcDhPe9PP tj4V8tatqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAie+IZ/tn9CfEy3srmd3nl lVilIDed57s2qp4sKi7OrCuNOC+k94HhJ+O9M+v+sl+cn1wdf2Gb0BK2Vh/97YnmXrLGM2TKdtR tZQcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 24 Feb 2024 13:50:48 +0000, chengming.zhou@linux.dev wrote:
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.
> 
> 

Updated commit message to point to slab removal.

---

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

[1/1] proc: remove SLAB_MEM_SPREAD flag usage
      https://git.kernel.org/vfs/vfs/c/d20a6a4de559

