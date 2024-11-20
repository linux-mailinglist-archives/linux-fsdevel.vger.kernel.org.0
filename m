Return-Path: <linux-fsdevel+bounces-35274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 491D99D3564
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B90C0B24909
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 08:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539A617277F;
	Wed, 20 Nov 2024 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RI6Ns4Z0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3362156F20;
	Wed, 20 Nov 2024 08:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091309; cv=none; b=J8UeYXECOb6IxQhDCoUg35TS7vY8WyCXMv7wxbKbb20xQOJbv7a5sHl1y7zNlQU/jgQKFmpFSFTbOUnF0N1pXoNGbPlVRskCuNOy4cxCLbm6mz+HdVKZ7JEs75/LWS9PvwFdMJVnzzGgKjy7sus6XttT+IULge4TmeCVW4S8Q8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091309; c=relaxed/simple;
	bh=BEN+FFG8DzVJ1Osemg/1oIpG9nJboJMmdJivsCj5HIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BzgrHDcDURIfzRnkJd6vpMQwcFo2NNldCK0m0RplgrNgT8NGKmsgtAyUOZL0lVbvV3I11lMxmdrpb7KJ3Q6SXIDUcJxQo8X7yAQaq7nBFtuw4/f3/xm6QleRzNkJA/FEZ9dZQiI+kzn2dmSZgLYqYjg2638y34NK3LPn29gpH2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RI6Ns4Z0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC74C4CECD;
	Wed, 20 Nov 2024 08:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732091309;
	bh=BEN+FFG8DzVJ1Osemg/1oIpG9nJboJMmdJivsCj5HIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RI6Ns4Z0pYGeqqYyRzWp77GU8jov8PilY5yrobKeBgcqD8S6ZpqISfqKlrj0OZx3U
	 GfHE34tX4H3cO6a0r7cHKBks6kpccjSL6yU6Y2TZ2msE39Gufe7jDC96ud4bNwogys
	 Rf0QgRYg6lyN4tc3QUwq61U5FU6M7fKzvzutLE2jzrWyUoNTsWzw2AeK4S9h9VYNDg
	 54C6UpMHibVGysZg4GgVtCfg1Blzsl4p+QqQvWiZ8roWUdockS6KK9x560C3zP1MkW
	 ynqrCYmtIc9aOhetsDYn3meLpcAO/FT91O7F/GoyNEG0on/tJoMRj6r7422w31W6MZ
	 2AMkgeYD2bZIQ==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] netfs: silence an uninitialized variable warning
Date: Wed, 20 Nov 2024 09:28:20 +0100
Message-ID: <20241120-lageplan-kneifen-e124b37dee93@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <867904ba-85fe-4766-91cb-3c8ce0703c1e@stanley.mountain>
References: <867904ba-85fe-4766-91cb-3c8ce0703c1e@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1158; i=brauner@kernel.org; h=from:subject:message-id; bh=BEN+FFG8DzVJ1Osemg/1oIpG9nJboJMmdJivsCj5HIU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTbzl2m8GxdzyqWFy9zImbvUJw/++bl1mUb5tr3zntx5 srjFCG+Zx2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATWfmO4Z/iEqHAqz0XZ2/0 Wq897+Mx8YYDebm3tbSLDXVNjtvLtlsxMiwsrfPROC4gLmD4wtk7pslGyzaXt+mg4mI3Ea1JDy6 L8wIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 18 Nov 2024 09:08:19 +0300, Dan Carpenter wrote:
> Smatch complains that "ret" is uninitialized on the success path if we
> don't enter the nested loop at the end of the function.  In real life we
> will enter that loop so "ret" will be zero.
> 
> Generally, I don't endorse silencing static checker warnings but in this
> case, I think it make sense.
> 
> [...]

Applied to the vfs-6.14.netfs branch of the vfs/vfs.git tree.
Patches in the vfs-6.14.netfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.14.netfs

[1/1] netfs: silence an uninitialized variable warning
      https://git.kernel.org/vfs/vfs/c/574cb560cc1c

