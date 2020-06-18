Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89ADB1FFE56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 00:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbgFRWuM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 18:50:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728932AbgFRWuM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 18:50:12 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56F5220720;
        Thu, 18 Jun 2020 22:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592520611;
        bh=HYGod6h7F0uGZKxft0EPpj5IScO/V7jm1M/teBNdy6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L+1dinT/55/j1xVvfBjHT5Et+P7+8KZg4YS557H8LYrg195s8hd/bYt7q+cQL6ZeO
         zlEj41LEnzrCKAAZ0yeGfyZbsTZY5xWsQemwiJN0ywf0k+qS4Mj4zfUXpiFe+wuBrG
         vLVCAVzIkptKANY2O81F1qNWTAD3JJQ4Bwcjs+OQ=
Date:   Thu, 18 Jun 2020 15:50:09 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/4] f2fs: add inline encryption support
Message-ID: <20200618225009.GA35732@gmail.com>
References: <20200617075732.213198-1-satyat@google.com>
 <20200617075732.213198-4-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617075732.213198-4-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 17, 2020 at 07:57:31AM +0000, Satya Tangirala wrote:
> Wire up f2fs to support inline encryption via the helper functions which
> fs/crypto/ now provides.  This includes:
> 
> - Adding a mount option 'inlinecrypt' which enables inline encryption
>   on encrypted files where it can be used.
> 
> - Setting the bio_crypt_ctx on bios that will be submitted to an
>   inline-encrypted file.
> 
> - Not adding logically discontiguous data to bios that will be submitted
>   to an inline-encrypted file.
> 
> - Not doing filesystem-layer crypto on inline-encrypted files.
> 
> This patch includes a fix for a race during IPU by
> Sahitya Tummala <stummala@codeaurora.org>
> 
> Co-developed-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  Documentation/filesystems/f2fs.rst |  7 ++-
>  fs/f2fs/compress.c                 |  2 +-
>  fs/f2fs/data.c                     | 81 ++++++++++++++++++++++++------
>  fs/f2fs/super.c                    | 32 ++++++++++++
>  4 files changed, 104 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index 099d45ac8d8f..4dc36143ff82 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -258,7 +258,12 @@ compress_extension=%s  Support adding specified extension, so that f2fs can enab
>                         on compression extension list and enable compression on
>                         these file by default rather than to enable it via ioctl.
>                         For other files, we can still enable compression via ioctl.
> -====================== ============================================================

The above line being deleted marks the end of a table, so it shouldn't be
deleted (it should go after the part below).

> +inlinecrypt
> +                       Encrypt/decrypt the contents of encrypted files using the
> +                       blk-crypto framework rather than filesystem-layer encryption.
> +                       This allows the use of inline encryption hardware. The on-disk
> +                       format is unaffected. For more details, see
> +                       Documentation/block/inline-encryption.rst.

Like I commented on one of the commit messages -- this doesn't make it clear
what happens in cases where blk-crypto can't be used.  Maybe just replace:
"Encrypt/decrypt" => "When possible, encrypt/decrypt".

Likewise for the ext4 documentation for this same mount option.

- Eric
