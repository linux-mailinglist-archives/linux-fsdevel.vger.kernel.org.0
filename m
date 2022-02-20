Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D544BCE38
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Feb 2022 12:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240933AbiBTLkv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Feb 2022 06:40:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240599AbiBTLkm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Feb 2022 06:40:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8595032052;
        Sun, 20 Feb 2022 03:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rVtuU6Hrq8wCtIw10ZxltjmyN+GjMD3/PKda00/vg6g=; b=QyunQTIbhs6QyM/MNE8tIOZ8NR
        8J9x7GNbtnqtEjiwN8tVwwtFQuoCUzqM472l1PRDW2oAUV3vngMml03D9suwj/LOHiOH9x7puHW0x
        EJdvx2+H+CG6jDZkS9WYca4c6rqDypdYOzq9g5a1MYxB9N4dDROK5iaFBrJz3RzZve2U2x+KD9RzH
        ezIIkD+cpqa1dd+A1vpj6a4Bxd8+XkzbaPQh37kW0OliuSDj/2wJ4M0+zNm+ECzZaMX53qu8JPMh7
        J1jP5PRzIxb9WgDWq1jybO4BqplW8EHCi53BvpNeTjvmE/HXr5HKMXyiT8GFppa4U1LvZ5lt1esGP
        chMITAWw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nLkZN-000oj8-5z; Sun, 20 Feb 2022 11:40:01 +0000
Date:   Sun, 20 Feb 2022 11:40:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     tangmeng <tangmeng@uniontech.com>
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, nizhen@uniontech.com,
        zhanglianjie@uniontech.com, nixiaoming@huawei.com
Subject: Re: [PATCH 10/11] fs/drop_caches: move drop_caches sysctls to its
 own file
Message-ID: <YhIokWPShGOYh9LK@casper.infradead.org>
References: <20220220060626.15885-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220220060626.15885-1-tangmeng@uniontech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 20, 2022 at 02:06:26PM +0800, tangmeng wrote:
> diff --git a/fs/drop_caches.c b/fs/drop_caches.c
> @@ -75,3 +75,25 @@ int drop_caches_sysctl_handler(struct ctl_table *table, int write,
>  	}
>  	return 0;
>  }
> +
> +#ifdef CONFIG_SYSCTL

fs/Makefile has:
obj-$(CONFIG_SYSCTL)            += drop_caches.o

so we don't need this ifdef.

> +static struct ctl_table vm_drop_caches_table[] = {
> +	{
> +		.procname       = "drop_caches",
> +		.data           = &sysctl_drop_caches,
> +		.maxlen         = sizeof(int),
> +		.mode           = 0200,
> +		.proc_handler   = drop_caches_sysctl_handler,
> +		.extra1         = SYSCTL_ONE,
> +		.extra2         = SYSCTL_FOUR,
> +	},
> +	{ }
> +};

Something which slightly concerns me about this sysctl splitup (which
is obviously the right thing to do) is that ctl_table is quite large
(64 bytes per entry) and every array is terminated with an empty one.
In this example, we've gone from 64 bytes to 128 bytes.

Would we be better off having a register_sysctl_one() which
registers exactly one ctl_table, rather than an array?  And/or a
register_sysctl_array() which takes an ARRAY_SIZE() of its argument
instead of looking for the NULL terminator?
