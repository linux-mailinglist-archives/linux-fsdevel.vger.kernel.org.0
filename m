Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB439275C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 07:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfEWFwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 01:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfEWFwO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 01:52:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD2A021019;
        Thu, 23 May 2019 05:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558590734;
        bh=QhoN2Mcwq66VNLJnFallZhbP3P+3xy0QYNpXS7iQTIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WMfgxe6wgJ4YAGCZEvfwTq3QpE3RjrfEHvmXyDzQb76bo9ysKlx1TZFuNvJkNrEON
         hYxKSYjSXZNgdQXT1FUe67NTVxtmmmQ3rq4Pk8KExSf6yL675Vxg5A7CXT7eMA7xot
         G3EEV+9oUGAxWFEoLquvK2vLSYZMrM4G7F8HMe5g=
Date:   Thu, 23 May 2019 07:52:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 3/3] soc: qcom: mdt_loader: add offset to
 request_firmware_into_buf
Message-ID: <20190523055212.GA22946@kroah.com>
References: <20190523025113.4605-1-scott.branden@broadcom.com>
 <20190523025113.4605-4-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523025113.4605-4-scott.branden@broadcom.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 22, 2019 at 07:51:13PM -0700, Scott Branden wrote:
> Adjust request_firmware_into_buf API to allow for portions
> of firmware file to be read into a buffer.  mdt_loader still
> retricts request fo whole file read into buffer.
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  drivers/soc/qcom/mdt_loader.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> index 1c488024c698..ad20d159699c 100644
> --- a/drivers/soc/qcom/mdt_loader.c
> +++ b/drivers/soc/qcom/mdt_loader.c
> @@ -172,8 +172,11 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
>  
>  		if (phdr->p_filesz) {
>  			sprintf(fw_name + fw_name_len - 3, "b%02d", i);
> -			ret = request_firmware_into_buf(&seg_fw, fw_name, dev,
> -							ptr, phdr->p_filesz);
> +			ret = request_firmware_into_buf
> +						(&seg_fw, fw_name, dev,
> +						 ptr, phdr->p_filesz,
> +						 0,
> +						 KERNEL_PREAD_FLAG_WHOLE);

So, all that work in the first 2 patches for no real change at all?  Why
are these changes even needed?

And didn't you break this driver in patch 2/3?  You can't fix it up
later here, you need to also resolve that in the 2nd patch.

thanks,

greg k-h
