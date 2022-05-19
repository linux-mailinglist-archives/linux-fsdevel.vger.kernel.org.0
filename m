Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB9952DA58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 18:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242032AbiESQfb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 12:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiESQfa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 12:35:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9BBD02AD;
        Thu, 19 May 2022 09:35:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B01CB82702;
        Thu, 19 May 2022 16:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8A6C385AA;
        Thu, 19 May 2022 16:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652978127;
        bh=3/br5LYtDoI/X4bSo4PPgGmUkW7E5nVl34Hg+//h3+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BcJnDSRRESNu3Bv9XoJ9pl+0S2A8a3xt0zvVSJ8QelZZtTYuNT2CS6HZzAMPHiu3X
         bKwqlkDnd82xppD6iOjEOLinzLfu75dt5S2QYLU0pcWcVh7xz5+EoRX4fj1VDxASAf
         45Z67KoXq0cB/9jWCs+OLw+AEPw1/0Kobf/AikB00GOpU6rSXOUZd6HXlzrYj3RuNS
         Fvk+kmK8X+50BNkNnysQ5AER4Dgp0TIgd3mVwCsKVNpu25/eJ97Us6C/FKsyN2hFKQ
         oNdCTS/3HaIZvSxlS0PwLtU6q0NbiQi+yr24T7UMiqjBufPgxaw28SYiriOKJf5q9x
         7rlV1MACXTa6A==
Date:   Thu, 19 May 2022 10:35:23 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Eric Biggers <ebiggers@kernel.org>, Keith Busch <kbusch@fb.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com
Subject: Re: [PATCHv2 3/3] block: relax direct io memory alignment
Message-ID: <YoZxy9RYvHlTkBIl@kbusch-mbp.dhcp.thefacebook.com>
References: <20220518171131.3525293-4-kbusch@fb.com>
 <YoWL+T8JiIO5Ln3h@sol.localdomain>
 <YoWWtwsiKGqoTbVU@kbusch-mbp.dhcp.thefacebook.com>
 <YoWjBxmKDQC1mCIz@sol.localdomain>
 <YoWkiCdduzyQxHR+@kbusch-mbp.dhcp.thefacebook.com>
 <YoWmi0mvoIk3CfQN@sol.localdomain>
 <YoWqlqIzBcYGkcnu@kbusch-mbp.dhcp.thefacebook.com>
 <YoW5Iy+Vbk4Rv3zT@sol.localdomain>
 <YoXN5CpSGGe7+OJs@kbusch-mbp.dhcp.thefacebook.com>
 <20220519074114.GG22301@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519074114.GG22301@lst.de>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 09:41:14AM +0200, Christoph Hellwig wrote:
> On Wed, May 18, 2022 at 10:56:04PM -0600, Keith Busch wrote:
> > I'm surely missing something here. I know the bvecs are not necessarily lbs
> > aligned, but why does that matter? Is there some driver that can only take
> > exactly 1 bvec, but allows it to be unaligned? If so, we could take the segment
> > queue limit into account, but I am not sure that we need to.
> 
> At least stacking drivers had all kinds of interesting limitations in
> this area.  How much testing did this series get with all kinds of
> interesting dm targets and md pesonalities?

The dma limit doesn't stack (should it?). It gets the default, sector size - 1,
so their constraints are effectively unchanged.
