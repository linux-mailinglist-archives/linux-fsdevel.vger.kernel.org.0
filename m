Return-Path: <linux-fsdevel+bounces-30038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC449854DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 10:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE971C22DBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 08:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A1D158A30;
	Wed, 25 Sep 2024 08:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBefCkJU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EFD15666B;
	Wed, 25 Sep 2024 08:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251249; cv=none; b=CelQLgogVUnOHtcJsXpcc4h4pR/OnD+Z2t6Ccze4vTru0J4C2LwjvtyUHs/C7fE4NbyxgUyxF8STJIReBBB5ypgqgf1v15XbkrWKvLdHl80bB8q9pc8uiO5GIdQ8np9JuiIlJZiWfLCAIsgBmjwa7l+h/oihX2Nwy/MCtTl1n0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251249; c=relaxed/simple;
	bh=zXEAFz7Q7RoUiIW7ZL5q+2ystQGk8UlUo9zBOm80IOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b7AX+UEbvkUXMPTMyVtjb5uEBjlCLSu+yMeBRkHUCc950IS72U86mCHboaLrlJwv+d1s3bSzCDWqoM3I8dQN4fiVRinUWXNMpQOQkZxwNd2NymwluIq7GhifszDmWkF3h7XKVcoa81tQf/cQBDYMIJihvSBRFw279uwmHiVAaXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBefCkJU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849FBC4CEC6;
	Wed, 25 Sep 2024 08:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727251248;
	bh=zXEAFz7Q7RoUiIW7ZL5q+2ystQGk8UlUo9zBOm80IOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IBefCkJUPC4m68EMvyyGVNd0R3zupnHFovKJDUWkFCLpsRONbAmbFn3t2+t3lduu0
	 MM91AbXvufxdyfFRY8tjADGD7Sug26Kvwq1h4jj97Q9BqDTgk+1EYH0EBHKRE6BAgk
	 BuB4FvpY9dei9jR0aWDczFwFf/0EFf/zXd06QzFiYmI8TOXYYKqRj2eyzm2of7Iw/x
	 xxALJycvom98PTzGCRufMpboSpD7BGXxNG/tmX/bmZUNT+HAcie3axY8ZdCgv9YYg3
	 zXKklMCidRSmDoywAbYmAko0tTx7CQWwVYsmTwnp3UrTcZh2xyP/8CODBOCZZaZnKf
	 VNoYe0+k0x8YA==
From: Christian Brauner <brauner@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH] acl: Annotate struct posix_acl with __counted_by()
Date: Wed, 25 Sep 2024 10:00:41 +0200
Message-ID: <20240925-besoldung-befragen-d6a9095c6d88@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240923213809.235128-2-thorsten.blum@linux.dev>
References: <20240923213809.235128-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1158; i=brauner@kernel.org; h=from:subject:message-id; bh=zXEAFz7Q7RoUiIW7ZL5q+2ystQGk8UlUo9zBOm80IOw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR9PqyVEc31UO38yjv7ZLStXe3fGV5MXVO/P0svrr1pZ tbj7rjNHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZ+ZmR4auiYc1JQf0FsjNf 3Zn+onqap37HI35ziQ0m0g6XXi0v38Xwv8y/4s8GOxfp7Ilrdd0v39h9QE8jcuKUB+7i9QumbLn 4hgUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 23 Sep 2024 23:38:05 +0200, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> a_entries to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Use struct_size() to calculate the number of bytes to allocate for new
> and cloned acls and remove the local size variables.
> 
> [...]

Applied to the vfs.misc.v6.13 branch of the vfs/vfs.git tree.
Patches in the vfs.misc.v6.13 branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc.v6.13

[1/1] acl: Annotate struct posix_acl with __counted_by()
      https://git.kernel.org/vfs/vfs/c/822fa32058a8

