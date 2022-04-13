Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B0D4FFC33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 19:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237237AbiDMROv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 13:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiDMROu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:14:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEE56B0A2;
        Wed, 13 Apr 2022 10:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rmaub1Fg6680Gb6loNmi4m+L/azuwzRdA8BbFTNNmAg=; b=sgs3KDtvSKxVoaXFni+5K4bL8q
        mx32Tw9M8zH06IGPbQyswfwg7yK/WNYXRQRS7FGFpMvWLw+cDVDfvMSCYDa7/+IT3hpgy3pLpuUZ1
        0QKt4gdsqmHuRgEltJFYLeppuPccld2519EU/iP8um3PGO8cA1OdmeF+aIj0yzhLayoJtpouozLsM
        GGJIhlXaZ9kBskq1eNS2S/rBFbJmG7gdvGdJSv3B8lNOkoNLvosgYI4exa6soIAFjyMy+XLEW5KyY
        E5QgZmTotNf30ZsKfv3DoLGPFkp8I73R6mGW/YDjm5WJl033DLY3JrA8v6dwOzLffBwqg9iZwB2FG
        eu8gf94g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1negXa-001url-0C; Wed, 13 Apr 2022 17:12:26 +0000
Date:   Wed, 13 Apr 2022 10:12:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>
Subject: Re: [PATCH v12 6/7] xfs: Implement ->notify_failure() for XFS
Message-ID: <YlcEeZbYOOIYln3s@infradead.org>
References: <20220410160904.3758789-1-ruansy.fnst@fujitsu.com>
 <20220410160904.3758789-7-ruansy.fnst@fujitsu.com>
 <20220413000423.GK1544202@dread.disaster.area>
 <CAPcyv4jKLZhcCiSEU+O+OJ2e+y9_B2CvaEfAKyBnhhSd+da=Zg@mail.gmail.com>
 <20220413060946.GL1544202@dread.disaster.area>
 <CAPcyv4jPgX3w2e1dENJvKjhCpiB7GMZURXWMoGUNNcOQFotb3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jPgX3w2e1dENJvKjhCpiB7GMZURXWMoGUNNcOQFotb3A@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 13, 2022 at 10:09:40AM -0700, Dan Williams wrote:
> Yes, sounds like we're on the same page. I had mistakenly interpreted
> "Hence these notifications need to be delayed until after the
> filesystem is mounted" as something the producer would need to handle,
> but yes, consumer is free to drop if the notification arrives at an
> inopportune time.

A SB_BORN check might be all that we need.
