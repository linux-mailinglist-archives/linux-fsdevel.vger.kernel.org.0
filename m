Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40675F204B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2019 22:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfKFVEg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Nov 2019 16:04:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727351AbfKFVEg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Nov 2019 16:04:36 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D4E020663;
        Wed,  6 Nov 2019 21:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573074274;
        bh=gjl0DiLR6wZlVim/nV2ye21G7PfWS65h/U6LfKQDhOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ar8VeiM8q2OQT8IoJYh3V+TV427A/Ul9oo2Nc+bBlNFftOaldwb8dJEju6gXLLTK/
         c5jxp1YbNtAI2dpDUDyh2rsJ6O/CA8ifSHEB7Cem82mpMWsqXgP77/aM3UnnzJ9dOF
         8vWJsJMWS7Rj2CGh8Qbh4EcGZaPviVhm4mbJmIo0=
Date:   Wed, 6 Nov 2019 13:04:33 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Satya Tangirala <satyat@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-ext4@vger.kernel.org, Paul Crowley <paulcrowley@google.com>
Subject: Re: [PATCH v2 0/3] fscrypt: support for IV_INO_LBLK_64 policies
Message-ID: <20191106210432.GB139580@gmail.com>
Mail-Followup-To: linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Satya Tangirala <satyat@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-ext4@vger.kernel.org, Paul Crowley <paulcrowley@google.com>
References: <20191024215438.138489-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024215438.138489-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 24, 2019 at 02:54:35PM -0700, Eric Biggers wrote:
> Hello,
> 
> In preparation for adding inline encryption support to fscrypt, this
> patchset adds a new fscrypt policy flag which modifies the encryption to
> be optimized for inline encryption hardware compliant with the UFS v2.1
> standard or the upcoming version of the eMMC standard.
> 
> This means using per-mode keys instead of per-file keys, and in
> compensation including the inode number in the IVs.  For ext4, this
> precludes filesystem shrinking, so I've also added a compat feature
> which will prevent the filesystem from being shrunk.
> 
> I've separated this from the full "Inline Encryption Support" patchset
> (https://lkml.kernel.org/linux-fsdevel/20190821075714.65140-1-satyat@google.com/)
> to avoid conflating an implementation (inline encryption) with a new
> on-disk format (IV_INO_LBLK_64).  This patchset purely adds support for
> IV_INO_LBLK_64 policies to fscrypt, but implements them using the
> existing filesystem layer crypto.
> 
> We're planning to make the *implementation* (filesystem layer or inline
> crypto) be controlled by a mount option '-o inlinecrypt'.
> 
> This patchset applies to fscrypt.git#master and can also be retrieved from
> https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=inline-crypt-optimized-v2
> 
> I've written a ciphertext verification test for this new type of policy:
> https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/xfstests-dev.git/log/?h=inline-encryption
> 
> Work-in-progress patches for the inline encryption implementation of
> both IV_INO_LBLK_64 and regular policies can be found at
> https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=inline-encryption-wip
> 
> Changes v1 => v2:
> 
> - Rename the flag from INLINE_CRYPT_OPTIMIZED to IV_INO_LBLK_64.
> 
> - Use the same key derivation and IV generation scheme for filenames
>   encryption too.
> 
> - Improve the documentation and commit messages.
> 
> Eric Biggers (3):
>   fscrypt: add support for IV_INO_LBLK_64 policies
>   ext4: add support for IV_INO_LBLK_64 encryption policies
>   f2fs: add support for IV_INO_LBLK_64 encryption policies
> 
>  Documentation/filesystems/fscrypt.rst | 63 +++++++++++++++++----------
>  fs/crypto/crypto.c                    | 10 ++++-
>  fs/crypto/fscrypt_private.h           | 16 +++++--
>  fs/crypto/keyring.c                   |  6 ++-
>  fs/crypto/keysetup.c                  | 45 ++++++++++++++-----
>  fs/crypto/policy.c                    | 41 ++++++++++++++++-
>  fs/ext4/ext4.h                        |  2 +
>  fs/ext4/super.c                       | 14 ++++++
>  fs/f2fs/super.c                       | 26 ++++++++---
>  include/linux/fscrypt.h               |  3 ++
>  include/uapi/linux/fscrypt.h          |  3 +-
>  11 files changed, 182 insertions(+), 47 deletions(-)
> 
> -- 

Applied to fscrypt.git#master for 5.5.

- Eric
