Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43A7F127566
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 06:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfLTFoq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 00:44:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:42328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbfLTFop (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 00:44:45 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B84421D7D;
        Fri, 20 Dec 2019 05:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576820684;
        bh=crWqBTWcrWs9Yhos0lMvcsdeK71eAsUMhrzRN5VLDls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u6bqa5Kiip/6ahbVT5hOuKU19IdN56g9JWtYUfZRTIdrzvnzQyWxjrEXkPz44EwhT
         Jw/r2SBBnmrvnIDAHniEUcNRDJ69m9srW0I5RVFhFCeFWhf/ohypkp+qEGNA49Irq+
         AyDqbRmxX3j6GLIi/aUxl3jSe7NM5UP1WNAfMIjM=
Date:   Thu, 19 Dec 2019 21:44:43 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 6/9] scsi: ufs: Add inline encryption support to UFS
Message-ID: <20191220054443.GF718@sol.localdomain>
References: <20191218145136.172774-1-satyat@google.com>
 <20191218145136.172774-7-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218145136.172774-7-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 06:51:33AM -0800, Satya Tangirala wrote:
> Wire up ufshcd.c with the UFS Crypto API, the block layer inline
> encryption additions and the keyslot manager.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  drivers/scsi/ufs/ufshcd-crypto.c | 30 ++++++++++++++++++
>  drivers/scsi/ufs/ufshcd-crypto.h | 21 +++++++++++++
>  drivers/scsi/ufs/ufshcd.c        | 54 +++++++++++++++++++++++++++++---
>  drivers/scsi/ufs/ufshcd.h        |  8 +++++
>  4 files changed, 108 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd-crypto.c b/drivers/scsi/ufs/ufshcd-crypto.c
> index b0aa072d9009..749c325686a7 100644
> --- a/drivers/scsi/ufs/ufshcd-crypto.c
> +++ b/drivers/scsi/ufs/ufshcd-crypto.c
> @@ -352,6 +352,36 @@ void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
>  }
>  EXPORT_SYMBOL_GPL(ufshcd_crypto_setup_rq_keyslot_manager);
>  
> +int ufshcd_prepare_lrbp_crypto(struct ufs_hba *hba,
> +			       struct scsi_cmnd *cmd,
> +			       struct ufshcd_lrb *lrbp)
> +{
> +	struct bio_crypt_ctx *bc;
> +
> +	if (!bio_crypt_should_process(cmd->request)) {
> +		lrbp->crypto_enable = false;
> +		return 0;
> +	}
> +	bc = cmd->request->bio->bi_crypt_context;
> +
> +	if (WARN_ON(!ufshcd_is_crypto_enabled(hba))) {
> +		/*
> +		 * Upper layer asked us to do inline encryption
> +		 * but that isn't enabled, so we fail this request.
> +		 */
> +		return -EINVAL;
> +	}
> +	if (!ufshcd_keyslot_valid(hba, bc->bc_keyslot))
> +		return -EINVAL;
> +
> +	lrbp->crypto_enable = true;
> +	lrbp->crypto_key_slot = bc->bc_keyslot;
> +	lrbp->data_unit_num = bc->bc_dun[0];
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ufshcd_prepare_lrbp_crypto);

The UFS driver only uses the first 64 bits of the DUN, but in this version of
the patchset the DUN in the bio_crypt_ctx can be up to the real length of the
algorithm's IV -- which for AES-256-XTS is 128 bits.  So if the user were to
specify anything nonzero in bits 64-127, the crypto would be done incorrectly.

(This case isn't encountered with fscrypt.  But it's still an issue with the
overall approach.)

So there needs to be a way for drivers to declare the max_dun_size they support,
and prevent them from being used with longer DUNs.

- Eric
