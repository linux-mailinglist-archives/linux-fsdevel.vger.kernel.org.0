Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0581A185F33
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 19:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgCOSsp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Mar 2020 14:48:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbgCOSsp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Mar 2020 14:48:45 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C90C520575;
        Sun, 15 Mar 2020 18:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584298125;
        bh=X7eZm/83zSemhOKu22Fty0SqoIeYPuDleqyyTdJy9RU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rv4px8s9Q3eGMV1pW/kfV45LvoiySpkl8HU+8x1zdkXRGMsh0dkAMrapkwL+AjZa0
         SCV1NVVv7N51uf4WdCkuYsvSDBby9mvNHp7QTngAMszE0Dksw0qMrF7BRxtmxbSruO
         DuDVYR6iZ/JAfXTPo4wxtR52H+NmnEVYOaxhDvl4=
Date:   Sun, 15 Mar 2020 11:48:43 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v8 07/11] scsi: ufs: Add inline encryption support to UFS
Message-ID: <20200315184843.GE1055@sol.localdomain>
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
> @@ -2470,6 +2504,9 @@ static int ufshcd_compose_dev_cmd(struct ufs_hba *hba,
>  	lrbp->task_tag = tag;
>  	lrbp->lun = 0; /* device management cmd is not specific to any LUN */
>  	lrbp->intr_cmd = true; /* No interrupt aggregation */
> +#ifdef CONFIG_SCSI_UFS_CRYPTO
> +	lrbp->crypto_enable = false; /* No crypto operations */
> +#endif
>  	hba->dev_cmd.type = cmd_type;

Doesn't this need to be initialized in ufshcd_issue_devman_upiu_cmd() too?
