Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D3922F594
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 18:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgG0QnN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 12:43:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgG0QnN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:43:13 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 584542073E;
        Mon, 27 Jul 2020 16:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595868192;
        bh=WCH9zfyg8tmZ1CDKwMEvUMAMGGTDY/5uLOBdgMEDeOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R6aKlvnwdyjHmrcM++1cTpF4QI1KZKk6ArDU/w7++2I/AKBbnfSS5KX619WzGAKPJ
         1paTP8Uy6DubwHcQksRt0Gm1lV+Kxy/VPtRRHVXW7BOvi5gEiU7/sR5eJG40Vn/7UR
         YHh0Memr/gx3lWSCnXiYRCsI8iA/F9AQYM0APa5A=
Date:   Mon, 27 Jul 2020 09:43:10 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v6 6/7] fscrypt: document inline encryption support
Message-ID: <20200727164310.GD1138@sol.localdomain>
References: <20200724184501.1651378-1-satyat@google.com>
 <20200724184501.1651378-7-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724184501.1651378-7-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 24, 2020 at 06:45:00PM +0000, Satya Tangirala wrote:
> Update the fscrypt documentation file for inline encryption support.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> Reviewed-by: Eric Biggers <ebiggers@google.com>
> Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  Documentation/filesystems/fscrypt.rst | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
> index 1a6ad6f736b5..423c5a0daf45 100644
> --- a/Documentation/filesystems/fscrypt.rst
> +++ b/Documentation/filesystems/fscrypt.rst
> @@ -1204,6 +1204,18 @@ buffer.  Some filesystems, such as UBIFS, already use temporary
>  buffers regardless of encryption.  Other filesystems, such as ext4 and
>  F2FS, have to allocate bounce pages specially for encryption.
>  
> +Fscrypt is also able to use inline encryption hardware instead of the
> +kernel crypto API for en/decryption of file contents.  When possible,
> +and if directed to do so (by specifying the 'inlinecrypt' mount option
> +for an ext4/F2FS filesystem), it adds encryption contexts to bios and
> +uses blk-crypto to perform the en/decryption instead of making use of
> +the above read/write path changes.  Of course, even if directed to
> +make use of inline encryption, fscrypt will only be able to do so if
> +either hardware inline encryption support is available for the
> +selected encryption algorithm or CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK
> +is selected.  If neither is the case, fscrypt will fall back to using
> +the above mentioned read/write path changes for en/decryption.
> +
>  Filename hashing and encoding
>  -----------------------------
>  
> @@ -1250,7 +1262,9 @@ Tests
>  
>  To test fscrypt, use xfstests, which is Linux's de facto standard
>  filesystem test suite.  First, run all the tests in the "encrypt"
> -group on the relevant filesystem(s).  For example, to test ext4 and
> +group on the relevant filesystem(s).  One can also run the tests
> +with the 'inlinecrypt' mount option to test the implementation for
> +inline encryption support.  For example, to test ext4 and
>  f2fs encryption using `kvm-xfstests
>  <https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md>`_::

Since this patch is separate from the direct I/O support, I've applied it to
fscrypt.git#master for 5.9.  I'm not applying the direct I/O patches yet.

- Eric
