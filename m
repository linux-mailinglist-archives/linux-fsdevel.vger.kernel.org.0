Return-Path: <linux-fsdevel+bounces-13637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C355F8723F6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 17:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80305288E12
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 16:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0173B12880F;
	Tue,  5 Mar 2024 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VO+JouT2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B75D128370;
	Tue,  5 Mar 2024 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655689; cv=none; b=pQRvI9QBd1sAos9fTKA11GBvoXArof2d5MSA2azwvBnY7Vo29Ogx+rYVQXGRp2F3Q5c/U4Cyx530PQRvuGOePOcbqIqYekbUz/9akOm93EGtCGb/WsBTNy8bOJ+r68JzZmaTPno9b2S4sStH4SzZq6jFpvP4rqmYLaW+EVCS7iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655689; c=relaxed/simple;
	bh=ha9vAefRx5WF0Mib4MgL7Y+0fSYBl+GdeL3CgSqM6T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9pnFM/p35tytxMMu8Rl6kX0b+P8G0xKiQ8i9vfP0FLJBhqSgvzLGqVdkz2X3JncGbnPOideedh2GjOzq9l1X7ot0CUNx1199my2aVn8jZuCypZRvH188NHtprcNu89Xc+YfEzG8hQwHXl0C+b6evxoo/PgncOfWsWCy+mBZbZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VO+JouT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADC8C433F1;
	Tue,  5 Mar 2024 16:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709655688;
	bh=ha9vAefRx5WF0Mib4MgL7Y+0fSYBl+GdeL3CgSqM6T0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VO+JouT2eFV8pxh12pAKUcRP+t36fj0DLGTGLq183lAJjoXA5JkJzZHFBhqxDk2/P
	 l7IxFG9s6SZGqlj9Y6dgWKODO+7+0spgffmpwOKJYZEv0LRfBgTLcZ9j9ywezJO2py
	 aq+aPA/kSYaXBMFaUSkumuzNrKMCaRgjcQOHWR7PMQYPrtG+A+mG/zBd40E0WUVbjj
	 1mjG2SE00SCmjrtrHPH9GeGbm4a9MO/nxhXmNMhMj7jXWmEyEDzNc5PPi9RpUdlZDC
	 OSkEudoMfU8ItUN58/ZsAAQWvzDYmaJfQ/GOut4DtuHI233z6GzkviLmJVfjigTdcJ
	 Z9VC9/+S1/7Qw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] xattr: restrict vfs_getxattr_alloc() allocation size
Date: Tue,  5 Mar 2024 17:21:16 +0100
Message-ID: <20240305-flogen-weiht-b1861cff0d19@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240305-effekt-luftzug-51913178f6cd@brauner>
References: <20240305-effekt-luftzug-51913178f6cd@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1484; i=brauner@kernel.org; h=from:subject:message-id; bh=ha9vAefRx5WF0Mib4MgL7Y+0fSYBl+GdeL3CgSqM6T0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ+d6tN6nTjXnm5/MSciEUfTWe+2n3o0b6HGp6zXtQ6C 852EX7J2VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARjs0M/xP45M/ql9r8mttZ r2zvU5j4UVDo/OzyiBVHXX8yZCjc38XwT32dkWnastOdbuveB9pHXE7fGmp50XVqc/kOy+2my5d M5AUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 05 Mar 2024 13:27:06 +0100, Christian Brauner wrote:
> The vfs_getxattr_alloc() interface is a special-purpose in-kernel api
> that does a racy query-size+allocate-buffer+retrieve-data. It is used by
> EVM, IMA, and fscaps to retrieve xattrs. Recently, we've seen issues
> where 9p returned values that amount to allocating about 8000GB worth of
> memory (cf. [1]). That's now fixed in 9p. But vfs_getxattr_alloc() has
> no reason to allow getting xattr values that are larger than
> XATTR_MAX_SIZE as that's the limit we use for setting and getting xattr
> values and nothing currently goes beyond that limit afaict. Let it check
> for that and reject requests that are larger than that.
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

[1/1] xattr: restrict vfs_getxattr_alloc() allocation size
      https://git.kernel.org/vfs/vfs/c/82a4c8736d72

