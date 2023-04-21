Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DA86EAE31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 17:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjDUPlB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 11:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjDUPlB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:41:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F457DA3;
        Fri, 21 Apr 2023 08:41:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A09C60C88;
        Fri, 21 Apr 2023 15:40:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED272C433D2;
        Fri, 21 Apr 2023 15:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682091659;
        bh=4/sDp6eyor4bV4ynZZFhULxaNjmg8NJb+WkzTVe+POQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sHHOA8yLRE3+ZM7gyBhvhTW6E78kM4pYGIGvT7L8xXb+gDTPUMy/aUrL2EbBlZKcr
         dQYkJWoPmaxAbZtyNaTxNN3BVavaewdqOA8aV5rSe3K+XbsZT8GvHDecnTkb4R67FD
         EqT5xHHeDOg7gjgp4ljxGNEEKXnfE3i2AD9nXU62uaTnffLYEw0Y5S7j+CnmQA4X7p
         47ceQlORgbL0dXLl438L8va8bmcact25vptceEWLRiZ7OwfaMiKEzhHIRG9SyQToWH
         mvlCZkCoNXwvZidhtiZNQNDFMmIRCCEjqZpkbgM5td7avW51ScffIrCnS95ZaKYg4I
         mvPJBdIM7xkCw==
Date:   Fri, 21 Apr 2023 08:40:58 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>, Ted Tso <tytso@mit.edu>
Subject: Re: [PATCHv6 0/9] ext2: DIO to use iomap
Message-ID: <20230421154058.GH360881@frogsfrogsfrogs>
References: <20230421112324.mxrrja2hynshu4b6@quack3>
 <87edodigo4.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edodigo4.fsf@doe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 05:35:47PM +0530, Ritesh Harjani wrote:
> Jan Kara <jack@suse.cz> writes:
> 
> > Hello Ritesh,
> >
> > On Fri 21-04-23 15:16:10, Ritesh Harjani (IBM) wrote:
> >> Hello All,
> >>
> >> Please find the series which rewrites ext2 direct-io path to use modern
> >> iomap interface.
> >
> > The patches now all look good to me. I'd like to discuss a bit how to merge
> 
> Thanks Jan,
> 
> 
> > them. The series has an ext4 cleanup (patch 3) and three iomap patches
> 
> Also Patch-3 is on top of ext4 journalled data patch series of yours,
> otheriwse we might see a minor merge conflict.
> 
> https://lore.kernel.org/all/20230329154950.19720-6-jack@suse.cz/
> 
> > (patches 6, 8 and 9). Darrick, do you want to take the iomap patches through
> > your tree?

Hmm.  I could do that for 6.4 since the first one should be trivially
verifiable and so far Linus hasn't objected to patches that add
tracepoints being thrown into for-next right at the start of the merge
window.

--D

> > The only dependency is that patch 7 for ext2 is dependent on definitions
> > from patch 6
> 
> That's right. Patch 6 defines TRACE_IOCB_STRINGS definition which both
> ext2 and iomap tracepoints depend upon.
> 
> > so I'd have to pull your branch into my tree. Or I can take
> > all the iomap patches through my tree but for that it would be nice to have
> > Darrick's acks.
> >
> > I can take the ext4 patch through my tree unless Ted objects.
> 
> Sure, we might have to merge with Ted's ext4 tree as well to avoid the
> merge conflict I mentioned above.
> 
> >
> > I guess I won't rush this for the coming merge window (unless Linus decides
> > to do rc8) but once we settle on the merge strategy I'll push out some
> 
> Ok.
> 
> > branch on which we can base further ext2 iomap conversion work.
> >
> 
> Sure, will this branch also gets reflected in linux-next for wider testing?
> 
> -ritesh
