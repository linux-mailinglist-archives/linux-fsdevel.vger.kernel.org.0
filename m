Return-Path: <linux-fsdevel+bounces-45906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B61A7E822
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 19:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B04188BFFF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 17:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A1B217657;
	Mon,  7 Apr 2025 17:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPt77zdh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5812B2163B6;
	Mon,  7 Apr 2025 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046779; cv=none; b=TZwtc4bw8UtPcEVm0jI9bCGFnrTnAnBs8uY7pfpia+WL+kEoP5oLic8I8cZG7jjq483JgKpg5ghbLzfW9IoNmq2mYC2w1QypKOTidYt0oJmAJQh2sNnytKbCckV4XL71GvmijQDe//fB6eGGxuv6csipWLstR32nTQux5/C99Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046779; c=relaxed/simple;
	bh=raL/UzKm/bH/RfBRNJdvfTVJ8Y8kROU3/R6LPqOJIDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPq1JHsXpzxSLvgqy/ubBbBrGsdjxoir2zgKK7le/7ONQ1shvjbzPdHvR6fHF9HBFo3GzH6wTE1Ua4HBE/xOl475yZIfXEW3/kmBiIA/eDDh8SAjvaCJqps6r41xv2HzaIgGcGVFo2vRWpl+arTjMe0l93CiQFHMhH0pmwp/GNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPt77zdh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC53C4CEDD;
	Mon,  7 Apr 2025 17:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744046778;
	bh=raL/UzKm/bH/RfBRNJdvfTVJ8Y8kROU3/R6LPqOJIDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lPt77zdh9NLNlTtH1QEsWEAH06SHbbi4uV4VJ7YBmIAU+UvIzEcRfiSZ1r3J0WMbN
	 T13ijgF/UvprSSK66VthX1YY3JB7K6E4Stv+dgTL+3Mw/Uo/rUFEY5sIy/6PLnvBU/
	 MCx+5gYJapd5/CcebC3kb9YyI+a3RI9HcmkmdZDI9LidxMykxtqkgVyoI2hdLxDt6T
	 iE9PoNI8YaAZVhuzi1z7tjv8+pqhebvr+iIgCUtY2swbLoqdrRfm4Ms32npFCeoVtG
	 V+uj8ViPqEIdFLxc30A873eqk0XOgtluMoSQbNRhKyEeZd4KXsU/jCf7S1kc/T/7Ox
	 tLVC2QxRiXTPw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasiliy Kovalev <kovalev@altlinux.org>
Cc: Christian Brauner <brauner@kernel.org>,
	lvc-patches@linuxtesting.org,
	dutyrok@altlinux.org,
	gerben@altlinux.org,
	syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key
Date: Mon,  7 Apr 2025 19:25:03 +0200
Message-ID: <20250407-chorkonzert-ankam-80ebcdbffd20@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20241019191303.24048-1-kovalev@altlinux.org>
References: <20241019191303.24048-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1346; i=brauner@kernel.org; h=from:subject:message-id; bh=raL/UzKm/bH/RfBRNJdvfTVJ8Y8kROU3/R6LPqOJIDw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR/4VqbHsCRUn/y7rwf/9IV1i9MmnNns17Phk+eOzz8L 7mt0tja2VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAnCTXzIyHP3/4vxE39io7xpH O5w796ZtXu/NtLAtgcutZw8nx1WByQz/dJLmWGZJTDn0N/B5hGPhae6DdtfdH1veFrgo43dH5fw xVgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 19 Oct 2024 22:13:03 +0300, Vasiliy Kovalev wrote:
> Syzbot reported an issue in hfs subsystem:
> 
> BUG: KASAN: slab-out-of-bounds in memcpy_from_page include/linux/highmem.h:423 [inline]
> BUG: KASAN: slab-out-of-bounds in hfs_bnode_read fs/hfs/bnode.c:35 [inline]
> BUG: KASAN: slab-out-of-bounds in hfs_bnode_read_key+0x314/0x450 fs/hfs/bnode.c:70
> Write of size 94 at addr ffff8880123cd100 by task syz-executor237/5102
> 
> [...]

Stop-gap measure at best. I expect there to be plenty of other ways for
syzbot to trigger issues in hpfsplus.

---

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

[1/1] hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key
      https://git.kernel.org/vfs/vfs/c/bb5e07cb9277

