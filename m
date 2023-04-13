Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A8D6E0AAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 11:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjDMJyb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 05:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDMJy1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:54:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5863974C;
        Thu, 13 Apr 2023 02:54:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68EFB63CBA;
        Thu, 13 Apr 2023 09:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F7EC4339B;
        Thu, 13 Apr 2023 09:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681379665;
        bh=726Vv60nLcRdRHuGleJutcRXEfvdcGUOQyO8Iw43z4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mz0N6CFUcySJeqze4kP14fQT5OCeSIYFDgiy5UBN9q6JYZsGxk0+iigYbKZIHOXiK
         EOmTo1cdk3GrGqUwF3jar22s+fxkqWLSXeRmkpg8waksWZQ0YU/W3WbIAy++JMkHap
         oPk56w2yVkG3JludMsg6Hu6LaPuTolGdTINvLFaACNS89niQcC5+tBCFUylTw9mg4Q
         +0md7VcifMrK+HUefuPliBF6iT7isKvCTwqQFgMNwLvqsdWAFgkY3oT4cfUKMIB9P/
         HOr1b0iUZS4YbJ4L8xZIOFCdf4A/V2JVAcL5728E3DSlzpZQpWao3OSmsv5bY3wTeh
         V31bWhVBfqy5A==
Date:   Thu, 13 Apr 2023 11:54:20 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFCv3 06/10] fs.h: Add TRACE_IOCB_STRINGS for use in trace
 points
Message-ID: <20230413-rauchen-gesalzen-f15b4be69248@brauner>
References: <cover.1681365596.git.ritesh.list@gmail.com>
 <1b57f3a973377392df1f1d02442675ac5fd0c115.1681365596.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b57f3a973377392df1f1d02442675ac5fd0c115.1681365596.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 13, 2023 at 02:10:28PM +0530, Ritesh Harjani (IBM) wrote:
> Add TRACE_IOCB_STRINGS macro which can be used in the trace point patch to
> print different flag values with meaningful string output.
> 
> Tested-by: Disha Goel <disgoel@linux.ibm.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---

Fine, but fs.h is such a dumping ground already I hope we can split more
stuff out of it going forward...

>  include/linux/fs.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 9ca3813f43e2..6903fc15987a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -340,6 +340,20 @@ enum rw_hint {
>  /* can use bio alloc cache */
>  #define IOCB_ALLOC_CACHE	(1 << 21)
>  
> +/* for use in trace events */
> +#define TRACE_IOCB_STRINGS \
> +	{ IOCB_HIPRI, "HIPRI"	}, \
> +	{ IOCB_DSYNC, "DSYNC"	}, \
> +	{ IOCB_SYNC, "SYNC"	}, \
> +	{ IOCB_NOWAIT, "NOWAIT" }, \
> +	{ IOCB_APPEND, "APPEND" }, \
> +	{ IOCB_EVENTFD, "EVENTD"}, \

s/EVENTD/EVENTFD/
