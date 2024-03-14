Return-Path: <linux-fsdevel+bounces-14391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1FF87BB8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 11:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A071C209C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 10:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887646E61A;
	Thu, 14 Mar 2024 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyMnC9HG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EC16BFC5;
	Thu, 14 Mar 2024 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710413662; cv=none; b=XIsW/U22jR4xPVE6kzlhpFOQRaBNqGn57HQmVeALjepvXSfAjXZyBpj44naIEY1Bomig00SK82BGyroCAob37CpJ9rHD9gr0kJGfze9P59lE1LwukLJMcwbEwojfIEmaTiHdtSdWQgoYnz1RCt49ONlI/+HTyUJLmFJTvmq9LTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710413662; c=relaxed/simple;
	bh=G2ZQm8/9IYt/dpjObjKDAMea8Ol8tMORCxSkT9wUBr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r0yHK907WYYrvaG31z/J6p8wD+GpqLwGxp0t/QvX9VmqOPG4HWr8wonTl5LxWlFgK2/yY63TO2NmLiXSkUhW1A1OVE2pTjGXEtQXN3wTTEqrYarwvzTdA4Px3kT5GGrnfQQtArJCC15TEwaVgz7F8K88GLEnvUxTm4aTiULobTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyMnC9HG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC58C433C7;
	Thu, 14 Mar 2024 10:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710413661;
	bh=G2ZQm8/9IYt/dpjObjKDAMea8Ol8tMORCxSkT9wUBr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VyMnC9HGKEs9liFrLCplqcK2eHVdJek32qYY4IVCLRhLHuXD+VhTFTJmv89Pn3kmz
	 61qECZxqvLBEbMPtWBBr346UQbO1obGL+TKZJopvElB1u/ma/5hA43M5SLKvvbI5zQ
	 DQsV/r7FC7PWGGbRmrnESMWHQLII/mk0qXEstpr7NqI+7UyJiRA+nfqMB/tbmrN3lv
	 0PmInl/r2I0Sw0qvBLKy29RqS36UFVue2ToQCnMAAd8eaM3wfkHfp/XdLet34vgUgX
	 EVUY1TUY4+ViT+DNtBKHrO3vQC1FFm02LzgbKDp6s89yRJiZ8LHvPoHxSUROXV3tQX
	 Fz1xwOm9o191A==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeffrey Altman <jaltman@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marc Dionne <marc.dionne@auristor.com>,
	Markus Suvanto <markus.suvanto@gmail.com>
Subject: Re: [PATCH] afs: Revert "afs: Hide silly-rename files from userspace"
Date: Thu, 14 Mar 2024 11:54:13 +0100
Message-ID: <20240314-hochofen-aktualisieren-1ee26cfb60e7@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3085695.1710328121@warthog.procyon.org.uk>
References: <3085695.1710328121@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1210; i=brauner@kernel.org; h=from:subject:message-id; bh=G2ZQm8/9IYt/dpjObjKDAMea8Ol8tMORCxSkT9wUBr8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR+uh4WuG/bjRTj+J+iV3QanNf9VPK71aeUxb75WTLz0 9feGx597ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI5ukM/wPjjIQmsDLXLmrr nJjkqVS08r1WwMXfUcudV6q/eRRfpsfwP2p+74FMl6bovTdPs4Z6ZgZM+PdEKJPT5K9lYNN9idk MXAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 13 Mar 2024 11:08:41 +0000, David Howells wrote:
> 
> This reverts commit 57e9d49c54528c49b8bffe6d99d782ea051ea534.
> 
> This undoes the hiding of .__afsXXXX silly-rename files.  The problem with
> hiding them is that rm can't then manually delete them.
> 
> This also reverts commit 5f7a07646655fb4108da527565dcdc80124b14c4 ("afs: Fix
> endless loop in directory parsing") as that's a bugfix for the above.
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

[1/1] afs: Revert "afs: Hide silly-rename files from userspace"
      https://git.kernel.org/vfs/vfs/c/c38cecdf5360

