Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8371274CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 05:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfLTEsl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 23:48:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:53104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbfLTEsl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 23:48:41 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE98624680;
        Fri, 20 Dec 2019 04:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576817320;
        bh=JG9lA6TKxyPsQrVZPp69bCwvWZBiXcOFmTMqWztJ2MI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FlfVl8k5h5A+pN0Rd73Jym68ICrvv5/gzvjdKHAZ81xLao5L19ZMM080e9HpgkFtF
         Y9qHpiDIQchO8s19CxgxgVn+xkynNfO41KHYC3Tyl0D4gj09rYMGuQNYjqCIMbFG6C
         ft8Tdz8/nGcBIPoXD1tl6uAOj9d0JG/XGhhpWqbs=
Date:   Thu, 19 Dec 2019 20:48:38 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 5/9] scsi: ufs: UFS crypto API
Message-ID: <20191220044838.GD718@sol.localdomain>
References: <20191218145136.172774-1-satyat@google.com>
 <20191218145136.172774-6-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218145136.172774-6-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 06:51:32AM -0800, Satya Tangirala wrote:
> +/**
> + * ufshcd_hba_init_crypto - Read crypto capabilities, init crypto fields in hba
> + * @hba: Per adapter instance
> + *
> + * Return: 0 if crypto was initialized or is not supported, else a -errno value.
> + */
> +int ufshcd_hba_init_crypto(struct ufs_hba *hba)
> +{
> +	int cap_idx = 0;
> +	int err = 0;
> +	unsigned int crypto_modes_supported[BLK_ENCRYPTION_MODE_MAX];
> +	enum blk_crypto_mode_num blk_mode_num;
> +
> +	/* Default to disabling crypto */
> +	hba->caps &= ~UFSHCD_CAP_CRYPTO;
> +
> +	/* Return 0 if crypto support isn't present */
> +	if (!(hba->capabilities & MASK_CRYPTO_SUPPORT))
> +		goto out;
> +

Note that unfortunately, this patch doesn't work yet on some UFS host
controllers that claim to support the UFS standard crypto, due to issues like
deviations from the UFS standard and missing device tree changes -- and this can
even cause boot-time crashes.

So if we can't fix everything right away (which can be really hard without help
from the relevant vendor) I think we have to define a bit
UFSHCD_QUIRK_BROKEN_CRYPTO in ufs_hba::quirks which can be set on host
controllers where the proper tricks to get the crypto working correctly haven't
been figured out yet.  The crypto support would be ignored if that bit is set.

- Eric
