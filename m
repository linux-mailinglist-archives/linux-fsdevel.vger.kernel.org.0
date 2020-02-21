Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C63F1684A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 18:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgBURQU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 12:16:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:35108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgBURQT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:16:19 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FE1120722;
        Fri, 21 Feb 2020 17:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582305378;
        bh=f7XISsFA2QC0w/nx2FlF5io26u2rX8x02+f2m36Terk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NUMgltUN0yBYHaOQ/aFBIrwhAcNKwA/PidYmHPX0ru5LvhjorfIwbqZOol1EvfYsK
         VeORKw1WbgCjocqzfsl5wqb+sEO7waw35VMZot7+g7pVbI6jCVMTJXOrV3suKf89Oc
         nc/Eio5QXHdx2IMwppF5L+NMMmWr8d73CkTSTRFA=
Date:   Fri, 21 Feb 2020 09:16:17 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v7 0/9] Inline Encryption Support
Message-ID: <20200221171617.GA925@sol.localdomain>
References: <20200221115050.238976-1-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221115050.238976-1-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 03:50:41AM -0800, Satya Tangirala wrote:
> This patch series adds support for Inline Encryption to the block layer,
> UFS, fscrypt, f2fs and ext4.
[...]
> Changes v6 => v7:
>  - Keyslot management is now done on a per-request basis rather than a
>    per-bio basis.
>  - Storage drivers can now specify the maximum number of bytes they
>    can accept for the data unit number (DUN) for each crypto algorithm,
>    and upper layers can specify the minimum number of bytes of DUN they
>    want with the blk_crypto_key they send with the bio - a driver is
>    only considered to support a blk_crypto_key if the driver supports at
>    least as many DUN bytes as the upper layer wants. This is necessary
>    because storage drivers may not support as many bytes as the
>    algorithm specification dictates (for e.g. UFS only supports 8 byte
>    DUNs for AES-256-XTS, even though the algorithm specification
>    says DUNs are 16 bytes long).
>  - Introduce SB_INLINECRYPT to keep track of whether inline encryption
>    is enabled for a filesystem (instead of using an fscrypt_operation).
>  - Expose keyslot manager declaration and embed it within ufs_hba to
>    clean up code.
>  - Make blk-crypto preclude blk-integrity.
>  - Some bug fixes
>  - Introduce UFSHCD_QUIRK_BROKEN_CRYPTO for UFS drivers that don't
>    support inline encryption (yet)

This patchset can also be retrieved from

	Repo: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
	Tag: inline-encryption-v7

For review purposes I also created a tag
inline-encryption-v6-rebased-onto-v7-base which is the v6 patchset rebased onto
the same base commit (v5.6-rc2).  So it's possible to see what changed by

	git diff inline-encryption-v6-rebased-onto-v7-base..inline-encryption-v7

(Although, I had to resolve conflicts in fs/crypto/ to do the rebase, so it's
not *exactly* v6.)

- Eric
