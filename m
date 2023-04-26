Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6768F6EFBAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 22:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbjDZUdN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 16:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDZUdM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 16:33:12 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D172685
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Apr 2023 13:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w8uuvC4A+/JQjzZ/8yriEgIVbDD1xhQp8yH0i8mPFZo=; b=U4VljWCQ7m4iNsV3o/mfbvd9bz
        V5NWihotMMGSWFjIRSq5BZubsytAyPUumn8lKaQbWKuwGnGv7+eMq2HTOppWW2mQL8SqB7ocChD6x
        dRcDoLuZZEZBw1tCSk/y60AU8Jal+pZABwrBfgiqeRiLVuxm/c5kdEQssJ94UFYk+G/qaMpHQgCBR
        nr4XysvrC2ySi+nWgpTf1Qhurn5B/n1xCQnW8De2XVV+J3kKFhw6ZOuLm+Qx9qe/frWXf2+TS+V1V
        QDw7mg9nGp+37hn9pCiPDBaF4lfePaJXBWJGGoQcdw1QgN701gRjAbgNvsg07YuiH7JC+6ADiY06q
        Qrc0SLWw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1prlp3-00Cwr9-2W;
        Wed, 26 Apr 2023 20:33:05 +0000
Date:   Wed, 26 Apr 2023 21:33:05 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Kernel.org Bugbot" <bugbot@kernel.org>, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, bugs@lists.linux.dev
Subject: Re: large pause when opening file descriptor which is power of 2
Message-ID: <20230426203305.GW3390869@ZenIV>
References: <20230426-b217366c0-53b6841a1f9a@bugzilla.kernel.org>
 <ZEl34WthS8UNJnNd@casper.infradead.org>
 <20230426194628.GU3390869@ZenIV>
 <ZEmB1bOJFz72K0ho@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEmB1bOJFz72K0ho@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 26, 2023 at 08:56:05PM +0100, Matthew Wilcox wrote:
> On Wed, Apr 26, 2023 at 08:46:28PM +0100, Al Viro wrote:
> > On Wed, Apr 26, 2023 at 08:13:37PM +0100, Matthew Wilcox wrote:
> > > On Wed, Apr 26, 2023 at 05:58:06PM +0000, Kernel.org Bugbot wrote:
> > > > When running a threaded program, and opening a file descriptor that
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	This.  The cost of allocation and copy doesn't depend upon the number
of threads; synchronize_rcu() call, OTOH, is conditional upon that being more
than 1.

> > > > is a power of 2 (starting at 64), the call takes a very long time to
> > > > complete. Normally such a call takes less than 2us. However with this
> > > > issue, I've seen the call take up to around 50ms. Additionally this only
> > > > happens the first time, and not subsequent times that file descriptor is
> > > > used. I'm guessing there might be some expansion of some internal data
> > > > structures going on. But I cannot see why this process would take so long.
> > > 
> > > Because we allocate a new block of memory and then memcpy() the old
> > > block of memory into it.  This isn't surprising behaviour to me.
> > > I don't think there's much we can do to change it (Allocating a
> > > segmented array of file descriptors has previously been vetoed by
> > > people who have programs with a million file descriptors).  Is it
> > > causing you problems?
> > 
> > FWIW, I suspect that this is not so much allocation + memcpy.
> >         /* make sure all fd_install() have seen resize_in_progress
> > 	 * or have finished their rcu_read_lock_sched() section.
> > 	 */
> > 	if (atomic_read(&files->count) > 1)
> > 		synchronize_rcu();
> > 
> > in expand_fdtable() is a likelier source of delays.
> 
> Perhaps?  The delay seemed to be roughly doubling with the test program,
> so I assumed it was primarily the memcpy() cost for the reporter's
> system:
> 
> FD=64 duration=12565293
> FD=128 duration=24755063
> FD=256 duration=7602777
> 
> ... although now I've pasted it, I see my brain skipped one digit, so
> 256 was faster than 64, not about twice as slow as 128.
