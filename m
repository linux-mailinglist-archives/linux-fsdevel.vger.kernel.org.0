Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884C7763E01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 19:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjGZR6o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 13:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjGZR6m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:58:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD302688;
        Wed, 26 Jul 2023 10:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YPmagiFQ/MeFHRjwmSRL0hWWXD4WhK730BMoQ57Tcfs=; b=kixqBCkSocxZEhHc2Sl4YQ3j/W
        6MHhYsaeGcAEFz3Ikfkl0tpJZeVVuCe/BiTxlYG3dJ8HcvJ/T2vdQAQ5gIBhR2n6UhgaBfMrG4PI3
        Z5Id/jv1a75gsjOtDXpt/LD7O15Touqa7NqiEPt/l8zBxXGlzsYO+bCoXjnUd4LyKsNR8uZGhhZRg
        +OyiKfgZbY7fbFXMfGEJdwxH3fx8IGSflQLhVMJDAioTezH4kPOYHszoYxlRVTrC6/MqPhn7X667m
        QRhIOcxcm6QRQ5XuiNwXgc2BldKLdF/obVnyC8UpbIg6DWBIlRNSJNh4WSktu5vL21AXLcVy8pPM7
        x0bCwxMw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qOimM-00BE8R-2H;
        Wed, 26 Jul 2023 17:58:30 +0000
Date:   Wed, 26 Jul 2023 10:58:30 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Joel Granados <j.granados@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, willy@infradead.org,
        josh@joshtriplett.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 06/14] sysctl: Add size to register_sysctl
Message-ID: <ZMFexmOcfyORkRRs@bombadil.infradead.org>
References: <20230726140635.2059334-1-j.granados@samsung.com>
 <CGME20230726140659eucas1p2c3cd9f57dd13c71ddeb78d2480587e72@eucas1p2.samsung.com>
 <20230726140635.2059334-7-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726140635.2059334-7-j.granados@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 26, 2023 at 04:06:26PM +0200, Joel Granados wrote:
> In order to remove the end element from the ctl_table struct arrays, we
> replace the register_syctl function with a macro that will add the
> ARRAY_SIZE to the new register_sysctl_sz function. In this way the
> callers that are already using an array of ctl_table structs do not have
> to change. We *do* change the callers that pass the ctl_table array as a
> pointer.

Thanks for doing this and this series!

> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 0495c858989f..b1168ae281c9 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -215,6 +215,9 @@ struct ctl_path {
>  	const char *procname;
>  };
>  
> +#define register_sysctl(path, table)	\
> +	register_sysctl_sz(path, table, ARRAY_SIZE(table))
> +
>  #ifdef CONFIG_SYSCTL

Wasn't it Greg who had suggested this? Maybe add Suggested-by with him
on it.

Also, your cover letter and first few patches are not CC'd to the netdev
list or others. What you want to do is collect all the email addresses
for this small patch series and add them to who you email for your
entire series, otherwise at times they won't be able to properly review
or understand the exact context of the changes. You want folks to do less
work to review, not more.

So please resend and add others to the other patches.

  Luis
