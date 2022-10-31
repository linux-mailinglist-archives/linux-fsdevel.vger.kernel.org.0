Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969DE6139C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 16:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiJaPOd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 11:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiJaPOc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:14:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA5311454
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 08:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=80LEc5METlTsJI8KoiQquV8OxDu+3U/ke9l2V0R/JCs=; b=A9X0/ehust/dGajey3UmClMCit
        EStnl1d1GSkdAff2iQm72PXUOAhtupS8lrAEhCL6KcDlDyFc0tYvv8c1heOH6f10zNSeFiYNsFfLG
        d9a3e/pb13lwZv//+mEIGaea0GIS56EikEi7vtcRPr4nO3vEm6K2sH7RmHCc2mGRKFNAVubS4M9wy
        1nD0pQdgZ6RvB/6Xh3xNpZip2PstZd1iY28wpTXAU5uhPHRzOnmgBRzq+1jnzzwMw2YK7K0cBGSJh
        2T8MJFwWUc2T4WW+cz4hefdocE1ZIrScN6PADGRLo8YinbkfyVrCWV+lwC4wZGbSiRy63vbXTntLe
        AqpkmuHA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opWUh-003lpk-IG; Mon, 31 Oct 2022 15:14:31 +0000
Date:   Mon, 31 Oct 2022 15:14:31 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-mm@kvack.org, Uladzislau Rezki <urezki@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 1/1] mm: Add folio_map_local()
Message-ID: <Y1/mVxMhjLLFklxu@casper.infradead.org>
References: <20221028151526.319681-2-willy@infradead.org>
 <20221028151526.319681-1-willy@infradead.org>
 <2557442.1667229098@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2557442.1667229098@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 31, 2022 at 03:11:38PM +0000, David Howells wrote:
> Matthew Wilcox (Oracle) <willy@infradead.org> wrote:
> 
> > +static inline __must_check void *folio_map_local(struct folio *folio)
> > +{
> > +	might_alloc(GFP_KERNEL);
> > +
> > +	if (!IS_ENABLED(CONFIG_HIGHMEM))
> > +		return folio_address(folio);
> 
> Can you make the might_alloc() contingent on CONFIG_HIGHMEM=y?

... so that 64-bit builds can inadvertently introduce bugs?  Either it's
safe to do GFP_KERNEL allocations from a given context, or it's not.
That's not going to depend on CONFIG_HIGHMEM.
