Return-Path: <linux-fsdevel+bounces-74084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 664EAD2F20F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAD3630407F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 09:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C65E3587B4;
	Fri, 16 Jan 2026 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2l+unwm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1CF2DC33F
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768557364; cv=none; b=fvosFC76w/TJZCwcVZcjJuMW5o7ExiWAiaSlgl3bQSwDInpnj7Uw1RSDbpbhVimgcgk5xfvhEELf/uqc0yNXK4PySL3V8gFhlvc0h7suWKC29SWXR4LzipYT8vafh5RzSUEdDrnO4rvyCzG8HhPPBF+9570N4bQNFbBKD0BuOD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768557364; c=relaxed/simple;
	bh=1/Y6D7uPZ1vIvz2rVhQ0aKwkUU8dlBZd3R4Fuh8oWx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAiqtml14Z+tttW9JerY8gZvvsZz5jrbAtgCD04tPJ4cpd2oq8z+UhUhRsnK/uJ+B6exsB85CgCPX9qHj9yVQic22BR1qXLV9ZbB01Pk+pfSDlrBP+bikYAzdz2Ouu4STFNR1oWTYhfVxJESFotZ1GrOhvWuH+0Pbz0hLmlOpQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2l+unwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCFBC116C6;
	Fri, 16 Jan 2026 09:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768557363;
	bh=1/Y6D7uPZ1vIvz2rVhQ0aKwkUU8dlBZd3R4Fuh8oWx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A2l+unwmGkiFa5eVrBFSVJ3Lx4xgylH31qRXKCQ5JOcfIzlDlMfpMphjzxRiTsWMI
	 dJ9YZDJ0ZxeNbjrrphEKZQ2NYQcLt8CjU+aoaHvOUMGJZ/mqVcjXuq4xCdZZg3TI3i
	 s07U1kXxqL02Gh0m4GlT1f2Uz1s86bSyXYfXldSG/eRSXOketa+cCitSaWOWkn6/Bm
	 8/k4MPSGOpBc6ksJvbuQHBxUxeX7kvr7zW5/1EO28j05vlbqlidfjG/MjzPKbYjL5v
	 sLhD8S7JAFqglNDeE1jfKgnFE2feejXush2aMqyMriyG2Ni3AR08tIVIC6joMhhTq1
	 s51CMnT+LTbcg==
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fuse: use private naming for fuse hash size
Date: Fri, 16 Jan 2026 10:55:57 +0100
Message-ID: <20260116-gesindel-kribbeln-e361af6c984a@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <195c9525-281c-4302-9549-f3d9259416c6@kernel.dk>
References: <195c9525-281c-4302-9549-f3d9259416c6@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1770; i=brauner@kernel.org; h=from:subject:message-id; bh=1/Y6D7uPZ1vIvz2rVhQ0aKwkUU8dlBZd3R4Fuh8oWx8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRmcet/3ninKPLp69KgP2si//j/e29zU6LZ6Tbfu/XGa SzT+Do0O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACay8RIjw7ObKuIMx5n+6D+7 nyW+UJor9qv165nbiy8Xx6jy8vVHnGVk+PtsefHypb8PH/51/3dXqilT/H02A5dLIk5Bn93sl/F IcgMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 15 Jan 2026 05:25:28 -0700, Jens Axboe wrote:
> With a mix of include dependencies, the compiler warns that:
> 
> fs/fuse/dir.c:35:9: warning: ?HASH_BITS? redefined
>    35 | #define HASH_BITS       5
>       |         ^~~~~~~~~
> In file included from ./include/linux/io_uring_types.h:5,
>                  from ./include/linux/bpf.h:34,
>                  from ./include/linux/security.h:35,
>                  from ./include/linux/fs_context.h:14,
>                  from fs/fuse/dir.c:13:
> ./include/linux/hashtable.h:28:9: note: this is the location of the previous definition
>    28 | #define HASH_BITS(name) ilog2(HASH_SIZE(name))
>       |         ^~~~~~~~~
> fs/fuse/dir.c:36:9: warning: ?HASH_SIZE? redefined
>    36 | #define HASH_SIZE       (1 << HASH_BITS)
>       |         ^~~~~~~~~
> ./include/linux/hashtable.h:27:9: note: this is the location of the previous definition
>    27 | #define HASH_SIZE(name) (ARRAY_SIZE(name))
>       |         ^~~~~~~~~
> 
> [...]

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

[1/1] fuse: use private naming for fuse hash size
      https://git.kernel.org/vfs/vfs/c/4973d95679fb

