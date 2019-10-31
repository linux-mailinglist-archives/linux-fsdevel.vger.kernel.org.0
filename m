Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10EC5EB6D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 19:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbfJaSXQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 14:23:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbfJaSXP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bxpUhY/qtwNaeue6qcQlTx7BDSxYIRC42kFrjayFps0=; b=r4ujFx2c+gNY+WxneSRVK4m9w
        H0qa02Od7ZaBJosxTMd2wNBMdyNOGkMAcwWD6iZGHkr82+AiJjxoYyyr8BU5ao1JrK3GUdgbOYO2G
        7+UV3QhIfrG2GV0ezl3f2ItkPqnazxDdRNrT5lmS7aF51M1KkRx1MQSrez6mI+/8y48vtz6H5COMB
        IeGuhUxt5oLlOReFvjh+GipT8sQfL3gZEJS2ewrhIAM7GLs+jgEOHebsY2Q5aqTWGK1skLgIElgOq
        pClq7/xatxK8uqc6+copbj6jtcl7bk7qV12Qi1zBNQ7KjgIujYB9qwLKEvqvQCDgqlEtQu/yPd5wr
        fUpF2Uh6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iQF6I-0001rc-B6; Thu, 31 Oct 2019 18:23:14 +0000
Date:   Thu, 31 Oct 2019 11:23:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v5 5/9] scsi: ufs: UFS crypto API
Message-ID: <20191031182314.GD23601@infradead.org>
References: <20191028072032.6911-1-satyat@google.com>
 <20191028072032.6911-6-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028072032.6911-6-satyat@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +static size_t get_keysize_bytes(enum ufs_crypto_key_size size)
> +{
> +	switch (size) {
> +	case UFS_CRYPTO_KEY_SIZE_128: return 16;
> +	case UFS_CRYPTO_KEY_SIZE_192: return 24;
> +	case UFS_CRYPTO_KEY_SIZE_256: return 32;
> +	case UFS_CRYPTO_KEY_SIZE_512: return 64;
> +	default: return 0;
> +	}
> +}

Please fix the indentation and move all the returns to their own
lines.  There are various more spots that will need to be fixed
like this as well later in the patch.

> +
> +static int ufshcd_crypto_cap_find(void *hba_p,
> +			   enum blk_crypto_mode_num crypto_mode,
> +			   unsigned int data_unit_size)
> +{
> +	struct ufs_hba *hba = hba_p;

Please properly type the first argument.

> +	case UFS_CRYPTO_ALG_BITLOCKER_AES_CBC: // fallthrough

Please don't use // comments.

> +static void program_key(struct ufs_hba *hba,
> +			const union ufs_crypto_cfg_entry *cfg,
> +			int slot)

The function name needs a ufshcd prefix.

> +	wmb();
> +	for (i = 0; i < 16; i++) {
> +		ufshcd_writel(hba, le32_to_cpu(cfg->reg_val[i]),
> +			      slot_offset + i * sizeof(cfg->reg_val[0]));
> +		/* Spec says each dword in key must be written sequentially */
> +		wmb();
> +	}
> +	/* Write dword 17 */
> +	ufshcd_writel(hba, le32_to_cpu(cfg->reg_val[17]),
> +		      slot_offset + 17 * sizeof(cfg->reg_val[0]));
> +	/* Dword 16 must be written last */
> +	wmb();
> +	/* Write dword 16 */
> +	ufshcd_writel(hba, le32_to_cpu(cfg->reg_val[16]),
> +		      slot_offset + 16 * sizeof(cfg->reg_val[0]));
> +	wmb();

wmb() has no meaning for MMIO operations, something looks very fishy
here.

> +static int ufshcd_crypto_keyslot_program(void *hba_p, const u8 *key,
> +					 enum blk_crypto_mode_num crypto_mode,
> +					 unsigned int data_unit_size,
> +					 unsigned int slot)
> +{
> +	struct ufs_hba *hba = hba_p;

This is not a very type safe API.  I think the proper thing to do
would be to allocte the struct keyslot_manager in the driver (ufshcd)
as part of the containing structure (ufs_hba) and then just have
a keyslot_manager_init that initializes the field.  Then pass the
struct keyslot_manager to the methods, which can use container_of
to get the containing structure.

> +#define NUM_KEYSLOTS(hba) (hba->crypto_capabilities.config_count + 1)

Please make this an inline function.
