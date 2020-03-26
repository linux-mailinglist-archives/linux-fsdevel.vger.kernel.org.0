Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A79219376D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 06:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgCZFJy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 01:09:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgCZFJy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 01:09:54 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C95EB2070A;
        Thu, 26 Mar 2020 05:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585199393;
        bh=SAzWGnLaDMWUeuZGiBEGw8t99I39riFFfBkRkECR76k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KBk6bh+2+KgvnH/GBoaOZP5CoOGFXBDEmHLgyFu7jp7J3p2K4KtNOxOGCOaR2gJoO
         NoaM3PK4kAQwznME9Gi10zGQmX6diVM0og4bc4/edRNOGvjRedijlsyrXSGWLAPzG2
         1sDc4qg8+owA7W1kg+pUvnaPTPQpJZ24CZrBYHL8=
Date:   Wed, 25 Mar 2020 22:09:51 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v9 07/11] scsi: ufs: Add inline encryption support to UFS
Message-ID: <20200326050951.GC858@sol.localdomain>
References: <20200326030702.223233-1-satyat@google.com>
 <20200326030702.223233-8-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326030702.223233-8-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 25, 2020 at 08:06:58PM -0700, Satya Tangirala wrote:
> Wire up ufshcd.c with the UFS Crypto API, the block layer inline
> encryption additions and the keyslot manager.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>

Thanks, like the previous patch this looks much better now!

A couple minor nits I noticed while reading this latest version:

> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index eaeb21b9cda24..3af15880e1e36 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -168,6 +168,8 @@ struct ufs_pm_lvl_states {
>   * @intr_cmd: Interrupt command (doesn't participate in interrupt aggregation)
>   * @issue_time_stamp: time stamp for debug purposes
>   * @compl_time_stamp: time stamp for statistics
> + * @crypto_key_slot: the key slot to use for inline crypto

It would be helpful if the comment mentioned the -1 case:

 * @crypto_key_slot: the key slot to use for inline crypto (-1 if none)

> + * @data_unit_num: the data unit number for the first block for inline crypto
>   * @req_abort_skip: skip request abort task flag
>   */
>  struct ufshcd_lrb {
> @@ -192,6 +194,10 @@ struct ufshcd_lrb {
>  	bool intr_cmd;
>  	ktime_t issue_time_stamp;
>  	ktime_t compl_time_stamp;
> +#if IS_ENABLED(CONFIG_SCSI_UFS_CRYPTO)
> +	int crypto_key_slot;
> +	u64 data_unit_num;
> +#endif

Since CONFIG_SCSI_UFS_CRYPTO is a bool this should use #ifdef, not IS_ENABLED().

- Eric
