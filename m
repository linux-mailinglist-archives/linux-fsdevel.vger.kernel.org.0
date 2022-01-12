Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55EC48BE9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 07:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiALGgD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 01:36:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55402 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiALGgD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 01:36:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDC4CB81E00;
        Wed, 12 Jan 2022 06:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6373DC36AE5;
        Wed, 12 Jan 2022 06:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641969360;
        bh=vfxFHyq0+NWBftGjcQnXakyJEnW27L81Lcvq1EqDjcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qfmN4tCDr8rAHNnP7z3WpL3G0F9sXvpf08aQCI7T/43sDbW94R1ga8QYTdiMRhLPF
         67s8W2vlW4dtFTL1BqiJw94Wwtda6jytN3+d4j7S7RLcyeQPzYUN5XMatEKbwkiOP7
         L6FqFVJljY+F8nyMp8lyL6dWdp4Sn7p2eKSSAvrP6OT0hd7HFXkal3ki2oPNmpfCZm
         nQbbF1ExY9Rict0Msj3QaNbIgoDuRrLtGn7wBZFMoD1Acpn5Zu+rMXc7738mL7Fyjs
         qJ5VG07MioKWTAAZhMr99hPa0dZH5oRfhIJ66zfvLKmJUnaO5frhKfXzCFidJWmE6g
         IYmY+Zhl88lCQ==
Date:   Tue, 11 Jan 2022 22:35:58 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/eventfd.c: Check error number after calling
 ida_simple_get
Message-ID: <Yd52ziCZh7aJUTIU@sol.localdomain>
References: <20220111070023.566773-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111070023.566773-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 11, 2022 at 03:00:23PM +0800, Jiasheng Jiang wrote:
> As the possible failure of the allocation, the ida_simple_get() will
> return error number.
> And then ctx->id will be printed in eventfd_show_fdinfo().
> Therefore, it should be better to check it and return error if fails,
> like the other allocation.
> 
> Fixes: b556db17b0e7 ("eventfd: present id to userspace via fdinfo")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  fs/eventfd.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/eventfd.c b/fs/eventfd.c
> index 3627dd7d25db..5ec1d998f3ac 100644
> --- a/fs/eventfd.c
> +++ b/fs/eventfd.c
> @@ -424,6 +424,10 @@ static int do_eventfd(unsigned int count, int flags)
>  	ctx->count = count;
>  	ctx->flags = flags;
>  	ctx->id = ida_simple_get(&eventfd_ida, 0, 0, GFP_KERNEL);
> +	if (ctx->id) {
> +		fd = ctx->id;
> +		goto err;
> +	}

Shouldn't this be 'ctx->id < 0'?

- Eric
