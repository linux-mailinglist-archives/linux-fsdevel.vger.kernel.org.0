Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62FF33D26C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 12:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbhCPLHV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 07:07:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:42120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhCPLGq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:06:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 47006AC1D;
        Tue, 16 Mar 2021 11:06:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B120ADA6E2; Tue, 16 Mar 2021 12:04:43 +0100 (CET)
Date:   Tue, 16 Mar 2021 12:04:43 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] fs/btrfs: Convert kmap to kmap_local_page() using
 coccinelle
Message-ID: <20210316110443.GI7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Ira Weiny <ira.weiny@intel.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20210217024826.3466046-1-ira.weiny@intel.com>
 <20210217024826.3466046-2-ira.weiny@intel.com>
 <20210312185839.GR7604@suse.cz>
 <20210312200314.GF3014244@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312200314.GF3014244@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 12, 2021 at 12:03:14PM -0800, Ira Weiny wrote:
> On Fri, Mar 12, 2021 at 07:58:39PM +0100, David Sterba wrote:
> > On Tue, Feb 16, 2021 at 06:48:23PM -0800, ira.weiny@intel.com wrote:
> > > --- a/fs/btrfs/lzo.c
> > > +++ b/fs/btrfs/lzo.c
> > > @@ -118,7 +118,7 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
> > >  	struct workspace *workspace = list_entry(ws, struct workspace, list);
> > >  	int ret = 0;
> > >  	char *data_in;
> > > -	char *cpage_out;
> > > +	char *cpage_out, *sizes_ptr;
> > >  	int nr_pages = 0;
> > >  	struct page *in_page = NULL;
> > >  	struct page *out_page = NULL;
> > > @@ -258,10 +258,9 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
> > >  	}
> > >  
> > >  	/* store the size of all chunks of compressed data */
> > > -	cpage_out = kmap(pages[0]);
> > > -	write_compress_length(cpage_out, tot_out);
> > > -
> > > -	kunmap(pages[0]);
> > > +	sizes_ptr = kmap_local_page(pages[0]);
> > > +	write_compress_length(sizes_ptr, tot_out);
> > > +	kunmap_local(sizes_ptr);
> > 
> > Why is not cpage_out reused for this mapping? I don't see any reason for
> > another temporary variable, cpage_out is not used at this point.
> 
> For this patch that is true.  However, I'm trying to convert the other kmaps as
> well.  To do that I'll need cpage_out preserved for the final kunmap_local().
> 
> Unfortunately, the required nesting ordering of kmap_local_page() makes
> converting the other calls hacky at best.  I'm not sure what to do about them.
> The best I've come up with is doing a hacky extra unmap/remap to preserve the
> nesting.
> 
> Anyway, I'd prefer to leave this additional temp variable but I can certainly
> change if it you want.  The other conversions may never work/land.  :-/

Ok, no problem keeping the variable then. I've added a note to changelog
why it's there. The whole conversion sounds tricky so adding trivial
helper code is no big deal.
