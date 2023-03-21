Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0706C3732
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 17:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjCUQnC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 12:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCUQmy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:42:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA787515C9;
        Tue, 21 Mar 2023 09:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jsbGFAPDCCg1dpVP/wNsQmBc5RaDf7+l5JCSc8t9iVo=; b=FhnEeA6H4LtXOaucATPKvixKkl
        RYM9VcfEKEv1zcsXDwbruTgihnGwu/d/9AAISum2o32B2CZYg0W//xM1V4aoWZ0u4aPOiYRd+AwJV
        RTSLEVcH1DLOpMhrHMvFBrk1hmSbgkWGUFD094FO5gTCnQyHxDh9GIg0m95lnWMzk/dQodobrYNKk
        xMAU9eMId00FGTiOlziX10V0R1leDkMXedb0oyrIE08frrnG1gHxZMQKJAPhnA5WBPuijWS3Yb1Cj
        fxFgXB10JU2hjdg8AzhphoLvW2D6/bbB5yC2JPDPOgRtWhIxxdvRGAx1a6QX364L05SExMP7BUTol
        Hqx1+ZZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pef4C-002CVB-I5; Tue, 21 Mar 2023 16:42:32 +0000
Date:   Tue, 21 Mar 2023 16:42:32 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] fs/drop_caches: move drop_caches sysctls into its own
 file
Message-ID: <ZBneeOYHKBZl8SGe@casper.infradead.org>
References: <20230321130908.6972-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321130908.6972-1-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 21, 2023 at 09:09:07PM +0800, Yangtao Li wrote:
> +static struct ctl_table drop_caches_table[] = {
> +	{
> +		.procname	= "drop_caches",
> +		.data		= &sysctl_drop_caches,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0200,
> +		.proc_handler	= drop_caches_sysctl_handler,
> +		.extra1		= SYSCTL_ONE,
> +		.extra2		= SYSCTL_FOUR,
> +	},
> +	{}
> +};

Could we avoid doing this until we no longer need an entire zero entry
after the last one?  Also, please post scripts/bloat-o-meter results
for before-and-after.
