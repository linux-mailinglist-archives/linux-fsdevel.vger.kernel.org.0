Return-Path: <linux-fsdevel+bounces-71345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 928A2CBE924
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 16:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7181301D9FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 15:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23ED346797;
	Mon, 15 Dec 2025 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcKETSWl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EE233ADA8;
	Mon, 15 Dec 2025 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808472; cv=none; b=cPIyJJn5D9z1rau9t69CNVAswcLAliZYD1S3nFbumDYfpHoXz5+REejWGGZYNmkHvcJ4T0MI6lVUmrpaO3qa1nx7ehORrPncMB7FqSv5WVeipj76s2lMoBFa0ptjdz38euDtHl2kuDJn/Mp55YFEnaRM1kjh0d215RxZ7+/EStA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808472; c=relaxed/simple;
	bh=ljAqlGir0hg+CJRtmbHoQuoEsW97nlQWXDh3Jib1L8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0QsP6gNbqr1koIQj463NZXRvC4PAgpQjyaU5TMQWORSk+uzt2ZWt4sPpM4YRyCBo6ef+BIdQaPaB3kbB5hZotNm0gUAnGC6H/Chzcs1LglDti8tSKS3HlucbexJi4+hWqjw3gN8uVGHHlwj++g6w/C6Dqy0RuztFxQJWPq7uxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QcKETSWl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF93C4CEF5;
	Mon, 15 Dec 2025 14:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765808471;
	bh=ljAqlGir0hg+CJRtmbHoQuoEsW97nlQWXDh3Jib1L8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QcKETSWl6gLN6f7eNHQqErj0B8bS+bC42POisZY9HcTzsq2NW9sy4e3MYt0ShbM3W
	 f3FCpxSFcEklKIx7aPFrnYesSxybWN0V7X3uylRdV5LGg/LZhLq8DoQwfUdDsonBok
	 uUCOv4FjxEcncyldWGg3RW9GNWuX8AWhbgpF0A2jZ63jjfu+xvPlHPPY1LzQfUk7be
	 WpnUT62Obyrk4vnubmGUvCBmMSnyHzlxzKEdrung95/rEHNlcVvGYRjC/mScin09tu
	 F0+62KclXcTtUhRDHrdKY4onpcxDRx1Ov5vs/md79WuXAwSsYV+A6oqC4gdveVdQxE
	 NpJnWcsgzJlUw==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH v2 0/2] filelock: fix conflict detection with userland file delegations
Date: Mon, 15 Dec 2025 15:20:55 +0100
Message-ID: <20251215-bildung-arrest-1957e6ff7b59@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251204-dir-deleg-ro-v2-0-22d37f92ce2c@kernel.org>
References: <20251204-dir-deleg-ro-v2-0-22d37f92ce2c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1270; i=brauner@kernel.org; h=from:subject:message-id; bh=ljAqlGir0hg+CJRtmbHoQuoEsW97nlQWXDh3Jib1L8A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ6SPrpRD3z0plU2bhuYeiG7Ttvc8ueW1bx01mJj/flT TMVPTenjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkcPs/wV/pA19aWpn3vVfZ2 z5QL2XaxSj+Dk1/vk9XDE9n9V71+LGJkuHzeK37nviKW9czzM36YL45m0uozsqxOct20u+vgmVn tXAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 04 Dec 2025 08:48:31 -0500, Jeff Layton wrote:
> This patchset fixes the way that conflicts are detected when userland
> requests file delegations. The problem is due to a hack that was added
> long ago which worked up until userland could request a file delegation.
> 
> This fixes the bug and makes things a bit less hacky. Please consider
> for v6.19.
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

[1/2] filelock: add lease_dispose_list() helper
      https://git.kernel.org/vfs/vfs/c/392e317a20c3
[2/2] filelock: allow lease_managers to dictate what qualifies as a conflict
      https://git.kernel.org/vfs/vfs/c/12965a190eae

