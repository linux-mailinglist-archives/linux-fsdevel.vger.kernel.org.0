Return-Path: <linux-fsdevel+bounces-41660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C64A3454E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 16:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AB933AE25E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 15:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025CD227EB3;
	Thu, 13 Feb 2025 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a05nNJBU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DF1148855;
	Thu, 13 Feb 2025 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458905; cv=none; b=Q8GPrG7Spj997zNbW3wPi4GJa5sge6WHOoIe95RTtMTdlc/1uYxCaZr9NlDOwo/OLQJseNLmmPQ/aHVPo41imocAODFpOqAKMVKMdr4lXeNiZIiEjGqf3X59dYbw6NeoxVEF9Jy+oogwhojZKJiujh6roTgC4Nv+dzDzDo57XE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458905; c=relaxed/simple;
	bh=M392JolpqBN59UU7gj1lCbZNzReqJFGeXEqLCAtPZIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u08Q8hKKewjA/jOEwxAsPpv7+yyDbQoUVmu4QdjBo3e6BANPTgkxLoA9bvfbshyg4xtr36PINphRNHtO2QUnQX0gZ8ni4Tn7WSH/Ty7Npru/48kfpcO5Un68UqD9DRQ8ubUbk9Rbb3kyU4js1867rR9Y9JJuLe93+e0DHG86BWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a05nNJBU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4582FC4CED1;
	Thu, 13 Feb 2025 15:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739458905;
	bh=M392JolpqBN59UU7gj1lCbZNzReqJFGeXEqLCAtPZIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a05nNJBUGp8ldp6m7CxxQpionQHaidKP1wtCgpsDBiaAlk+TJxXuOBid1JHLpxhYe
	 RRYvXjSgJTb6djMCF88SXDmbPfTU0RCq+MnBP1LFA1VUpRPXpjZ+Tsd1Uj4GPOGDW5
	 xtZETGfyQamJSU/DaXSN7wG1yuq0y70qozSS5ztzjnvGF0RNaFQc+F50d9FkkZ3u22
	 GlXPPbGgDI6NkXrMxE7EfE8Gkq5jopatEuyWY70TopeDiNOx6MUkF17E9PZvSjUnaR
	 yASl9kNkKq706ougqtL3coEehtbb9A3sEraayr/vC1irSrBQB9IyKkJu8PdoHDmbFP
	 DKMMA1AQurMGQ==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Max Kellermann <max.kellermann@ionos.com>,
	Steve French <sfrench@samba.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeff Layton <jlayton@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
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
Subject: Re: [PATCH 0/3] netfs: Miscellaneous fixes
Date: Thu, 13 Feb 2025 16:01:24 +0100
Message-ID: <20250213-kosenamen-bestochen-0d997261875e@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250212222402.3618494-1-dhowells@redhat.com>
References: <20250212222402.3618494-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290; i=brauner@kernel.org; h=from:subject:message-id; bh=M392JolpqBN59UU7gj1lCbZNzReqJFGeXEqLCAtPZIo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSv4wx4qRqnFzRflWne51XHu+cbHcxM/LR4XWtwoIP68 pjO1Di5jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIncUGH4Hzljn3D5UVnhu+8v H3HpkQj4c+vpHef+E9JuPMKmR1fNfsfwP+BBsxSb6ufgd6c/ROlzPtv598zXZ99Sq1J6GpewNHO oMAAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 12 Feb 2025 22:23:58 +0000, David Howells wrote:
> Here are some miscellaneous fixes and changes for netfslib, if you could
> pull them:
> 
>  (1) Fix a number of read-retry hangs, including:
> 
>      (a) Incorrect getting/putting of references on subreqs as we retry
>      	 them.
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

[1/3] netfs: Fix a number of read-retry hangs
      https://git.kernel.org/vfs/vfs/c/1d0013962d22
[2/3] netfs: Add retry stat counters
      https://git.kernel.org/vfs/vfs/c/d01c495f432c
[3/3] netfs: Fix setting NETFS_RREQ_ALL_QUEUED to be after all subreqs queued
      https://git.kernel.org/vfs/vfs/c/5de0219a9bb9

