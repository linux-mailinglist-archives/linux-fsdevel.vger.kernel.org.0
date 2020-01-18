Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D82B61415BB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2020 04:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgARD6H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 22:58:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgARD6H (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 22:58:07 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F7692072B;
        Sat, 18 Jan 2020 03:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579319886;
        bh=fMspsEvLC7cRCvV8B4hOYJXyJHVbjKq9MkwOe9RNS4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TnxD89jX+A4F+MemC8PvzvH8szJ6VL6+/uBi5T16UDReENGERBpSDN7a4kjx+E1eX
         cNj7fjEnqTNslHlJaPEMJ4xo53Q/x5VT12ZdeiVe2d6n4pnlZqr4jt6YgE9iKY5WO1
         i7dUiZ7v3ogjEopxskFYuSoBWzJxwZhI1s19PDng=
Date:   Fri, 17 Jan 2020 19:58:05 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 6/9] scsi: ufs: Add inline encryption support to UFS
Message-ID: <20200118035805.GA3290@sol.localdomain>
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
> @@ -4654,6 +4686,8 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
>  	if (ufshcd_is_rpm_autosuspend_allowed(hba))
>  		sdev->rpm_autosuspend = 1;
>  
> +	ufshcd_crypto_setup_rq_keyslot_manager(hba, q);
> +
>  	return 0;
>  }
>  
> @@ -4664,6 +4698,7 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
>  static void ufshcd_slave_destroy(struct scsi_device *sdev)
>  {
>  	struct ufs_hba *hba;
> +	struct request_queue *q = sdev->request_queue;
>  
>  	hba = shost_priv(sdev->host);
>  	/* Drop the reference as it won't be needed anymore */
> @@ -4674,6 +4709,8 @@ static void ufshcd_slave_destroy(struct scsi_device *sdev)
>  		hba->sdev_ufs_device = NULL;
>  		spin_unlock_irqrestore(hba->host->host_lock, flags);
>  	}
> +
> +	ufshcd_crypto_destroy_rq_keyslot_manager(hba, q);
>  }

Just noticed this --- this is still destroying the keyslot manager when a SCSI
device is destroyed.  The keyslot manager is associated with the host controller
(which might control multiple devices), so it must not be destroyed until the
ufs_hba is destroyed, i.e. in ufshcd_dealloc_host().

(I was also thinking about whether we could use devm so that the keyslot_manager
doesn't need to be explicitly freed.  But that wouldn't actually help because we
still need to ensure that all the crypto keys get zeroed.)

- Eric
