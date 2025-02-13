Return-Path: <linux-fsdevel+bounces-41661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 323C4A345CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 16:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F42188801E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 15:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6E7187550;
	Thu, 13 Feb 2025 15:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5bPOXko"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6973C16D4E6;
	Thu, 13 Feb 2025 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459120; cv=none; b=gksSc9e4R7G4rYnSsHrp4X3fCTXnGDZHG+bDKZ1atweDZwyqSVuDTicgPFBhQG/RgGF6Dua2Oga4aPflQzRQyzbcWRmZZFqixqYMQIWWYCz+2quUacve1CIL+Ah/tbN7xu0ZHLlWngRd9ziFTKkt/F0aD8SqBk+YN/9dDnIjVaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459120; c=relaxed/simple;
	bh=WJMQWBQFwuhi/gc3R8BLmRiHN8CmAmzH+WpsOlb8MLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YR5JG9InX/Jywdno8Z2DgX4Pm1dINZuCPdadIahA9IApQBb00vh/NGb0MwiFkp813eA2w170FKYkKEkbp3kgdXsY2dl36BU2HqL6xE64s2ZO/ARHJI8yHLOdZ5H/SPZKR5H++0yLvWdYcPqwnWtqPlChni2YBCnjfcIQU1pPV1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5bPOXko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F56C4CED1;
	Thu, 13 Feb 2025 15:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739459120;
	bh=WJMQWBQFwuhi/gc3R8BLmRiHN8CmAmzH+WpsOlb8MLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U5bPOXkodSTE4SU2bByq6qLxDe52q1exxLaMKzQCp+dm9nQFZZfPwtNXypVzLdSYs
	 9DNzIXFEzRBKG43yVlQ/Jzz2xyptDPQimMp1UO1tjgChDj99rgBfNps0xxvy9OVkP7
	 NR850+gITCE49yaRod7fng0i8Jpg6hEkjl+QQo9/Wcn8AoQTBVV1f9NK0ikOOKrBfL
	 KbFn6dQfluGcDRW8mtwIUx5FlYlAJI5M/nDjw+r2UB+lvORlV3xEH0C7AHZGOmq7K8
	 GRRucLyA+ciqlrR9Dor+rGzrvLTfjub2Um+dB26+TYiHhq84pUn3AWEmfWbX2Dkyyc
	 Hiv3QCN8roeuQ==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: inline new_inode_pseudo() and de-staticize alloc_inode()
Date: Thu, 13 Feb 2025 16:05:13 +0100
Message-ID: <20250213-knabe-sitzbank-c74871dc3e38@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250212180459.1022983-1-mjguzik@gmail.com>
References: <20250212180459.1022983-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1115; i=brauner@kernel.org; h=from:subject:message-id; bh=WJMQWBQFwuhi/gc3R8BLmRiHN8CmAmzH+WpsOlb8MLM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSv49L6upPv+obqdol7wr4/Or0Dg76pHe5xb9YLS9S++ vGmT/qijlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIls/s7IcPfSOmaGyuMBZ/fE nl3IlfRaNUbyf8pdtWXsn+wj2f698mNk2KCW8SNjvdZX+83rDNyuVSz59qY469Ahp2T3eM+aT0u M2AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 12 Feb 2025 19:04:59 +0100, Mateusz Guzik wrote:
> The former is a no-op wrapper with the same argument.
> 
> I left it in place to not lose the information who needs it -- one day
> "pseudo" inodes may start differing from what alloc_inode() returns.
> 
> In the meantime no point taking a detour.
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

[1/1] vfs: inline new_inode_pseudo() and de-staticize alloc_inode()
      https://git.kernel.org/vfs/vfs/c/e298fc4edca8

