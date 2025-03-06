Return-Path: <linux-fsdevel+bounces-43321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FDAA54543
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 09:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B153A54D8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 08:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7F0207E07;
	Thu,  6 Mar 2025 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AB63qzBf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E841519D891;
	Thu,  6 Mar 2025 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250867; cv=none; b=qNOCHYnmJd8pC9GBKPgfNvE2GIkj46W2i6oRmnigMcrdr1AhLhBixFIyfqT7Mi/Mqrwpq3TM+d46hx+d3fcPgGIiJk5amxeZnWjULeGADsTrbWf17p9xxtHIm72F0bsa98l0ZYm+uoHCGKsiJBgrbfgNL8QC8qMZ9BUqOxwiP10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250867; c=relaxed/simple;
	bh=12pRnKMM3oj/6bYjZMs3d0jaNeQblRP+N8DXFazNXyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocbbVaglo2JF0hgswCNLx6r7DpGq6IyE9xmyfkf33JqS0hxrA5h5CWn6+UM/NxRNnSkcx7MElR1eo5h9lu3qKwlWwzcByaSpoCzWNtK4ymE8yqWA2q1szj1vlj2CSN/bxySmnXJLxKAO1b3bWTm8v+DtxmaQ+IcpSbPnvss107M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AB63qzBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E89C4CEE0;
	Thu,  6 Mar 2025 08:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741250866;
	bh=12pRnKMM3oj/6bYjZMs3d0jaNeQblRP+N8DXFazNXyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AB63qzBfyGUAgFUS2sejRrY4CYAKf792DfspDYJ5BRII+Sz//5Et7RQjpSiBVRk1p
	 ATY39q2EyGheMtZHj/0uMETppHAyakiDSV78Tk3xmb4RG6NiezrJzOynUDbZSbRIME
	 NU1hwJQ+20w4xMwmZ7gkkvt50P16zVJV+RHWEcHDPfZyDR6BxvjX9+peBsuaemsCRp
	 F0dd8eXPw3pQ1owYthc+uK2FVdSPQvSyfdKF3iYBFOo/SxLdXrs66Gfg+ElWuRfHGK
	 S6ei18RvBkZFvWGp9IdkxcjkW7ohh8uo24VdAfMnfat9xbapav6L5ws6VZDucY+0um
	 u5aVWNWreNmjw==
From: Christian Brauner <brauner@kernel.org>
To: djwong@kernel.org,
	cem@kernel.org,
	John Garry <john.g.garry@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	martin.petersen@oracle.com,
	tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: (subset) [PATCH v4 00/12] large atomic writes for xfs with CoW
Date: Thu,  6 Mar 2025 09:47:24 +0100
Message-ID: <20250306-beugen-sehkraft-997e984040a1@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250303171120.2837067-1-john.g.garry@oracle.com>
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1330; i=brauner@kernel.org; h=from:subject:message-id; bh=12pRnKMM3oj/6bYjZMs3d0jaNeQblRP+N8DXFazNXyI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSfTNT6MvnMcTOurk2ntDtc1ePcvnuuDHvMWvk1beVud n7bjYlHOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyWoORYcF10XCmn/xWfmuX GBdK/uIN4DLhtDi8/c/CeW4L197j38vI8IqPLz02YM8vxhl12q66rg8Xid7YGP3q8Mn1x0Qijqz g4AEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 03 Mar 2025 17:11:08 +0000, John Garry wrote:
> Currently atomic write support for xfs is limited to writing a single
> block as we have no way to guarantee alignment and that the write covers
> a single extent.
> 
> This series introduces a method to issue atomic writes via a software
> emulated method.
> 
> [...]

Applied to the vfs-6.15.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.iomap

[02/12] iomap: Rename IOMAP_ATOMIC -> IOMAP_ATOMIC_HW
        https://git.kernel.org/vfs/vfs/c/af97c9498b28
[05/12] iomap: Support SW-based atomic writes
        https://git.kernel.org/vfs/vfs/c/e5708b92d9bf
[06/12] iomap: Lift blocksize restriction on atomic writes
        https://git.kernel.org/vfs/vfs/c/2ebcf55ea0c6

