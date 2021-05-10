Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E33377D82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 09:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhEJHyA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 03:54:00 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:56138 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhEJHx5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 03:53:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620633173; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=2z80gbPhH136dYR4Fq2BEfvgVhJIsU7HqbSV3qvsj2c=;
 b=YyvJqUvP7AUa4mIkdVNELkYk3nxrTlxPqOKGaaRMkhzY5DoG+OQdcO961q1CUevKDVOx90Tv
 P+AFzZsdpMwGaYNMkeZrOzJmC7euEfx9//XrHNBtGeoRNxboQu2X2gKwmXFfChnEjc6JEv2T
 8hWcGhvAvQ52rii9YtrDNbYs928=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyIxOTQxNiIsICJsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 6098e63a87ce1fbb56a01777 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 10 May 2021 07:52:26
 GMT
Sender: pragalla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 63F1FC43145; Mon, 10 May 2021 07:52:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pragalla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BD7DEC4338A;
        Mon, 10 May 2021 07:52:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 10 May 2021 13:22:23 +0530
From:   pragalla@codeaurora.org
To:     miklos@szeredi.hu
Cc:     stummala@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V1] fuse: Set fuse request error upon fuse abort
 connection
In-Reply-To: <1618582752-26178-1-git-send-email-pragalla@codeaurora.org>
References: <1618582752-26178-1-git-send-email-pragalla@codeaurora.org>
Message-ID: <c0c0c33be51672f01d4f7a2e097bb978@codeaurora.org>
X-Sender: pragalla@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miklos,

Did you get a chance to look on the below change ?
could you please review and provide your comments if any.

Thanks and Regards,
Pradeep

On 2021-04-16 19:49, Pradeep P V K wrote:
> There is a minor race in setting the fuse out request error
> between fuse_abort_conn() and fuse_dev_do_read() as explained
> below.
> 
> Thread-1			  Thread-2
> ========			  ========
> ->fuse_simple_request()           ->shutdown
>   ->__fuse_request_send()
>     ->queue_request()		->fuse_abort_conn()
> ->fuse_dev_do_read()                ->acquire(fpq->lock)
>   ->wait_for(fpq->lock) 	  ->set err to all req's in fpq->io
> 				  ->release(fpq->lock)
>   ->acquire(fpq->lock)
>   ->add req to fpq->io
> 
> The above scenario may cause Thread-1 request to add into
> fpq->io list after Thread-2 sets -ECONNABORTED err to all
> its requests in fpq->io list. This leaves Thread-1 request
> with unset err and this further misleads as a completed
> request without an err set upon request_end().
> 
> Handle this by setting the err appropriately.
> 
> Signed-off-by: Pradeep P V K <pragalla@codeaurora.org>
> ---
>  fs/fuse/dev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index a5ceccc..102c56f 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1283,6 +1283,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev
> *fud, struct file *file,
>  	clear_bit(FR_LOCKED, &req->flags);
>  	if (!fpq->connected) {
>  		err = fc->aborted ? -ECONNABORTED : -ENODEV;
> +		req->out.h.error = err;
>  		goto out_end;
>  	}
>  	if (err) {
