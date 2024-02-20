Return-Path: <linux-fsdevel+bounces-12104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F376E85B4F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3223E1C22301
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 08:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745925C61D;
	Tue, 20 Feb 2024 08:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9M93ogO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE46A5C022;
	Tue, 20 Feb 2024 08:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417484; cv=none; b=Eyl66Fisabfm8hNhyBvYoSW8cS52mA6oHsvW0cq7EBjr0MdmqwcZ7yU5/6ZyEIkjNiKzZeSfHxjxujySX8G3Au4evv5Rny1lXMinEkbX7I3B3oNNe6AXfda31kFNF9BGrjf2KS8ucT3a0n+f1LhR46oGBxlE5yJyJZxXnHBsXaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417484; c=relaxed/simple;
	bh=3hVYHf7Y4dd6cy7p1+tAVMfMvbeuxapCRgGgam5sYQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUokyuR2sWt7diwOgiABaIGIdMjlTR+95gZllz5yVf3LWGm7mkyZ8lqwmgXpndM0cr6HdY+KBLPcev/kYJOYCv1HdE7mmiSsRAALRh1TZytJSwyZUZweuk7Q8rNf8DdFBsEyrpWq+r/n+E7FvljmyyH42zTo+VtNnRjJQ7JjBSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9M93ogO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE73C433C7;
	Tue, 20 Feb 2024 08:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708417484;
	bh=3hVYHf7Y4dd6cy7p1+tAVMfMvbeuxapCRgGgam5sYQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D9M93ogOKn3KBccye1S4fOuvNKvmKo0j2HvsvZQkA7VQAdWkIi0go7PFCbqyBZP9l
	 7rWt75MK73lSg+Z/g+BVVIA0llRqZmcxMuzp4ppa/wHiihrUxOpDRPVi8RkCdrJnX7
	 5I7TdRuraVqxyCjoB00sZRtjs6IxdU4/o7zPFBjQn5jJshenkgBfA36ZTkY4bNwZvr
	 unQ0N2gWQE9WXk6QLa19CMzFFqbeFtmWDWj3gSRG/8ULNHFCtivRB5w5dyrogeh1vy
	 WpxKCU0N9biDkOxn6OnjJ5WfrP21cY4BSk5vaWf5Tt+oKr/YYTWY/xiX4xG84FDe8A
	 TJ2dxuGDkglVw==
From: Christian Brauner <brauner@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andi Kleen <ak@linux.intel.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs/select: rework stack allocation hack for clang
Date: Tue, 20 Feb 2024 09:24:35 +0100
Message-ID: <20240220-geortet-nordlicht-0abe19f356e7@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216202352.2492798-1-arnd@kernel.org>
References: <20240216202352.2492798-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1298; i=brauner@kernel.org; h=from:subject:message-id; bh=3hVYHf7Y4dd6cy7p1+tAVMfMvbeuxapCRgGgam5sYQc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaReSTyiUHLVcH3Gk4+8t2Zf/8FT5b7yRfvGCYUZS4LYT j6tfPjaoqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiv5QZ/rs3Os//opi96M5a /r3lVRfTX259334n77+m9u5faXaf7tsz/E/rb3RdyqJcc5hnibL6M6EW+TclKTsTElZftp3D+pJ hLRcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 16 Feb 2024 21:23:34 +0100, Arnd Bergmann wrote:
> A while ago, we changed the way that select() and poll() preallocate
> a temporary buffer just under the size of the static warning limit of
> 1024 bytes, as clang was frequently going slightly above that limit.
> 
> The warnings have recently returned and I took another look. As it turns
> out, clang is not actually inherently worse at reserving stack space,
> it just happens to inline do_select() into core_sys_select(), while gcc
> never inlines it.
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

[1/1] fs/select: rework stack allocation hack for clang
      https://git.kernel.org/vfs/vfs/c/f3dd8c812c24

