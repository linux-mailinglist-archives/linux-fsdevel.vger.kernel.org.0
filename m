Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D342B8D07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 09:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgKSIZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 03:25:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:52024 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgKSIZH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:25:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1FC9DAD2F;
        Thu, 19 Nov 2020 08:25:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C74001E1303; Thu, 19 Nov 2020 09:25:05 +0100 (CET)
Date:   Thu, 19 Nov 2020 09:25:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 07/20] init: refactor name_to_dev_t
Message-ID: <20201119082505.GS1981@quack2.suse.cz>
References: <20201118084800.2339180-1-hch@lst.de>
 <20201118084800.2339180-8-hch@lst.de>
 <20201118143747.GL1981@quack2.suse.cz>
 <20201119075225.GA15815@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119075225.GA15815@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 19-11-20 08:52:25, Christoph Hellwig wrote:
> On Wed, Nov 18, 2020 at 03:37:47PM +0100, Jan Kara wrote:
> > > -static inline dev_t blk_lookup_devt(const char *name, int partno)
> > > -{
> > > -	dev_t devt = MKDEV(0, 0);
> > > -	return devt;
> > > -}
> > >  #endif /* CONFIG_BLOCK */
> > 
> > This hunk looks unrelated to the change? Also why you move the declaration
> > outside the CONFIG_BLOCK ifdef? AFAICS blk_lookup_devt() still exists only
> > when CONFIG_BLOCK is defined? Otherwise the patch looks good to me.
> 
> blk_lookup_devt is a hack only for name_to_dev_t only referenced from
> code under CONFIG_BLOCK now, as it didn't do anything before when
> blk_lookup_devt returned 0.  I guess I'll need to update the commit log
> a little to mention this.

OK, understood. Still it would seem more logical to leave blk_lookup_devt()
declaration inside #ifdef CONFIG_BLOCK and just delete the !CONFIG_BLOCK
definition (to make it clear we ever expect only users compiled when
CONFIG_BLOCK is defined). But whatever... Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
