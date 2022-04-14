Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD6A50049F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 05:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239751AbiDNDZu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 23:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239739AbiDNDZr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 23:25:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD8353A5B;
        Wed, 13 Apr 2022 20:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=siGjlGOP8a8aVEoY/7zrcxACP5zMOSpeZmIpk9cPz9o=; b=OBPd6/ohI1DvqAySC5Djju6KPg
        hI8+2jr7e3hswGtVmaZMCLOC9g/uGxrA5UxYe9JRriY8q8QI53otU5SaIoSpJWJW0JvsgGRA/f15M
        ag4tYSwnQAho9a20SBVj+sQbPM9ndSYDBtpo7jFAgMgl+RewVNLc8vtMi6skIDP5iN7ngsabAYSVd
        KvCjW1D0RV1s/9PdOe+DVBh9VH+DvvTJ+5PiNagSuspV1dmFSMBPFBaZmcEuMbY6aKpcr8a3I5hds
        c3ZlWb5RJ4b+Ey6/OSic2zcSU6YFv0UIEPqJ93WgG9q+XnJtyqGdC5jhha1AdnQPNMTMEHb36nDy/
        O8Cbyh6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neq4f-00EmtJ-GQ; Thu, 14 Apr 2022 03:23:13 +0000
Date:   Thu, 14 Apr 2022 04:23:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/smaps_rollup: return empty file for kthreads instead
 of ESRCH
Message-ID: <YleToQbgeRalHTwO@casper.infradead.org>
References: <20220413211357.26938-1-alex_y_xu.ref@yahoo.ca>
 <20220413211357.26938-1-alex_y_xu@yahoo.ca>
 <20220413142748.a5796e31e567a6205c850ae7@linux-foundation.org>
 <1649886492.rqei1nn3vm.none@localhost>
 <20220413160613.385269bf45a9ebb2f7223ca8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413160613.385269bf45a9ebb2f7223ca8@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 13, 2022 at 04:06:13PM -0700, Andrew Morton wrote:
> On Wed, 13 Apr 2022 18:25:53 -0400 "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca> wrote:
> > > 258f669e7e88 was 4 years ago, so I guess a -stable backport isn't
> > > really needed.
> > 
> > Current behavior (4.19+):
[...]
> > Pre-4.19 and post-patch behavior:
> 
> I don't think this will work very well.  smaps_rollup is the sort of
> system tuning thing for which organizations will develop in-house
> tooling which never get relesaed externally.
> 
> > 3. As mentioned previously, this was already the behavior between 4.14 
> >    and 4.18 (inclusive).
> > 
> 
> Yup.  Hm, tricky.  I'd prefer to leave it alone if possible.  How
> serious a problem is this, really?  

I don't think "It's been like this for four years" is as solid an argument
as you might like.  Certain distributions (of the coloured millinery
variety, for example) haven't updated their kernel since then and so
there may well be many organisations who have not been exposed to the
current behaviour.  Even my employers distribution, while it offers a
5.4 based kernel, still has many customers who have not moved from the
4.14 kernel.  Inertia is a real thing, and restoring this older behaviour
might well be an improvement.
