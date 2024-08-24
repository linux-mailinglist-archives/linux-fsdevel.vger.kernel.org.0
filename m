Return-Path: <linux-fsdevel+bounces-27030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B1295DE4E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 16:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58CF4B217DE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 14:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3841B17625E;
	Sat, 24 Aug 2024 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSGnLKAX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772FA186A;
	Sat, 24 Aug 2024 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724508792; cv=none; b=RNiPCYaDCJYzmma3ylxOyymnW5vUOgcoF1yRwdweq6voOJxp8jVHAV1qb3Rwy9RmqwfBEYkYSR0A85E4q8dzxOYqRBPtosr+zNzhAS8gemagAMiieKQkOlGLjQuBPbJiWxR2nmfHv8z4GWkFYb9hy+tGXypmxkVGzaDh1S0zWtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724508792; c=relaxed/simple;
	bh=1RROgoMoiIURZrgBI0u+sQOi22mVdm5uhe2i5PEaJ7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cpUhtYmy0EtfIXIVOOPpeNQpvpLG9ECsf0a8eI25Ckxg2XhYseB7e1Om0fs2TISNGbmh5A7e5JNZB79Mdne7XoTKuXvdfLRrOYaAC3sq8Y0ryiL4g5Bl6oZlJJ1SHKCX702vIol854Y5lqXg9TCi3oB86RxHChrDUk+EtBKVG6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSGnLKAX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A59C32781;
	Sat, 24 Aug 2024 14:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724508792;
	bh=1RROgoMoiIURZrgBI0u+sQOi22mVdm5uhe2i5PEaJ7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TSGnLKAXbEucvWAQfLpYFzmykp5QeFdt9IGLO+QBd3M9TQsdDcpmVFe8sIb1ZSi0l
	 +xUKZvMbaYbGjtogaGv09XTXzAuo3HtUW2ICNSKj9fMMR27DBbK2E1mYlZ8J2gyerm
	 /1PL8xB02z5ButNd1qgVUbpCElWMbZ1P1wArc2W84/S5cKlHRjHUEhfBiwOjHiEORA
	 DrUX7VJMPECqiLrCo6LNitskmpC6nLf+zytSgeFiVmlaE/DoS2qzaGEi+wgkLOLxVK
	 IaO8KNkckCOjIhYKAqG+j4ZySWSAQ7nLPL5KSegXJ7SMcBj+z2/inWTDbW9aFUtA0+
	 eYCtNddeZ/ciw==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>,
	Steve French <sfrench@samba.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/9] netfs, cifs: Combined repost of fixes for truncation, DIO read and read-retry
Date: Sat, 24 Aug 2024 16:09:51 +0200
Message-ID: <20240824-ohrwurm-kernaufgabe-6253ce9cb620@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823200819.532106-1-dhowells@redhat.com>
References: <20240823200819.532106-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1823; i=brauner@kernel.org; h=from:subject:message-id; bh=1RROgoMoiIURZrgBI0u+sQOi22mVdm5uhe2i5PEaJ7Q=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSdfJVffXKaT/8Pjqu3GVvfLH2vu2VCaW5K1dO7uq5zj 7TqHFq0s6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiD5IZGRo7T3+Ld/D4IPp9 k8KLx7tbnO8x+ez5wfR20v6496lRfS4M/11XbSi+/6B3pnG0bXW1kq909nHuDUFrV6Rdv7zltM8 eB24A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 23 Aug 2024 21:08:08 +0100, David Howells wrote:
> Firstly, there are some fixes for truncation, netfslib and afs that I
> discovered whilst trying Pankaj Raghav's minimum folio order patchset:
> 
>  (1) Fix truncate to make it honour AS_RELEASE_ALWAYS in a couple of places
>      that got missed.
> 
>  (2) Fix duplicated editing of a partially invalidated folio in afs's
>      post-setattr edit phase.
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

[1/9] mm: Fix missing folio invalidation calls during truncation
      https://git.kernel.org/vfs/vfs/c/0aa2e1b2fb7a
[2/9] afs: Fix post-setattr file edit to do truncation correctly
      https://git.kernel.org/vfs/vfs/c/a74ee0e878e2
[3/9] netfs: Fix netfs_release_folio() to say no if folio dirty
      https://git.kernel.org/vfs/vfs/c/7dfc8f0c6144
[4/9] netfs: Fix trimming of streaming-write folios in netfs_inval_folio()
      https://git.kernel.org/vfs/vfs/c/cce6bfa6ca0e
[5/9] netfs: Fix missing iterator reset on retry of short read
      https://git.kernel.org/vfs/vfs/c/950b03d0f664
[10/10] netfs: Fix interaction of streaming writes with zero-point tracker
        https://git.kernel.org/vfs/vfs/c/e00e99ba6c6b

