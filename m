Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414CE6C775A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 06:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjCXF3p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 01:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjCXF31 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:29:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4987EC6;
        Thu, 23 Mar 2023 22:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TV7YjIHRnPh40nGPyD/b78oZpFAOJePPPC7MTmz9a1E=; b=EIrDU50rOI3Xz29qFSRpu11dlA
        AedAprTuENA3LXMn+itdT5GR8eAmD+eYCT3X4rZmtp4UwlAAU8ysqXbRrEEaoALSZXOL/lv92RfZ5
        oedESncsWBOyYdJkBfy9QKdZFQ0kXzMJFlweZE5RgLd+7F+FbeJQX27xvC1kLDBcgOc4gFKjVIW4M
        9v8nh1N7zFi8SoHMrM1ErH84s8Y/jRKPjVoRo6c/0po/nnr2fqcyF5TCBjFPXdljmDUAmAPIxXO54
        fanlmz0MKjaVGp95DOScKK1RaL1ogjU/bQShSDQM9950rIzQb8+J5fGUhABDotI4f4zS7lBqqGPE0
        nBANTGKA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfZyA-004bql-1q; Fri, 24 Mar 2023 05:28:06 +0000
Date:   Fri, 24 Mar 2023 05:28:06 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     aloktiagi <aloktiagi@gmail.com>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        David.Laight@aculab.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        hch@infradead.org, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [RFC v3 2/3] file: allow callers to free the old file descriptor
 after dup2
Message-ID: <ZB005rys4ZTeaQfU@casper.infradead.org>
References: <20230324051526.963702-1-aloktiagi@gmail.com>
 <20230324051526.963702-2-aloktiagi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324051526.963702-2-aloktiagi@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 24, 2023 at 05:15:25AM +0000, aloktiagi wrote:
> @@ -1119,8 +1119,12 @@ __releases(&files->file_lock)
>  		__clear_close_on_exec(fd, fdt);
>  	spin_unlock(&files->file_lock);
>  
> -	if (tofree)
> -		filp_close(tofree, files);
> +	if (fdfile) {
> +		*fdfile = tofree;
> +	} else {
> +		if (tofree)
> +			filp_close(tofree, files);
> +	}

Why not:

	if (fdfile)
		 *fdfile = tofree;
	else if (tofree)
		filp_close(tofree, files);

Shorter and makes the parallel structure more obvious.

