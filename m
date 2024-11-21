Return-Path: <linux-fsdevel+bounces-35392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1339D48E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 09:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE9B2821A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 08:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949C81581F8;
	Thu, 21 Nov 2024 08:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJFbb7mh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0190423099D
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 08:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732177912; cv=none; b=L6jkD4M3b0KoZzwTFm70CjbyHp3iilEfrpz1n1Eb+K09LVhJ2EQ+qfuFwkgzhoiBZDx0tDxrBu9IVEA/u7TlmZ+ZeYSgrYHLYNZn1sYstZ8zJiXs0gqTZhdF2dYIxHv48gBa93PmhCGletA5Vb1IoHkjqp2nuJIu5Grp05Ahk+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732177912; c=relaxed/simple;
	bh=EnU6Q4r9X4QdILaHujjvGgiv0Y4GCB+azY4z/Els6b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=euPXJOTJpIFD6dMWFvDIiLVLn2esTfBcZ9u3pGvx0DPia3R1e7B06brFAXJUl44eModpTxXC8Iz5PqqI5LeoFWoczpHBnnpF3vi8N3qRPnvfm+iQSG7Q2as2u4bLmpyvCVciTAnLHMfk2ae+6cZDdqI28KzO+fOphv96uZKtKc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJFbb7mh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C215BC4CECC;
	Thu, 21 Nov 2024 08:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732177911;
	bh=EnU6Q4r9X4QdILaHujjvGgiv0Y4GCB+azY4z/Els6b8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CJFbb7mhvYGaRGw/DIATwRsKOPOuo3Ok5D/tljKkdjBuNtNghnyiMMtbCRjds3lDb
	 r3hWenwBN71exzAAgksB2Jj6TnH4QVW69uEG8DcVXPTE/r2Vf5Q4PNakE5XT40LKuv
	 ZONQp0Jw7b+voIs1m6fue/86x15g8VzCAgModq3k7Gsxwyk9g+9f7SplTq735uvKlu
	 VY0tYuyuIaPmWp5d9QgXI8wi1frEgfau/vUpqFrsptC3m5PP6NUlereejetkhDXuwF
	 9HR7nrv2h2CdHt+Qo0/i9d7fMSic7I+niosPFoMO3GtT58VVtVO21kOjiiv1BsDiAj
	 SZPreRZFuH5bQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Miklos Szeredi <mszeredi@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] statmount: clean up unescaped option handling
Date: Thu, 21 Nov 2024 09:31:41 +0100
Message-ID: <20241121-boomen-entrollt-e9705cee3279@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241120142732.55210-1-mszeredi@redhat.com>
References: <20241120142732.55210-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=brauner@kernel.org; h=from:subject:message-id; bh=EnU6Q4r9X4QdILaHujjvGgiv0Y4GCB+azY4z/Els6b8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTbvf9wzjzJpWZG+dSMReZcd/dLsH15eqx0/SWNVRIJE nvuyb7e01HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCROU8Y/kfUbNzMJuateiuE bd3/7CmHdtqkx0Vn/3ks2d7gcfY/ezcjw8eTF6UjtDxVl/YGbVgvHznRZfuqvkm2D1zfiefO9fo aww4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 20 Nov 2024 15:27:23 +0100, Miklos Szeredi wrote:
> Move common code from opt_array/opt_sec_array to helper.  This helper
> does more than just unescape options, so rename to
> statmount_opt_process().
> 
> Handle corner case of just a single character in options.
> 
> Rename some local variables to better describe their function.
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

[1/1] statmount: clean up unescaped option handling
      https://git.kernel.org/vfs/vfs/c/d09ddc9b1976

