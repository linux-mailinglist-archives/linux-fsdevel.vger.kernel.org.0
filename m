Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6526744409
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 23:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjF3VpB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 17:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjF3Vo7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 17:44:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5672D78;
        Fri, 30 Jun 2023 14:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+cB9Vy4PGBCg00Ikr+gnSUEOhOgkOBzDU9EJ0vrWwfE=; b=NwfAsxr+tiUQkGXB2OgurImbgT
        kArhJcKlMjiPJJ1RV6tuQO0aFk2Ri9ssoAyfpPoxLKMdyo6ViviRBytG1sxLOSS+zuWFLg6GBloZT
        JBSz2kdkrXtfDfk+FsYdXaIOo/xoszMs3AgfTS+pRdo9AuvkrPiFdteT7r0BSntHNtmFTA03O+afE
        ij39sXJZr4wmrH75D4JV+GkFSDWD316XfN/hnEkhq39Q32bMTCqz3Yde7dPbzPmtp904ADw8QpQ9h
        S71ZR23ENShAwsRtgirWCO8Aiwsg2vOW1m4+vsYH4tjV3yxNbfaYMERUipgjV/FjrjXEyP9jnbxS4
        VjkycUKg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qFLv3-0062Yq-7k; Fri, 30 Jun 2023 21:44:45 +0000
Date:   Fri, 30 Jun 2023 22:44:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     zenghongling <zenghongling@kylinos.cn>
Cc:     hch@infradead.org, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhongling0719@126.com
Subject: Re: [PATCH] fs: Optimize unixbench's file copy test
Message-ID: <ZJ9MzXol8ZZtYygD@casper.infradead.org>
References: <1688117303-8294-1-git-send-email-zenghongling@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688117303-8294-1-git-send-email-zenghongling@kylinos.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 30, 2023 at 05:28:23PM +0800, zenghongling wrote:
> The iomap_set_range_uptodate function checks if the file is a private
> mapping,and if it is, it needs to do something about it.UnixBench's
> file copy tests are mostly share mapping, such a check would reduce
> file copy scores, so we added the unlikely macro for optimization.
> and the score of file copy can be improved after branch optimization.
>  
> -	if (page_has_private(page))
> +	if (unlikely(page_has_private(page)))

This changelog shows a complete misunderstanding of the code you're
changing.  page_has_private() has nothing to do with whether the file
is "a private mapping", whatever that means.  The test is whether the
filesystem has added private data to the page.

As Darrick said, this code has been completely rewritten in a current
kernel.  You should test with something recent.
