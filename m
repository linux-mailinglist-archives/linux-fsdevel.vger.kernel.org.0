Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAD2753E11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 16:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbjGNOvw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 10:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbjGNOvv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:51:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525DE268F;
        Fri, 14 Jul 2023 07:51:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D665961D38;
        Fri, 14 Jul 2023 14:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3620AC433C8;
        Fri, 14 Jul 2023 14:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689346309;
        bh=EmuXgMswwpll4+eXL/sCR+UsTsoPPhcDdmhzY0al6U8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IOLJ93GLYwwrL7hycURFHrroTCpSoA1wSjWRX1Q0yfnwXhpVQdRFcV8UoBV5E2Z+s
         kFWdj1nxmD8/oZYvWB0LVEqhKRXyjvX/joSOg9miNHpQz1w/8v/fniR4Pu9Z4JcqVw
         mXpgle//ggCGDZMfaiZZ8tgjsVpOUNBXFJ+WyHOcBleXXe6G7471hbchybO9ZVM1RT
         XbGYzljob4UNWwBEDaGxxWlLpRu/wF7w7MMOgd+Y/mkduLKiTcqireO6diqLU3gjug
         sga0eV1irq6/3NAr9O6JUPFQAt3A89/RnTAxJ/TrujuZwPLVXNbl/+maO56vt7QQ40
         Y6SdI7+SfKBAA==
Date:   Fri, 14 Jul 2023 07:51:48 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [PATCH 1/2] iomap: fix a regression for partial write errors
Message-ID: <20230714145148.GW108251@frogsfrogsfrogs>
References: <20230714085124.548920-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714085124.548920-1-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 14, 2023 at 10:51:23AM +0200, Christoph Hellwig wrote:
> When write* wrote some data it should return the amount of written data
> and not the error code that caused it to stop.  Fix a recent regression
> in iomap_file_buffered_write that caused it to return the errno instead.
> 
> Fixes: 219580eea1ee ("iomap: update ki_pos in iomap_file_buffered_write")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Reported-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Simple enough reversion, sorry for the breakage...

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index adb92cdb24b009..7cc9f7274883a5 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -872,7 +872,7 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
>  		iter.processed = iomap_write_iter(&iter, i);
>  
> -	if (unlikely(ret < 0))
> +	if (unlikely(iter.pos == iocb->ki_pos))
>  		return ret;
>  	ret = iter.pos - iocb->ki_pos;
>  	iocb->ki_pos += ret;
> -- 
> 2.39.2
> 
