Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3911D721A4F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jun 2023 23:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjFDVjP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jun 2023 17:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFDVjO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jun 2023 17:39:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EECBD;
        Sun,  4 Jun 2023 14:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wbFECn7a5dfNblDCxl+RQO4vj9HqzId4RHlv9BbLJoA=; b=sY4So05/K4339ZoxRULIJnofQf
        k0LuVLfYo5GedALcjvpckSu+3j5N/iKJU9C/X2XEv+Q++FlnS6JfFo8pdjNdGjsVPjyozRyX0G4Z7
        0BjU1Waqt0oLQjqfYQav4TEK24yW3Y0k0pwofkomQobHKer3GdrtvlfHckljr5zSL8/3YA7h1fiSn
        pwtCSLC7GGoYOitkoOSkYg8HCq9Pw2JFMZsewrII1+SFC2agNFCdx4/tlUoO3oPq7C5Z8GN4pJmbC
        tbVTO/zDzM55BA/w7KuqtK2bvTvRLRgitUsa7Vy8NAXng5l7MG7lAc4MOA7X2C/aJb0BFfLjt4hgw
        hXe4tufA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q5vRJ-00BNE4-2P; Sun, 04 Jun 2023 21:39:05 +0000
Date:   Sun, 4 Jun 2023 22:39:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v2 3/7] iomap: Remove unnecessary test from
 iomap_release_folio()
Message-ID: <ZH0EeQmH95WoNmMc@casper.infradead.org>
References: <20230602222445.2284892-1-willy@infradead.org>
 <20230602222445.2284892-4-willy@infradead.org>
 <20230604180141.GD72241@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604180141.GD72241@frogsfrogsfrogs>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 04, 2023 at 11:01:41AM -0700, Darrick J. Wong wrote:
> On Fri, Jun 02, 2023 at 11:24:40PM +0100, Matthew Wilcox (Oracle) wrote:
> > The check for the folio being under writeback is unnecessary; the caller
> > has checked this and the folio is locked, so the folio cannot be under
> > writeback at this point.
> 
> Do we need a debug assertion here to validate that filemap_release_folio
> has already filtered out folios unergoing writeback?  The documentation
> change in the next patch might be fine since you're the pagecache
> maintainer.

I don't think so?  We don't usually include asserts in filesystems that
the VFS is living up to its promises.

> >  	/*
> > -	 * mm accommodates an old ext3 case where clean folios might
> > -	 * not have had the dirty bit cleared.  Thus, it can send actual
> > -	 * dirty folios to ->release_folio() via shrink_active_list();
> > -	 * skip those here.
> > +	 * If the folio is dirty, we refuse to release our metadata because
> > +	 * it may be partially dirty (FIXME, add a test for that).
> 
> Er... is this FIXME reflective of incomplete code?

It's a note to Ritesh ;-)

Once we have per-block dirty bits, if all the dirty bits are set, we
can free the iomap_page without losing any information.  But I don't
want to introduce a dependency between this and Ritesh's work.
