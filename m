Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391F66C6C58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 16:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjCWPdr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 11:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjCWPdi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:33:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AB776B2;
        Thu, 23 Mar 2023 08:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hi678RG+egR/ohgFkrrnz97rFnnIU7oN844J5N2rULQ=; b=YmTajRSERctVdDqthoUzk8V1y5
        JcXUqGfOrW0uvT2auwRy+Z2MmEoW0In7FSEHQRJgt0bvf7Q3tCok1ZKq2pDmq2U97c/0tltJaxwbC
        2aGLHCuAGuY3SPkVcxxp9bnm26fMEdA2JRXCE+lyumGZfi5ycDfcHj+wi+a4CbLYuWjJrLd2piPyy
        VBj0caG5Ainp0pOxP8pKeTJLVQpzm8DRD2cLbALRn+mEiuYDMIJUr7VcsdxbbazF9Rwh+hIZ2QwCv
        BF3B32nf5/UtTpuotoi1dQ5nFpqTcinuGimhxlVY5TQ0MuwXj8rtoOpZHe7GZ9FpM6PoQf4gk46Tc
        OxEUTDXg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfMwJ-0042qM-6r; Thu, 23 Mar 2023 15:33:19 +0000
Date:   Thu, 23 Mar 2023 15:33:19 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     senozhatsky@chromium.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        brauner@kernel.org, akpm@linux-foundation.org, minchan@kernel.org,
        hubcap@omnibond.com, martin@omnibond.com, mcgrof@kernel.org,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC v2 0/5] remove page_endio()
Message-ID: <ZBxxPw9BTdkE4KF0@casper.infradead.org>
References: <CGME20230322135015eucas1p2ff980e76159f0ceef7bf66934580bd6c@eucas1p2.samsung.com>
 <20230322135013.197076-1-p.raghav@samsung.com>
 <ZBtSevjWLybE6S07@casper.infradead.org>
 <fbf5bc8a-6c82-a43e-dd96-8a9d2b7d3bf4@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbf5bc8a-6c82-a43e-dd96-8a9d2b7d3bf4@samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 23, 2023 at 04:00:37PM +0100, Pankaj Raghav wrote:
> > We don't need to set the error flag.  Only some filesystems still use
> > the error flag, and orangefs isn't one of them.  I'd like to get rid
> > of the error flag altogether, and I've sent patches in the past which
> > get us a lot closer to that desired outcome.  Not sure we're there yet.
> > Regardless, generic code doesn't check the error flag.
> 
> Thanks for the explanation. I think found the series you are referring here.
> 
> https://lore.kernel.org/linux-mm/20220527155036.524743-1-willy@infradead.org/#t
> 
> I see orangefs is still setting the error flag in orangefs_read_folio(), so
> it should be removed at some point?

Yes, OrangeFS only sets the error flag, it never checks it, so it never
needs to set it.

> I also changed mpage to **not set** the error flag in the read path. It does beg
> the question whether block_read_full_folio() and iomap_finish_folio_read() should
> also follow the suit.

Wrong.  mpage is used by filesystems which *DO* check the error flag.
You can't remove it being set until they're fixed to not check it.
