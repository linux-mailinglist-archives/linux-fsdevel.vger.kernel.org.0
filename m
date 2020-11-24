Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0032C34AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 00:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388603AbgKXX2R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 18:28:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:37914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388499AbgKXX2R (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 18:28:17 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 213DF2100A;
        Tue, 24 Nov 2020 23:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606260496;
        bh=Oo4Tlzm+6V2f+cAlPJ1FnNFARv4c7gmBZzibGJ+KTPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xe5/qIrgFn//Ktx8T3FzD8iH+OmarHXR72XJec5aY3dKU9ct5j77kLudzv2sZf5oJ
         OGLz2xon5t1SKARHH1Shpa+fH+vE/ro2Dxh4IgiIiXhu9GMsszm9Js/C2MAv2yO0kf
         +eIj3mO0kFqZH0y5k2Aj81/VXm+rLTLYJc0plIV0=
Date:   Tue, 24 Nov 2020 15:28:14 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] fscrypt: prevent creating duplicate encrypted
 filenames
Message-ID: <X72XDv89kSPWCqTQ@sol.localdomain>
References: <20201118075609.120337-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118075609.120337-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 17, 2020 at 11:56:04PM -0800, Eric Biggers wrote:
> This series fixes a longstanding race condition where a duplicate
> filename can be created in an encrypted directory if a syscall that
> creates a new filename (e.g. open() or mkdir()) races with the
> directory's encryption key being added.
> 
> To close this race, we need to prevent creating files if the dentry is
> still marked as a no-key name.  I.e. we need to fail the ->create() (or
> other operation that creates a new filename) if the key wasn't available
> when doing the dentry lookup earlier in the syscall, even if the key was
> concurrently added between the dentry lookup and ->create().
> 
> See patch 1 for a more detailed explanation.
> 
> Patch 1 introduces a helper function required for the fix.  Patches 2-4
> fix the bug on ext4, f2fs, and ubifs.  Patch 5 is a cleanup.
> 
> This fixes xfstest generic/595 on ubifs, but that test was hitting this
> bug only accidentally.  I've also written a new xfstest which reproduces
> this bug on both ext4 and ubifs.
> 
> Eric Biggers (5):
>   fscrypt: add fscrypt_is_nokey_name()
>   ext4: prevent creating duplicate encrypted filenames
>   f2fs: prevent creating duplicate encrypted filenames
>   ubifs: prevent creating duplicate encrypted filenames
>   fscrypt: remove unnecessary calls to fscrypt_require_key()
> 
>  fs/crypto/hooks.c       | 31 +++++++++++--------------------
>  fs/ext4/namei.c         |  3 +++
>  fs/f2fs/f2fs.h          |  2 ++
>  fs/ubifs/dir.c          | 17 +++++++++++++----
>  include/linux/fscrypt.h | 37 +++++++++++++++++++++++++++++++++++--
>  5 files changed, 64 insertions(+), 26 deletions(-)
> 
> 
> base-commit: 3ceb6543e9cf6ed87cc1fbc6f23ca2db903564cd

All applied to fscrypt.git#master for 5.11.

I'd still appreciate acks for ext4, f2fs, and ubifs though.

- Eric
