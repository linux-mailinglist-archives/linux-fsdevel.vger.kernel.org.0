Return-Path: <linux-fsdevel+bounces-42747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC751A47821
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 09:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF443B0408
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 08:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0333A225412;
	Thu, 27 Feb 2025 08:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dm/GF3nS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626331F16B;
	Thu, 27 Feb 2025 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740645970; cv=none; b=A5qlNksmxahTZQPRqvMToI02/A7G7A0HLAXuNiQMxLcZI2INo6fDCQIJsleA1bNaYwYaxUYyNUv/2SpFTbnK3AukCJjB2Ukb+GJD5ssZZ4d5QKbcF3b78mYeDQB56wE+gD56ZRTjrgD3WUGWrkPCoQDnK8ANnUtQEK3Pte+JJeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740645970; c=relaxed/simple;
	bh=+mw4AmEs2khSPV0cFLSRNs7O9EUXGmmGWpPp7c+s66E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OlbWbO8foDdL7r/A7ECvKxv1DbvCpZR38CSkrWlEJEYNRJhlKf+JJwhGaIB31OVTa817sfHAfyWigV0Ck7u89EkVqOyJw0ILHwLiIsXXt4m8EwRLnU0QhzvBFFvTCTclfYRjIQ6csFSqKhXOqtZ6S/jcaGdZacYFp0NArDjCYyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dm/GF3nS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B060C4CEDD;
	Thu, 27 Feb 2025 08:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740645969;
	bh=+mw4AmEs2khSPV0cFLSRNs7O9EUXGmmGWpPp7c+s66E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dm/GF3nS9KvQUat4GXtaWiuyz6SFevpZZ5c+v8Ock75BU0OcXG8TWTG6IdiZg5MN2
	 O2ZeGwILyuTrch5oX0JDQnbLk/TDV6A37uY101O6Auk0POqayNGtr7QkNXY5u/Fmk4
	 a/jIYw5cJ3sebyNzMgg7S6ForZvyogs/O4bgf8HCV9FmMbXWLUoI+BIkyR/X5q25Yb
	 BMa0Te3VaFbimaPCQx/ceTBTBwmSxvAJfrHRvKvrc4FuSjyUQhPxqup48ebqj+3taw
	 njwW811I08fZjoMAw4V7U+QMdnNC72RCJUXfMSsxupbfiV4hkOosq0Xs/4e2sygojC
	 Y7zAkH8mJ+bTQ==
From: Christian Brauner <brauner@kernel.org>
To: Lin Feng <linf@wangsu.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	soheil@google.com,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: [PATCH] epoll: simplify ep_busy_loop by removing always 0 argument
Date: Thu, 27 Feb 2025 09:45:58 +0100
Message-ID: <20250227-kanon-unrentabel-e3cf5eea0ded@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250227033412.5873-1-linf@wangsu.com>
References: <20250227033412.5873-1-linf@wangsu.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1237; i=brauner@kernel.org; h=from:subject:message-id; bh=+mw4AmEs2khSPV0cFLSRNs7O9EUXGmmGWpPp7c+s66E=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfUPO5GtxjfUdY5mbTHUP+jfoTHl3genTpT+ysWb+v+ SgKGPRIdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEKYWRYZL23RUt/VoiBsHl z7IUBJyCJ+/nENt1SEOPOdWzI5rtMsN/F8lDZr5MOfeXTZwq++rlrD1ynCw6gvdPFPJUTXT99fA AEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 27 Feb 2025 11:34:12 +0800, Lin Feng wrote:
> Commit 00b27634bc471("epoll: replace gotos with a proper loop") refactored
> ep_poll and always feeds ep_busy_loop with a time_out value of 0, nonblock
> mode for ep_busy_loop has sunk since, IOW nonblock mode checking has been
> taken over by ep_poll itself, codes snipped:
> 
> static int ep_poll(struct eventpoll *ep...
> {
> ...
>     if (timed_out)
>         return 0;
> 
> [...]

Applied to the vfs-6.15.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.misc

[1/1] epoll: simplify ep_busy_loop by removing always 0 argument
      https://git.kernel.org/vfs/vfs/c/d3a194d95fc8

