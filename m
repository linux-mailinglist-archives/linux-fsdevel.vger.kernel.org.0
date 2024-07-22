Return-Path: <linux-fsdevel+bounces-24075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5532C93900E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 15:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10885281CE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 13:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAA516D9AE;
	Mon, 22 Jul 2024 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYRwgviY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6340D16938C;
	Mon, 22 Jul 2024 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721655743; cv=none; b=e986wwwRTLhFrvHVTTzH5NQT/Pztx+UHmP6KOQabWSwUMnQBiWOm1uIpvBnZkHFt2W/bGoIvCqMngXJS4XnPhXPOWDnGqL8+9mpNLA6WM75Qu9ClHyzYr9tBZoucL1/tsuOZGvreozdEt1eTNbKu9/nAu/9XK93pKOTk+fPxKzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721655743; c=relaxed/simple;
	bh=qK0ONfV9iys46ggpuq7bnLraECJEYlDaQStKDTJXMIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ooHyxOeUc3qMGoGdHQ8+Wgn4vM8goznflcCDNcgelsR6vpvnuJghSrlEXJv9ottJNb0FqbWnq4UW+JopgBktaqT8oHpnNcmWPOUCecz4AVEyeREFIHOGTYlYyiqfXYK8j9fDD3jjHQ2RqYl2lMTyKqDHFHxChtGUi/H4r1xA3k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYRwgviY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F916C116B1;
	Mon, 22 Jul 2024 13:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721655743;
	bh=qK0ONfV9iys46ggpuq7bnLraECJEYlDaQStKDTJXMIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SYRwgviYzihao+j585ISY4cgxSbu804UxBEFvwyWMFo6e/YGxedCeUgg/RhiRmMDg
	 BN53J+fb6H/kgMCEL9zDU20nOjTLE2MTaqF+VJ+CSdCtMBSMkLhHL0gVphWKQBkEcH
	 l/v1tuEtXlH0nJ2CArEt9NH3ENAHZMC0nY3/LVfjQEcx8RQkorytBqM5sELCDkPHfi
	 kcqHd11sj8XSOLHr8pPtbSQ9lzSgfA96M5uFnzO7lm8a/Uuwu48DnEeXeuLKcNEQxi
	 9ClPyvYLtpUWBiXU9dxDU+PxgfCpJyJ7lH/dxw2YDF0BSDan3gVplnPTErDLVNYDci
	 kk8YQsBtssD/Q==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cachefiles: Set the max subreq size for cache writes to MAX_RW_COUNT
Date: Mon, 22 Jul 2024 15:42:15 +0200
Message-ID: <20240722-errungenschaft-sektflaschen-9b434fce6c81@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1599005.1721398742@warthog.procyon.org.uk>
References: <1599005.1721398742@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022; i=brauner@kernel.org; h=from:subject:message-id; bh=qK0ONfV9iys46ggpuq7bnLraECJEYlDaQStKDTJXMIA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTNS9xhrLfq8ap2tTn64W7fLQNb9/xuuxC4sXFNVfXfe c8mqYU/6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI/GBGhqXVIRk6R+eFKwV3 K/9YcuR51OJozcN6op99/YXZ+BfraTL802JdEJ3L9XW35bMTtQ5WpXyHixT19r1qv87t1MHSvKi CBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 19 Jul 2024 15:19:02 +0100, David Howells wrote:
> Set the maximum size of a subrequest that writes to cachefiles to be
> MAX_RW_COUNT so that we don't overrun the maximum write we can make to the
> backing filesystem.
> 
> 

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

[1/1] cachefiles: Set the max subreq size for cache writes to MAX_RW_COUNT
      https://git.kernel.org/vfs/vfs/c/1275fb2bfa90

