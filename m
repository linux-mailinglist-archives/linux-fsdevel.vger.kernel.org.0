Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FDE50AFCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 07:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbiDVF7y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 01:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbiDVF7x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 01:59:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350CA4F9CC;
        Thu, 21 Apr 2022 22:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5CrcGiBymwl5tH/DPvPCBY6qZ7g9+AZplUJ8FrXnOJI=; b=dXfoMIO+TpLIKFU1vCQM8wxy0p
        IjWp8Y0li+OTLPizO3nvhSEOyDdVcM9mgcItSewhbqdtH38XRDcvT5kl6c47B9qFnTLmlBwy6WYuV
        qOOUIz9H2l+/fQZvjCc2L4kq2nw5KjxEHTpViVE7O8jYO2bobHdPeghjzFMmKsumIYmNX3MW7odKn
        xnKvfVr13ho13H6S6817dWbIyNwt8ppzMxAEOCsJAHosbP25uXeOQ69ln6A1l2WJYGPh9EOXc35h9
        RM55NKuj5aWe4guSBWRqIlwN36VzB8xQjsUlVdQ2s6Yrzh7jhsIiwtCi8Y91/f5vmwZtRdQOej5gt
        s7jE2FBw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhmHp-00GIgr-Bs; Fri, 22 Apr 2022 05:56:57 +0000
Date:   Thu, 21 Apr 2022 22:56:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
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
Message-ID: <YmJDqceT1AiePyxj@infradead.org>
References: <CAHj4cs9OTm9sb_5fmzgz+W9OSLeVPKix3Yri856kqQVccwd_Mw@mail.gmail.com>
 <fba69540-b623-9602-a0e2-00de3348dbd6@interlog.com>
 <YlW7gY8nr9LnBEF+@bombadil.infradead.org>
 <00ebace8-b513-53c0-f13b-d3320757695d@interlog.com>
 <YmGaGoz2+Kdqu05l@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmGaGoz2+Kdqu05l@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 21, 2022 at 10:53:30AM -0700, Luis Chamberlain wrote:
> Moving this discussion to the lists as we need to really think
> about how testing on fstests and blktests uses scsi_debug for
> a high confidence in baseline without false positives on failures
> due to the inability to the remove scsi_debug module.
> 
> This should also apply to other test debug modules like null_blk,
> nvme target loop drivers, etc, it's all the same long term. But yeah
> scsi surely make this... painful today. In any case hopefully folks
> with other test debug drivesr are running tests to ensure you can
> always rmmod these modules regardless of what is happening.

Maybe fix blktests to not rely on module removal  I have such a hard
time actually using blktests because it is suck a f^^Y% broken piece
of crap that assumes everything is modular.  Stop making that whole
assumption and work fine with built-in driver as a first step.  Then
start worrying about module removal.
