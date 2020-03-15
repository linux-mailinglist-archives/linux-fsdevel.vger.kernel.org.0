Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 892A3185F1F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 19:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgCOSi5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Mar 2020 14:38:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbgCOSi5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Mar 2020 14:38:57 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1F23206B1;
        Sun, 15 Mar 2020 18:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584297536;
        bh=yUyEe7jl1Hda7My1Plde2EvqqY+GsrqTpCi9dXbNxWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jXUvLLDFZmrcPU5pNFp2HZIUVFvFqaO65XP03BvEjSVESbNelERLk7TQoQcPYKbgT
         Mhca0LLZo0yypo+AbZZcnBnALHhH6NPRf5NqwIP/id5mJIhZyQZiawfRC7FrpIFMTi
         xttDljYze+VWT8uLPHbYH67LH0QXu8LYn7o73h5c=
Date:   Sun, 15 Mar 2020 11:38:54 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v8 07/11] scsi: ufs: Add inline encryption support to UFS
Message-ID: <20200315183854.GD1055@sol.localdomain>
References: <20200312080253.3667-1-satyat@google.com>
 <20200312080253.3667-8-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312080253.3667-8-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 12, 2020 at 01:02:49AM -0700, Satya Tangirala wrote:
> Wire up ufshcd.c with the UFS Crypto API, the block layer inline
> encryption additions and the keyslot manager.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  drivers/scsi/ufs/ufshcd-crypto.c | 27 +++++++++++++++
>  drivers/scsi/ufs/ufshcd-crypto.h | 14 ++++++++
>  drivers/scsi/ufs/ufshcd.c        | 59 +++++++++++++++++++++++++++++---
>  drivers/scsi/ufs/ufshcd.h        |  8 +++++
>  4 files changed, 103 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd-crypto.c b/drivers/scsi/ufs/ufshcd-crypto.c
> index 8b6f7c83f77f..37254472326a 100644
> --- a/drivers/scsi/ufs/ufshcd-crypto.c
> +++ b/drivers/scsi/ufs/ufshcd-crypto.c
> @@ -368,3 +368,30 @@ void ufshcd_crypto_destroy_keyslot_manager(struct ufs_hba *hba)
>  {
>  	blk_ksm_destroy(&hba->ksm);
>  }
> +
> +int ufshcd_prepare_lrbp_crypto(struct ufs_hba *hba,
> +			       struct scsi_cmnd *cmd,
> +			       struct ufshcd_lrb *lrbp)
> +{
> +	struct request *rq = cmd->request;
> +	struct bio_crypt_ctx *bc = rq->crypt_ctx;
> +	unsigned int slot_idx = blk_ksm_get_slot_idx(rq->crypt_keyslot);
> +
> +	lrbp->crypto_enable = false;
> +
> +	if (WARN_ON(!(hba->caps & UFSHCD_CAP_CRYPTO))) {
> +		/*
> +		 * Upper layer asked us to do inline encryption
> +		 * but that isn't enabled, so we fail this request.
> +		 */
> +		return -EINVAL;
> +	}
> +	if (!ufshcd_keyslot_valid(hba, slot_idx))
> +		return -EINVAL;
> +
> +	lrbp->crypto_enable = true;
> +	lrbp->crypto_key_slot = slot_idx;
> +	lrbp->data_unit_num = bc->bc_dun[0];
> +
> +	return 0;
> +}
> diff --git a/drivers/scsi/ufs/ufshcd-crypto.h b/drivers/scsi/ufs/ufshcd-crypto.h
> index 8270c0c5081a..c76f93ede51c 100644
> --- a/drivers/scsi/ufs/ufshcd-crypto.h
> +++ b/drivers/scsi/ufs/ufshcd-crypto.h
> @@ -16,6 +16,15 @@ static inline bool ufshcd_hba_is_crypto_supported(struct ufs_hba *hba)
>  	return hba->crypto_capabilities.reg_val != 0;
>  }
>  
> +int ufshcd_prepare_lrbp_crypto(struct ufs_hba *hba,
> +			       struct scsi_cmnd *cmd,
> +			       struct ufshcd_lrb *lrbp);
> +
> +static inline bool ufshcd_lrbp_crypto_enabled(struct ufshcd_lrb *lrbp)
> +{
> +	return lrbp->crypto_enable;
> +}
> +
>  void ufshcd_crypto_enable(struct ufs_hba *hba);
>  
>  void ufshcd_crypto_disable(struct ufs_hba *hba);
> @@ -49,6 +58,11 @@ static inline void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
>  static inline void ufshcd_crypto_destroy_keyslot_manager(struct ufs_hba *hba)
>  { }
>  
> +static inline bool ufshcd_lrbp_crypto_enabled(struct ufshcd_lrb *lrbp)
> +{
> +	return false;
> +}
> +
>  #endif /* CONFIG_SCSI_UFS_CRYPTO */
>  
>  #endif /* _UFSHCD_CRYPTO_H */
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 825d9eb34f10..3a19966dbee9 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -47,6 +47,7 @@
>  #include "unipro.h"
>  #include "ufs-sysfs.h"
>  #include "ufs_bsg.h"
> +#include "ufshcd-crypto.h"
>  
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/ufs.h>
> @@ -816,7 +817,14 @@ static void ufshcd_enable_run_stop_reg(struct ufs_hba *hba)
>   */
>  static inline void ufshcd_hba_start(struct ufs_hba *hba)
>  {
> -	ufshcd_writel(hba, CONTROLLER_ENABLE, REG_CONTROLLER_ENABLE);
> +	u32 val = CONTROLLER_ENABLE;
> +
> +	if (ufshcd_hba_is_crypto_supported(hba)) {
> +		ufshcd_crypto_enable(hba);
> +		val |= CRYPTO_GENERAL_ENABLE;
> +	}
> +
> +	ufshcd_writel(hba, val, REG_CONTROLLER_ENABLE);
>  }
>  
>  /**
> @@ -2192,9 +2200,23 @@ static void ufshcd_prepare_req_desc_hdr(struct ufshcd_lrb *lrbp,
>  		dword_0 |= UTP_REQ_DESC_INT_CMD;
>  
>  	/* Transfer request descriptor header fields */
> +	if (ufshcd_lrbp_crypto_enabled(lrbp)) {
> +#ifdef CONFIG_SCSI_UFS_CRYPTO
> +		dword_0 |= UTP_REQ_DESC_CRYPTO_ENABLE_CMD;
> +		dword_0 |= lrbp->crypto_key_slot;
> +		req_desc->header.dword_1 =
> +			cpu_to_le32(lower_32_bits(lrbp->data_unit_num));
> +		req_desc->header.dword_3 =
> +			cpu_to_le32(upper_32_bits(lrbp->data_unit_num));
> +#endif /* CONFIG_SCSI_UFS_CRYPTO */
> +	} else {
> +		/* dword_1 and dword_3 are reserved, hence they are set to 0 */
> +		req_desc->header.dword_1 = 0;
> +		req_desc->header.dword_3 = 0;
> +	}
> +
>  	req_desc->header.dword_0 = cpu_to_le32(dword_0);
> -	/* dword_1 is reserved, hence it is set to 0 */
> -	req_desc->header.dword_1 = 0;
> +
>  	/*
>  	 * assigning invalid value for command status. Controller
>  	 * updates OCS on command completion, with the command
> @@ -2202,8 +2224,6 @@ static void ufshcd_prepare_req_desc_hdr(struct ufshcd_lrb *lrbp,
>  	 */
>  	req_desc->header.dword_2 =
>  		cpu_to_le32(OCS_INVALID_COMMAND_STATUS);
> -	/* dword_3 is reserved, hence it is set to 0 */
> -	req_desc->header.dword_3 = 0;
>  
>  	req_desc->prd_table_length = 0;
>  }
> @@ -2437,6 +2457,20 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
>  	lrbp->task_tag = tag;
>  	lrbp->lun = ufshcd_scsi_to_upiu_lun(cmd->device->lun);
>  	lrbp->intr_cmd = !ufshcd_is_intr_aggr_allowed(hba) ? true : false;
> +
> +#ifdef CONFIG_SCSI_UFS_CRYPTO
> +	if (cmd->request->crypt_keyslot) {
> +		err = ufshcd_prepare_lrbp_crypto(hba, cmd, lrbp);
> +		if (err) {
> +			lrbp->cmd = NULL;
> +			ufshcd_release(hba);
> +			goto out;
> +		}
> +	} else {
> +		lrbp->crypto_enable = false;
> +	}
> +#endif
> +
>  	lrbp->req_abort_skip = false;
>  
>  	ufshcd_comp_scsi_upiu(hba, lrbp);
> @@ -2470,6 +2504,9 @@ static int ufshcd_compose_dev_cmd(struct ufs_hba *hba,
>  	lrbp->task_tag = tag;
>  	lrbp->lun = 0; /* device management cmd is not specific to any LUN */
>  	lrbp->intr_cmd = true; /* No interrupt aggregation */
> +#ifdef CONFIG_SCSI_UFS_CRYPTO
> +	lrbp->crypto_enable = false; /* No crypto operations */
> +#endif
>  	hba->dev_cmd.type = cmd_type;
>  
>  	return ufshcd_comp_devman_upiu(hba, lrbp);

This is all much more complicated than needed.

- We don't need the 'crypto_enable' field.  Just make 'crypto_key_slot' an int
  and use 'crypto_key_slot = -1' instead.

- ufshcd_lrbp_crypto_enabled() isn't needed since it's only used in one place
  which uses an ifdef anyway.  It can simply check crypto_key_slot >= 0.

- The checks in ufshcd_prepare_lrbp_crypto() are unneeded, as the block layer
  already ensures that a valid keyslot is provided.

So for the per-command code, all we actually need is:

#ifdef CONFIG_SCSI_UFS_CRYPTO
static inline void ufshcd_prepare_lrbp_crypto(struct scsi_cmnd *cmd,
                                              struct ufshcd_lrb *lrbp)
{       
        struct request *rq = cmd->request; 
        
        if (rq->crypt_keyslot) {
                lrbp->crypto_key_slot = blk_ksm_get_slot_idx(rq->crypt_keyslot);
                lrbp->data_unit_num = rq->crypt_ctx->bc_dun[0];
        } else {
                lrbp->crypto_key_slot = -1;
        }
}                              
...
#else
static inline void ufshcd_prepare_lrbp_crypto(struct scsi_cmnd *cmd,
                                              struct ufshcd_lrb *lrbp)
{       
}                              
...
#endif

Then in ufshcd_queuecommand():

	...

        lrbp->intr_cmd = !ufshcd_is_intr_aggr_allowed(hba) ? true : false;
        lrbp->req_abort_skip = false;

        ufshcd_prepare_lrbp_crypto(cmd, lrbp);

        ufshcd_comp_scsi_upiu(hba, lrbp);

	...

Then in ufshcd_prepare_req_desc_hdr():

        u32 dword_1 = 0;
        u32 dword_3 = 0;

	...

#ifdef CONFIG_SCSI_UFS_CRYPTO
        if (lrbp->crypto_key_slot >= 0) {
                dword_0 |= UTP_REQ_DESC_CRYPTO_ENABLE_CMD;
                dword_0 |= lrbp->crypto_key_slot;
                dword_1 = lower_32_bits(lrbp->data_unit_num);
                dword_3 = upper_32_bits(lrbp->data_unit_num);
        }
#endif

	req_desc->header.dword_0 = cpu_to_le32(dword_0);
	req_desc->header.dword_1 = cpu_to_le32(dword_1);
	...
	req_desc->header.dword_2 =
		cpu_to_le32(OCS_INVALID_COMMAND_STATUS);
	req_desc->header.dword_3 = cpu_to_le32(dword_3);
