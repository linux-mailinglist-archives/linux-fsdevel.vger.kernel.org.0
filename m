Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82EE31E11D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 17:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404200AbgEYPdf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 11:33:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404092AbgEYPdf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 11:33:35 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D41B2071A;
        Mon, 25 May 2020 15:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590420814;
        bh=/lRcApMN9bchgxQmdRuHru0M8nV62fiOyAvgNyyKOqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FkSvkKrkHrQNmOS5J/o9VjrQqOrK15S4n8hbD/X0fyIUhr7F42waBhGQOqj/6HAJx
         tyzcpYbp9yyCxo7RvSbHabJpYOQEmcyfJ+E1oVol2cFd97D1c/VRNotZIGgME0uUKv
         pVg9kv2JyeNisFfbKjtrNkuNbJM87euAu3sXNQ6I=
Date:   Mon, 25 May 2020 08:33:20 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-mmc@vger.kernel.org, "Theodore Y . Ts'o" <tytso@mit.edu>,
        Satya Tangirala <satyat@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Paul Crowley <paulcrowley@google.com>
Subject: Re: [PATCH] fscrypt: add support for IV_INO_LBLK_32 policies
Message-ID: <20200525153320.GA2152@sol.localdomain>
References: <20200515204141.251098-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515204141.251098-1-ebiggers@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 01:41:41PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The eMMC inline crypto standard will only specify 32 DUN bits (a.k.a. IV
> bits), unlike UFS's 64.  IV_INO_LBLK_64 is therefore not applicable, but
> an encryption format which uses one key per policy and permits the
> moving of encrypted file contents (as f2fs's garbage collector requires)
> is still desirable.
> 
> To support such hardware, add a new encryption format IV_INO_LBLK_32
> that makes the best use of the 32 bits: the IV is set to
> 'SipHash-2-4(inode_number) + file_logical_block_number mod 2^32', where
> the SipHash key is derived from the fscrypt master key.  We hash only
> the inode number and not also the block number, because we need to
> maintain contiguity of DUNs to merge bios.
> 
> Unlike with IV_INO_LBLK_64, with this format IV reuse is possible; this
> is unavoidable given the size of the DUN.  This means this format should
> only be used where the requirements of the first paragraph apply.
> However, the hash spreads out the IVs in the whole usable range, and the
> use of a keyed hash makes it difficult for an attacker to determine
> which files use which IVs.
> 
> Besides the above differences, this flag works like IV_INO_LBLK_64 in
> that on ext4 it is only allowed if the stable_inodes feature has been
> enabled to prevent inode numbers and the filesystem UUID from changing.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  Documentation/filesystems/fscrypt.rst | 33 +++++++++--
>  fs/crypto/crypto.c                    |  6 +-
>  fs/crypto/fscrypt_private.h           | 20 +++++--
>  fs/crypto/keyring.c                   |  5 +-
>  fs/crypto/keysetup.c                  | 85 +++++++++++++++++++++------
>  fs/crypto/policy.c                    | 51 +++++++++++-----
>  include/uapi/linux/fscrypt.h          |  3 +-
>  7 files changed, 157 insertions(+), 46 deletions(-)

Applied to fscrypt.git#master for 5.8.

- Eric
