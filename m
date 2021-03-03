Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F082432C50F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381944AbhCDATH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:19:07 -0500
Received: from verein.lst.de ([213.95.11.211]:36063 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1842937AbhCCKWo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:44 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4F89968CFE; Wed,  3 Mar 2021 10:44:54 +0100 (CET)
Date:   Wed, 3 Mar 2021 10:44:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH v2 05/10] fsdax: Replace mmap entry in case of CoW
Message-ID: <20210303094454.GA15967@lst.de>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com> <OSBPR01MB2920FB5AD1C9ADC64100238AF4989@OSBPR01MB2920.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB2920FB5AD1C9ADC64100238AF4989@OSBPR01MB2920.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 03, 2021 at 09:41:54AM +0000, ruansy.fnst@fujitsu.com wrote:
> 
> > >
> > >       if (dirty)
> > >               __mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
> > 
> > I still think the __mark_inode_dirty should just be moved into the one
> > caller that needs it.
> 
> I found that the dirty flag will be used in the next few lines, so I keep
> this function inside. If I move it outside, the drity flag should be passed
> in as well. 
> 
> @@ -774,6 +780,9 @@ static void *dax_insert_entry(struct xa_state *xas,
>          if (dirty)
>                  xas_set_mark(xas, PAGECACHE_TAG_DIRTY);
>  
> +       if (cow)
> +               xas_set_mark(xas, PAGECACHE_TAG_TOWRITE);
> +
>          xas_unlock_irq(xas);
>          return entry;
> }
> 
> 
> So, may I ask what's your purpose for doing in that way?

Oh, true.  We can't just move that out as the xas needs to stay
locked.
