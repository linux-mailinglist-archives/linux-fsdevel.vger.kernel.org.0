Return-Path: <linux-fsdevel+bounces-45191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1328A74630
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 10:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886EC1894A37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 09:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C1A2139D8;
	Fri, 28 Mar 2025 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWmXuvrI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568C91DE4D0;
	Fri, 28 Mar 2025 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743153537; cv=none; b=e5bPmS3drcAj67GRZE2v26pR7t7LlqgI95sUF4bRv9EZlM6lQJrT31Cw8qb7yOzfHM6nzu1jLk8dqo6qS86rymTrIti5jCZ5z6LxFYxrKX/V2cM4fRyYHr7OgTkrN5c7PatwX4GQMQKJGAiN/x8EVqu2AFZ8eP5jcFxqZeZVkCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743153537; c=relaxed/simple;
	bh=XNAwCLv/vF2XPivuKN0kO6nF+TkG13gfAKTB7wxmtQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=We1+Jb3ps/J8W6bhJOf30HO6Zyw1ZGKXRUq46qHFWwWuj6lL/19F2ERqiu7I+crdfZJviS6mwsE4Z0KFfM6mWjh+Eo3MiKlLn4UMuFz8QAYS12zwgk3MgHfVZlw0FWLyXb/orkHe/tJAht9JOGFH0CFcQsTToqfxJgeXPHpck7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWmXuvrI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A609C4CEE4;
	Fri, 28 Mar 2025 09:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743153536;
	bh=XNAwCLv/vF2XPivuKN0kO6nF+TkG13gfAKTB7wxmtQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gWmXuvrIzxSEfRgoPXrjOT4pKhYvSnxzMto6YAhHHiI7eibe+WDc3XO1fpMPex611
	 T5kK05aABMPQV8Ts7T886gludtOofRNQOaeqJH/gBL6ucviO57rjlszZXKyGc6lRPN
	 eiiGsrfrFV7VNRlXXgSMC2pkxocOANuJE8nIL1YtUhM4U643isEFs7wWvufNm0RL5o
	 CCUCYFT7ythvFGSwn7a/mckZIW3kyYZwwMuVf73S0X/FgLCTSbrPgPOT8ZV+nJneBY
	 nnBUFS27jHMAuN1YwLl6M5c6eaV9l+2acDXVXz0UsVzrKiEzfqU9XVhhxKedF+2UVk
	 kkLVDITXkMKWA==
From: Christian Brauner <brauner@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH][next] fs: namespace: Avoid -Wflex-array-member-not-at-end warning
Date: Fri, 28 Mar 2025 10:18:45 +0100
Message-ID: <20250328-speziell-typisch-49284d100d8a@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <Z-SZKNdCiAkVJvqm@kspp>
References: <Z-SZKNdCiAkVJvqm@kspp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=brauner@kernel.org; h=from:subject:message-id; bh=XNAwCLv/vF2XPivuKN0kO6nF+TkG13gfAKTB7wxmtQ0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ/y6wuun9TeJNAsuLr0vwNIZ6B2ovai7ctWNlcfO//j 6KzpdtsOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby7iUjw6QtV6N15vV3nha0 luCbvazOff2Kg0eWZ7NIG8YodBz13MLI8Nfx1pcLC/9pnIyeXnJDYvcsfg/npE/PFm4+lpmRutr 6KhMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 26 Mar 2025 18:17:44 -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration to the end of the structure. Notice
> that `struct statmount` is a flexible structure --a structure that
> contains a flexible-array member.
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

[1/1] fs: namespace: Avoid -Wflex-array-member-not-at-end warning
      https://git.kernel.org/vfs/vfs/c/9e6901f17a71

