Return-Path: <linux-fsdevel+bounces-34199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2899C3A5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 10:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70D8C1F22002
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 09:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA83115E5DC;
	Mon, 11 Nov 2024 09:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbsjPBTG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3169361FE9;
	Mon, 11 Nov 2024 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731315705; cv=none; b=R+sJvScFnYU8G+A9rAg6WANOOcFN+PhPb7VhfZb/FeMT+RAlrnwsUnCuR9gGda/t9UTY0ZVaAmWcWY2dsjcGXnAZqKnWv8R2TEUqSbdXbKJM/8BZIu7T4/tX/+m+VGMB0NixZKGGmTXdn0aAszpMz7UNmEa1wJc4cWtro1Sxnsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731315705; c=relaxed/simple;
	bh=4Pz1De1KGPwOlxrvM7cpp5mUzQMEEB+/2WKk0NhL3b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGPwB4d2BAav0j/1tGAf9Yf/WITxgM/ygz4vVl4I1Kek0WKDIU/3UJdDGi5DxA9WhC70OVp2+fkhsIU9LTdnhRGksZxmEi2aS3x+gVyjwt3uwcSETEgwLR1jLCNKyrZUpz54vQB6/XvbpD+Eppq971YIjz4reOz872zModsvBa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbsjPBTG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38DAC4CED0;
	Mon, 11 Nov 2024 09:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731315704;
	bh=4Pz1De1KGPwOlxrvM7cpp5mUzQMEEB+/2WKk0NhL3b8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RbsjPBTGoy6BzHxmRYdVqDXd7hnQDWSmzx4GR2o7WCjQB/0nGWTMLDtcxXU9sErLg
	 d4pwYSWrd97aEBHBaRlxp6n5BJxGmlvvNbMDxaVr6kOnx0S4QnwV3wlxL7DDe4GkjL
	 660RneTrEdq7/BCSQC2bF5PvJJdcqUnWcfKlHosryyHgfr09qTi0nfMWWm6lq5ncz9
	 XBs/Keyx7euihh9qpbbTPPgU8LZ1qWFY7naq+pQQ7tIl6RAX64YLUtNY8GoL0CRB9S
	 w+Cf9ucbNf8WWJwS1u5rjvA5xOTNRdJ0wf+UVQOkAuC7Q1We8/QSbCTG+Ftd/oBqad
	 aGjhZmcPeJrhw==
From: Christian Brauner <brauner@kernel.org>
To: Omar Sandoval <osandov@osandov.com>
Cc: Christian Brauner <brauner@kernel.org>,
	kernel-team@fb.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0/4] proc/kcore: performance optimizations
Date: Mon, 11 Nov 2024 10:00:54 +0100
Message-ID: <20241111-umgebaut-freifahrt-cb0882051b88@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1731115587.git.osandov@fb.com>
References: <cover.1731115587.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1535; i=brauner@kernel.org; h=from:subject:message-id; bh=4Pz1De1KGPwOlxrvM7cpp5mUzQMEEB+/2WKk0NhL3b8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQbHv8oc7jE0p9pcg3T6gPzrx/P36p/JXj1OyH7ad9lv a4vX6vyoqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAifSmMDDM/xXasXSC44YXt pPjXcpMUP21aE+O1wI13B89pljrFwkRGhsbf6rfyzSWtPv7d+vJaBfuB+uzNPR8vLZGqOm9f/3D GPS4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 08 Nov 2024 17:28:38 -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Hi,
> 
> The performance of /proc/kcore reads has been showing up as a bottleneck
> for drgn. drgn scripts often spend ~25% of their time in the kernel
> reading from /proc/kcore.
> 
> [...]

A bit too late for v6.13, I think but certainly something we can look at
for v6.14. And great that your stepping up to maintain it!

---

Applied to the vfs-6.14.kcore branch of the vfs/vfs.git tree.
Patches in the vfs-6.14.kcore branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.14.kcore

[1/4] proc/kcore: mark proc entry as permanent
      https://git.kernel.org/vfs/vfs/c/182e1391e525
[2/4] proc/kcore: don't walk list on every read
      https://git.kernel.org/vfs/vfs/c/7d528645beeb
[3/4] proc/kcore: use percpu_rw_semaphore for kclist_lock
      https://git.kernel.org/vfs/vfs/c/61c85db61fad
[4/4] MAINTAINERS: add me as /proc/kcore maintainer
      https://git.kernel.org/vfs/vfs/c/f792a4899395

