Return-Path: <linux-fsdevel+bounces-42638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7565A45809
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8594B1883EC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7FA1DFD89;
	Wed, 26 Feb 2025 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkFDUxgG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0000746426;
	Wed, 26 Feb 2025 08:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558209; cv=none; b=alh70Me89YsUNDqNOwDC3MyP0doHDZKv4NmIm6tjoOGNQZjnzirOkyy7UNSk6YYI3Wc+M3obKtxX6i9n7LROk51Wz2Hm9JAtp0ehcR6lbqUxu39+qe8ZWZvN5jAU3gnycFP8xwyexpRuxB8CDBJDp8nrx8DlT59yOVua+nyhIWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558209; c=relaxed/simple;
	bh=S88eGtK7YJQAfqBg/oeH1gGqR1u+4gInkzJEGHDIRJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Heh1KZMx1C9lx0oCiUOAsVz649ZG72Pm1MApPpEZLSkE5vmhJWSadhoXAblug/HovuG50rINnImOGxibau9Z0Z31M1SpnLzXqB760yvQlq5krfoRF5ODTQfYy/f7/5oWK/wENYQkvvVc0Ma7U8Ki3q8rF/PqG8PfJSPZ0vt+6z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkFDUxgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0168C4CED6;
	Wed, 26 Feb 2025 08:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740558208;
	bh=S88eGtK7YJQAfqBg/oeH1gGqR1u+4gInkzJEGHDIRJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bkFDUxgGc+NrDSYqceFZEAA2/uz5VSXXYivgojqrGCd0GV6Mn8E6ppMUA3RTQ5lLQ
	 wMVWcCscJCzpSdSiRuPShEZJgBL0fPYKvItVuosvAx9v2yYcEIGWHeCwqEPLpdpYbp
	 KkMXYocXmU/yiwNukYqXr6zuygTV3nbQcm1cdvRXBJAeINx+Ql9k+53mi9yKxAPYiw
	 xhPsPBufrN1H8W8wLm49rH1o9PaQLxdZplpq6J8I8difis7S7eOGo6294VcNuTidh8
	 qlE1VSTdFfK8zy7JOKC8T7TtuS+1/owLYllajK1K3yEtnKmkKVzQBIwRTMWJDfR6v+
	 ZKNbS3LfIkOZg==
From: Christian Brauner <brauner@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jan Kara <jack@suse.cz>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>,
	"Seth Forshee (DigitalOcean)" <sforshee@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] fs: namespace: fix uninitialized variable use
Date: Wed, 26 Feb 2025 09:23:11 +0100
Message-ID: <20250226-wohlgefallen-kennwort-f82a7c042ab6@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250226081201.1876195-1-arnd@kernel.org>
References: <20250226081201.1876195-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1688; i=brauner@kernel.org; h=from:subject:message-id; bh=S88eGtK7YJQAfqBg/oeH1gGqR1u+4gInkzJEGHDIRJc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTvO1/BeuS43PlK5+1t0oavUiVVb89s2xJ1a9bjtY9cJ 9WeXaGo01HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRRitGhrthm3ILNfkq3DXl Wy5GCq8OrU/9uPPPaaOdXmfFLsrY/WL4n1N4f7V5Qv19297PAtbiu4uXpAj9/746eZlF2cKpe1c o8QIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 26 Feb 2025 09:11:54 +0100, Arnd Bergmann wrote:
> clang correctly notices that the 'uflags' variable initialization
> only happens in some cases:
> 
> fs/namespace.c:4622:6: error: variable 'uflags' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>  4622 |         if (flags & MOVE_MOUNT_F_EMPTY_PATH)    uflags = AT_EMPTY_PATH;
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> fs/namespace.c:4623:48: note: uninitialized use occurs here
>  4623 |         from_name = getname_maybe_null(from_pathname, uflags);
>       |                                                       ^~~~~~
> fs/namespace.c:4622:2: note: remove the 'if' if its condition is always true
>  4622 |         if (flags & MOVE_MOUNT_F_EMPTY_PATH)    uflags = AT_EMPTY_PATH;
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to the vfs-6.15.mount.namespace branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.mount.namespace branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.mount.namespace

[1/1] fs: namespace: fix uninitialized variable use
      https://git.kernel.org/vfs/vfs/c/980512134163

