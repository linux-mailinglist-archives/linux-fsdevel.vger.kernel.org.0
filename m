Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 030A9EB6E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 19:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbfJaS0a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 14:26:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35714 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfJaS0a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xGKoferNKfspRbnIISs596AcbXhd0qJEbsy99cjQW1s=; b=ibOAU5TmxrFii45Kim/G2t/2E
        SDu1BNQ2603yUpmstCvG9YOw9+45EfSx6bxgKgmWFummCnqG9qVS+aamDLoccHltMk7s/UmEm4i4R
        yOYAMeDbHe5btNNkCL46bf/ncTNnj915yc6uNmS51gpFVym5Pj+xkMXxYacyckfiaP34cL4ub3OQU
        X/LDZrHu+Zk7USfXuHNCTwKrt3qYjS+UVopJbcmZ67xospYg7al5CBPmLV2Afi6Yk5ROp0sHLcflG
        YhhXLHP8OoARskk8vxmv9sLQVU/2mdsYCYeHD1FU3woCN6gu2D+lgtSQ2b3RKwFoyZRRxIcztfn/q
        SPWu+FafA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iQF9R-0003Ro-PR; Thu, 31 Oct 2019 18:26:29 +0000
Date:   Thu, 31 Oct 2019 11:26:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v5 6/9] scsi: ufs: Add inline encryption support to UFS
Message-ID: <20191031182629.GE23601@infradead.org>
References: <20191028072032.6911-1-satyat@google.com>
 <20191028072032.6911-7-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028072032.6911-7-satyat@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  	/* Transfer request descriptor header fields */
> +	if (lrbp->crypto_enable) {

Maybe we want a little inline function so that we can use IS_ENABLED
to make sure the compiler eliminates the dead code if crypt config
option is not set.

 a) don't have to define the crypto_enable if the config options are
    not set

> +		dword_0 |= UTP_REQ_DESC_CRYPTO_ENABLE_CMD;
> +		dword_0 |= lrbp->crypto_key_slot;
> +		req_desc->header.dword_1 =
> +			cpu_to_le32((u32)lrbp->data_unit_num);
> +		req_desc->header.dword_3 =
> +			cpu_to_le32((u32)(lrbp->data_unit_num >> 32));

This should use ther upper_32_bits / lower_32_bits helpers.

> +static inline int ufshcd_prepare_lrbp_crypto(struct ufs_hba *hba,
> +					     struct scsi_cmnd *cmd,
> +					     struct ufshcd_lrb *lrbp)
> +{
> +	int key_slot;
> +
> +	if (!cmd->request->bio ||
> +	    !bio_crypt_should_process(cmd->request->bio, cmd->request->q)) {
> +		lrbp->crypto_enable = false;
> +		return 0;
> +	}
> +
> +	if (WARN_ON(!ufshcd_is_crypto_enabled(hba))) {
> +		/*
> +		 * Upper layer asked us to do inline encryption
> +		 * but that isn't enabled, so we fail this request.
> +		 */
> +		return -EINVAL;
> +	}
> +	key_slot = bio_crypt_get_keyslot(cmd->request->bio);
> +	if (!ufshcd_keyslot_valid(hba, key_slot))
> +		return -EINVAL;
> +
> +	lrbp->crypto_enable = true;
> +	lrbp->crypto_key_slot = key_slot;
> +	lrbp->data_unit_num = bio_crypt_data_unit_num(cmd->request->bio);
> +
> +	return 0;

I think this should go into ufshcd-crypto.c so that it can be stubbed
out for non-crypto builds.  That also means we can remove various
stubs for the block layer helpers and just dereference the fields
directly, helping with code readability.
