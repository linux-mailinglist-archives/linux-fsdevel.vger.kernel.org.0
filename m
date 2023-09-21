Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6833A7AA574
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 01:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjIUXFp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 19:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjIUXFb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 19:05:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93665561C4;
        Thu, 21 Sep 2023 13:47:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDE7C433C9;
        Thu, 21 Sep 2023 20:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695329241;
        bh=RLA8T3fc6qHtdc/his8qpk9mIDEAxM3xk0IjQR4r2PA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rsr/Lctcicc+50Eg3JXu0b8dhmZ2v3WiFXeY2wkmrCnTqXUF4B7nsPi9SuqW7wRul
         J71+88B/rdDTyO0UzmenIyD+3u0qf56/39z2OoPLy2LZVxpos7P1sw4x+ZsjCPD1lQ
         Oi9wT74862kw3Owh0dAp1xYUD+4S0G0QULBC/Bc82yvw4uqrhWsK/tI7wWQ7VPjEC8
         khmD/u7EE/Fzc2tfF3nKmvx7KwOL6FCNMKwTQ4cwikFOFEDe8GintWgWS1PEIGrSOb
         dnAd2mBBrhDizb7QLZ5SDOooRRhE27lfw506KM3naUySsxMrWD5uZ8F0beX7iHsWlf
         o2ovLfeWYivnA==
Date:   Thu, 21 Sep 2023 13:47:19 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 00/13] Pass data temperature information to zoned UFS
 devices
Message-ID: <ZQyr1wR9rM48p65l@google.com>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <ZQtHwsNvS1wYDKfG@casper.infradead.org>
 <1522d8ec-6b15-45d5-b6d9-517337e2c8cf@acm.org>
 <ZQv07Mg7qIXayHlf@x1-carbon>
 <8781636a-57ac-4dbd-8ec6-b49c10c81345@acm.org>
 <ZQyZEqXJymyFWlKV@casper.infradead.org>
 <4cacae64-6a11-41ab-9bec-f8915da00106@acm.org>
 <ZQydeSIoHHJDQjHW@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQydeSIoHHJDQjHW@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09/21, Matthew Wilcox wrote:
> On Thu, Sep 21, 2023 at 12:39:00PM -0700, Bart Van Assche wrote:
> > On 9/21/23 12:27, Matthew Wilcox wrote:
> > > On Thu, Sep 21, 2023 at 07:27:08AM -0700, Bart Van Assche wrote:
> > > > On 9/21/23 00:46, Niklas Cassel wrote:
> > > > > Should NVMe streams be brought back? Yes? No?
> > > > 
> > > > From commit 561593a048d7 ("Merge tag 'for-5.18/write-streams-2022-03-18'
> > > > of git://git.kernel.dk/linux-block"): "This removes the write streams
> > > > support in NVMe. No vendor ever really shipped working support for this,
> > > > and they are not interested in supporting it."
> > > 
> > > It sounds like UFS is at the same stage that NVMe got to -- standard
> > > exists, no vendor has committed to actually shipping it.  Isn't bringing
> > > it back a little premature?
> > 
> > Hi Matthew,
> > 
> > That's a misunderstanding. UFS vendors support interpreting the SCSI GROUP
> > NUMBER as a data temperature since many years, probably since more than ten
> > years. Additionally, for multiple UFS vendors having the data temperature
> > available is important for achieving good performance. This message shows
> > how UFS vendors were using that information before write hint support was
> > removed: https://lore.kernel.org/linux-block/PH0PR08MB7889642784B2E1FC1799A828DB0B9@PH0PR08MB7889.namprd08.prod.outlook.com/
> 
> If vendor support already exists, then why did you dodge the question
> asking for quantified data that I asked earlier?  And can we have that
> data now?

I'm in doubt this patch-set really requires the quantified data which may be
mostly confidential to all the companies, also given the revert reason was no
user, IIUC. OTOH, I'm not sure whether you're famailiar with FTL, but, when
we consider the entire stack ranging from f2fs to FTL which manages NAND blocks,
I do see a clear benefit to give the temperature hints for FTL to align therein
garbage collection unit with one in f2fs, which is the key idea on Zoned UFS
in mobile world, I believe. Otherwise, it can show non-deterministic longer
write latencies due to internal GCs, increase WAI feeding to shorter lifetime.
