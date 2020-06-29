Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD1820DD72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 23:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgF2Syh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 14:54:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728084AbgF2SxW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:53:22 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1E37204EC;
        Mon, 29 Jun 2020 18:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593456802;
        bh=W1gAL231GdpfTzeSawMbnT+/vhlibbLVm5O4BlAr+To=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gKjmzYSiQ96d+bPzFXbNs1Z1D7M6nBioD7k2Kk8wAD8D1sdT0KwrP+7dRymuowCMk
         W1GS85/L4li6HodUiqTV1+eyHgI6f+hLnjoWdVc8se4XffmDaW3gEVcjeX4I5DiRhT
         ryu6Fs1b9zJdpFPcejncKZrU0eIuvxpXWkQEFnC8=
Date:   Mon, 29 Jun 2020 11:53:20 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2 3/4] f2fs: add inline encryption support
Message-ID: <20200629185320.GH20492@sol.localdomain>
References: <20200629120405.701023-1-satyat@google.com>
 <20200629120405.701023-4-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629120405.701023-4-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 29, 2020 at 12:04:04PM +0000, Satya Tangirala via Linux-f2fs-devel wrote:
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
> Acked-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Eric Biggers <ebiggers@google.com>

> ---
>  Documentation/filesystems/f2fs.rst |  7 +++
>  fs/f2fs/compress.c                 |  2 +-
>  fs/f2fs/data.c                     | 78 +++++++++++++++++++++++++-----
>  fs/f2fs/super.c                    | 35 ++++++++++++++
>  4 files changed, 108 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index 099d45ac8d8f..8b4fac44f4e1 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -258,6 +258,13 @@ compress_extension=%s  Support adding specified extension, so that f2fs can enab
>                         on compression extension list and enable compression on
>                         these file by default rather than to enable it via ioctl.
>                         For other files, we can still enable compression via ioctl.
> +inlinecrypt
> +                       When possible, encrypt/decrypt the contents of encrypted
> +                       files using the blk-crypto framework rather than
> +                       filesystem-layer encryption. This allows the use of
> +                       inline encryption hardware. The on-disk format is
> +                       unaffected. For more details, see
> +                       Documentation/block/inline-encryption.rst.
>  ====================== ============================================================

Last time I suggested adding "When possible, ", and it got added here but not in
the ext4 patch.  It should go in both.

- Eric
