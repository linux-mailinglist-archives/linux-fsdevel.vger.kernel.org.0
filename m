Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2646225E1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 14:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgGTMDV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 08:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbgGTMDU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 08:03:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5661BC061794;
        Mon, 20 Jul 2020 05:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r6dsj8pxTqtn3NLeQXECCjoNOIjatp7b7gHsR16dalE=; b=G99G9fsltR8hD/EK9QDcnBEEz2
        FQqtw0X4kXGCmPR/TyA6+POEoGYjCkwY3qg4zkV3LQxWPuj2J3tHRtw8RG31CXwcFesePGPczjqVE
        HbLM9v8+iPBDhpNMKGDPYYzvG62Fwwva/zH1F73qlENXRTOrGIb2LkC6qdC+s0l8pxbJdlFri0hN/
        52GP4VhKwqWIa0btJFBOdGMkIYyYdIo+RQq2FYBh5907sDhk7iPeP6ImcQ6PpdqcfiV4LUR7Sq2yD
        vITnkccfjhiSEmnbEq27DdbpfKMsrREHZx2bpFeigQxYVriBjbcUF9zJ+aB+hTwNw8+5rbE0GqOWT
        4o+bKLxA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxUVi-00029K-E0; Mon, 20 Jul 2020 12:03:10 +0000
Date:   Mon, 20 Jul 2020 13:03:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Wang Long <w@laoqinren.net>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] xarray: update document for error space returned by
 xarray normal API
Message-ID: <20200720120310.GV12769@casper.infradead.org>
References: <1595218658-53727-1-git-send-email-w@laoqinren.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595218658-53727-1-git-send-email-w@laoqinren.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 20, 2020 at 12:17:38PM +0800, Wang Long wrote:
> In the current xarray code, the negative value -1 and -4095 represented
> as an error.
> 
> xa_is_err(xa_mk_internal(-4095)) and xa_is_err(xa_mk_internal(-1))
> are all return true.
> 
> This patch update the document.

There are actually three distinct problems here, but none of them are
fixed by this patch.

The first is that there's no test-suite coverage for this.
The second is that xa_is_err() is checking against -MAX_ERRNO instead of
-1023.
The third is that the documentation isn't clear enough because the line
you're correcting is accurate.

I don't think any of these three problems is terribly urgent to fix.
The second is most important because it could lead to confusion between
an xa_node that happens to be allocated at the top of memory and an
error return, but I don't think there is ever a situation where we end
up checking a node entry for being an error entry.  I may be wrong.

The solution to the first problem probably looks like this:

+++ b/lib/test_xarray.c
@@ -81,6 +81,11 @@ static void *xa_store_order(struct xarray *xa, unsigned long index,
 
 static noinline void check_xa_err(struct xarray *xa)
 {
+       XA_BUG_ON(xa, xa_is_err(xa_mk_internal(0)));
+       XA_BUG_ON(xa, !xa_is_err(xa_mk_internal(-1)));
+       XA_BUG_ON(xa, !xa_is_err(xa_mk_internal(-1023)));
+       XA_BUG_ON(xa, xa_is_err(xa_mk_internal(-1024)));
+
        XA_BUG_ON(xa, xa_err(xa_store_index(xa, 0, GFP_NOWAIT)) != 0);
        XA_BUG_ON(xa, xa_err(xa_erase(xa, 0)) != 0);
 #ifndef __KERNEL__


> Signed-off-by: Wang Long <w@laoqinren.net>
> ---
>  include/linux/xarray.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
> index b4d70e7..0588fb9 100644
> --- a/include/linux/xarray.h
> +++ b/include/linux/xarray.h
> @@ -36,7 +36,7 @@
>   * 257: Zero entry
>   *
>   * Errors are also represented as internal entries, but use the negative
> - * space (-4094 to -2).  They're never stored in the slots array; only
> + * space (-4095 to -1).  They're never stored in the slots array; only
>   * returned by the normal API.
>   */
>  
> -- 
> 1.8.3.1
> 
> 
> 
> 
