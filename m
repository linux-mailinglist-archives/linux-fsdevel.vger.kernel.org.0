Return-Path: <linux-fsdevel+bounces-32485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D94E9A69EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 15:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2F11F23816
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 13:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430991F4292;
	Mon, 21 Oct 2024 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfU7CQv4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C241E0DD7;
	Mon, 21 Oct 2024 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729516811; cv=none; b=RpWUt4+zJ5A0u+614SuUGKjfcL0FxA87DbXBlu2XDNLEkd3e6MiLFjRt5xWXOpdb7ZRLsgI/kWcjkT4DzmLALvAu8cG5CzUbbumxJlZrM3Q6AN/+zNEAdaUKXLLVjaDjLTh/n2VWN91jTYp/1mxKTXOQRoFNVZBjjuNgA60L5Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729516811; c=relaxed/simple;
	bh=4R/WKRARQw/4IlPbaQI7M3DPYBrwc9XcRDPFEX/AV7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqdNbuLa9Xyt3a85a2lYXshwxgLND0WUVf/Kwx92uqKguHf23sNs5hCNhRloAy0siallgRQ2c9GGv5fu9O6F2Mt2Abg3pBNb02E66+tVX90zu8LcN80PbDLACKuypYMVjcJ4jbc6BTYu5swjWhjj0G5T9AYXhLoJZXoyJRo4SqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfU7CQv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D866DC4CEC3;
	Mon, 21 Oct 2024 13:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729516811;
	bh=4R/WKRARQw/4IlPbaQI7M3DPYBrwc9XcRDPFEX/AV7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rfU7CQv4/Ex0Hm4HCwQgGues8xgjV4uUlbKKs6KE4dQK3Yfnkex+Cf6GceY1QGIqX
	 couOKavPDfCgJI5IKQuFYwKAEPrVO6cAPjEMZI2O6W8KuQOYiD6snLXoRJ2kN1uGdw
	 JSd0P6qs0Ce9AmIeo2YR0kWUb7lYYT/dmpfdZ+4wi6nQa/u10JfT9e7FaJTErq8f0Z
	 Z/iHJtJ+3ro+ocX8JRMJekUcvc4wPEXe1e5oWxE3Zgqlk4lzS23xeEiob3SqtX6CNd
	 BFdHC6Q/NEjxW1II4/+R9HEiEUPB/ssJvxOxWXHO0YQoB/ypyFdLIPtue4IquYgSzn
	 IEq9DUPYwDK2w==
From: Christian Brauner <brauner@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v2] acl: Annotate struct posix_acl with __counted_by()
Date: Mon, 21 Oct 2024 15:20:03 +0200
Message-ID: <20241021-skalpell-kulant-6622b37fc93a@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018121426.155247-2-thorsten.blum@linux.dev>
References: <20241018121426.155247-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140; i=brauner@kernel.org; h=from:subject:message-id; bh=4R/WKRARQw/4IlPbaQI7M3DPYBrwc9XcRDPFEX/AV7Q=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSLhbLs27gs1nVGgsHTtwyXmKQ+vWhh1Z9b6Prk4W8OH SV3u+CJHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPhYWP47667nlc2e93rIzHb 1r0/WdDd8UurwK+yecexRLN7vLXWzowMx7+dqVqjLabsGbLud3tYPN/RS2szn/DNu78w+d++/VX L+QA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 18 Oct 2024 14:14:21 +0200, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> a_entries to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Use struct_size() to calculate the number of bytes to allocate for new
> and cloned acls and remove the local size variables.
> 
> [...]

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

[1/1] acl: Annotate struct posix_acl with __counted_by()
      https://git.kernel.org/vfs/vfs/c/ac0812ef00c8

