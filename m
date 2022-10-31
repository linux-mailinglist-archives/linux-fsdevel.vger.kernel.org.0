Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226F3613870
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 14:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiJaNxe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 09:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiJaNxd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:53:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC9AF009
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 06:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XWkecNOLLa725kieZWzUtGZZJ1BiGuXEX5YrOzGl6yA=; b=T/Elvhm0xu9XeLTbzMnhIoGaMI
        Xt1zi9CJ1yvWJ+Vxf3zbpUB3kuiz8pVO0RZss7uccuXoJZ539cK4VmIgTKYE5IyRWbEqukY/DZ/t0
        NOFdVU3PiEbrTsBWnXRJXcIFovxR2WA9+cB7d+vJrsBocKzHL3CJ6NOHGXSPCGn9SeY4l49KaMZlN
        WbOblFCM1h7rdy07xlKVxGfgesnkA7JkRxU6pv1ggvGBo5XCUqyDYUhPMUaZbE64ATEPjricRe35P
        serDOqU432TX1sEtFxAjSMO4CPADQZkl+cbxQg5jR60IG2Be1cur6BSSBJQJqNYcWroYT7uzpHlCX
        bfiFwWew==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opVEH-003ioB-KJ; Mon, 31 Oct 2022 13:53:29 +0000
Date:   Mon, 31 Oct 2022 13:53:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     hch@infradead.org, viro@zeniv.linux.org.uk, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs: fix undefined behavior in bit shift for SB_NOUSER
Message-ID: <Y1/TWdY//yUgXGck@casper.infradead.org>
References: <20221031134811.178127-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031134811.178127-1-cuigaosheng1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 31, 2022 at 09:48:11PM +0800, Gaosheng Cui wrote:
> +++ b/include/linux/fs.h
> @@ -1384,19 +1384,19 @@ extern int send_sigurg(struct fown_struct *fown);
>  #define SB_NOATIME	1024	/* Do not update access times. */
>  #define SB_NODIRATIME	2048	/* Do not update directory access times */
>  #define SB_SILENT	32768

Shouldn't those ^^^ also be marked as unsigned?  And it's confusing to
have the style change halfway through the sequence; can you convert them
to (1U << n) as well?

> -#define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
> -#define SB_INLINECRYPT	(1<<17)	/* Use blk-crypto for encrypted files */
> -#define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
> -#define SB_I_VERSION	(1<<23) /* Update inode I_version field */
> -#define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
> +#define SB_POSIXACL	(1U << 16) /* VFS does not apply the umask */
> +#define SB_INLINECRYPT	(1U << 17) /* Use blk-crypto for encrypted files */
> +#define SB_KERNMOUNT	(1U << 22) /* this is a kern_mount call */
> +#define SB_I_VERSION	(1U << 23) /* Update inode I_version field */
> +#define SB_LAZYTIME	(1U << 25) /* Update the on-disk [acm]times lazily */
>  
>  /* These sb flags are internal to the kernel */
> -#define SB_SUBMOUNT     (1<<26)
> -#define SB_FORCE    	(1<<27)
> -#define SB_NOSEC	(1<<28)
> -#define SB_BORN		(1<<29)
> -#define SB_ACTIVE	(1<<30)
> -#define SB_NOUSER	(1<<31)
> +#define SB_SUBMOUNT	(1U << 26)
> +#define SB_FORCE	(1U << 27)
> +#define SB_NOSEC	(1U << 28)
> +#define SB_BORN		(1U << 29)
> +#define SB_ACTIVE	(1U << 30)
> +#define SB_NOUSER	(1U << 31)
>  
>  /* These flags relate to encoding and casefolding */
>  #define SB_ENC_STRICT_MODE_FL	(1 << 0)
> -- 
> 2.25.1
> 
