Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6BB2D07F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 00:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgLFXNJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 18:13:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727350AbgLFXNI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 18:13:08 -0500
Date:   Sun, 6 Dec 2020 15:12:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607296347;
        bh=wRedg1gNvQnfzRd6Sc7Ch4DYbkAvFJu/PD8ZGSHjgdQ=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=p/xjEKdNmYBgu8ertFQ3kUSFZYs3wZW1WKv60D5Oq2w7r1BqLZpkeVCObJviLcO9c
         mn+fdEsig3KRc+N+WZ0ZB3QtuvA/8UBzd+2zhfU/qvEoJzXAgwaJsTSVb4tDD0revn
         FThRM3xGsbpwK/GH4RDGh1eLB6BesQ0OXu28aTHkTl2XK/CIdOnmQT71ogyuIca+Rj
         d/G0x3Gv47eJEDJlnGLra/FTf9tKEYa7heydAUn5gFubAeTAglA/+VFvAulBht2ne/
         khg13oQdPfbl6LqgKhnsG7vNz0V/N69ZbgosskWCY2TNS/me34ryQYoL+20rOBYjIQ
         qJhC9wCHWNrvg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 0/9] Allow deleting files with unsupported encryption
 policy
Message-ID: <X81lWZeMaSHi5gz4@sol.localdomain>
References: <20201203022041.230976-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203022041.230976-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 02, 2020 at 06:20:32PM -0800, Eric Biggers wrote:
> Currently it's impossible to delete files that use an unsupported
> encryption policy, as the kernel will just return an error when
> performing any operation on the top-level encrypted directory, even just
> a path lookup into the directory or opening the directory for readdir.
> 
> It's desirable to return errors for most operations on files that use an
> unsupported encryption policy, but the current behavior is too strict.
> We need to allow enough to delete files, so that people can't be stuck
> with undeletable files when downgrading kernel versions.  That includes
> allowing directories to be listed and allowing dentries to be looked up.
> 
> This series fixes this (on ext4, f2fs, and ubifs) by treating an
> unsupported encryption policy in the same way as "key unavailable" in
> the cases that are required for a recursive delete to work.
> 
> The actual fix is in patch 9, so see that for more details.
> 
> Patches 1-8 are cleanups that prepare for the actual fix by removing
> direct use of fscrypt_get_encryption_info() by filesystems.
> 
> This patchset applies to branch "master" (commit 4a4b8721f1a5) of
> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git.
> 
> Changed since v1:
>   - Made some minor updates to commit messages.
>   - Added Reviewed-by tags.
> 
> Eric Biggers (9):
>   ext4: remove ext4_dir_open()
>   f2fs: remove f2fs_dir_open()
>   ubifs: remove ubifs_dir_open()
>   ext4: don't call fscrypt_get_encryption_info() from dx_show_leaf()
>   fscrypt: introduce fscrypt_prepare_readdir()
>   fscrypt: move body of fscrypt_prepare_setattr() out-of-line
>   fscrypt: move fscrypt_require_key() to fscrypt_private.h
>   fscrypt: unexport fscrypt_get_encryption_info()
>   fscrypt: allow deleting files with unsupported encryption policy
> 
>  fs/crypto/fname.c           |  8 +++-
>  fs/crypto/fscrypt_private.h | 28 ++++++++++++++
>  fs/crypto/hooks.c           | 16 +++++++-
>  fs/crypto/keysetup.c        | 20 ++++++++--
>  fs/crypto/policy.c          | 22 +++++++----
>  fs/ext4/dir.c               | 16 ++------
>  fs/ext4/namei.c             | 10 +----
>  fs/f2fs/dir.c               | 10 +----
>  fs/ubifs/dir.c              | 11 +-----
>  include/linux/fscrypt.h     | 75 +++++++++++++++++++------------------
>  10 files changed, 126 insertions(+), 90 deletions(-)
> 
> 
> base-commit: 4a4b8721f1a5e4b01e45b3153c68d5a1014b25de

All applied to fscrypt.git#master for 5.11.

- Eric
