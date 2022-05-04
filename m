Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F0D5192CF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 02:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244658AbiEDAbR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 20:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244654AbiEDAbQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 20:31:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7737817E3A;
        Tue,  3 May 2022 17:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BeSfiEm4BczT3hnriw4YnlduoFRdweQ5na/C87w7vjM=; b=Hy/LsDNzp6ms9dCFXJVdLyAPud
        vFWWO5M/lXp6lH63PBzfuD7bLGbuIC8SXovpU/5rYIKUX8ByQrA5UoepXkCFMWAXn1d3GDAWwlzed
        AlU7fMPo+BC5/1tWv72CoYsGC6Y4rY9xAp1GtigOgYn6xyiEz++F4jznNHhZeefUrE2gFsPp1kiPu
        vE3nZB9inRMRBiQOAmsPrjRGtNuw41GFyZgACMNzMxiKxltlP0vbF3SU1Xvb3QjOAzvKXg1OF1jjJ
        5oIuR5rV1sj+YMg4aJE3qcHMIpraMl+thEFmaKLrAGn9UrknClkXw+EggOswMktXLShcRrKuSHDgU
        H+7NCcHw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nm2rg-00G5BE-Ho; Wed, 04 May 2022 00:27:36 +0000
Date:   Wed, 4 May 2022 01:27:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] iomap: iomap_write_end cleanup
Message-ID: <YnHIeHuAXr6WCk7M@casper.infradead.org>
References: <20220503213727.3273873-1-agruenba@redhat.com>
 <YnGkO9zpuzahiI0F@casper.infradead.org>
 <CAHc6FU5_JTi+RJxYwa+CLc9tx_3_CS8_r8DjkEiYRhyjUvbFww@mail.gmail.com>
 <20220503230226.GK8265@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503230226.GK8265@magnolia>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 03, 2022 at 04:02:26PM -0700, Darrick J. Wong wrote:
> On Wed, May 04, 2022 at 12:15:45AM +0200, Andreas Gruenbacher wrote:
> > On Tue, May 3, 2022 at 11:53 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > On Tue, May 03, 2022 at 11:37:27PM +0200, Andreas Gruenbacher wrote:
> > > > In iomap_write_end(), only call iomap_write_failed() on the byte range
> > > > that has failed.  This should improve code readability, but doesn't fix
> > > > an actual bug because iomap_write_failed() is called after updating the
> > > > file size here and it only affects the memory beyond the end of the
> > > > file.
> > >
> > > I can't find a way to set 'ret' to anything other than 0 or len.  I know
> > > the code is written to make it look like we can return a short write,
> > > but I can't see a way to do it.
> > 
> > Good point, but that doesn't make the code any less confusing in my eyes.
> 
> Not to mention it leaves a logic bomb if we ever /do/ start returning
> 0 < ret < len.

This is one of the things I noticed when folioising iomap and didn't
get round to cleaning up, but I feel like we should change the calling
convention here to bool (true = success, false = fail).  Changing
block_write_end() might not be on the cards, unless someone's really
motivated, but we can at least change iomap_write_end() to not have this
stupid calling convention.

I mean, I won't NAK this patch, it is somewhat better with it than without
it, but it perpetuates the myth that this is in some way ever going to
happen, and the code could be a lot simpler if we stopped pretending.
