Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8011152CA4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 05:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbiESDZs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 23:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiESDZs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 23:25:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E83111456;
        Wed, 18 May 2022 20:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OSyE8SOU5BkfOUgGl2faWPnm3KPoXoHKqGtKZbhztWw=; b=DbZp3OmrzgVn17w7AqGMFwsC6v
        knDkZgFfKC1VBF7bXaGk587Q7AljPclSLmZfD2jMuqB+XZWuFrYqAO160c26bVXOY49UuxCMMOSwQ
        GEFVGmB7EKICylb73a2XMnX91mbvk13Toizx7FoDiHzVP0Nq5kdqMbUuXuDqv7VbnB+ZRBW+IGhVa
        Tluj/U+PsDgacmQ+gTcvdEG2PJnkl6/6w/ikUwwK1ciGG2c5VKvYakEm2zYP64mWXGIc7M48zB/ia
        E3nZY3OlRUCrHTWnO81vc8akdNKd22/aUBCY4MDttHDrGiS9WxOySsVrESIIAYy08MAmvAJgTkgK/
        lzq3jOpg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrWnF-004s6A-PC; Thu, 19 May 2022 03:25:41 +0000
Date:   Wed, 18 May 2022 20:25:41 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Merge adjacent CONFIG_TREE_RCU blocks
Message-ID: <YoW4tRf693CSAioE@bombadil.infradead.org>
References: <a6931221b532ae7a5cf0eb229ace58acee4f0c1a.1652799977.git.geert+renesas@glider.be>
 <20220517155737.GA1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517155737.GA1790663@paulmck-ThinkPad-P17-Gen-1>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 17, 2022 at 08:57:37AM -0700, Paul E. McKenney wrote:
> On Tue, May 17, 2022 at 05:07:31PM +0200, Geert Uytterhoeven wrote:
> > There are two adjacent sysctl entries protected by the same
> > CONFIG_TREE_RCU config symbol.  Merge them into a single block to
> > improve readability.
> > 
> > Use the more common "#ifdef" form while at it.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> If you would like me to take this, please let me know.  (The default
> would be not the upcoming merge window, but the one after that.)
> 
> If you would rather send it via some other path:
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

The one that that occurs to me is that while at it, Geert,
can you also just then follow up with a patch 2/2 which then
moves the sysctl out to the respective RCU code. If you look
at linux-nxt kernel/sysctl.c is getting modified heavily with
time to avoid stuffing everyone's sysctls there because this
creates merge conflicts, make the file hard to read, and we
have ways to split this.

This work started about 2 kernel releases ago and is ongoing,
it may take 3-4 more before kernel/sysctl.c stop being a kitchen
sink of everyone's syctls.

Paul, I've been collecting these modifications in a sysctl-next
tree to avoid merge conflicts, and I try to not do to much per
kernel release. If you like I can take this in for that tree
as well, but as you noted, this would be for the next release,
not the current one which we'll soon enter the merge window for.

Let me know!

  Luis
> 
> > ---
> >  kernel/sysctl.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index 82bcf5e3009fa377..597069da18148f42 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -2227,7 +2227,7 @@ static struct ctl_table kern_table[] = {
> >  		.extra1		= SYSCTL_ZERO,
> >  		.extra2		= SYSCTL_ONE,
> >  	},
> > -#if defined(CONFIG_TREE_RCU)
> > +#ifdef CONFIG_TREE_RCU
> >  	{
> >  		.procname	= "panic_on_rcu_stall",
> >  		.data		= &sysctl_panic_on_rcu_stall,
> > @@ -2237,8 +2237,6 @@ static struct ctl_table kern_table[] = {
> >  		.extra1		= SYSCTL_ZERO,
> >  		.extra2		= SYSCTL_ONE,
> >  	},
> > -#endif
> > -#if defined(CONFIG_TREE_RCU)
> >  	{
> >  		.procname	= "max_rcu_stall_to_panic",
> >  		.data		= &sysctl_max_rcu_stall_to_panic,
> > -- 
> > 2.25.1
> > 
