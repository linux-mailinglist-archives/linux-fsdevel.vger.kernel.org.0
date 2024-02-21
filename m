Return-Path: <linux-fsdevel+bounces-12222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7CC85D2BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 09:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAFAA282287
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 08:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2DE3C6BC;
	Wed, 21 Feb 2024 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWEaHfEo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374243C491;
	Wed, 21 Feb 2024 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708504953; cv=none; b=MTDZQYql1UBoNx8q9Z8JTl0273zeedd+C11dW4gTFh8yLH7Dx8ZT+D8+DBoORVYs3qUuXEcKhIJX/hR1qpVkOFaJHhXxn6xwve0aZghoniOmKRsD2kpPc8oqzjx8wCIt2Ff/fvSKStt8//cOptBTPWxdulbJFVX6CKcr9n1QVSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708504953; c=relaxed/simple;
	bh=Hm/T6R40Q9bbhXwWW59brd4nHrq6BqWNFWB/5+TjPt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WxJ9YoGtCBfXch135w1VK3KUZpJOyvHKUuUuDI67vcZZ4U72dWhtzciCv+nFdOep2VfLgnEZV3NqDmA01iUUq+erTU+gZ1Bz5ygdMnxJP1K6ZA74+P+FGkBszZ8slhEiB3EHO9djN+OAE2VrKqaKsAo+tcwq4w9nlfRTtWELInQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWEaHfEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1FAC433C7;
	Wed, 21 Feb 2024 08:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708504952;
	bh=Hm/T6R40Q9bbhXwWW59brd4nHrq6BqWNFWB/5+TjPt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JWEaHfEoRVAFr/nLYob1FVzTl9J7P9kUCpeR/cwVdZ7QBHCqpmE44xbC0GqwV0fc9
	 3f3Y9MvkSNelKnNBjoMvkQrvITAgt2KsOOluE5vIZQUkTxjlzoDGuXBoqNz+y5r36a
	 j3KQm/orS0U0545yYlFe0Ys/8lxXGLDgIJKPBCSnD3oiAxmYxGyhPlRPwJ4PZmCCV3
	 N/xOV7ywT5GEs/PZSlHpoGKiSmqsEBSdrCw34/+j5TDS9mt6zMQvnYxtH3EQToCnkI
	 rdXyjYh3JjooEI19htXTwhy4KU94d6vt1f79vm7kfuScF525sTVwDeM7NwE6dw6FW1
	 9gmG5v18uuMAg==
From: Christian Brauner <brauner@kernel.org>
To: Liam.Howlett@oracle.com,
	Chuck Lever <cel@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	lkp@intel.com,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	hughd@google.com,
	akpm@linux-foundation.org,
	oliver.sang@intel.com,
	feng.tang@intel.com
Subject: Re: [PATCH v2 0/6] Use Maple Trees for simple_offset utilities
Date: Wed, 21 Feb 2024 09:41:17 +0100
Message-ID: <20240221-bezaubern-absieht-4d49d38a0fb1@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <170820083431.6328.16233178852085891453.stgit@91.116.238.104.host.secureserver.net>
References:  <170820083431.6328.16233178852085891453.stgit@91.116.238.104.host.secureserver.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1623; i=brauner@kernel.org; h=from:subject:message-id; bh=Hm/T6R40Q9bbhXwWW59brd4nHrq6BqWNFWB/5+TjPt8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRe3Z7X99jGYo9AuOK1Gb+rr3w9/cyh8M1dBZsWB/2rs YlH2K6t6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZgIpxXDPyXWH33Gspftl7Cm T3Nz9V98SLSbrcW/5WVJ1pdUVq6EPQx/eH6ILv2r2jeldPciv1U3eJmEw2X8qxN5GoVvLOfby5D FBAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 17 Feb 2024 15:23:32 -0500, Chuck Lever wrote:
> In an effort to address slab fragmentation issues reported a few
> months ago, I've replaced the use of xarrays for the directory
> offset map in "simple" file systems (including tmpfs).
> 
> Thanks to Liam Howlett for helping me get this working with Maple
> Trees.
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

[1/6] libfs: Re-arrange locking in offset_iterate_dir()
      https://git.kernel.org/vfs/vfs/c/1a5996a67b26
[2/6] libfs: Define a minimum directory offset
      https://git.kernel.org/vfs/vfs/c/1fef81c35969
[3/6] libfs: Add simple_offset_empty()
      https://git.kernel.org/vfs/vfs/c/59ec43c537e5
[4/6] maple_tree: Add mtree_alloc_cyclic()
      https://git.kernel.org/vfs/vfs/c/9bb457ea15ad
[5/6] test_maple_tree: testing the cyclic allocation
      https://git.kernel.org/vfs/vfs/c/20237d2c3eed
[6/6] libfs: Convert simple directory offsets to use a Maple Tree
      https://git.kernel.org/vfs/vfs/c/624e104353a3

