Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460C86EFB62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 21:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjDZT4M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 15:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbjDZT4L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:56:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B93319B7
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Apr 2023 12:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u7cBdBisx6BgWLiQLiUMETMOhxQQiiymVzDMTf0s8uk=; b=WT8HnaQ3KoblOsHIjRwGIiKje9
        8BDMl7plc3v5ZzV+S84IlV4ezUMGHbLHow+IRWbF9hfUO56OjY1Lx9zp6G7VhLEL3yIa6qScQOpbN
        SVGWkKzb9BAsIl6xLVM8W1sMrv7gJ39mLjZxmEgsf/xvQvlGErle7Wn4GYjmFXgTROT5s2bOKTtW0
        10gTE3XyXWDe6H71RvhHiM7gCNRZ98oQDhnXinJAGPNJihtfY7zMlcjyHPSSJqRTovFOejKyd5ZCk
        MpCFG9KIqGeqd7fUFJqW55Mkaws10GzyozhDZjGtk5tZBS+EML5MwNMlPFOsw+YHWBc4ZcPA+pTab
        ilj7jROw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1prlFF-002nf5-JF; Wed, 26 Apr 2023 19:56:05 +0000
Date:   Wed, 26 Apr 2023 20:56:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Kernel.org Bugbot" <bugbot@kernel.org>, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, bugs@lists.linux.dev
Subject: Re: large pause when opening file descriptor which is power of 2
Message-ID: <ZEmB1bOJFz72K0ho@casper.infradead.org>
References: <20230426-b217366c0-53b6841a1f9a@bugzilla.kernel.org>
 <ZEl34WthS8UNJnNd@casper.infradead.org>
 <20230426194628.GU3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426194628.GU3390869@ZenIV>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 26, 2023 at 08:46:28PM +0100, Al Viro wrote:
> On Wed, Apr 26, 2023 at 08:13:37PM +0100, Matthew Wilcox wrote:
> > On Wed, Apr 26, 2023 at 05:58:06PM +0000, Kernel.org Bugbot wrote:
> > > When running a threaded program, and opening a file descriptor that
> > > is a power of 2 (starting at 64), the call takes a very long time to
> > > complete. Normally such a call takes less than 2us. However with this
> > > issue, I've seen the call take up to around 50ms. Additionally this only
> > > happens the first time, and not subsequent times that file descriptor is
> > > used. I'm guessing there might be some expansion of some internal data
> > > structures going on. But I cannot see why this process would take so long.
> > 
> > Because we allocate a new block of memory and then memcpy() the old
> > block of memory into it.  This isn't surprising behaviour to me.
> > I don't think there's much we can do to change it (Allocating a
> > segmented array of file descriptors has previously been vetoed by
> > people who have programs with a million file descriptors).  Is it
> > causing you problems?
> 
> FWIW, I suspect that this is not so much allocation + memcpy.
>         /* make sure all fd_install() have seen resize_in_progress
> 	 * or have finished their rcu_read_lock_sched() section.
> 	 */
> 	if (atomic_read(&files->count) > 1)
> 		synchronize_rcu();
> 
> in expand_fdtable() is a likelier source of delays.

Perhaps?  The delay seemed to be roughly doubling with the test program,
so I assumed it was primarily the memcpy() cost for the reporter's
system:

FD=64 duration=12565293
FD=128 duration=24755063
FD=256 duration=7602777

... although now I've pasted it, I see my brain skipped one digit, so
256 was faster than 64, not about twice as slow as 128.
