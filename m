Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C217640F81
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 21:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbiLBUxu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 15:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbiLBUxt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 15:53:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E3DDB615;
        Fri,  2 Dec 2022 12:53:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4005AB8229B;
        Fri,  2 Dec 2022 20:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F67C433D6;
        Fri,  2 Dec 2022 20:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1670014425;
        bh=UyfrIfBwgRbws4E6wvQ9jOxRC9kf4UQkkYiiqt2Trm4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VQ6Kt73vpwRd9sui69s96hd9uhvSKWsJ4WR6vBi/7Be+2rqQL7SlW8oqS1D18qaxe
         GzxMmezBd++jpf7Wde2XV6iAKNTcncWQih5RaMbrYvX3iZ35JrrzpXRfJLpxEp0UYC
         BkbAuAp1SajuCE4kvSQAYYmDeHrTluA2R/5kxHOY=
Date:   Fri, 2 Dec 2022 12:53:44 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Aditya Garg <gargaditya08@live.com>
Cc:     "willy@infradead.org" <willy@infradead.org>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] hfsplus: Add module parameter to enable force writes
Message-Id: <20221202125344.4254ab20d2fe0a8e784b33e8@linux-foundation.org>
In-Reply-To: <53821C76-DAFE-4505-9EC8-BE4ACBEA9DD9@live.com>
References: <53821C76-DAFE-4505-9EC8-BE4ACBEA9DD9@live.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2 Dec 2022 06:01:16 +0000 Aditya Garg <gargaditya08@live.com> wrote:

> From: Aditya Garg <gargaditya08@live.com>
> 
> This patch enables users to permanently enable writes of HFS+ locked
> and/or journaled volumes using a module parameter.
> 
> Why module parameter?
> Reason being, its not convenient to manually mount the volume with force
> everytime. There are use cases which are fine with force enabling writes
> on journaled volumes. I've seen many on various online forums and I am one
> of them as well.
> 
> Isn't it risky?
> Yes obviously it is, as the driver itself warns users for the same. But
> any user using the parameter obviously shall be well aware of the risks
> involved. To be honest, I've been writing on a 100Gb journaled volume for
> a few days, including both large and small files, and haven't faced any
> corruption yet.
> 

Presumably anyone who enables this knows the risk, and if it's a
convenience, why not.

Documentation/filesystems/hfsplus.rst would be a good place to document
this module parameter please.

> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -459,12 +477,20 @@ static int hfsplus_fill_super(struct super_block *sb, void *data, int silent)
>  	} else if (test_and_clear_bit(HFSPLUS_SB_FORCE, &sbi->flags)) {
>  		/* nothing */
>  	} else if (vhdr->attributes & cpu_to_be32(HFSPLUS_VOL_SOFTLOCK)) {
> -		pr_warn("Filesystem is marked locked, mounting read-only.\n");
> -		sb->s_flags |= SB_RDONLY;
> +		if (force_locked_rw) {
> +			pr_warn("Filesystem is marked locked, but writes have been force enabled.\n");
> +		} else {
> +			pr_warn("Filesystem is marked locked, mounting read-only.\n");
> +			sb->s_flags |= SB_RDONLY;
> +		}
>  	} else if ((vhdr->attributes & cpu_to_be32(HFSPLUS_VOL_JOURNALED)) &&
>  			!sb_rdonly(sb)) {
> -		pr_warn("write access to a journaled filesystem is not supported, use the force option at your own risk, mounting read-only.\n");
> -		sb->s_flags |= SB_RDONLY;
> +		if (force_journaled_rw) {
> +			pr_warn("write access to a journaled filesystem is not supported, but has been force enabled.\n");
> +		} else {
> +			pr_warn("write access to a journaled filesystem is not supported, use the force option at your own risk, mounting read-only.\n");
> +			sb->s_flags |= SB_RDONLY;
> +		}

All these super long lines are an eyesore.  How about

			pr_warn("write access to a journaled filesystem is "
				"not supported, but has been force enabled.\n");

