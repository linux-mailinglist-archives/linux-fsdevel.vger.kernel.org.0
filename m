Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2A6752697
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 17:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjGMPT4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 11:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjGMPTz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:19:55 -0400
Received: from out-29.mta1.migadu.com (out-29.mta1.migadu.com [95.215.58.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073B1B4
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 08:19:53 -0700 (PDT)
Date:   Thu, 13 Jul 2023 11:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689261592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xi2T4bbPuT/YZb73yStmbzssaWiIAH6aQf2vyhFk2tA=;
        b=W7j7mHLV8eXdPp0Yz+mFZ0yguQvl5iuBiB96bfVayWOJAxFk8n+RUGMWRxKosYsaCpDXw+
        5abU3lsXzj/WMlbY8EFhn62SORrmwvCieYHVrv5cMGi5HTa5v3+esxkFSHLIArMjiX9x65
        IUD6zYWsL8NSg5B4SX7RbU4V4CcdwCc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 7/9] filemap: Allow __filemap_get_folio to allocate
 large folios
Message-ID: <20230713151946.afkekednznhazno7@moria.home.lan>
References: <20230710130253.3484695-1-willy@infradead.org>
 <20230710130253.3484695-8-willy@infradead.org>
 <20230713050439.ehtbvs3bugm6vvtb@moria.home.lan>
 <ZLANSurqCQi2jHmP@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLANSurqCQi2jHmP@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 13, 2023 at 03:42:18PM +0100, Matthew Wilcox wrote:
> On Thu, Jul 13, 2023 at 01:04:39AM -0400, Kent Overstreet wrote:
> > On Mon, Jul 10, 2023 at 02:02:51PM +0100, Matthew Wilcox (Oracle) wrote:
> > > Allow callers of __filemap_get_folio() to specify a preferred folio
> > > order in the FGP flags.  This is only honoured in the FGP_CREATE path;
> > > if there is already a folio in the page cache that covers the index,
> > > we will return it, no matter what its order is.  No create-around is
> > > attempted; we will only create folios which start at the specified index.
> > > Unmodified callers will continue to allocate order 0 folios.
> > 
> > Why not just add an end_index parameter to filemap_get_folio()?
> 
> I'm reluctant to add more parameters.  Aside from the churn, every extra
> parameter makes the function that little bit harder to use.  I like this
> encoding; users who don't know/care about it get the current default
> behaviour, and it's a simple addition to the users who do want to care.
> end_index is particularly tricky ... what if it's lower than index?

But we're refactoring all this code (and chaning our thinking) to
extents/ranges, not blocks - I'd say end_index is more natural in the
long run.

Plus, it lets us put the logic for "how big of a folio do we want to
allocate" in one place.

(end_index < index is just a BUG_ON()).
