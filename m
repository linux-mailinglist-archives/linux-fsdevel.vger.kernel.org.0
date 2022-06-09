Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19531544E46
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 16:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbiFIN7R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 09:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343932AbiFIN6W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:58:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7F02AA011;
        Thu,  9 Jun 2022 06:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ciLcywds5wOdnXeWouFexQ8d/+FNSoE5WBQrR+b6OwM=; b=mKsWKYf2pkhC8HfcoFMxBoJXzi
        K/oB0kSnAezMRQsl3td03sgJoPvVDD9+KSpF5qIneVrf9Mn8EP64LmojGJ0L1hvPJnZrvh4vYTBPx
        DnlfSnVzEtZylYW3daHrq5wI1c7JfPec1UTHBh3K8uzT+R3qgXgT2eH4vdy+zw/Z9+E3lWhCimGkY
        P5BA0LHMcGkJnt17ox8V4ir7JNMfXlNDYM3PG1yCL8GGg9dg40ZGZeTin7rarjXKpBWsTscGVeA7G
        IEIbVBZsSVPLpGmnR+rfBe0iLV+ltHJOsbubUYb7Ul1N2pyj/VQFsOV/lrQ5KaGyy3whNous/JlFd
        s5sebcsg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzIfy-002MlT-IV; Thu, 09 Jun 2022 13:58:18 +0000
Date:   Thu, 9 Jun 2022 06:58:18 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Merge adjacent CONFIG_TREE_RCU blocks
Message-ID: <YqH8esqnhj2VTW+g@bombadil.infradead.org>
References: <a6931221b532ae7a5cf0eb229ace58acee4f0c1a.1652799977.git.geert+renesas@glider.be>
 <20220517155737.GA1790663@paulmck-ThinkPad-P17-Gen-1>
 <YoW4tRf693CSAioE@bombadil.infradead.org>
 <20220519035720.GV1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519035720.GV1790663@paulmck-ThinkPad-P17-Gen-1>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 18, 2022 at 08:57:20PM -0700, Paul E. McKenney wrote:
> On Wed, May 18, 2022 at 08:25:41PM -0700, Luis Chamberlain wrote:
> > On Tue, May 17, 2022 at 08:57:37AM -0700, Paul E. McKenney wrote:
> > > On Tue, May 17, 2022 at 05:07:31PM +0200, Geert Uytterhoeven wrote:
> > > > There are two adjacent sysctl entries protected by the same
> > > > CONFIG_TREE_RCU config symbol.  Merge them into a single block to
> > > > improve readability.
> > > > 
> > > > Use the more common "#ifdef" form while at it.
> > > > 
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > 
> > > If you would like me to take this, please let me know.  (The default
> > > would be not the upcoming merge window, but the one after that.)
> > > 
> > > If you would rather send it via some other path:
> > > 
> > > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > The one that that occurs to me is that while at it, Geert,
> > can you also just then follow up with a patch 2/2 which then
> > moves the sysctl out to the respective RCU code. If you look
> > at linux-nxt kernel/sysctl.c is getting modified heavily with
> > time to avoid stuffing everyone's sysctls there because this
> > creates merge conflicts, make the file hard to read, and we
> > have ways to split this.
> > 
> > This work started about 2 kernel releases ago and is ongoing,
> > it may take 3-4 more before kernel/sysctl.c stop being a kitchen
> > sink of everyone's syctls.
> > 
> > Paul, I've been collecting these modifications in a sysctl-next
> > tree to avoid merge conflicts, and I try to not do to much per
> > kernel release. If you like I can take this in for that tree
> > as well, but as you noted, this would be for the next release,
> > not the current one which we'll soon enter the merge window for.
> > 
> > Let me know!
> 
> Please do take it!

Geert, I queued this up onto sysctl-next, but would hope you *might*
be inclined to move the sysctls out as outlined above to help with
the kitchen sink on kernel/sysctl.c.

 Luis
