Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6E83CC6C6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jul 2021 01:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhGQXaJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jul 2021 19:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhGQXaJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jul 2021 19:30:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9ABCC061762
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jul 2021 16:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4v3mh4cqgqf/BRgKcQOkDQBmxTqX9mmIHLbOgFkhmRI=; b=HArwuRLz83oqtm6OHIUgxDa6Ox
        euffXP6Isw5SfyruHbx0axyNIt8gS9nlLOnHirhBfwHL8VzvgYeknDT7Wp10yqL/WyIY6JznxsDr0
        nt6PySzK7RIj+YmIkFoDd+LCiIcZUUcw/d7FIRn9TxihCDQN31qAQ2Evc4H78V7BohXfYkZcyx63Z
        NdPwBkzf7I0RpMa+4WCixhNCp2bGF/l7m/BT22Cv9/PJFozYO0kDUS5vuVgxCTwy2MZuTfgAZ7co1
        oDr+sUrZhBQON5/nZ82fbyW0En02a/sdbJZTwkz8RpEayePQP0vrOMlU4zs+6MksF6D2Pod7c2aKk
        FMDiN6CQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m4th2-005dOY-Aq; Sat, 17 Jul 2021 23:26:13 +0000
Date:   Sun, 18 Jul 2021 00:26:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [fsdax xfs] Regression panic at inode_switch_wbs_work_fn
Message-ID: <YPNnCItyLXWb3/dB@casper.infradead.org>
References: <CADJHv_uitWbPquubkFJGwiFi8Vx7V0ZxhYUSiEOd1_vMhHOonA@mail.gmail.com>
 <YPBdG2pe94hRdCMC@carbon.dhcp.thefacebook.com>
 <CADJHv_sij245-dtvhSac_cwkYQLrSFBgjoXnja_-OYaZk6Cfdg@mail.gmail.com>
 <YPHoUQyWW0/02l1X@carbon.dhcp.thefacebook.com>
 <20210717171713.GB22357@magnolia>
 <YPNU3BAfe97WrkMq@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPNU3BAfe97WrkMq@carbon.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 17, 2021 at 03:08:28PM -0700, Roman Gushchin wrote:
> On Sat, Jul 17, 2021 at 10:17:13AM -0700, Darrick J. Wong wrote:
> > On Fri, Jul 16, 2021 at 01:13:05PM -0700, Roman Gushchin wrote:
> > > On Fri, Jul 16, 2021 at 01:57:55PM +0800, Murphy Zhou wrote:
> > > > Hi,
> > > > 
> > > > On Fri, Jul 16, 2021 at 12:07 AM Roman Gushchin <guro@fb.com> wrote:
> > > > >
> > > > > On Thu, Jul 15, 2021 at 06:10:22PM +0800, Murphy Zhou wrote:
> > > > > > Hi,
> > > > > >
> > > > > > #Looping generic/270 of xfstests[1] on pmem ramdisk with
> > > > > > mount option:  -o dax=always
> > > > > > mkfs.xfs option: -f -b size=4096 -m reflink=0
> > > > > > can hit this panic now.
> > > > > >
> > > > > > #It's not reproducible on ext4.
> > > > > > #It's not reproducible without dax=always.
> > > > >
> > > > > Hi Murphy!
> > > > >
> > > > > Thank you for the report!
> > > > >
> > > > > Can you, please, check if the following patch fixes the problem?
> > > > 
> > > > No. Still the same panic.
> > > 
> > > Hm, can you, please, double check this? It seems that the patch fixes the
> > > problem for others (of course, it can be a different problem).
> > > CCed you on the proper patch, just sent to the list.
> > > 
> > > Otherwise, can you, please, say on which line of code the panic happens?
> > > (using addr2line utility, for example)
> > 
> > I experience the same problem that Murphy does, and I tracked it down
> > to this chunk of inode_do_switch_wbs:
> > 
> > 	/*
> > 	 * Count and transfer stats.  Note that PAGECACHE_TAG_DIRTY points
> > 	 * to possibly dirty pages while PAGECACHE_TAG_WRITEBACK points to
> > 	 * pages actually under writeback.
> > 	 */
> > 	xas_for_each_marked(&xas, page, ULONG_MAX, PAGECACHE_TAG_DIRTY) {
> > here >>>>>>>>>> if (PageDirty(page)) {
> > 			dec_wb_stat(old_wb, WB_RECLAIMABLE);
> > 			inc_wb_stat(new_wb, WB_RECLAIMABLE);
> > 		}
> > 	}
> > 
> > I suspect that "page" is really a pfn to a pmem mapping and not a real
> > struct page.
> 
> Good catch! Now it's clear that it's a different issue.
> 
> I think as now the best option is to ignore dax inodes completely.
> Can you, please, confirm, that the following patch solves the problem?
> 
> Thanks!
> 
> --
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 06d04a74ab6c..4c3370548982 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -521,6 +521,9 @@ static bool inode_prepare_wbs_switch(struct inode *inode,
>          */
>         smp_mb();
>  
> +       if (IS_DAX(inode))
> +               return false;
> +
>         /* while holding I_WB_SWITCH, no one else can update the association */
>         spin_lock(&inode->i_lock);
>         if (!(inode->i_sb->s_flags & SB_ACTIVE) ||

That should work, but wouldn't it be better to test that at the top of
inode_switch_wbs()?  Or even earlier?

