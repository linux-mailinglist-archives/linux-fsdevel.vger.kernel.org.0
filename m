Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EB6598665
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 16:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343706AbiHROuP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 10:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343684AbiHROuO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:50:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6822EB56FA;
        Thu, 18 Aug 2022 07:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kcvfVewPJvPhkIgYC4PjI+fY/pTp+IQ+7EHGsX/jXkc=; b=BLTlKkx4WurVPayDWJNAkI2zNs
        sCVob1kKu+ckvs1ZrBnEMoy/sKzfiWO9Ni/jhwSz5BZww81yfvgcdBjhjGF6ybu35TVci544IE99C
        BqWwS7mfaTqbWf7yt05HrL1U8PfX2nSaCAT9kXtGCa1rbxShhtYblgfZ+xhi9+Lg36Cx+YQBbUGsr
        3v4qigAHqo3dq1AzIOfXSuB0zslO2ILy2Maouz0d5lTB6wLAbDSFS8hB4YBdTAtdAyCLCtXhSsJ+W
        WXyzna/4JsLROYfsgDOSTiLuDMOi1BYFVbEQOlLVzC3uO85Hbu+ZodK87Po/CFWy+hdcKyVlmNdFq
        zdhlzPeA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOgqQ-009tn9-KD; Thu, 18 Aug 2022 14:50:02 +0000
Date:   Thu, 18 Aug 2022 15:50:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     david@fromorbit.com, djwong@kernel.org, fgheet255t@gmail.com,
        hch@infradead.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, riteshh@linux.ibm.com,
        syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in iomap_iter
Message-ID: <Yv5RmsUvRh+RKpXH@casper.infradead.org>
References: <20220818110031.89467-1-code@siddh.me>
 <20220818111117.102681-1-code@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818111117.102681-1-code@siddh.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 18, 2022 at 04:41:17PM +0530, Siddh Raman Pant wrote:
>  include/uapi/linux/loop.h | 12 ++++++------

I don't think changing these from u64 to s64 is the right way to go.

>  2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index e3c0ba93c1a3..4ca20ce3158d 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -977,6 +977,9 @@ loop_set_status_from_info(struct loop_device *lo,
>  		return -EINVAL;
>  	}
>  
> +	if (info->lo_offset < 0 || info->lo_sizelimit < 0)
> +		return -EINVAL;
> +
>  	lo->lo_offset = info->lo_offset;
>  	lo->lo_sizelimit = info->lo_sizelimit;

I'd instead do it here:

	if (lo>lo_offset < 0 || lo->lo_sizelimit < 0)
		return -EINVAL;

