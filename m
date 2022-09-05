Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5689A5AC8FD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 05:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbiIEDM7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Sep 2022 23:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbiIEDM3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Sep 2022 23:12:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138B82DA8A;
        Sun,  4 Sep 2022 20:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yROR3A9qWQE0YvXg0cAkFq4b3tbcszFyRiafJdzCw04=; b=rYjH3wCeNvv7VWbzH0NNY7xGxf
        3LxfgwDO8fGfiA/yCk8k0strCTYu25k0NUgXPs7yTMe+QTdDDhRflu4IrIRDK1Ay8phPN9PZnDPgw
        XQXjGxa4eR6q6CyDt4iEPAsDBzTJfGz9h5dUqjO4F0d9dR5KiI0lSLsdPtlI+wJ81nr9825x/3RLL
        lJ3Gvksm4iBMHM/L+2sUq5W1x4Jp/b8+Z7xoYVll3J/gPOBLE8NUXQjk244+6oubckgV/dTmaVv79
        zXz3i9uM3QcK0I2PhDy2NXqv6RD7Tkg5yNo5jPS9K60yIC4lVaekzzIBswj9KUcwvMPNQxc4nX1lj
        YDYDcZAA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oV2Wx-0097yK-G1; Mon, 05 Sep 2022 03:12:11 +0000
Date:   Mon, 5 Sep 2022 04:12:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Li zeming <zeming@nfschina.com>
Cc:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc/proc_sysctl: Modify the order of scheduling
 function calls
Message-ID: <YxVpCyHBweai9npY@casper.infradead.org>
References: <20220905012925.3117-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905012925.3117-1-zeming@nfschina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 05, 2022 at 09:29:25AM +0800, Li zeming wrote:
> When the ctl_table_header object is judged to be valid, the scheduling
> check is performed again.

No, we want the check in all cases, even if the header is NULL.

> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>  fs/proc/proc_sysctl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 50ba9e4fb284..36921e2ebeb0 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -1729,11 +1729,10 @@ static void drop_sysctl_table(struct ctl_table_header *header)
>  void unregister_sysctl_table(struct ctl_table_header * header)
>  {
>  	int nr_subheaders;
> -	might_sleep();
> -
>  	if (header == NULL)
>  		return;
>  
> +	might_sleep();
>  	nr_subheaders = count_subheaders(header->ctl_table_arg);
>  	if (unlikely(nr_subheaders > 1)) {
>  		struct ctl_table_header **subheaders;
> -- 
> 2.18.2
> 
