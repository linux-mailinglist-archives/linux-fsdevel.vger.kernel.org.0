Return-Path: <linux-fsdevel+bounces-49927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 106E5AC5A75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 21:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43491BC2262
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 19:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECF328032E;
	Tue, 27 May 2025 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSlTq6hk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58556280CCF
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748373034; cv=none; b=g/iKjkppmMBuyqTozDDGyVVpGcQX7vEzaFkinkRvDdytmLRl1SMr2i6YtvbsE2chZjELgz/xpe+Rpcxjq76TesbkNrAZQQXW+a0AIErViV8OAcs1nys9Lu3DA762NO6IEAXVQbKFD1A7nKwpxtjS6ugWgHH5mFBxRpH4UZzaUWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748373034; c=relaxed/simple;
	bh=dr7kbHvYdMhdGR1t3cShyX9fisGAvtjAjYTP501S0Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kBCoSjIq2RxdSiEZtcuAzjdj0bUA52oa5ME7ZN4ScrQzuK15kpN+ABl1UDtgLSb5iT8na4uJ2qUbBVrK8UdYNIZSNvZKdJV/QkDkVl1TGWaF8nwVDRCKrLy3HmVIjHtAJM4mbM+vIfnM+E7680vBFE0j3kryrnxu9I7gTyPjjB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSlTq6hk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D39C4CEE9;
	Tue, 27 May 2025 19:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748373033;
	bh=dr7kbHvYdMhdGR1t3cShyX9fisGAvtjAjYTP501S0Fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lSlTq6hkTSnqVFLB6SNTB/ibV/1Z3GrBt/F7baWwW4HJ6xEMyfbJ61QfwM0V9b3Dw
	 Nk+dEaahQqkuis/o5VIf87JXrY2VDTphqz/lr9454byotA8X1B9FOlikOuWvb0xnd6
	 2Mbfu1FP1xpQRn3pudVBS5WlUP0fXQES5d2u+qeIhshuIrgXJMBfgt3leasPapPgiJ
	 VGeBHxWuYhDLhe5Pqvxdibfumy0pjLBUBsLWdKhInVeqTGjfFzIRBsR+S8xETtLV5I
	 JMNAjD5afgGEN1s3Ja1JQWri5NBHqwOl8NbWLZRFX0DIJflYN5DKozrJmNOVMjuztl
	 2G+N7elVjTVOw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	djwong@kernel.org,
	torvalds@linux-foundation.org,
	trondmy@hammerspace.com
Subject: Re: [PATCHSET 0/5] dropbehind fixes and cleanups
Date: Tue, 27 May 2025 21:10:19 +0200
Message-ID: <20250527-feuilleton-neonlicht-df0becf90a84@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250527133255.452431-1-axboe@kernel.dk>
References: <20250527133255.452431-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1731; i=brauner@kernel.org; h=from:subject:message-id; bh=dr7kbHvYdMhdGR1t3cShyX9fisGAvtjAjYTP501S0Fo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSY8SkomUqwpuyY//D8g2tl4Wa7xB5rrhQ6eOpn0A6ec 0yeHUscOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaS9pzhf0zF2ztr/+2XmSA+ 8azrWzben7f3JAq9ZmD5qHnLVlfsZzbDP00uR7sEhbDSEuNCb97gM+o1PVNm3Dvw32fBk/hVYb/ CGAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 27 May 2025 07:28:51 -0600, Jens Axboe wrote:
> As per the thread here:
> 
> https://lore.kernel.org/linux-fsdevel/20250525083209.GS2023217@ZenIV/
> 
> there was an issue with the dropbehind support, and hence it got
> reverted (effectively) for the 6.15 kernel release. The problem stems
> from the fact that the folio can get redirtied and/or scheduled for
> writeback after the initial dropbehind test, and before we have it
> locked again for invalidation.
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

[1/5] mm/filemap: gate dropbehind invalidate on folio !dirty && !writeback
      https://git.kernel.org/vfs/vfs/c/095f627add86
[2/5] mm/filemap: use filemap_end_dropbehind() for read invalidation
      https://git.kernel.org/vfs/vfs/c/25b065a744ff
[3/5] Revert "Disable FOP_DONTCACHE for now due to bugs"
      https://git.kernel.org/vfs/vfs/c/7b2b67dbd449
[4/5] mm/filemap: unify read/write dropbehind naming
      https://git.kernel.org/vfs/vfs/c/1da7a06d9ce4
[5/5] mm/filemap: unify dropbehind flag testing and clearing
      https://git.kernel.org/vfs/vfs/c/a1d98e4ffb97

