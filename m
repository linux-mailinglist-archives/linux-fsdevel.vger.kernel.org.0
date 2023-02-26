Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817956A3587
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 00:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjBZXM5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 18:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjBZXM4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 18:12:56 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579043A82
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Feb 2023 15:12:55 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso339349pjb.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Feb 2023 15:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TwZNoR51p1x2zsuL9SYO3/6YS2NiEz18nrjCQsyjfus=;
        b=UHaq4QsVi+98zPnNaF7nYMsDyPfg3dScUaBqTzoJ0D09H3tlN5ysRzFz69YCXQFfft
         NDIcmx5Zk4xalTcbWIOWnWYQFU8/4rQDlZJr8z5qOPfi0nnSZSXAEo5U/3Nfa4sPj7Tb
         9sc8434DitETWXOTwnYjCicCKOsF+fOIiRJbKu27/mY/ab7VEwC4kUqjqH2fRrpWZlcq
         aPOhgqbuH/xdVXddiZANY4S+4U3Ksa43ihUSwbhxfVCnw955pCq6gutZowbMly92LBZv
         cmZVkmVeYb/8S6Nm2/a92TWY1IUhnMPT3G/GZr+WZUIl64hRf5vo90fACa/tASPg/0P6
         v5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwZNoR51p1x2zsuL9SYO3/6YS2NiEz18nrjCQsyjfus=;
        b=jQCdsvwsNY8V8kUnKcLKjPUhghmI775IgXYH5ew/homzSpRbA/EpULFxjqZswa5BOb
         fPtgn3or6QcbvO/neSVmXWgDoKwpEVO9Az5JmE1G7dNrx/7Ao64btBQzZTJsxjnF1Y1l
         GaAOC4M+YkmNfTahL8YiTB7O/tLO/VqnCfRvCiI0ui6cjIAODVL16wtdBlXwlqzYwk1J
         SI/+h0F198h3JKlTcbnf8vYxEY5FxgShOTgF7gi+psgihAJAT9lYhhgeBh8QgtYQol0N
         euU8VuOXREMB8fXanqb775hMR2FZ9t/VkfMRADsfdMrAHwvN8x0OOiB4ip4Od6wU7Egt
         3yDQ==
X-Gm-Message-State: AO0yUKVnToL7UvtyXkTp1X9b6qZzjRf1f4nw38lG+qdgAJqoVWISsjA/
        9Kf/Wp5BktjDLT208s+CP2p6iK8zRSdjOixb
X-Google-Smtp-Source: AK7set/JHxQegoPFrPfFn77k3xg9iEJjQbP3Q2lQJI1KDI8z18S3wmO+ZEZ1dBYXe0sO3barGhJTQg==
X-Received: by 2002:a17:902:dacf:b0:19c:d32a:befc with SMTP id q15-20020a170902dacf00b0019cd32abefcmr12023843plx.15.1677453174840;
        Sun, 26 Feb 2023 15:12:54 -0800 (PST)
Received: from dread.disaster.area (pa49-186-4-237.pa.vic.optusnet.com.au. [49.186.4.237])
        by smtp.gmail.com with ESMTPSA id e19-20020a170902ed9300b0019949fd956bsm3137549plj.178.2023.02.26.15.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 15:12:54 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pWQCJ-002Vyy-Ef; Mon, 27 Feb 2023 10:12:51 +1100
Date:   Mon, 27 Feb 2023 10:12:51 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFCv3 2/3] iomap: Change uptodate variable name to state
Message-ID: <20230226231251.GW360264@dread.disaster.area>
References: <cover.1677428794.git.ritesh.list@gmail.com>
 <457680a57d7c581aae81def50773ed96034af420.1677428794.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457680a57d7c581aae81def50773ed96034af420.1677428794.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 27, 2023 at 01:13:31AM +0530, Ritesh Harjani (IBM) wrote:
> This patch changes the struct iomap_page uptodate & uptodate_lock
> member names to state and state_lock to better reflect their purpose
> for the upcoming patch. It also introduces the accessor functions for
> updating uptodate state bits in iop->state bitmap. This makes the code
> easy to understand on when different bitmap types are getting referred
> in different code paths.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 65 ++++++++++++++++++++++++++++++++----------
>  1 file changed, 50 insertions(+), 15 deletions(-)
....

The mechanical change itself looks fine, so from that perspective:

Reviewed-by: Dave Chinner <dchinner@redhat.com>

However, I'm wondering about the efficiency of these bit searches.

> @@ -110,7 +143,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>  
>  		/* move forward for each leading block marked uptodate */
>  		for (i = first; i <= last; i++) {
> -			if (!test_bit(i, iop->uptodate))
> +			if (!iop_test_uptodate(iop, i, nr_blocks))
>  				break;
>  			*pos += block_size;
>  			poff += block_size;

Looking at this code, it could have been written to use
find_first_zero_bit() rather than testing each bit individually...

> @@ -120,7 +153,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>  
>  		/* truncate len if we find any trailing uptodate block(s) */
>  		for ( ; i <= last; i++) {
> -			if (test_bit(i, iop->uptodate)) {
> +			if (iop_test_uptodate(iop, i, nr_blocks)) {
>  				plen -= (last - i + 1) * block_size;
>  				last = i - 1;
>  				break;

And this is find_first_bit()...

>  static void iomap_set_range_uptodate(struct folio *folio,
> @@ -439,6 +473,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
>  	struct iomap_page *iop = to_iomap_page(folio);
>  	struct inode *inode = folio->mapping->host;
>  	unsigned first, last, i;
> +	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
>  
>  	if (!iop)
>  		return false;
> @@ -451,7 +486,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
>  	last = (from + count - 1) >> inode->i_blkbits;
>  
>  	for (i = first; i <= last; i++)
> -		if (!test_bit(i, iop->uptodate))
> +		if (!iop_test_uptodate(iop, i, nr_blocks))
>  			return false;

Again, find_first_zero_bit().

These seem like worthwhile optimisations in light of the heavier use
these bitmaps will get with sub-folio dirty tracking, especially
considering large folios will now use these paths. Do these
interface changes preclude the use of efficient bitmap searching
functions?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
