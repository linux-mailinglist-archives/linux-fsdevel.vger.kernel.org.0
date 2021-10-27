Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307C543C6C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 11:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238905AbhJ0JuU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 05:50:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37324 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbhJ0JuT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 05:50:19 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DE75D1FD40;
        Wed, 27 Oct 2021 09:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635328073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gPAOC+AGYpK7cN4JnD4gRZanlYWPHwNJlRBhzVQdha8=;
        b=aKXPiluYUxmVEspGqvlEOh9ULlgxVH6w0YN5t0n2njK0lJa5cYEMg5g5MIGFisOCPH3keW
        ebAnC0C6KDOML+QcC/xsTfZBLhsHdUE8GpYFfB977bpZ7iWEqAfPeZ+HLOJnPXndLz3nEB
        H+6StryAAns95yE84QDP5lhJ3bjkch4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635328073;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gPAOC+AGYpK7cN4JnD4gRZanlYWPHwNJlRBhzVQdha8=;
        b=ahlWei9NSuVMm0nMCVPEDWSL8griO/AvExEmsWoqfeHPy1D0D4NvVw0U+DmCdbikh1AtQ+
        gTJejWkhoTMvAXCA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id A39CDA3B83;
        Wed, 27 Oct 2021 09:47:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8A0B21F2C66; Wed, 27 Oct 2021 11:47:53 +0200 (CEST)
Date:   Wed, 27 Oct 2021 11:47:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 5/5] mm: simplify bdi refcounting
Message-ID: <20211027094753.GB28650@quack2.suse.cz>
References: <20211021124441.668816-1-hch@lst.de>
 <20211021124441.668816-6-hch@lst.de>
 <20211022090203.GF1026@quack2.suse.cz>
 <20211027074207.GA12793@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027074207.GA12793@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 27-10-21 09:42:07, Christoph Hellwig wrote:
> On Fri, Oct 22, 2021 at 11:02:03AM +0200, Jan Kara wrote:
> > On Thu 21-10-21 14:44:41, Christoph Hellwig wrote:
> > > Move grabbing and releasing the bdi refcount out of the common
> > > wb_init/wb_exit helpers into code that is only used for the non-default
> > > memcg driven bdi_writeback structures.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Can we perhaps add a comment to struct bdi_writeback definition (or maybe
> > wb_init()?) mentioning that it holds a reference to 'bdi' if it is
> > bdi_writeback struct for a cgroup? I don't see it mentioned anywhere and
> > now that you've changed the code, it isn't that obvious from the code
> > either... Otherwise the patch looks good so feel free to add:
> 
> Like this?
> 
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index 33207004cfded..a3d7dd1cc30a1 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -103,6 +103,9 @@ struct wb_completion {
>   * change as blkcg is disabled and enabled higher up in the hierarchy, a wb
>   * is tested for blkcg after lookup and removed from index on mismatch so
>   * that a new wb for the combination can be created.
> + *
> + * Each bdi_writeback that is no embedded into the backing_dev_info must hold
				 ^^^ not

> + * a reference to the parent backing_dev_info.  See cgwb_create() for details.
>   */

Otherwise looks nice. Thanks!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
