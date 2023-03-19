Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1A36C0500
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Mar 2023 21:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjCSUyy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Mar 2023 16:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCSUyy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Mar 2023 16:54:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040FF14EA4;
        Sun, 19 Mar 2023 13:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pzM7XEyWktl+4erzWcp/dvZf8Yk5D9ydJeEulAkdtcY=; b=aaMaq0ktdc8/eKtK9kgPSMr6nc
        uLfrSTZhkf6C03goYbPvHDP8L60VeO/YQvPyk7I3I6yfR4JcHFCGEZIPvo8G8fojalL16btYpQzta
        2H8DEnLtfQirBad5SCOg6TkFzkLkJ4W8SijzVOlervUOiPUiIu+bIHBObeOQavR2uwwGEZNXOfkxK
        hGtJ0B33DVWrIuwW7lN9GeyRK+2MVJ47kSgYNWnSYzoagsEoO3ttOxxKeK+Kx08wDLmGRpAcuy2sn
        VpiqknroJdZjwhL/Tt5eh8H9VO6aDoVPtXXC0BsFLlocRZ7NN/YTwWgjMiFWV2SjXD1dPTeDxhkHJ
        Gig91M7g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pe03C-007Q0S-0G;
        Sun, 19 Mar 2023 20:54:46 +0000
Date:   Sun, 19 Mar 2023 13:54:46 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     ye.xingchen@zte.com.cn, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        chi.minghao@zte.com.cn
Subject: Re: [PATCH V3 1/2] mm: compaction: move compact_memory sysctl to its
 own file
Message-ID: <ZBd2lhza9JRcFI+8@bombadil.infradead.org>
References: <202303091144483856804@zte.com.cn>
 <17e2a143-37eb-fb4e-d8a9-2d6dc20f9499@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17e2a143-37eb-fb4e-d8a9-2d6dc20f9499@suse.cz>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 09, 2023 at 10:47:46AM +0100, Vlastimil Babka wrote:
> On 3/9/23 04:44, ye.xingchen@zte.com.cn wrote:
> > From: Minghao Chi <chi.minghao@zte.com.cn>
> > 
> > The compact_memory is part of compaction, move it to its own file.
> > 
> > Link: https://lore.kernel.org/all/ZAJwoXJCzfk1WIBx@bombadil.infradead.org/
> > Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> > Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> > ---
> >  kernel/sysctl.c |  7 -------
> >  mm/compaction.c | 15 +++++++++++++++
> >  2 files changed, 15 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index c14552a662ae..f574f9985df4 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -2190,13 +2190,6 @@ static struct ctl_table vm_table[] = {
> >  		.extra2		= SYSCTL_FOUR,
> >  	},
> >  #ifdef CONFIG_COMPACTION
> > -	{
> > -		.procname	= "compact_memory",
> > -		.data		= NULL,
> > -		.maxlen		= sizeof(int),
> > -		.mode		= 0200,
> > -		.proc_handler	= sysctl_compaction_handler,
> > -	},
> >  	{
> >  		.procname	= "compaction_proactiveness",
> >  		.data		= &sysctl_compaction_proactiveness,
> 
> There's also this one, and two more, please move all of them at once?

I'll wait for a v4, and if you can rebase on top of this tree that would
be appreciated:

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=sysctl-next

  Luis
