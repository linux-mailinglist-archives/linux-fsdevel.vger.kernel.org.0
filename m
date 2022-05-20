Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6994A52E4B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 08:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345731AbiETGIF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 02:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiETGIE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 02:08:04 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E0049263;
        Thu, 19 May 2022 23:08:02 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D775A68AFE; Fri, 20 May 2022 08:07:58 +0200 (CEST)
Date:   Fri, 20 May 2022 08:07:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Eric Biggers <ebiggers@kernel.org>,
        Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, bvanassche@acm.org,
        damien.lemoal@opensource.wdc.com
Subject: Re: [PATCHv2 3/3] block: relax direct io memory alignment
Message-ID: <20220520060758.GA16557@lst.de>
References: <YoWL+T8JiIO5Ln3h@sol.localdomain> <YoWWtwsiKGqoTbVU@kbusch-mbp.dhcp.thefacebook.com> <YoWjBxmKDQC1mCIz@sol.localdomain> <YoWkiCdduzyQxHR+@kbusch-mbp.dhcp.thefacebook.com> <YoWmi0mvoIk3CfQN@sol.localdomain> <YoWqlqIzBcYGkcnu@kbusch-mbp.dhcp.thefacebook.com> <YoW5Iy+Vbk4Rv3zT@sol.localdomain> <YoXN5CpSGGe7+OJs@kbusch-mbp.dhcp.thefacebook.com> <20220519074114.GG22301@lst.de> <YoZxy9RYvHlTkBIl@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoZxy9RYvHlTkBIl@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 10:35:23AM -0600, Keith Busch wrote:
> > At least stacking drivers had all kinds of interesting limitations in
> > this area.  How much testing did this series get with all kinds of
> > interesting dm targets and md pesonalities?
> 
> The dma limit doesn't stack (should it?). It gets the default, sector size - 1,
> so their constraints are effectively unchanged.

In general it should stack, as modulo implementation issues stacking
drivers sould not care about the alignment.  However since it doesn't
there might be some of those.
