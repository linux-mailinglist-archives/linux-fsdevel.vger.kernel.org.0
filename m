Return-Path: <linux-fsdevel+bounces-59621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17316B3B4AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 09:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7EC1C83A98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 07:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98444285041;
	Fri, 29 Aug 2025 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2GmsSzS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ADE27B34D
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 07:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453731; cv=none; b=mzdQfe8e9xtVsrBQvK9FczT02eEFDV1xFY40lbSCPrO4Ybiw70K7GgRHYGw2NndOmd6d82Jwe+YkriUBCul59YexsmlgOTK/29c3sJe1Kmp3F+uPvRAgmatnIO7RR4jdg+tPiwZbuqVgehYG/Y3hFLyIqwT08Jp1Sj1WxMUEAR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453731; c=relaxed/simple;
	bh=7CoFdUTMbU3T8+Y2B+sklr0+B3GhttWyVKczfGDM5iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZLvHkpw1dA5kvk/yR2cHCr+KMCrfX6X0eG4EujjjaML6kMJjVd4iU2cOZ1K4HeZ9WyV9gd44wmC1q9PMVNNSfR+7r37cp88HIEIZHboZOU68aaNDJ2d5ti0Nc+jBFejbsLybuWI2qaEHEU99mNpcsGeB/7XFbLvCIoWylHFcoXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2GmsSzS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088F0C4CEF0;
	Fri, 29 Aug 2025 07:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756453730;
	bh=7CoFdUTMbU3T8+Y2B+sklr0+B3GhttWyVKczfGDM5iA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U2GmsSzS0Pi5FSKOmDKslhxT4RUtg14fLTq85q2zm4j/AtnWPyv4U4EyJj6xh8557
	 zQmDkHqmKukShArP2RTTMo7KEMpHiLtzTAp/urY55FSW1BmEEhV946x9Xt+k86E584
	 X8DIgZpXrQjDHi1wUQApuRMsyuCYc0iU4twUsRYwqJLvziTpD96ljFobaMBBaUJrqA
	 iudWbrlJgGetBJUuiORegm9rjVM77PI05h7fR4M9/jA6/oBKtzCMJydqPekGIb0JDo
	 Tpnfz9wQtJ8E21HtTHQ0131B4w91voGG+e9DsPVPcKtECCIDAgAiG5MY4P8V0SwjHe
	 UWUP3cCasOlFg==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fhandle: use more consistent rules for decoding file handle from userns
Date: Fri, 29 Aug 2025 09:48:45 +0200
Message-ID: <20250829-becher-harmonie-ab5186ce9611@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250827194309.1259650-1-amir73il@gmail.com>
References: <20250827194309.1259650-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1215; i=brauner@kernel.org; h=from:subject:message-id; bh=7CoFdUTMbU3T8+Y2B+sklr0+B3GhttWyVKczfGDM5iA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRsjI7bY2zGPS2P8bfyBwXb9SZnnFslLvHaNO2Y9Im3m P1p5a8JHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNJ283wPy4iQVPst3QRc/px JttGH8u4Fctm3HVZJ3X850QFs4gQC4b/0fdL3+U+Y/Phzjl9wF5+tnmD9JeJhmfPFtrsCno9S7W IHQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 27 Aug 2025 21:43:09 +0200, Amir Goldstein wrote:
> Commit 620c266f39493 ("fhandle: relax open_by_handle_at() permission
> checks") relaxed the coditions for decoding a file handle from non init
> userns.
> 
> The conditions are that that decoded dentry is accessible from the user
> provided mountfd (or to fs root) and that all the ancestors along the
> path have a valid id mapping in the userns.
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

[1/1] fhandle: use more consistent rules for decoding file handle from userns
      https://git.kernel.org/vfs/vfs/c/bb585591ebf0

