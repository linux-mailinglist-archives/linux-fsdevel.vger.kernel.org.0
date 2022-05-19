Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D2552CA93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 05:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiESD5Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 23:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiESD5X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 23:57:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFECDFA7;
        Wed, 18 May 2022 20:57:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBDF56181A;
        Thu, 19 May 2022 03:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3536CC385B8;
        Thu, 19 May 2022 03:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652932641;
        bh=Cw/bSvzhskHy+6kqHl2QrfuEwtgAOdgImcnM82BTlfg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hLnI1XhVmkuPZkWL7LKIiFGbIFhlfzU1Hjfk0uSgM1kKYEmlBUfggOlTNdg64rvgq
         JYnjsJJYmuyQLg1h/vMnhRNlGotG1EqP05prRy06wqhpyqLgGJ5bEUG0A6ewnpDFk+
         HSNS4ftz/hMf8xqiKJUvDv8zhZh+RRHdeHujB0UkFrSvXFIxCpLfC/NvpvvLhlUk+d
         oG3om01aTWxBGgumZYGQHix3zWe+wlMuehfS/I9z6QwhovyTUnqaq89TVZ3oQZrEaG
         CZc+JggkA3s1IykuRxDh+ynoi2Rtro0muxJKDOL2PP3p7L0wI5G2VcFFiS+t4nSKFF
         jdBrUxFAe9RvQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CF16C5C033E; Wed, 18 May 2022 20:57:20 -0700 (PDT)
Date:   Wed, 18 May 2022 20:57:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Merge adjacent CONFIG_TREE_RCU blocks
Message-ID: <20220519035720.GV1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <a6931221b532ae7a5cf0eb229ace58acee4f0c1a.1652799977.git.geert+renesas@glider.be>
 <20220517155737.GA1790663@paulmck-ThinkPad-P17-Gen-1>
 <YoW4tRf693CSAioE@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoW4tRf693CSAioE@bombadil.infradead.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 18, 2022 at 08:25:41PM -0700, Luis Chamberlain wrote:
> On Tue, May 17, 2022 at 08:57:37AM -0700, Paul E. McKenney wrote:
> > On Tue, May 17, 2022 at 05:07:31PM +0200, Geert Uytterhoeven wrote:
> > > There are two adjacent sysctl entries protected by the same
> > > CONFIG_TREE_RCU config symbol.  Merge them into a single block to
> > > improve readability.
> > > 
> > > Use the more common "#ifdef" form while at it.
> > > 
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > 
> > If you would like me to take this, please let me know.  (The default
> > would be not the upcoming merge window, but the one after that.)
> > 
> > If you would rather send it via some other path:
> > 
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 
> The one that that occurs to me is that while at it, Geert,
> can you also just then follow up with a patch 2/2 which then
> moves the sysctl out to the respective RCU code. If you look
> at linux-nxt kernel/sysctl.c is getting modified heavily with
> time to avoid stuffing everyone's sysctls there because this
> creates merge conflicts, make the file hard to read, and we
> have ways to split this.
> 
> This work started about 2 kernel releases ago and is ongoing,
> it may take 3-4 more before kernel/sysctl.c stop being a kitchen
> sink of everyone's syctls.
> 
> Paul, I've been collecting these modifications in a sysctl-next
> tree to avoid merge conflicts, and I try to not do to much per
> kernel release. If you like I can take this in for that tree
> as well, but as you noted, this would be for the next release,
> not the current one which we'll soon enter the merge window for.
> 
> Let me know!

Please do take it!

							Thanx, Paul

>   Luis
> > 
> > > ---
> > >  kernel/sysctl.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > > index 82bcf5e3009fa377..597069da18148f42 100644
> > > --- a/kernel/sysctl.c
> > > +++ b/kernel/sysctl.c
> > > @@ -2227,7 +2227,7 @@ static struct ctl_table kern_table[] = {
> > >  		.extra1		= SYSCTL_ZERO,
> > >  		.extra2		= SYSCTL_ONE,
> > >  	},
> > > -#if defined(CONFIG_TREE_RCU)
> > > +#ifdef CONFIG_TREE_RCU
> > >  	{
> > >  		.procname	= "panic_on_rcu_stall",
> > >  		.data		= &sysctl_panic_on_rcu_stall,
> > > @@ -2237,8 +2237,6 @@ static struct ctl_table kern_table[] = {
> > >  		.extra1		= SYSCTL_ZERO,
> > >  		.extra2		= SYSCTL_ONE,
> > >  	},
> > > -#endif
> > > -#if defined(CONFIG_TREE_RCU)
> > >  	{
> > >  		.procname	= "max_rcu_stall_to_panic",
> > >  		.data		= &sysctl_max_rcu_stall_to_panic,
> > > -- 
> > > 2.25.1
> > > 
