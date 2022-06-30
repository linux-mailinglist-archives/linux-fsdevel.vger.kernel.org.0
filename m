Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C4256263D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 00:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiF3Wp6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 18:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiF3Wp5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:45:57 -0400
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78A924F67B
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 15:45:55 -0700 (PDT)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by gw2.atmark-techno.com (Postfix) with ESMTPS id 440E820CB0
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Jul 2022 07:45:54 +0900 (JST)
Received: by mail-pj1-f70.google.com with SMTP id em12-20020a17090b014c00b001ed493d4f0cso365534pjb.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 15:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=km11n9bibd1DONw/oZcy8niZnRZ3n4v8wZkKOW817eo=;
        b=cH3EjsTnH5btiJkGylipUeNUb6cwusmPIsiL9eaKfIO1M5juo2mEx+WYXOHQ+fBkcu
         sYhnluWQhmOYeTge7ahiMcNwiHc4Ut/eLavxtqOvb8nuzdX9RIfFFe8rHyqo6dWSnMyC
         S8qKP+FpIROd59Dh/6i7GcDpKZ0dGdRbSVMKCUbI0Ub3jGFQCWrBkjrF345dlYfMtUyc
         N9EAo4mDJA5FI6Z5zHYiPjkyKY2LfXcrG2dyK4iNRLtjOqnNkPyd/eanpPDBgW9q52xK
         GaBn2D+8ggnP1dvtg/xICF6ywiggfiNDcuXHGrsSTA0T3rim77xweFmFzXnd+Gvdih6f
         18Iw==
X-Gm-Message-State: AJIora902NjW8Y/W6agg/sHwjANSJG6uIM/xPcboch3zaQkUCKMBIn4P
        SQyCAPizGCqg2shAh55RJKNWVxRY1/mQXaxFKK9wev8g9tlbROS1OirJah+cuf+tqLee41XgQAQ
        +fL+bxxnaKm6WhoRNtJSPCnDCkM8=
X-Received: by 2002:a17:90a:e7c7:b0:1ec:99eb:ff3a with SMTP id kb7-20020a17090ae7c700b001ec99ebff3amr14185460pjb.204.1656629153372;
        Thu, 30 Jun 2022 15:45:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tbEF7rysEj6qq7RxLY0j8faMqmAl6JmAcrnAwXLdvYnDiPLFibeEEek+5kuLiDdUWGgs+lTw==
X-Received: by 2002:a17:90a:e7c7:b0:1ec:99eb:ff3a with SMTP id kb7-20020a17090ae7c700b001ec99ebff3amr14185441pjb.204.1656629153168;
        Thu, 30 Jun 2022 15:45:53 -0700 (PDT)
Received: from pc-zest.atmarktech (117.209.187.35.bc.googleusercontent.com. [35.187.209.117])
        by smtp.gmail.com with ESMTPSA id s9-20020a62e709000000b00527ab697c6asm8281384pfh.18.2022.06.30.15.45.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jun 2022 15:45:52 -0700 (PDT)
Received: from martinet by pc-zest.atmarktech with local (Exim 4.95)
        (envelope-from <martinet@pc-zest>)
        id 1o72su-000Ee0-Uy;
        Fri, 01 Jul 2022 07:43:40 +0900
Date:   Fri, 1 Jul 2022 07:43:30 +0900
From:   Dominique MARTINET <dominique.martinet@atmark-techno.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: Major btrfs fiemap slowdown on file with many extents once in
 cache (RCU stalls?) (Was: [PATCH 1/3] filemap: Correct the conditions for
 marking a folio as accessed)
Message-ID: <Yr4nEoNLkXPKcOBi@atmark-techno.com>
References: <20220619151143.1054746-1-willy@infradead.org>
 <20220619151143.1054746-2-willy@infradead.org>
 <Yr1QwVW+sHWlAqKj@atmark-techno.com>
 <Yr21RoL+ztf1W5Od@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yr21RoL+ztf1W5Od@mit.edu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Theodore Ts'o wrote on Thu, Jun 30, 2022 at 10:37:58AM -0400:
> On Thu, Jun 30, 2022 at 04:29:05PM +0900, Dominique MARTINET wrote:
> > Hi Willy, linux-btrfs@vger,
> > 
> > Matthew Wilcox (Oracle) wrote on Sun, Jun 19, 2022 at 04:11:41PM +0100:
> > > We had an off-by-one error which meant that we never marked the first page
> > > in a read as accessed.  This was visible as a slowdown when re-reading
> > > a file as pages were being evicted from cache too soon.  In reviewing
> > > this code, we noticed a second bug where a multi-page folio would be
> > > marked as accessed multiple times when doing reads that were less than
> > > the size of the folio.
> > 
> > when debugging an unrelated issue (short reads on btrfs with io_uring
> > and O_DIRECT[1]), I noticed that my horrible big file copy speeds fell
> > down from ~2GB/s (there's compression and lots of zeroes) to ~100MB/s
> > the second time I was copying it with cp.
> > 
> > I've taken a moment to bisect this and came down to this patch.
> 
> I think you may have forgotten to include the commit-id that was the
> results of your bisect.... ?

Sorry, this is the patch I replied to and it was recent enough that I
assumed it'd still be in mailboxes, but you're right it's better with a
commit id. This is was merged as 5ccc944dce3d ("filemap: Correct the
conditions for marking a folio as accessed")


Thanks,
-- 
Dominique
