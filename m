Return-Path: <linux-fsdevel+bounces-17156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F058A878B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A252E1C21B8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 15:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B091474C7;
	Wed, 17 Apr 2024 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/bhcD49"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCAD13A265
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367598; cv=none; b=QJvEKux1f0Jbv9F7Ff5oUNztcbPa+vcB9c5bq3Ny0f/j2G23NhSSCdjgQc8InDabHUXQPvZ+TdJz3M/+6ax4YT0XZUtwMNdx0jPwQlZmeQ7NEATQoSeZBRIKqQGOb+96tc5lPZRNP8LKBy7A5mWeQJspnmOxem5uhGZsnHkchlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367598; c=relaxed/simple;
	bh=vKlmk1nBYASgDXwdaXU1+s/rUCo+YuReb/17Xw/rnWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myKd9zKUU5ysqM1oMzxLbvDJ+1CS8bShuIDtB/wjal4HYBEywci7M67BZG58Gm+RhtSpdO3q86frheLlwSBKSTQ37IICr/XbxTNm2nJLepFNuRIcBxexLwf4rnaThhR/TlwygFSLLTkCeBXTS9Nd3PgOkrXco/zBmYersWuni8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/bhcD49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0F8C072AA;
	Wed, 17 Apr 2024 15:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713367597;
	bh=vKlmk1nBYASgDXwdaXU1+s/rUCo+YuReb/17Xw/rnWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H/bhcD49Xf4504DEvoanCaw/63tbWbF3do3H/+AfznQXfjg+BECrIbZBQbfs3j8+W
	 DfivWy1t4lDtW2UXPiK2e8LbS7MJ0ez9JuEkoh8bKb9rDKYGtvvLnots2bBLyaAicL
	 6nLOgjdb/wBr6EpFm/Evk04sDHKUFfpVTc8L4xa0jkO7RZPhtf9svyJfsD+MEsPGUO
	 nMeZ3B6ck0XhIkyeuqc2VpLW4+Dt/Wqt/lm9UiwvIYlOKtpxr489iFvlZ7D4yJwyKy
	 dmGp5AC2Qjs7EeGADFO8huxM/qzKDPSICvg+51yPX3/hIIo2KGD+60HBnrR11HlhL/
	 MgnujEES1+AIg==
From: Christian Brauner <brauner@kernel.org>
To: cel@kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 0/3] Fix shmem_rename2 directory offset calculation
Date: Wed, 17 Apr 2024 17:26:13 +0200
Message-ID: <20240417-anfassen-kennt-2042c8e29bef@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415152057.4605-1-cel@kernel.org>
References: <20240415152057.4605-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1419; i=brauner@kernel.org; h=from:subject:message-id; bh=vKlmk1nBYASgDXwdaXU1+s/rUCo+YuReb/17Xw/rnWo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTJvxJb/UiBnTflxmo+y4fdngsOiYfUxN38MLs82vlXs mH4ml1hHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMxn8bw38l48SvOWBf5lkz3 hatzb845IJn/hyH2ROzvyVETxLtNNjH84ZzZ58jle6l1UQObtZF6+eSUoCdH+tLiuuble9xxss/ jBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 15 Apr 2024 11:20:53 -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The existing code in shmem_rename2() allocates a fresh directory
> offset value when renaming over an existing destination entry. User
> space does not expect this behavior. In particular, applications
> that rename while walking a directory can loop indefinitely because
> they never reach the end of the directory.
> 
> [...]

Thanks for fixing this!

---

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

[1/3] libfs: Fix simple_offset_rename_exchange()
      https://git.kernel.org/vfs/vfs/c/23cdd0eed3f1
[2/3] libfs: Add simple_offset_rename() API
      https://git.kernel.org/vfs/vfs/c/5a1a25be995e
[3/3] shmem: Fix shmem_rename2()
      https://git.kernel.org/vfs/vfs/c/ad191eb6d694

