Return-Path: <linux-fsdevel+bounces-31168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1FD992AA0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 13:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F912B23183
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 11:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A581D1F7B;
	Mon,  7 Oct 2024 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxKpbxMD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1511D0F78;
	Mon,  7 Oct 2024 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301732; cv=none; b=JX2Gzpo/uQiqoWyvN+igkBal30tf8mwles44mma1lWkzrlVO80ulfEz7ZVmomickyroGkyZIhHDsCrpWg89pcV3YKVEPQVJ+B7bi6hGj6RMxPydezR3j8WagQwvLERUpvHcfL9R+xik4evvqicOaRMwMNosh4A8D2Eq1j2FpyCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301732; c=relaxed/simple;
	bh=kbc4xmfeNAfmBlWlHAJaCe/u2AgE7q7Q3kDpNlK08bA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+07mlcwunh+mm+ESE/wlv1a7zmevVBLfbOgra5qGKpFyCGjO0PPYFWiaoaWzK28nowE6WrhCTPbtsW4FtlFabWl7k0tvS6+QUoZIbgFljOjv+OkCFtl6+98hX4MCLUJyANjajNJFYqaf72FKELekLzNwcWYnSIWttkiu9/ivV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxKpbxMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F142C4CEC6;
	Mon,  7 Oct 2024 11:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728301731;
	bh=kbc4xmfeNAfmBlWlHAJaCe/u2AgE7q7Q3kDpNlK08bA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oxKpbxMDJbiODH7UoCcd4X3j37d15s6MHNSxk+RBdoLqwklaofqnvd6FSkNyuDRuP
	 3GyyDz4IErGrK2ZzrvWoHfKc0D7iRjnqJj9BCPbuKeWbhnKTh7jXJTwH1HjbsHQdli
	 bzQhbJ0xmsDYqBXeeQ/MskSAGTI8HaY8FkUXa9E3S3fTGXGm4QbM+e5MRZvXA7c3Ke
	 BnDOyEt+l4zqLHnn8aDY8gl2lvQmE9docZ2Y5dy9rQ+KuEgJ2zpnbjJpQL0r+rO6Cw
	 rIr0v6PK5a5nxw1ehzNMZQMR0mazqAYBwY2bm4S/Fh4jhiH2qPXrJetSXL9DMiluxT
	 TlmkAHDtWZSPA==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: In readahead, put the folio refs as soon extracted
Date: Mon,  7 Oct 2024 13:48:46 +0200
Message-ID: <20241007-eifrig-zinsniveau-7b31e4c4a4ab@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <3771538.1728052438@warthog.procyon.org.uk>
References: <3771538.1728052438@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1311; i=brauner@kernel.org; h=from:subject:message-id; bh=kbc4xmfeNAfmBlWlHAJaCe/u2AgE7q7Q3kDpNlK08bA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQzn5r34bC/ncwk9j0bbnic1/j5Sbyfjy+EKYDhYENH1 IqOMtZbHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMJWcDwh9fIcNuTD/2lmdzB cf/n+O44qXpC9/rH+IXRPM9UxO98UWX4H1CztLvXW+R1zt263wpTHhy1KDt8tFe0QfyvpPtCx6k WPAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 04 Oct 2024 15:33:58 +0100, David Howells wrote:
> netfslib currently defers dropping the ref on the folios it obtains during
> readahead to after it has started I/O on the basis that we can do it whilst
> we wait for the I/O to complete, but this runs the risk of the I/O
> collection racing with this in future.
> 
> Furthermore, Matthew Wilcox strongly suggests that the refs should be
> dropped immediately, as readahead_folio() does (netfslib is using
> __readahead_batch() which doesn't drop the refs).
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

[1/1] netfs: In readahead, put the folio refs as soon extracted
      https://git.kernel.org/vfs/vfs/c/796a4049640b

