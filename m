Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35785140BD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 14:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbgAQN6J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 08:58:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54138 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQN6I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 08:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sA5uuJQ04YeT72bao/JNQ4IKdK/ivCsVISnYxzEFHZQ=; b=I4YcAs1VzPP57kXD99FyxS6XW
        udZnW6lIH/c0erbsKZyO4mlV41IrhFb0FtbmGZjE2j3wvNCVBn83nZbwMpC7xMM8PkhHl4JaX38gS
        ch2fXnVCh2yaaVKgMcJV+nxYiYZHTDK2aSJqkjmlvmBrbYOh2cqYX+D3/GTMVdNWLJWYS/BKo2G7s
        AMDimyFz4NjLSsw6RsTS3KUNnVoyud1DUgZYXJX0BzlfMadoWs/+Z0TveQvoM1Rm2HxvaQ1TaPDty
        X+OSfDf0IQoL1PY6RZFwLhVmmXariSS08QBAO7KCdLRXGUOUTFSPvXq0c0Udie99E6perf4pv1X8u
        Wcg9y6Y2w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isS8W-0006WI-9s; Fri, 17 Jan 2020 13:58:08 +0000
Date:   Fri, 17 Jan 2020 05:58:08 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 6/9] scsi: ufs: Add inline encryption support to UFS
Message-ID: <20200117135808.GB5670@infradead.org>
References: <20191218145136.172774-1-satyat@google.com>
 <20191218145136.172774-7-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218145136.172774-7-satyat@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 06:51:33AM -0800, Satya Tangirala wrote:
> Wire up ufshcd.c with the UFS Crypto API, the block layer inline
> encryption additions and the keyslot manager.

I think this patch should be merged into the previous patch, as the
previous one isn't useful without wiring it up.

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

I think this check belongs into the caller so that there is no function
call overhead for the !inline crypto case.  If you extend the
conditional
to

	if (!IS_ENABLED(CONFIG_SCSI_UFS_CRYPTO) ||
	    !bio_crypt_should_process(cmd->request))

you also don't need the stub for ufshcd_prepare_lrbp_crypto.

> +EXPORT_SYMBOL_GPL(ufshcd_prepare_lrbp_crypto);

No need to export this function.

> +	if (ufshcd_lrbp_crypto_enabled(lrbp)) {
> +#if IS_ENABLED(CONFIG_SCSI_UFS_CRYPTO)
> +		dword_0 |= UTP_REQ_DESC_CRYPTO_ENABLE_CMD;
> +		dword_0 |= lrbp->crypto_key_slot;
> +		req_desc->header.dword_1 =
> +			cpu_to_le32(lower_32_bits(lrbp->data_unit_num));
> +		req_desc->header.dword_3 =
> +			cpu_to_le32(upper_32_bits(lrbp->data_unit_num));
> +#endif /* CONFIG_SCSI_UFS_CRYPTO */

This can be a plain old ifdef without the IS_ENABLED obsfucation.

> +#if IS_ENABLED(CONFIG_SCSI_UFS_CRYPTO)
> +	lrbp->crypto_enable = false; /* No crypto operations */
> +#endif

Same here.

> +#if IS_ENABLED(CONFIG_SCSI_UFS_CRYPTO)
> +	bool crypto_enable;
> +	u8 crypto_key_slot;
> +	u64 data_unit_num;
> +#endif /* CONFIG_SCSI_UFS_CRYPTO */

.. and here.
