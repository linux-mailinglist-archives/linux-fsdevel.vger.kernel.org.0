Return-Path: <linux-fsdevel+bounces-66580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BCBC24F28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 13:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCFE91894C47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 12:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28763451BD;
	Fri, 31 Oct 2025 12:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzrUNkry"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB2E12B93
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 12:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761912761; cv=none; b=jXofjhmn7N8CQ5JIsXK90lydjldV1PYFkcyQyFpwXkQ7wRwWhvfj3yE/vokmcl2mkERrbbn8pwMof8cUDykbNdImngPdC28QAwO80UukkJ7wmG9bHb2vxTzzT8xOvTieFEewidof52+FNnOjhA/KZlALEUyrbOpmsNvuD4TE93k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761912761; c=relaxed/simple;
	bh=61ZOKlDmwQ3wxJizUynx4s/JDByTKWCZ3U2GIY5wCn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AVPBS9Rpar/OFTRXiAu8xCAsEufVQyByoIl9zxG5nvfFZFGDjvWaFB+vMFOQexhskEp5o/8B/NMnWoRyLOJ1O5iWu7RvgC4/tOixR5QCNElYPrP0IxuT9Imc0Vpqf7L85qw2nQf5eSkQi16lde50qBNDWPJCLGbniiukiUHMk4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzrUNkry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1421EC4CEE7;
	Fri, 31 Oct 2025 12:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761912761;
	bh=61ZOKlDmwQ3wxJizUynx4s/JDByTKWCZ3U2GIY5wCn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SzrUNkryi/jRZaZxUDIC/GXrM1eVTxr1euraeSbH1FmSuBwcAmY6kDz6wzZT/IcuG
	 v3cPSSBq9mzj/07weBC40F/5ofaYS+12STVJvqb/Ksh0HK39IAY7dLd9PyWonhQZqD
	 kiFLsNNOiJQy9UJd/l3usA1mAQb76bFe/izcRz5+UEUQUMlZk8Tvthi1vL4PHW3lJp
	 awRiIXYHutXdeJ7DX/DQ5kQDXTJmSKU5SZFCmiGRmYdlrD7eYhrR+E6Rke25Kowbs3
	 he0M3o3cwsUalmw3LDa7pwsZkZJGbEoIaLdQMB1G2RRX2/9CfRGDM/Tp3cr87IZbw+
	 dBUoamWKm60SQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 00/10] Add and use folio_next_pos()
Date: Fri, 31 Oct 2025 13:12:03 +0100
Message-ID: <20251031-chaostheorie-lautlos-f2dee81d337b@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024170822.1427218-1-willy@infradead.org>
References: <20251024170822.1427218-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2235; i=brauner@kernel.org; h=from:subject:message-id; bh=61ZOKlDmwQ3wxJizUynx4s/JDByTKWCZ3U2GIY5wCn0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSyLN8Sx7SB18v2meX1KcU/GR+7ti7JavryVtyV7yx39 /y6m0e2dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEkIeRYdeK8Of59/bsfjit OESk9vfEBq75i3Q6Du1IfRok2nyqmo2R4epq8dyJLCui94dZ3roykVW4TnZp5rLV7PmKHh/qDjh 7sQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 24 Oct 2025 18:08:08 +0100, Matthew Wilcox (Oracle) wrote:
> It's relatively common in filesystems to want to know the end of the
> current folio we're looking at.  So common in fact that btrfs has its own
> helper for that.  Lift that helper to filemap and use it everywhere that
> I've noticed it could be used.  This actually fixes a long-standing bug
> in ocfs2 on 32-bit systems with files larger than 2GiB.  Presumably this
> is not a common configuration, but I've marked it for backport anyway.
> 
> [...]

I'm moving this into a separate topic branch for now in case any
filesystems would like to base off of this.

---

Applied to the vfs-6.19.folio branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.folio branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.folio

[01/10] filemap: Add folio_next_pos()
        https://git.kernel.org/vfs/vfs/c/4511fd86db6f
[02/10] btrfs: Use folio_next_pos()
        https://git.kernel.org/vfs/vfs/c/48f3784b17d9
[03/10] buffer: Use folio_next_pos()
        https://git.kernel.org/vfs/vfs/c/6870892b6437
[04/10] ext4: Use folio_next_pos()
        https://git.kernel.org/vfs/vfs/c/4db47b252190
[05/10] f2fs: Use folio_next_pos()
        https://git.kernel.org/vfs/vfs/c/4fcafa30b70a
[06/10] gfs2: Use folio_next_pos()
        https://git.kernel.org/vfs/vfs/c/5f0fc785322d
[07/10] iomap: Use folio_next_pos()
        https://git.kernel.org/vfs/vfs/c/ac9752080475
[08/10] netfs: Use folio_next_pos()
        https://git.kernel.org/vfs/vfs/c/2408900d408a
[09/10] xfs: Use folio_next_pos()
        https://git.kernel.org/vfs/vfs/c/ac0a11113de3
[10/10] mm: Use folio_next_pos()
        https://git.kernel.org/vfs/vfs/c/60a70e61430b

