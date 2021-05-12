Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E01337EE9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 00:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347620AbhELVyl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 17:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390110AbhELVtZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 17:49:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E9CC061763;
        Wed, 12 May 2021 14:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7A7HMOGi56yiHuwqH8IQWJw8WnpwX4w/xlLU5VhAyUg=; b=l8kG07dKTfVHHcSVRY+nHuPqwV
        hklw5xsgZ4sdEusGnBYomzVlFCJmpnb7DPQretQdjO82JK/2bWBYsGCw2qC3YmTTh4sFtaT55olw4
        0LOqp7UEOHggob10edxNgWYx+twiVeP+69pfoo0VwXAeuAHr0D40yzFBesVax3gL/+oeLu9pluXS4
        QuLlBVa+3I96fKWVS2kD9DQZ5WRdJ16f0fCbmUCAZ5GjPJVOPolPunZCPFHS3E2i2y6/fxv0+NiFI
        AdIdCFQ7ulqFLiODR9T4/C/Dzu0UHuyKSu9pU0g6eK+MrTrUiHfcb4RxsI6U1dfEoKiEjgRm5wIT+
        +mwmL1yg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgwgZ-008uHI-O8; Wed, 12 May 2021 21:47:05 +0000
Date:   Wed, 12 May 2021 22:46:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] radix tree test suite: Add __must_be_array() support
Message-ID: <YJxMt92cy/9zM7li@casper.infradead.org>
References: <20210512184850.3526677-1-Liam.Howlett@Oracle.com>
 <20210512184850.3526677-2-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512184850.3526677-2-Liam.Howlett@Oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 12, 2021 at 06:48:52PM +0000, Liam Howlett wrote:
> Copy __must_be_array() define from include/linux/compiler.h for use in
> the radix tree test suite userspace compiles.

We needed this earlier, but see commit
7487de534dcbe143e6f41da751dd3ffcf93b00ee

I bet if you revert this commit, it'll still build fine.

Also, I bet patch 1/4 is the same -- I see a definition of
fallthrough in tools/include/linux/compiler-gcc.h

> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  tools/testing/radix-tree/linux/kernel.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-tree/linux/kernel.h
> index c400a27e544a..2c3771fff2c0 100644
> --- a/tools/testing/radix-tree/linux/kernel.h
> +++ b/tools/testing/radix-tree/linux/kernel.h
> @@ -30,4 +30,6 @@
>  # define fallthrough                    do {} while (0)  /* fallthrough */
>  #endif /* __has_attribute */
>  
> +#define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
> +
>  #endif /* _KERNEL_H */
> -- 
> 2.30.2
