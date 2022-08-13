Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33EB591B53
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Aug 2022 17:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239704AbiHMPVb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Aug 2022 11:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239504AbiHMPVb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Aug 2022 11:21:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4A414D05;
        Sat, 13 Aug 2022 08:21:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1836860EA4;
        Sat, 13 Aug 2022 15:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F8AC433D7;
        Sat, 13 Aug 2022 15:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660404089;
        bh=1bch3XDANl0k9DvmU6CuDi2zlCPHHGmLfdhnnxKhjyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LoW9QQfHJ5Rji+RnsochC5SywhKQnC9KGIW5bEMpWKluIF3ZP6lh+MvEZZsGYVUSi
         aWILW4U0sD30oYcMNWMYP2DAnUf+f9R/jJshgB+eWctcvI7vVsSQo9SSU+8vyP+X/7
         A4OHIeqPKhHHgsB+AZTcPfD1L32fXhocDggzU0moqFz2MhdPFn50I2oS1x4KcREMt3
         mA/oWzW9QBET1xINTdDMlZZTvRhlj0hTpd1XXxZDiQfdDxZLkLNiKbzUq1pcaULPH1
         IYZeZFGf6UaNVgvf91eGAXIruKtRFzxsb/IrK4obOuYaHWuT87Kc8RHYnIAPnb/v8+
         Zz0ZSxUcza7pg==
Date:   Sat, 13 Aug 2022 18:21:12 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: State of the Page (August 2022)
Message-ID: <YvfBaKUlDkeVzIm9@kernel.org>
References: <YvV1KTyzZ+Jrtj9x@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvV1KTyzZ+Jrtj9x@casper.infradead.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Thu, Aug 11, 2022 at 10:31:21PM +0100, Matthew Wilcox wrote:
> ==============================
> State Of The Page, August 2022
> ==============================
> 
> I thought I'd write down where we are with struct page and where
> we're going, just to make sure we're all (still?) pulling in a similar
> direction.
> 
> Destination
> ===========
> 
> For some users, the size of struct page is simply too large.  At 64
> bytes per 4KiB page, memmap occupies 1.6% of memory.  If we can get
> struct page down to an 8 byte tagged pointer, it will be 0.2% of memory,
> which is an acceptable overhead.
> 
>    struct page {
>       unsigned long mem_desc;
>    };

This is 0.2% for a system that does not have any actual memdescs.

Do you have an estimate how much memory will be used by the memdescs, at
least for some use-cases?

Another thing, we are very strict about keeping struct page at its current
size. Don't you think it will be much more tempting to grow either of
memdescs and for some use cases the overhead will be at least as big as
now?
 
> Types of memdesc
> ----------------
> 
> This is very much subject to change as new users present themselves.
> Here are the current ones in-plan:
> 
>  - Undescribed.  Instead of the rest of the word being a pointer,
>    there are 2^28 subtypes available:
>    - Unmappable.  Typically device drivers allocating private memory.
>    - Reserved.  These pages are not allocatable.
>    - HWPoison
>    - Offline (eg balloon)
>    - Guard (see debug_pagealloc)
>  - Slab
>  - Anon Folio
>  - File Folio
>  - Buddy (ie free -- also for PCP?)
>  - Page Table
>  - Vmalloc
>  - Net Pool
>  - Zsmalloc
>  - Z3Fold
>  - Mappable.  Typically device drivers mapping memory to userspace
> 
> That implies 4 bits needed for the tag, so all memdesc allocations
> must be 16-byte aligned.  That is not an undue burden.  Memdescs
> must also be TYPESAFE_BY_RCU if they are mappable to userspace or
> can be stored in a file's address_space.
> 
> It may be worth distinguishing between vmalloc-mappable and
> vmalloc-unmappable to prevent some things being mapped to userspace
> inadvertently.

-- 
Sincerely yours,
Mike.
