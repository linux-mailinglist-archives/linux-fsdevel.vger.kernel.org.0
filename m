Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343BA5972CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 17:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237677AbiHQPRD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 11:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiHQPRC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:17:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5831D85ABB
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 08:17:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2357FB81DBA
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 15:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADFB1C433D6;
        Wed, 17 Aug 2022 15:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660749418;
        bh=bvyIzZJrRa0bm3MH19GN/vBsiy/w3mR0xQi5d0Eecok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fz6z0mdUDidus0UBEQuLMFF9undb497YyoXteTH+zr7rQFFrA+zzafteY6foWTcMR
         4yEfvAVwEu273CEHonTWw9ZYaA94lLX7YlP3MbBuNoYBTTlECm5C/DkgKbM9UZ45zn
         NGkQS87KP4cBHiqgOFqEuh0SdGOuOD/Nqot7S0FU=
Date:   Wed, 17 Aug 2022 08:16:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Guixin Liu <kanie@linux.alibaba.com>
Cc:     willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [RFC PATCH] mm/filemap.c: fix the timing of asignment of
 prev_pos
Message-Id: <20220817081657.5e8332cec593621fccfacf93@linux-foundation.org>
In-Reply-To: <1660744317-8183-1-git-send-email-kanie@linux.alibaba.com>
References: <1660744317-8183-1-git-send-email-kanie@linux.alibaba.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 17 Aug 2022 21:51:57 +0800 Guixin Liu <kanie@linux.alibaba.com> wrote:

> The prev_pos should be assigned before the iocb->ki_pos is incremented,
> so that the prev_pos is the exact location of the last visit.
> 
> Fixes: 06c0444290cec ("mm/filemap.c: generic_file_buffered_read() now
> uses find_get_pages_contig")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> 
> ---
> Hi guys,
>     When I`m running repetitive 4k read io which has same offset,
> I find that access to folio_mark_accessed is inevitable in the
> read process, the reason is that the prev_pos is assigned after the
> iocb->ki_pos is incremented, so that the prev_pos is always not equal
> to the position currently visited.
>     Is this a bug that needs fixing?

It looks wrong to me and it does appear that 06c0444290cecf0 did this
unintentionally.

> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2703,8 +2703,8 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>  			copied = copy_folio_to_iter(folio, offset, bytes, iter);
>  
>  			already_read += copied;
> -			iocb->ki_pos += copied;
>  			ra->prev_pos = iocb->ki_pos;
> +			iocb->ki_pos += copied;
>  
>  			if (copied < bytes) {
>  				error = -EFAULT;

So we significantly messed up pagecache page aging and nobody noticed
for nearly two years.  What does this tell us :(

I'd be interested if anyone can demonstrate runtime effects from this
change.  If yes then I'll add cc:stable.  If no then I'll ask why we
even bothered.
