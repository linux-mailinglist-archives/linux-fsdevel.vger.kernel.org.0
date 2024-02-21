Return-Path: <linux-fsdevel+bounces-12213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C76C385D180
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 08:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A7EAB21EE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 07:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8672B3B296;
	Wed, 21 Feb 2024 07:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4EkjjN2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D8E3AC2D;
	Wed, 21 Feb 2024 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500968; cv=none; b=sKubdbNZCv3cl/9GcwrXsWzidpPaP6AVUMY24n6utYA6hG5jz73s9XM7LRIR9Kn5ITL/Syq5PObNgR8Z+lVx8fQMzdsQTSyvU4JRbuoFtA9rz75Wi+tvPNwmg1Xkj0L7e98wF++syV9GrLP4xt80SOac+1ohGapG5IkwvpWie+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500968; c=relaxed/simple;
	bh=Xu/mivu9Omjv8pN+LQWQfTamnCS30TCS4XhU3t8yUjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AyyhfT979xDEvTEAT+NRT8RVZC/9JkNMmf5bHbaq0E15+0svbDWNOzPg76PHP+nkbJ6WhjEmpIQi7p1GadDSuve+S2STWoOmV1dEzgnLkKdE6giwj0lzHrPN1zMa5eTwv+eHaEV4ClcLg7dpXK62hl8EkK/9iEjj7jAnCWB0g9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4EkjjN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE7CC433C7;
	Wed, 21 Feb 2024 07:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708500967;
	bh=Xu/mivu9Omjv8pN+LQWQfTamnCS30TCS4XhU3t8yUjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r4EkjjN2rN6/boK0EZlODV0TR7jjemYr4U950rKgH56CTKob338bpI8+wJt03o4QB
	 EOv5h0cY1XcCd05mTjYl0A3JaccjmOy4Oakql6uNU0V9CPF0o1z3PQ36zQ8xXeqUJH
	 3La9kd83G1s1Rv7I6yat2xdVEJcA8QokRVBLhhPaIoOFAA2pOLweVOj8Otw+kKZrka
	 xjHLk3AAtO74IWQeYVzud5pCsho3dkbHJLJz9OkNtbogeDMa+dm2+iZ4f1YK2gKHAO
	 Vak+4GKV7B6abpo5ul8Biu+xLclemWRkeusryZSaYQkTB9AcCcpfJPMHfcWFaVP5+s
	 l3obGQ/QOVx1g==
From: Christian Brauner <brauner@kernel.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	david@fromorbit.com,
	tytso@mit.edu,
	jack@suse.cz,
	yi.zhang@huawei.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH -next] iomap: add pos and dirty_len into trace_iomap_writepage_map
Date: Wed, 21 Feb 2024 08:35:58 +0100
Message-ID: <20240221-vorwiegend-klebrig-74a49733a441@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220115759.3445025-1-yi.zhang@huaweicloud.com>
References: <20240220115759.3445025-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1198; i=brauner@kernel.org; h=from:subject:message-id; bh=Xu/mivu9Omjv8pN+LQWQfTamnCS30TCS4XhU3t8yUjk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaReXX6fyWaPmseh2lMhRuLJ20XXK975YJLO8u3nFFGHz b+T7Fkud5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk8WxGhs11Tc3JgSmuB6+d ufTmiuZBFomVeTHa5Xu/1hi8Ebt96DMjw4mJFY/OzwxR+HWDg3vFl7Wy3Rv6ZrNYnI0qED3ZVto axgYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 20 Feb 2024 19:57:59 +0800, Zhang Yi wrote:
> Since commit fd07e0aa23c4 ("iomap: map multiple blocks at a time"), we
> could map multi-blocks once a time, and the dirty_len indicates the
> expected map length, map_len won't large than it. The pos and dirty_len
> means the dirty range that should be mapped to write, add them into
> trace_iomap_writepage_map() could be more useful for debug.
> 
> 
> [...]

Applied to the vfs.iomap branch of the vfs/vfs.git tree.
Patches in the vfs.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.iomap

[1/1] iomap: add pos and dirty_len into trace_iomap_writepage_map
      https://git.kernel.org/vfs/vfs/c/1284865eff6a

