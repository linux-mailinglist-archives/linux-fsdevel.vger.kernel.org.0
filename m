Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC8170ACF3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 10:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjEUILn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 04:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjEUILm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 04:11:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39ED9FE;
        Sun, 21 May 2023 01:11:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3C4B60B80;
        Sun, 21 May 2023 08:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5222C433EF;
        Sun, 21 May 2023 08:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684656700;
        bh=Vs5qRgCqd2qJlcmjsNsGzS/ClTU/a/N9UtE13XZoOn8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uqSWxVHgSM9S5XOFyq3IQ8YY+l71UBf0VaYxwfHjxIwTFWCFG0TiyfjyWO3WJ064n
         H+XPC2MNHIOYZ58z92GV2XqLOaazVaRTqMidxTOUpLwgHpwdPPE+w1lvmhYRU/Z3B9
         MxVuXCOgnO9vQ5xdLqcA9VmCKq7iofEuOvZO9Y9y5q4HFeVjtgg9zzouTpwwULGBa5
         lTpugURNdunf9hJQVmF5Fjq9R7VZa5tvNod5ui2EmaP7NZGNUGGwBsdmK9dhhEqcj0
         7jpKZcvloew8BMGjXYH5MS5+/9tILtdsA+MGuKlNJrCKrFuXMgIn3i9r/R864GMsVe
         VHGBzSXp1tJ3Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 814EDCE1D68; Sun, 21 May 2023 01:11:31 -0700 (PDT)
Date:   Sun, 21 May 2023 01:11:31 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Neil Brown <neilb@suse.de>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 2/9] fs: add infrastructure for multigrain inode
 i_m/ctime
Message-ID: <919ebbd0-6467-4e25-ba93-c98dc74e052a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230518114742.128950-3-jlayton@kernel.org>
 <ZGkoU6Wfcst6scNk@mit.edu>
 <ZGmARbuI4BC05cJi@Boquns-Mac-mini.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGmARbuI4BC05cJi@Boquns-Mac-mini.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 20, 2023 at 07:21:57PM -0700, Boqun Feng wrote:
> [Cc Paul and Mark]
> 
> On Sat, May 20, 2023 at 04:06:43PM -0400, Theodore Ts'o wrote:
> > On Thu, May 18, 2023 at 07:47:35AM -0400, Jeff Layton wrote:
> > > Use the 31st bit of the ctime tv_nsec field to indicate that something
> > > has queried the inode for the i_mtime or i_ctime. When this flag is set,
> > > on the next timestamp update, the kernel can fetch a fine-grained
> > > timestamp instead of the usual coarse-grained one.
> > 
> > TIL....  that atomic_long_fetch_or() and atomic_long_fetch_andnot()
> > exist.  :-)
> > 
> > When I went looking for documentation about why they do or this
> > particular usage pattern found in the patch, I didn't find any --- at
> > least, certainly not in the Documentation in the kernel sources.  The
> > closest that I fond was this LWN article written by Neil Brown from
> > 2016:
> > 
> > 	https://lwn.net/Articles/698315/
> > 
> > ... and this only covered the use atomic_fetch_or(); I wasn't able to
> > find anything discussing atomic_fetch_andnot().
> > 
> > It looks like Peter Zijlstra added some bare-bones documentation in
> > 2017, in commit: 706eeb3e9c6f ("Documentation/locking/atomic: Add
> > documents for new atomic_t APIs") so we do have Documentation that
> > these functions *exist*, but there is nothing explaining what they do,
> > or how they can be used (e.g., in this rather clever way to set and
> > clear a flag in the high bits of the nsec field).
> > 
> > I know that it's best to report missing documentation in the form of a
> > patch, but I fear I don't have the time or the expertise to really do
> > this topic justice, so I'd just thought I'd just note this lack for
> > now, and maybe in my copious spare time I'll try to get at least
> > something that will no doubt contain errors, but might inspire some
> > folks to correct the text.  (Or maybe on someone on linux-doc will
> > feel inspired and get there ahead of me.  :-)
> > 
> 
> Paul already started the work:
> 
> 	https://lore.kernel.org/lkml/19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop/

Which reminds me, I need to forward-port that documentation to Mark's
latest version.  ;-)

							Thanx, Paul
