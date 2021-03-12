Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7953397E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 21:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbhCLUDk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 15:03:40 -0500
Received: from mga14.intel.com ([192.55.52.115]:31067 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234294AbhCLUDR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 15:03:17 -0500
IronPort-SDR: FZWzccZeEmv6SV9kVrbzp/EtAmcTC5JFlCUQxW/pCflwaMabXfEkbAkavdTnv38g3GVBLNqinS
 t1St/DcXp2jw==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="188248073"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="188248073"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 12:03:14 -0800
IronPort-SDR: GvhqHz2C3BZ9nUflQhI5sQU6TJdlA/608uXDKfs91rOQZdRlQ/N/SproFDZmHXIO9qFYHn+Buf
 D+TRGR63Whmg==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="404529094"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 12:03:14 -0800
Date:   Fri, 12 Mar 2021 12:03:14 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     dsterba@suse.cz, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] fs/btrfs: Convert kmap to kmap_local_page() using
 coccinelle
Message-ID: <20210312200314.GF3014244@iweiny-DESK2.sc.intel.com>
References: <20210217024826.3466046-1-ira.weiny@intel.com>
 <20210217024826.3466046-2-ira.weiny@intel.com>
 <20210312185839.GR7604@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312185839.GR7604@suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 12, 2021 at 07:58:39PM +0100, David Sterba wrote:
> On Tue, Feb 16, 2021 at 06:48:23PM -0800, ira.weiny@intel.com wrote:
> > --- a/fs/btrfs/lzo.c
> > +++ b/fs/btrfs/lzo.c
> > @@ -118,7 +118,7 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
> >  	struct workspace *workspace = list_entry(ws, struct workspace, list);
> >  	int ret = 0;
> >  	char *data_in;
> > -	char *cpage_out;
> > +	char *cpage_out, *sizes_ptr;
> >  	int nr_pages = 0;
> >  	struct page *in_page = NULL;
> >  	struct page *out_page = NULL;
> > @@ -258,10 +258,9 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
> >  	}
> >  
> >  	/* store the size of all chunks of compressed data */
> > -	cpage_out = kmap(pages[0]);
> > -	write_compress_length(cpage_out, tot_out);
> > -
> > -	kunmap(pages[0]);
> > +	sizes_ptr = kmap_local_page(pages[0]);
> > +	write_compress_length(sizes_ptr, tot_out);
> > +	kunmap_local(sizes_ptr);
> 
> Why is not cpage_out reused for this mapping? I don't see any reason for
> another temporary variable, cpage_out is not used at this point.

For this patch that is true.  However, I'm trying to convert the other kmaps as
well.  To do that I'll need cpage_out preserved for the final kunmap_local().

Unfortunately, the required nesting ordering of kmap_local_page() makes
converting the other calls hacky at best.  I'm not sure what to do about them.
The best I've come up with is doing a hacky extra unmap/remap to preserve the
nesting.

Anyway, I'd prefer to leave this additional temp variable but I can certainly
change if it you want.  The other conversions may never work/land.  :-/

Ira
