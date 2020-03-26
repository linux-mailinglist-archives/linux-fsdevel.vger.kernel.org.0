Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D21219376A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 06:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgCZFHU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 01:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgCZFHU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 01:07:20 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 326E62070A;
        Thu, 26 Mar 2020 05:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585199239;
        bh=L93EhN0UlFtJqX/gYR0aa3wk+7m7DwlPwFZinjcu45g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P/05KEELLY9eRnCZ52KBkPmIRjwf+w3dHjNT7/NUOuZFrdqZf0gHvuUN/cHWOysBs
         gG3gj6U+cMZEqWlgzpNJBKMArfqL0F2qBFDorlUP2jUGpN1iU8Rx1kySNW1RJLAXC5
         AOubGRlzbwKQfv+KB+KhM9+L5/+vsIcyFOOXoxOM=
Date:   Wed, 25 Mar 2020 22:07:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v9 06/11] scsi: ufs: UFS crypto API
Message-ID: <20200326050717.GB858@sol.localdomain>
References: <20200326030702.223233-1-satyat@google.com>
 <20200326030702.223233-7-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326030702.223233-7-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 25, 2020 at 08:06:57PM -0700, Satya Tangirala wrote:
> Introduce functions to manipulate UFS inline encryption hardware
> in line with the JEDEC UFSHCI v2.1 specification and to work with the
> block keyslot manager.
> 
> The UFS crypto API will assume by default that a vendor driver doesn't
> support UFS crypto, even if the hardware advertises the capability, because
> a lot of hardware requires some special handling that's not specified in
> the aforementioned JEDEC spec. Each vendor driver must explicity set
> hba->caps |= UFSHCD_CAP_CRYPTO before ufshcd_hba_init_crypto is called to
> opt-in to UFS crypto support.
> 

Thanks, this looks much better now!

A couple minor nits I noticed while reading this latest version:

> +void ufshcd_crypto_setup_rq_keyslot_manager(struct ufs_hba *hba,
> +					    struct request_queue *q)
> +{
> +	if ((hba->caps & UFSHCD_CAP_CRYPTO))
> +		blk_ksm_register(&hba->ksm, q);
> +}

There's an extra pair of parentheses in the 'if'.

> diff --git a/drivers/scsi/ufs/ufshcd-crypto.h b/drivers/scsi/ufs/ufshcd-crypto.h
> new file mode 100644
> index 0000000000000..1e98f1fc99965
> --- /dev/null
> +++ b/drivers/scsi/ufs/ufshcd-crypto.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2019 Google LLC
> + */
> +
> +#ifndef _UFSHCD_CRYPTO_H
> +#define _UFSHCD_CRYPTO_H
> +
> +#ifdef CONFIG_SCSI_UFS_CRYPTO
> +#include "ufshcd.h"
> +#include "ufshci.h"
> +
> +bool ufshcd_crypto_enable(struct ufs_hba *hba);
> +
> +void ufshcd_crypto_disable(struct ufs_hba *hba);

ufshcd_crypto_disable() has been removed, so its declaration should be removed
too.

- Eric
