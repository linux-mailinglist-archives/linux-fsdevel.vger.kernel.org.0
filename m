Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2A17282F8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 16:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbjFHOpr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 10:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbjFHOpp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:45:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D55A2D74;
        Thu,  8 Jun 2023 07:45:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB94664E2A;
        Thu,  8 Jun 2023 14:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231E1C433D2;
        Thu,  8 Jun 2023 14:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686235544;
        bh=vr+S7p4BemUuKVL8ipqKq9LlC8dveRd0cQrLqDtQqOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FExw4wExNGC8Hyu65x5rYR5g/msc6MOkMpIjU6Efn1u43clgrSCuDs6YEnmQoq9x7
         A/T/6jwr1wjeZiBiLbXLzy24BRGhL8agfqxaQnMJRYHmQNtoiH3CSqga4Gb50hxYkY
         dX3fQOqvRqQf0gvEwwTEnDcvEwSUdoSpsCGfVZU7CzZsdI3CQTNLjqCONC+QDJRS9F
         nMkVahvMA9nIlgssbzIfk915/barWbb8tyvkHHThKg8FVLdWXF6vtZ0BwzGBafrcRV
         aohPU1RX1dDafzOz7ipvs5KI4xedZzXAM6dTE+TXOkoZu3jmU5Z4+FAA0XWw4oXCN4
         qcmlhhwPMMaGA==
Date:   Thu, 8 Jun 2023 07:45:43 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [PATCHv8 5/5] iomap: Add per-block dirty state tracking to
 improve performance
Message-ID: <20230608144543.GT1325469@frogsfrogsfrogs>
References: <ZIAsEkURZHRAcxtP@infradead.org>
 <87o7lri8r4.fsf@doe.com>
 <ZIFoQIugyQLbQnfj@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIFoQIugyQLbQnfj@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 07, 2023 at 10:33:52PM -0700, Christoph Hellwig wrote:
> On Wed, Jun 07, 2023 at 09:07:19PM +0530, Ritesh Harjani wrote:
> > I think the only remaining piece is the naming of this enum and struct
> > iomap_page.
> > 
> > Ok, so here is what I think my preference would be -
> > 
> > This enum perfectly qualifies for "iomap_block_state" as it holds the
> > state of per-block.
> > Then the struct iomap_page (iop) should be renamed to struct
> > "iomap_folio_state" (ifs), because that holds the state information of all the
> > blocks within a folio.
> 
> Fine with me.

Yeah, fine with me too.

> > > 	if (!iof)
> > > 		return NULL;
> > >
> > > here and unindent the rest.
> > 
> > Sure. Is it ok to fold this change in the same patch, right?
> > Or does it qualify for a seperate patch?
> 
> Either way is fine with me.

Same patch is ok.

--D
