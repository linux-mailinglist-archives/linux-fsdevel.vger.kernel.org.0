Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3D47A9E00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 21:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjIUTxJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 15:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjIUTw4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:52:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0707A3B191;
        Thu, 21 Sep 2023 12:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n6Owd0b29R3F+oLZERwwfQvWcqOKx+MYNJ1GGP2+h9U=; b=qaiShqcW//4ZUh/Q19Qnfc5j5v
        0yqGTwlooSpRgQu9pHhXVLmbYoYnEmLoizakwQV7WHA2S1eUkpsY8ih6mV8FWy9PH4bZQ/fa2N+ol
        pUZxeNtw8h9nLG6H17ePerko06JIjLHBdziKF1BPjZ1fu+LU95Hb2aMzclZYl4hMFE4+XPTpsd8RC
        meDsKcYQLnqAPvjGgD9P2OIKOGD0WJWGnOByCmOs3pa/t5lR/dhIrMmFVHzJBhWZ1WVsCo2mERdoV
        GUckSpfYv0RF2f+0IH0FFoeryAEVipth+IfKKE1f0gjXH1yVxPa43KHdvHwX0jZCvIctnVmbITp6F
        qjttXlrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qjPcf-00Dm0V-Ny; Thu, 21 Sep 2023 19:46:01 +0000
Date:   Thu, 21 Sep 2023 20:46:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 00/13] Pass data temperature information to zoned UFS
 devices
Message-ID: <ZQydeSIoHHJDQjHW@casper.infradead.org>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <ZQtHwsNvS1wYDKfG@casper.infradead.org>
 <1522d8ec-6b15-45d5-b6d9-517337e2c8cf@acm.org>
 <ZQv07Mg7qIXayHlf@x1-carbon>
 <8781636a-57ac-4dbd-8ec6-b49c10c81345@acm.org>
 <ZQyZEqXJymyFWlKV@casper.infradead.org>
 <4cacae64-6a11-41ab-9bec-f8915da00106@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cacae64-6a11-41ab-9bec-f8915da00106@acm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 12:39:00PM -0700, Bart Van Assche wrote:
> On 9/21/23 12:27, Matthew Wilcox wrote:
> > On Thu, Sep 21, 2023 at 07:27:08AM -0700, Bart Van Assche wrote:
> > > On 9/21/23 00:46, Niklas Cassel wrote:
> > > > Should NVMe streams be brought back? Yes? No?
> > > 
> > > From commit 561593a048d7 ("Merge tag 'for-5.18/write-streams-2022-03-18'
> > > of git://git.kernel.dk/linux-block"): "This removes the write streams
> > > support in NVMe. No vendor ever really shipped working support for this,
> > > and they are not interested in supporting it."
> > 
> > It sounds like UFS is at the same stage that NVMe got to -- standard
> > exists, no vendor has committed to actually shipping it.  Isn't bringing
> > it back a little premature?
> 
> Hi Matthew,
> 
> That's a misunderstanding. UFS vendors support interpreting the SCSI GROUP
> NUMBER as a data temperature since many years, probably since more than ten
> years. Additionally, for multiple UFS vendors having the data temperature
> available is important for achieving good performance. This message shows
> how UFS vendors were using that information before write hint support was
> removed: https://lore.kernel.org/linux-block/PH0PR08MB7889642784B2E1FC1799A828DB0B9@PH0PR08MB7889.namprd08.prod.outlook.com/

If vendor support already exists, then why did you dodge the question
asking for quantified data that I asked earlier?  And can we have that
data now?
