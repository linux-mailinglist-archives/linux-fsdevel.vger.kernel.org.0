Return-Path: <linux-fsdevel+bounces-12432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC13685F3D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 10:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654311F24C24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 09:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC3E2261F;
	Thu, 22 Feb 2024 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4zRNaSN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C7F3717C
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592653; cv=none; b=hwzhBv1BC1MhU+jBgMWsB4ObO8+nk5r4+Nwuc6AiFxCkue9PsYP0mLOl8y/HmZ0VUdeZBVdJKx8fmwPJTF0G4VBUARJqr8GFRuY/z8PPGxlRQXXCyXW/8LPxs8hj1WGjTX0tSelVUSmJBxG49zJlZWV1ql3sSaPzh5+VWDd0cfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592653; c=relaxed/simple;
	bh=5jCha4t6jNCL1sYUFcC+wAgZvHXdv2M+YC1wa4609/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JT2v933Ve9u9PnbPXnoQamuvWkjyOL2V7hD2p75wdE4wdXwYwoYUdoPYSmcC1v5Xf/hJOHE1GrOh1a4GGa25zJC7nRmlSivqgtB9aWrCz+3w1WMZn1//8CsJYBTUPeB5b6TmOxfRRMGU4M5ndSxd4vJKQjZ2UBFlSI8098ozGRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4zRNaSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609C7C433C7;
	Thu, 22 Feb 2024 09:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708592652;
	bh=5jCha4t6jNCL1sYUFcC+wAgZvHXdv2M+YC1wa4609/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y4zRNaSNSb/c1PSf0qrGsRRcnZTRCi8UI7ue27cLLTWAH7/AP2Mi60/G36rI1QbFx
	 nNjFyg1/DFw1QrWJMkUiV1MYloTBtApbb9Zks8BViCelgonC/7fUIh+zHu1j2e5WIi
	 AIY3dnXO8ov5NOeiQR9rnpMaGQEZP2TNlbNleQ/xpCsvBpWHxRIhTthdO8s168iioC
	 tnQ6BR4tE+g1B0yFzMJ/OeyGvdIViSYLhAPC6Xzi5Cgq/WVPml4U+3O3RbzAyLMK7X
	 opw9vDja66O4g7PPWDwzxhba0V4zJGmOvulmKDV4DyrP/eT4dt1jfJ/a1Ss5N/wfxC
	 rcXslW8tU+hEA==
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	Bill O'Donnell <billodo@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V2] Convert coda to use the new mount API
Date: Thu, 22 Feb 2024 10:03:56 +0100
Message-ID: <20240222-irreal-teigtaschen-7b5e5ae09ad7@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <97650eeb-94c7-4041-b58c-90e81e76b699@redhat.com>
References: <2d1374cc-6b52-49ff-97d5-670709f54eae@redhat.com> <97650eeb-94c7-4041-b58c-90e81e76b699@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1125; i=brauner@kernel.org; h=from:subject:message-id; bh=5jCha4t6jNCL1sYUFcC+wAgZvHXdv2M+YC1wa4609/s=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRe52NZwH6gOfxU7V4DN7dNe3SsFk5rlz+6Me3Xu+Bi/ V/aZ6bLdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEVoDhr5w2r5dumFDMkZeb Fmyov9Ude27ZToFHi87r2syd2vmerZjhn73IdbZU76jGWSn7Tv1xi3aakZKQoZ748NJzl87TX9b e5AYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 21 Feb 2024 09:40:03 -0600, Eric Sandeen wrote:
> Convert the coda filesystem to the new internal mount API as the old
> one will be obsoleted and removed.  This allows greater flexibility in
> communication of mount parameters between userspace, the VFS and the
> filesystem.
> 
> See Documentation/filesystems/mount_api.rst for more information.
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

[1/1] Convert coda to use the new mount API
      https://git.kernel.org/vfs/vfs/c/62e3038211db

