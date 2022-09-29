Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8BC5EFFD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 00:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiI2WAW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 18:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiI2WAU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 18:00:20 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E742FD58A1;
        Thu, 29 Sep 2022 15:00:18 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au [49.181.106.210])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id CE0168AB466;
        Fri, 30 Sep 2022 08:00:15 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oe1Zm-00Dih8-3s; Fri, 30 Sep 2022 08:00:14 +1000
Date:   Fri, 30 Sep 2022 08:00:14 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] iomap: add a tracepoint for mappings returned by
 map_blocks
Message-ID: <20220929220014.GH3600936@dread.disaster.area>
References: <YzXnt8Qr+IVF38+7@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzXnt8Qr+IVF38+7@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=63361570
        a=j6JUzzrSC7wlfFge/rmVbg==:117 a=j6JUzzrSC7wlfFge/rmVbg==:17
        a=kj9zAlcOel0A:10 a=xOM3xZuef0cA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
        a=7-415B0cAAAA:8 a=ORDN_mDP8pton5EWOZ0A:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 11:45:11AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add a new tracepoint so we can see what mapping the filesystem returns
> to writeback a dirty page.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/iomap/buffered-io.c |    1 +
>  fs/iomap/trace.h       |    1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 77d59c159248..91ee0b308e13 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1360,6 +1360,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		error = wpc->ops->map_blocks(wpc, inode, pos);
>  		if (error)
>  			break;
> +		trace_iomap_writepage_map(inode, &wpc->iomap);
>  		if (WARN_ON_ONCE(wpc->iomap.type == IOMAP_INLINE))
>  			continue;
>  		if (wpc->iomap.type == IOMAP_HOLE)
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index d48868fc40d7..f6ea9540d082 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -148,6 +148,7 @@ DEFINE_EVENT(iomap_class, name,	\
>  	TP_ARGS(inode, iomap))
>  DEFINE_IOMAP_EVENT(iomap_iter_dstmap);
>  DEFINE_IOMAP_EVENT(iomap_iter_srcmap);
> +DEFINE_IOMAP_EVENT(iomap_writepage_map);
>  
>  TRACE_EVENT(iomap_iter,
>  	TP_PROTO(struct iomap_iter *iter, const void *ops,

Looks fine.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
