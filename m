Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DD725CF86
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 04:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbgIDCzZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 22:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbgIDCzY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 22:55:24 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B549DC061244;
        Thu,  3 Sep 2020 19:55:23 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kE1sd-00A8P7-0S; Fri, 04 Sep 2020 02:55:11 +0000
Date:   Fri, 4 Sep 2020 03:55:10 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 12/14] x86: remove address space overrides using set_fs()
Message-ID: <20200904025510.GO1236603@ZenIV.linux.org.uk>
References: <20200903142242.925828-1-hch@lst.de>
 <20200903142242.925828-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903142242.925828-13-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 03, 2020 at 04:22:40PM +0200, Christoph Hellwig wrote:

> diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
> index c8a85b512796e1..94f7be4971ed04 100644
> --- a/arch/x86/lib/getuser.S
> +++ b/arch/x86/lib/getuser.S
> @@ -35,10 +35,19 @@
>  #include <asm/smap.h>
>  #include <asm/export.h>
>  
> +#ifdef CONFIG_X86_5LEVEL
> +#define LOAD_TASK_SIZE_MINUS_N(n) \
> +	ALTERNATIVE "mov $((1 << 47) - 4096 - (n)),%rdx", \
> +		    "mov $((1 << 56) - 4096 - (n)),%rdx", X86_FEATURE_LA57
> +#else
> +#define LOAD_TASK_SIZE_MINUS_N(n) \
> +	mov $(TASK_SIZE_MAX - (n)),%_ASM_DX
> +#endif

Wait a sec... how is that supposed to build with X86_5LEVEL?  Do you mean

#define LOAD_TASK_SIZE_MINUS_N(n) \
	ALTERNATIVE __stringify(mov $((1 << 47) - 4096 - (n)),%rdx), \
		    __stringify(mov $((1 << 56) - 4096 - (n)),%rdx), X86_FEATURE_LA57

there?
