Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A97E59EA3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 19:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiHWRrP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 13:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbiHWRql (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:46:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED2AAD9BE;
        Tue, 23 Aug 2022 08:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3KC+y7shGXfeXR6lfiy6v4DMA4hsK0wDHXXQ2rqtmzE=; b=RgjB6Fu6K+t8NIO2AEpqYam85Q
        y0FUgg0QZg9krQv1A24ct2FhPIXLHILmDAHektLa+qxQEWNuPyOU6HubTTzk07YXry1hsk5y1myrV
        Xqw+ND2XRUsA8izEoKizya6ZlmBl4nuRaRhCjhG+OAaRpocWvhxr3zNH8NooQS/DjreVhGsfuxKFP
        FOAho2rqgrSWmT3Q0w0FsH2hrbGe6hPI7GdePrYk7KU8B+vdkEt2uSBOkbHzZ/iFCrUchmzcunsWF
        uJKC87/w4IUKGS5ixkly/7EkD2REGVNKiJw59uKXM3Criso4Yhzd1BSP5myede87xAdRuMcpXeRfE
        Syrjdeow==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQW2d-00FP8U-Rf; Tue, 23 Aug 2022 15:42:11 +0000
Date:   Tue, 23 Aug 2022 16:42:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     david@fromorbit.com, djwong@kernel.org, fgheet255t@gmail.com,
        hch@infradead.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, riteshh@linux.ibm.com,
        syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in iomap_iter
Message-ID: <YwT1U18DuzmEaLAL@casper.infradead.org>
References: <YwTyO0yZmUT1MVZW@casper.infradead.org>
 <20220823153542.177799-1-code@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823153542.177799-1-code@siddh.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 23, 2022 at 09:05:42PM +0530, Siddh Raman Pant wrote:
> Oof, I didn't mean it to be there. That would actually be wrong anyways.
> 
> Extremely sorry for the avoidable oversight,
> Siddh
> 
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> ---
>  drivers/block/loop.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index e3c0ba93c1a3..e1fe8eda020f 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -979,6 +979,11 @@ loop_set_status_from_info(struct loop_device *lo,
>  
>  	lo->lo_offset = info->lo_offset;
>  	lo->lo_sizelimit = info->lo_sizelimit;
> +
> +	/* loff_t vars have been assigned __u64 */
> +	if (lo->lo_offset < 0 || lo->lo_sizelimit < 0)
> +		return -EOVERFLOW;
> +
>  	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
>  	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
>  	lo->lo_flags = info->lo_flags;
> -- 
> 2.35.1
> 
> 
