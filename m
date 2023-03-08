Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D986B127B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 20:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjCHT5m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 14:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCHT5k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:57:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA18FCB65F;
        Wed,  8 Mar 2023 11:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Uo9/aqo20KI120FvQgvIVbHTtMTRaptP+tVLmnc4amA=; b=iVR0qR+C2IUumAPzmongx7qG77
        DaIZ1RgKiw5jipb3r0oqBvmQEno9Ltfooh+oQuA3ejQu8xVB6hwTnEbeYcr9FvCXrZRV/46obu6R9
        7JUMI1InQaTnIadzcQnlFgNjyLPODLlMrXSGt8t+I30FBP92yMXNln1dHyVcJeQePk8zACK9IM6hS
        zcWD8/oZECEEsk+bQp0X4SXaQFyOTaIYPFeAp0pHksa1CANwGMSf9z1IyUd2uYH1S5hWwRdBOtRLW
        B6672VITdC/sgxnWs2WASPZYP4jyNnSCFJriXGXPilJgPdtaXNfIeiTit5+WbHH3CHIWW1fTAAlJf
        dB+3JQSw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZzum-006bng-W2; Wed, 08 Mar 2023 19:57:32 +0000
Date:   Wed, 8 Mar 2023 11:57:32 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     ye.xingchen@zte.com.cn, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, linmiaohe@huawei.com,
        chi.minghao@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V2 2/2] mm: compaction: Limit the value of interface
 compact_memory
Message-ID: <ZAjorPD2nSszUsXz@bombadil.infradead.org>
References: <202303061405242788477@zte.com.cn>
 <c48666f2-8226-3678-a744-6d613288f188@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c48666f2-8226-3678-a744-6d613288f188@suse.cz>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 08, 2023 at 11:23:45AM +0100, Vlastimil Babka wrote:
> 
> 
> On 3/6/23 07:05, ye.xingchen@zte.com.cn wrote:
> > From: Minghao Chi <chi.minghao@zte.com.cn>
> > 
> > Available only when CONFIG_COMPACTION is set. When 1 is written to
> > the file, all zones are compacted such that free memory is available
> > in contiguous blocks where possible.
> > But echo others-parameter > compact_memory, this function will be
> > triggered by writing parameters to the interface.
> > 
> > Applied this patch,
> > sh/$ echo 1.1 > /proc/sys/vm/compact_memory
> > sh/$ sh: write error: Invalid argument
> > The start and end time of printing triggering compact_memory.
> > 
> > Link: https://lore.kernel.org/all/ZAJwoXJCzfk1WIBx@bombadil.infradead.org/
> > Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> > Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> > ---
> >  mm/compaction.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index 5a9501e0ae01..2c9ecc4b9d23 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -2763,6 +2763,8 @@ int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,
> >  	return 0;
> >  }
> > 
> > +/* The written value is actually unused, all memory is compacted */
> > +int sysctl_compact_memory;
> >  /*
> >   * This is the entry point for compacting all nodes via
> >   * /proc/sys/vm/compact_memory
> > @@ -2770,8 +2772,16 @@ int compaction_proactiveness_sysctl_handler(struct ctl_table *table, int write,
> >  int sysctl_compaction_handler(struct ctl_table *table, int write,
> >  			void *buffer, size_t *length, loff_t *ppos)
> >  {
> > -	if (write)
> > +	int ret;
> > +
> > +	ret = proc_dointvec_minmax(table, write, buffer, length, ppos);
> > +	if (ret)
> > +		return ret;
> > +	if (write) {
> > +		pr_info("compact_nodes start\n");
> >  		compact_nodes();
> > +		pr_info("compact_nodes end\n");
> 
> I'm not sure we want to start spamming the dmesg. This would make sense
> if we wanted to deprecate the sysctl and start hunting for remaining
> callers to be fixed. Otherwise ftrace can be used to capture e.g. the time.

Without that print, I don't think a custom proc handler is needed too,
right? So what would simplify the code.

  Luis
