Return-Path: <linux-fsdevel+bounces-19899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BF38CB06F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 16:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C461F22BDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 14:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D53130481;
	Tue, 21 May 2024 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y90ecRCg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABA212FF91;
	Tue, 21 May 2024 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301667; cv=none; b=tJcy3d86sF876lf6t3YVPvCr7dzQ13UtNv2p6zplbgiGK8dl9n60dPZEMt3+sGRu1/zcbkcrs2/UWXkSwJSeiXtdosmV5tSktAlZnTRThGL4VMZYFVk1YbOIYnA9Q7kgFj1nKx/E5ghWomaC5zaD+/57yr7v4JsDc1ABvzi0BzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301667; c=relaxed/simple;
	bh=N0cM3yxnHhctCSdjxbIjzQRvpL3SVaCTMfYfSYckKMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOX0V3PuTMHSf9vL2WFdNdNXho1eHN7KJZp3fIUeF1k0srtU2o8faNuqeTtyQWIXGOqe0O86wWaE2WF6IkHVkCEmtvp4IFh2hywf191G2joV78dsUwpj6foJvicogEyfakY1gdyOCF372NaI/uBGvN4RI4VcNFuKl9h/KzMHjcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y90ecRCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9287CC2BD11;
	Tue, 21 May 2024 14:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716301667;
	bh=N0cM3yxnHhctCSdjxbIjzQRvpL3SVaCTMfYfSYckKMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y90ecRCg3gZjCzCB3pUZ/OESTWKCiQ2XZ2dZ5hC7U+Z6nyhFbCg7qStWUjaC5HH/4
	 EOytmejLfW1WpSGaV74JHScIuN2h9Mi5dCBa+1pFssdOGZJjwPN8nOKH9iwPavOULs
	 EQ06xY10pvhxDAsCkaBoJvjFYNKoQ2A9OyahmTxspSm4pzjTb5MZHyTwinrW3Za3ui
	 pZ2C9Eha9+eX4hbkaFYgGGLERnzgAxosmKEuSP2ZSjaDJi/Bh2kch2g3XibU9xWkr2
	 rvGKZvpDFfHAEz5+YnJ7RTFDQjjU8a6WG3z3ERjJwuGWSVLIGaqphGMalG/uZBJvFc
	 /FQUmp1ZmT35w==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: switch timespec64 fields in inode to discrete integers
Date: Tue, 21 May 2024 16:27:10 +0200
Message-ID: <20240521-unwiederholbar-stelzen-84e3769c4349@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240517-amtime-v1-1-7b804ca4be8f@kernel.org>
References: <20240517-amtime-v1-1-7b804ca4be8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1458; i=brauner@kernel.org; h=from:subject:message-id; bh=N0cM3yxnHhctCSdjxbIjzQRvpL3SVaCTMfYfSYckKMA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT5rI/e/OZx3abalri8R2mNOyrnL9csmDb7VHXY9Yl2f zTee1Zv7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIxtuMDJ0+VsZnFyc7csvZ 3xHni/Zp/5BzL/mgrm55rKBDcFbcZYb/mee1BUK2G/bZyv6MUbJv3/H1x4TlD7b1lZ376/jzm4A KPwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 17 May 2024 20:08:40 -0400, Jeff Layton wrote:
> Adjacent struct timespec64's pack poorly. Switch them to discrete
> integer fields for the seconds and nanoseconds. This shaves 8 bytes off
> struct inode with a garden-variety Fedora Kconfig on x86_64, but that
> also moves the i_lock into the previous cacheline, away from the fields
> it protects.
> 
> To remedy that, move i_generation above the i_lock, which moves the new
> 4-byte hole to just after the i_fsnotify_mask in my setup. Amir has
> plans to use that to expand the i_fsnotify_mask, so add a comment to
> that effect as well.
> 
> [...]

Let's see what the performance bot thing has to say...

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

[1/1] fs: switch timespec64 fields in inode to discrete integers
      https://git.kernel.org/vfs/vfs/c/ad401d976810

