Return-Path: <linux-fsdevel+bounces-67109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30976C35879
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 12:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D953A14F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 11:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141383112DB;
	Wed,  5 Nov 2025 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6NcoiCB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515D730FC2E
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762343401; cv=none; b=Kc0Mj7VA4RaxHH8PKqXD9LdGUPa1aeY1Tog2santB++ucS5FcqunZK0lLUVZee5TuwQuMVf1pkQZaqm27MYPMGodfmq220E1fA3WBtC5jcKmrhxHqhQIQ1MSfzXO9cAQVFmcmnMrOH+wO3p9M/lCk2mJXfQWfB4MI03NLAyo89U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762343401; c=relaxed/simple;
	bh=cYisz+BPCPPo9iKlG7Zl8dlW4/c/TMH36NkoJa5E4qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iU9505iqVTRYqfaHQU8qXNGFw4Oc9qlLji3Zcys1W/NK/EujQEcKm8ajzW3vBRulHEBv0YrgolDHYyJQdsPBMAgpBAyVFr2a61Ef8vEp9C/wih5H9X5llZkTRBrQ7mKdshOebWrSHebejqorxmdbmqx8Hke0IVNZwsg2ZOvkAkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6NcoiCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9246CC4CEFB;
	Wed,  5 Nov 2025 11:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762343400;
	bh=cYisz+BPCPPo9iKlG7Zl8dlW4/c/TMH36NkoJa5E4qY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m6NcoiCBygUUaDD7JF0WDpweHCB7LS8qBKpkzPwN08KzhTrK0rAbYY1CeZmXVA8xL
	 a5pTHE9mniJ2lJXatA3SUjQqOE/zPgYpgIWyLXg88Mkz8L+ldYO4f6Cl/miA5pUJ94
	 OrUMLXZNxEDvwK9wIZbr+eDamjaxoHielQ0H/k2m+43zXBCG46iITM0hQeXGLQhvEZ
	 8dorK4KytS1bzfZ7RBBMeq78HPPyQAEQevL1oYXCdF0REk2vj7Cu8u5HlOfC9Q+w4A
	 c+ZT+eewxv9F/ke0YaboKRZdrBxHAFHGpPl58J8W+tIvRjKzCaJ2QBbiF5qCYFwpDR
	 TXomETdD42ytg==
From: Christian Brauner <brauner@kernel.org>
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: [PATCH] init: Replace simple_strtoul() with kstrtouint() in root_delay_setup()
Date: Wed,  5 Nov 2025 12:49:49 +0100
Message-ID: <20251105-wahlabend-grafen-004b38292c23@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251103080627.1844645-1-kaushlendra.kumar@intel.com>
References: <20251103080627.1844645-1-kaushlendra.kumar@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1275; i=brauner@kernel.org; h=from:subject:message-id; bh=cYisz+BPCPPo9iKlG7Zl8dlW4/c/TMH36NkoJa5E4qY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyWz5pqNo/9Sib8vmPnYbqHCGHfAzUZL03Xog6bn6Jf brLjpflHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP52c3IMO3qG7HsgE/737JX aT+qSs9N9/x/9Pbs0/InL5laHBL+sInhn/HZuMgb29V9DM8eOTblpLXkrLmBTLlb1i468GqqaPn RdmYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 03 Nov 2025 13:36:27 +0530, Kaushlendra Kumar wrote:
> Replace deprecated simple_strtoul() with kstrtouint() for better error
> handling and input validation. Return 0 on parsing failure to indicate
> invalid parameter, maintaining existing behavior for valid inputs.
> 
> The simple_strtoul() function is deprecated in favor of kstrtoint()
> family functions which provide better error handling and are recommended
> for new code and replacements.
> 
> [...]

Applied to the vfs-6.19.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.misc

[1/1] init: Replace simple_strtoul() with kstrtouint() in root_delay_setup()
      https://git.kernel.org/vfs/vfs/c/a6446829f841

