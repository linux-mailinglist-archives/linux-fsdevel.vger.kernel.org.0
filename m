Return-Path: <linux-fsdevel+bounces-72555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69294CFB4BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 23:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 082193094014
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 22:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CA22EBB89;
	Tue,  6 Jan 2026 22:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdlgMYFP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D7815CD7E;
	Tue,  6 Jan 2026 22:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767739961; cv=none; b=F4MVFxTERCvmHD9vIZHT1AWn9+L/egaD4wL+Ko9Qx9ov4kcHbfiRcwhhY5yBZ+J8kzaqqPJnBkdH5f7vUlQpC97VDexevRafVsVswrKkoX9DtjfNV9hi/clT0a+iGAt2bA7MUmkdvdkNCHH0PgFjv948RfPPyFW0Mkvll4hs0eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767739961; c=relaxed/simple;
	bh=EvgRjuABbtvspbiyqvvchh+FiourdHQVC7S9EMdls14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8AUSucu+oWx95sjVrQDI3GyoWQtJOyRIKC3IUDHyBII1EU9icGwhPNxpSfUuJiHHKc8yUFMoyJZrLHUKE16LFMSjzeSdzAmCwgajfr6qbMn7j402Cqj+m0C0FpGCchctU8BmIG1nsO5pqwCzQ9tidj6F6II8JM/NwgJ2ArfJX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdlgMYFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07066C116C6;
	Tue,  6 Jan 2026 22:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767739960;
	bh=EvgRjuABbtvspbiyqvvchh+FiourdHQVC7S9EMdls14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZdlgMYFPniJnYz2MsQoxiACMiXt/U9fnBCfc7DxRo6djU3C13wKGxsQfLKDkxJaGu
	 1z1YRBkcquUtELcGq8DzV/6vBrloGi1W+BUNk7BwILx1r2u1UYFXY3iNHEorwIHG2J
	 dGEIHQOf8wV8/Jf07O+4UD1SijR94gODHR+O7J02LsqwN/IJQARFH35hQ66Y/SiAeF
	 v81wRKO4GAtyUugr1Y7QIIqr6Sei5JQU/s1PU85YAThtbv40ugFeI6z2/i1myOWuzf
	 uwCYW4Em0rLE9EJ44zyEBieVmO9sOaPTcN3rHREQOFGUu7WsqQWib5sqzo3nYdN8WW
	 fzSTVqCbT6lVg==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: only assert on LOOKUP_RCU when built with CONFIG_DEBUG_VFS
Date: Tue,  6 Jan 2026 23:51:51 +0100
Message-ID: <20260106-zauber-mitspielen-ffab56bea891@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251229125751.826050-1-mjguzik@gmail.com>
References: <20251229125751.826050-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=989; i=brauner@kernel.org; h=from:subject:message-id; bh=EvgRjuABbtvspbiyqvvchh+FiourdHQVC7S9EMdls14=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTGTuLoVi03OB6Wd06r4X5yz8kn0978M6zf6dioNveAs hJrXmtURykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQ+GTH8D+nnzVG4xHU4Ni2E b3dpgP26l7XzN139EdnYFVU51VzUleEPz9mWM1phKhInlu1Yk6v4w2nCXvYA6fnPJ+slSYUKVbK yAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 29 Dec 2025 13:57:51 +0100, Mateusz Guzik wrote:
> Calls to the 2 modified routines are explicitly gated with checks for
> the flag, so there is no use for this in production kernels.
> 
> 

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

[1/1] fs: only assert on LOOKUP_RCU when built with CONFIG_DEBUG_VFS
      https://git.kernel.org/vfs/vfs/c/729d015ab230

