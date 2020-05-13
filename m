Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68BF1D1D4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 20:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390013AbgEMSTM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 14:19:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732845AbgEMSTM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 14:19:12 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4805120659;
        Wed, 13 May 2020 18:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589393952;
        bh=SfJxDaSxm0hnHBUQQlW7klJYEBeSvPqH0A5X4yUESvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kt83iOznWMDCO7CN/KhYA7OhhIp+dJ8qjppZYlYd2ZsvQlDtaSkePzBNQ0yXT9cgV
         07AV6jluBY8Dd8bzEHcoaYXYWMU8a1QHqZ3QPQR/S4o5OUCUD8o717ISAFRdVYw9yE
         DQeGKgRVoKhyPjUqErvy36jlZzCZ/Mg+LtCftVEc=
Date:   Wed, 13 May 2020 11:19:10 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v12 08/12] scsi: ufs: Add inline encryption support to UFS
Message-ID: <20200513181910.GH1243@sol.localdomain>
References: <20200430115959.238073-1-satyat@google.com>
 <20200430115959.238073-9-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430115959.238073-9-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 30, 2020 at 11:59:55AM +0000, Satya Tangirala wrote:
> @@ -8541,6 +8568,13 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
>  	/* Reset the attached device */
>  	ufshcd_vops_device_reset(hba);
>  
> +	/* Init crypto */
> +	err = ufshcd_hba_init_crypto(hba);
> +	if (err) {
> +		dev_err(hba->dev, "crypto setup failed\n");
> +		goto out_remove_scsi_host;
> +	}
> +

Due to changes in v5.6, this is jumping to the wrong error label.
It should be 'free_tmf_queue'.

- Eric
