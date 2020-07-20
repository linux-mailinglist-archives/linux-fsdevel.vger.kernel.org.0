Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A5E226F17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 21:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgGTTez (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 15:34:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgGTTez (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 15:34:55 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F190F207DF;
        Mon, 20 Jul 2020 19:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595273695;
        bh=gvoR90bmjWKLI6StivijfjivWNaNOvpnS43HZMXXkI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0ECqOAP5qntFeHvHP3rCgmLeWZmcRzkVpjPjpKKX7kc222b4dMmX7dKOhC4k0q20s
         s+qvigsG3jg0HwEhIG6q2zoyS//842FNc1Fb7Fh45OW6uxRqipMEFAIlYpdpg0AwOE
         edNygX41zP00UlndM2ZspUciOB1QqJ7lXDZa41AQ=
Date:   Mon, 20 Jul 2020 12:34:53 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 6/7] fscrypt: document inline encryption support
Message-ID: <20200720193453.GH1292162@gmail.com>
References: <20200717014540.71515-1-satyat@google.com>
 <20200717014540.71515-7-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717014540.71515-7-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 01:45:39AM +0000, Satya Tangirala wrote:
> Update the fscrypt documentation file for inline encryption support.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>

Reviewed-by: Eric Biggers <ebiggers@google.com>

> diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
> index f5d8b0303ddf..f3d87a1a0a7f 100644
> --- a/Documentation/filesystems/fscrypt.rst
> +++ b/Documentation/filesystems/fscrypt.rst
> @@ -1204,6 +1204,18 @@ buffer.  Some filesystems, such as UBIFS, already use temporary
>  buffers regardless of encryption.  Other filesystems, such as ext4 and
>  F2FS, have to allocate bounce pages specially for encryption.
>  
> +Fscrypt is also able to use inline encryption hardware instead of the
> +kernel crypto API for en/decryption of file contents.  When possible, and
> +if directed to do so (by specifying the 'inlinecrypt' mount option for
> +an ext4/F2FS filesystem), it adds encryption contexts to bios and
> +uses blk-crypto to perform the en/decryption instead of making use
> +of the above read/write path changes.  Of course, even if directed to make
> +use of inline encryption, fscrypt will only be able to do so if either
> +hardware inline encryption support is available for the selected encryption
> +algorithm or CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK is selected.  If neither
> +is the case, fscrypt will fall back to using the above mentioned read/write
> +path changes for en/decryption.
> +

Nit: most of the text in this file is formatted with textwidth=70.

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
>  
> -- 
> 2.28.0.rc0.105.gf9edc3c819-goog
> 
