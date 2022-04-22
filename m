Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8108F50BB35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 17:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449155AbiDVPJ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 11:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448818AbiDVPJ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:09:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAC0EB5;
        Fri, 22 Apr 2022 08:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mFncqWCKvQF05lMTB2SFFG+iF4YpYqLCCasPX67AD7k=; b=BETH7U/Y+aeCjHm4Q5HroD3cnW
        YCTNb2n11d3t5HZWTSVyNM99kdBujhE/7FsHGHX/0mx/py/evYabjC4fANKhEhoDc5jYfpkNSHJBa
        T+94tbZ3hRV8udSwcINtsIEUiurB73ZlqijbU508wbjfa64asQaFORRnnUzjfbuydCBGWAQ5TecT4
        bf+4zInLrgQ1ygGQaCEaEG52Q+4uFHYiTwk4Y7Qt7iBy30TnpEKebrDpcXae63pBXCIhRKKu9xf3S
        qnikewtr3lEdIoSqD/RMOrAT0daTpJMjv1rq6F3w4TJ9bn2lP++NU2k+VxvlIvGZ48Nv31LZE6DoR
        VraW0UsQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhurh-000zr0-96; Fri, 22 Apr 2022 15:06:33 +0000
Date:   Fri, 22 Apr 2022 08:06:33 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Douglas Gilbert <dgilbert@interlog.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-modules@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Pankaj Malhotra <pankaj1.m@samsung.com>,
        Vincent Fu <vincent.fu@samsung.com>
Subject: Re: scsi_debug in fstests and blktests (Was: Re: Fwd: [bug
 report][bisected] modprob -r scsi-debug take more than 3mins during blktests
 srp/ tests)
Message-ID: <YmLEeUhTImWKIshO@bombadil.infradead.org>
References: <CAHj4cs9OTm9sb_5fmzgz+W9OSLeVPKix3Yri856kqQVccwd_Mw@mail.gmail.com>
 <fba69540-b623-9602-a0e2-00de3348dbd6@interlog.com>
 <YlW7gY8nr9LnBEF+@bombadil.infradead.org>
 <00ebace8-b513-53c0-f13b-d3320757695d@interlog.com>
 <YmGaGoz2+Kdqu05l@bombadil.infradead.org>
 <YmJDqceT1AiePyxj@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmJDqceT1AiePyxj@infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 21, 2022 at 10:56:57PM -0700, Christoph Hellwig wrote:
> On Thu, Apr 21, 2022 at 10:53:30AM -0700, Luis Chamberlain wrote:
> > Moving this discussion to the lists as we need to really think
> > about how testing on fstests and blktests uses scsi_debug for
> > a high confidence in baseline without false positives on failures
> > due to the inability to the remove scsi_debug module.
> > 
> > This should also apply to other test debug modules like null_blk,
> > nvme target loop drivers, etc, it's all the same long term. But yeah
> > scsi surely make this... painful today. In any case hopefully folks
> > with other test debug drivesr are running tests to ensure you can
> > always rmmod these modules regardless of what is happening.
> 
> Maybe fix blktests to not rely on module removal  I have such a hard
> time actually using blktests because it is suck a f^^Y% broken piece
> of crap that assumes everything is modular.  Stop making that whole
> assumption and work fine with built-in driver as a first step.  Then
> start worrying about module removal.

It begs the question if the same wish should apply to fstests.

If we want to *not* rely on module removal then the right thing to do I
think would be to replace module removal on these debug modules
(scsi_debug) with an API as null_blk has which uses configfs to *add* /
*remove* devices.

  Luis
