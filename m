Return-Path: <linux-fsdevel+bounces-59358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84593B380A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 13:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55169208546
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 11:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F46134DCDC;
	Wed, 27 Aug 2025 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUxt3Fnx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F8B2BE65A;
	Wed, 27 Aug 2025 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756293284; cv=none; b=IW75Cj9IgNbpZ7f79W8Dbc2aCOgHxRXAtLjGPNaKRArJLvFFRNwLutDSKwsJJ6sUcWyazJbd12kHjJgj1T1sX2SwTjwK1Q+ALtap6dSw5ltesOsCNhuMfjX1Y4T7dXtVtz3+U2svi7HATp+MxObzzaebD7w3VtpWk/i2RU8aQ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756293284; c=relaxed/simple;
	bh=97CkpAPWHjj2AKlXJDv0/VHWkmEitAUsCAH+K9WEGek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HUt2T2ANNMFIEo0LLri+hb7vHaP6F94g4vH2iQzc0CzAtIt69eKAIp3BEWwCtseBRk8cpdsRK7Lj9YY3RwXnpEXLwaVXtMrY++jfqv248IRN7x67m5l/nDYENMb6K7v5oXm2JpNmN1t9gsJCWEOD8ZPDEhlmhxDCoogX+cMK2iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUxt3Fnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BF8C4CEEB;
	Wed, 27 Aug 2025 11:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756293283;
	bh=97CkpAPWHjj2AKlXJDv0/VHWkmEitAUsCAH+K9WEGek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GUxt3Fnxja1JcyRmTcYOJY1OBUanEXbKRTjcOX2VuLWnTVZlICO08jFwqGfMD4xbd
	 12KzgNG+Jf8s4sTQ1RcbCC6kduKsHi0OHs3zG59VEmnLJvWQ5KLTf8K35HI6OIb0hJ
	 /Iwb27DligNn2QziM9CnVg8trNy0PWiElyM15FrD5XfQry/C2OK+iteRc2ZF6gfNCI
	 CbJdt0fIXIhCxEWsXqShnAGLYF06BmzvtVAp7xa6m6f4n0NhZLi87YS+Hcz1t0DQNK
	 MDaI0ivaSaxu1XexvuuZIV7ECBITigmg2Mo6RnpwjWwdytX6q5T3t53INg988YRmOk
	 Z4yMATfuOeVLw==
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: Re: (subset) [PATCH v2 00/54] fs: rework inode reference counting
Date: Wed, 27 Aug 2025 13:14:24 +0200
Message-ID: <20250827-dasein-abfuhr-99d106a5c266@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2144; i=brauner@kernel.org; h=from:subject:message-id; bh=97CkpAPWHjj2AKlXJDv0/VHWkmEitAUsCAH+K9WEGek=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSsezEvVlrkj+93TgYuvbxe5oCTpWEXKwMEAo78W+Xwv /Gf61OpjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlM+czwi2lfn+8hIwNnzXN3 m76vNQ17KHFqjd8Xk7T1E3ICzB/sWcnI8N250bo5wayyh7/alcfisRTnarNr67/UCFRYNN3c/4q LCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 26 Aug 2025 11:39:00 -0400, Josef Bacik wrote:
> v1: https://lore.kernel.org/linux-fsdevel/cover.1755806649.git.josef@toxicpanda.com/
> 
> v1->v2:
> - Fixed all the things that Christian pointed out.
> - Re-ordered some of the patches to the front in case Christian wants to take
>   those first.
> - Added a new patch for reading the current i_count and propagated that
>   everywhere.
> - Fixed the cifs build breakage.
> - Removed I_REFERENCED since it's no longer needed.
> - Remove I_LRU_ISOLATING since it's no longer needed.
> - Reworked the drop_nlink/clear_nlink part to simply remove the inode from the
>   LRU in the unlink path, and made this its own patch to make the behavior
>   change clear.
> - NOTE: I'm re-running fstests on this now, there was a slight issue with
>   removing the drop_nlink/clear_nlink patch and so I had to add the unlink/rmdir
>   patch to resolve it. I assume everything will be fine but just an FYI.
> - NOTE #2: I reordered stuff, and I did a rebase and rebuild at every step, but
>   I noticed this morning I still missed an odd rebase artifact, so by all means
>   validate I didn't make any silly mistakes on the in-between patches.
> 
> [...]

Applied to the vfs-6.18.inode.refcount.preliminaries branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.inode.refcount.preliminaries branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.inode.refcount.preliminaries

[01/54] fs: make the i_state flags an enum
        https://git.kernel.org/vfs/vfs/c/02ec4868cf6f
[03/54] fs: rework iput logic
        https://git.kernel.org/vfs/vfs/c/b92e5104e8a9

