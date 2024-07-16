Return-Path: <linux-fsdevel+bounces-23738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258CC9321AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 10:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFC441F2242F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 08:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AEE51C4A;
	Tue, 16 Jul 2024 08:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndV5wXMr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020C82EAEA
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jul 2024 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721117556; cv=none; b=pd02R9iSMTO98ddde3xRY+Nt1l2R799OJLZZsdslTJCX6rp0slUIRF6+zj/O1damU5jx+vgV8QTVA9WWt97xmsb0A2RjzCZRhmjna5MTDSnYTQvqPtHKCKiLLe32uGCVqNgsvWyWn7mYBRiqTdxvUZ8U/yq2w56ZHLUwbePkRIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721117556; c=relaxed/simple;
	bh=4coTuAzv12+W2AdCW/Dic4pQY1/XWFmTox8pYiOvR6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Js/LSSMSJkuSgUBuik9SSMe/bmcCBMsxnTv5ZRwp4Pzqvdtlt7PfIzBgCe+U8L/1LnZxqkYguwNrvxzRdBYG8m4Be3rhJnyMpaFt/XIvMEPCTR9SyUQOMMV1PF8ccrdt822+pJrvjBp++n37iVaeVfyfro52XkFNPhMgAfGJG9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndV5wXMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DF3C4AF0B;
	Tue, 16 Jul 2024 08:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721117555;
	bh=4coTuAzv12+W2AdCW/Dic4pQY1/XWFmTox8pYiOvR6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ndV5wXMrW3NILCdjULeBd35eB34x/+jsmkBW0F+9PeACOtfxxXrtJkG1Aa8okH0d7
	 O/plL4y+/k/gf25Ixz+JaNULYJpTCFMdYVkkpuRtw4i3MycBOitTCfY7phMqNPiXUz
	 OLa0UsFRvP850vycPuNdSyWLPqcqxQ6a8/Ub1ua4J5tX1g8uGIx8C1QBrhDWGJbp8g
	 lzFXeD6KutrEYi2XUVJTgZ9Sb8BJUor9uqZwr1pRpfTjsfRzZTEdC1L7eHFNA1nAxK
	 jnedCrwlqdh1ZMotatR2GlF6912xumuoeNiyk/R3bGwo7cA/frBQ0n01GYeDJn1VBt
	 uHLINXI7SDyng==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0/6] Convert qnx6 directory handling to folios
Date: Tue, 16 Jul 2024 10:12:24 +0200
Message-ID: <20240716-fauna-hubschrauber-5aabe455493b@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710155946.2257293-1-willy@infradead.org>
References: <20240710155946.2257293-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1821; i=brauner@kernel.org; h=from:subject:message-id; bh=4coTuAzv12+W2AdCW/Dic4pQY1/XWFmTox8pYiOvR6w=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRN0879dqPn6IpDvLzf4j/Km6W+8FWQvSOyfvkf5pBJX L7yVt/dO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYirMfI8GSL+ZUPjDPvauQw sKoEv1Uq4DE0YN+su985M7jt4/0bJYwMj3JWnc0Wm5jduIufP9iY68C8MuZEBuZ7fVmBgp0Znde ZAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 10 Jul 2024 16:59:38 +0100, Matthew Wilcox (Oracle) wrote:
> This patch series mirrors the changes to ext2 directory handling.
> COmpile tested only.
> 
> Matthew Wilcox (Oracle) (6):
>   qnx6: Convert qnx6_get_page() to qnx6_get_folio()
>   qnx6: Convert qnx6_find_entry() to qnx6_find_ino()
>   qnx6: Convert qnx6_longname() to take a folio
>   qnx6: Convert qnx6_checkroot() to use a folio
>   qnx6: Convert qnx6_iget() to use a folio
>   qnx6: Convert directory handling to use kmap_local
> 
> [...]

Applied to the vfs.qnx6 branch of the vfs/vfs.git tree.
Patches in the vfs.qnx6 branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.qnx6

[1/6] qnx6: Convert qnx6_get_page() to qnx6_get_folio()
      https://git.kernel.org/vfs/vfs/c/bedab6ec809d
[2/6] qnx6: Convert qnx6_find_entry() to qnx6_find_ino()
      https://git.kernel.org/vfs/vfs/c/31d48d668d7e
[3/6] qnx6: Convert qnx6_longname() to take a folio
      https://git.kernel.org/vfs/vfs/c/a5a63c87df3e
[4/6] qnx6: Convert qnx6_checkroot() to use a folio
      https://git.kernel.org/vfs/vfs/c/711ae9703e0b
[5/6] qnx6: Convert qnx6_iget() to use a folio
      https://git.kernel.org/vfs/vfs/c/5a1610488ce5
[6/6] qnx6: Convert directory handling to use kmap_local
      https://git.kernel.org/vfs/vfs/c/82282037419a

