Return-Path: <linux-fsdevel+bounces-43282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2344A50664
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 18:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB091646DD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 17:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CBE1A9B2C;
	Wed,  5 Mar 2025 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUUwwB+x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952EFA95C;
	Wed,  5 Mar 2025 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195911; cv=none; b=feRH8nc/qEv+yihOeVa45urUAtTS0m6vHX6avjC93SnqC4Kg3Wn6OH1nmTGa8UResHpnU+I8Ah3TX7Xrc9+G2wZHqQjlJGvbc2m9r8Jnn+6L0ivk74TT7nHJaf9nAkG9tETdKhm/+/NK0sc98NU6S7lruKTfyT2kqBle4bJppBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195911; c=relaxed/simple;
	bh=2svgui4v6qaYhwrsuytBuxiJHG+Iq5QxgSWeNiW65II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NT0N7AAF1dVblkfTRSM8BSweYi7altdTeIbv+g4vHwSkA6xgm0DDspZQII/1jCOEYHd898o9wXzPfQSkrrjBmsMHd8F2TfoycCoqKjtnHpbIu+kSOS9Ca0MKV8+aGRdtUEO2ZMbU3On6J8D5vdJGKwrKpm+31hsO1izSh6LwIBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUUwwB+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5773CC4CED1;
	Wed,  5 Mar 2025 17:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741195911;
	bh=2svgui4v6qaYhwrsuytBuxiJHG+Iq5QxgSWeNiW65II=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OUUwwB+xXA/zcNgXsnbJ2KbEaTlULli2RTns4uTH6qXu2x5dgSK1sa8xU6PEaPpSa
	 tAVAT63Mopor57LDLAUs/5/Mx7ppNj19oRQwVydUyESNwfs5t7uQSuumxIZUmZPJDQ
	 s+xCMTkMQqDzE2hg9+9+iduO2hiTIsVaLAlRk6y6IUVHdqedZCKcbDZgH50iFAYpsa
	 KmtqNajp+gE5zTt1ec7/tEx/gTgteKtJ9JI5T3M9ZUtu6yDFFnfEdFeP396JEHyeW6
	 tpG8LaiyOp8Edco8QWUr6S0xe+1ITlMuEApbqvGvbeVg72Qk4T1TnJMK2tDGgkVmnP
	 9imhhMzSjQY2A==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/4] avoid the extra atomic on a ref when closing a fd
Date: Wed,  5 Mar 2025 18:31:36 +0100
Message-ID: <20250305-angepackt-berggipfel-c4d21f1db4b3@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250305123644.554845-1-mjguzik@gmail.com>
References: <20250305123644.554845-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1826; i=brauner@kernel.org; h=from:subject:message-id; bh=2svgui4v6qaYhwrsuytBuxiJHG+Iq5QxgSWeNiW65II=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSf6GqokP2sfKe6skc8TcDn8KUT4gG7oxj7U1PDMmon3 LczK/rQUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBHlYwz/I3r+fvPYPUHsMW+Z 2oz/H/Ru+01O2bOaN+S6tYdQ9S+GcIb/oT4CvCrs544JFmy//e/sbjG5qedEw1yatudPMFq96Nt BVgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 05 Mar 2025 13:36:40 +0100, Mateusz Guzik wrote:
> The stock kernel transitioning the file to no refs held penalizes the
> caller with an extra atomic to block any increments.
> 
> For cases where the file is highly likely to be going away this is
> easily avoidable.
> 
> In the open+close case the win is very modest because of the following
> problems:
> - kmem and memcg having terrible performance
> - putname using an atomic (I have a wip to whack that)
> - open performing an extra ref/unref on the dentry (there are patches to
>   do it, including by Al. I mailed about them in [1])
> - creds using atomics (I have a wip to whack that)
> - apparmor using atomics (ditto, same mechanism)
> 
> [...]

Applied to the vfs-6.15.file branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.file branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.file

[1/4] file: add fput and file_ref_put routines optimized for use when closing a fd
      https://git.kernel.org/vfs/vfs/c/e83588458f65
[2/4] fs: use fput_close_sync() in close()
      https://git.kernel.org/vfs/vfs/c/3e46a92a27c2
[3/4] fs: use fput_close() in filp_close()
      https://git.kernel.org/vfs/vfs/c/a914bd93f3ed
[4/4] fs: use fput_close() in path_openat()
      https://git.kernel.org/vfs/vfs/c/606623de503f

