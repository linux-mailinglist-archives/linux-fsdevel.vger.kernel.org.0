Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C145436969C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 18:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhDWQH1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 12:07:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:55642 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbhDWQH0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 12:07:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DDDF2B1AB;
        Fri, 23 Apr 2021 16:06:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 436561E37A2; Fri, 23 Apr 2021 18:06:47 +0200 (CEST)
Date:   Fri, 23 Apr 2021 18:06:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        adilger.kernel@dilger.ca, yukuai3@huawei.com
Subject: Re: [RFC PATCH v2 7/7] ext4: fix race between blkdev_releasepage()
 and ext4_put_super()
Message-ID: <20210423160647.GE8755@quack2.suse.cz>
References: <20210414134737.2366971-1-yi.zhang@huawei.com>
 <20210414134737.2366971-8-yi.zhang@huawei.com>
 <20210415145235.GD2069063@infradead.org>
 <ca810e21-5f92-ee6c-a046-255c70c6bf78@huawei.com>
 <20210420130841.GA3618564@infradead.org>
 <20210421134634.GT8706@quack2.suse.cz>
 <YIBZgx4cm0j7OObj@mit.edu>
 <20210422090410.GA26221@quack2.suse.cz>
 <9c83866e-7517-2051-8894-bca2892df1b6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c83866e-7517-2051-8894-bca2892df1b6@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 23-04-21 19:39:09, Zhang Yi wrote:
> On 2021/4/22 17:04, Jan Kara wrote:
> > I'm OK with that because mainly for IO error reporting it makes sense to
> > me. For this memory reclaim problem I think we have also other reasonably
> > sensible options. E.g. we could have a shrinker that would just walk the
> > checkpoint list and reclaim journal heads for whatever is already written
> > out... Or we could just release journal heads already after commit and
> > during checkpoint we'd fetch the list of blocks that may need to be written
> > out e.g. from journal descriptor blocks. This would be a larger overhaul
> > but as a bonus we'd get rid of probably the last place in the kernel which
> > can write out page contents through buffer heads without updating page
> > state properly (and thus get rid of some workarounds in mm code as well).
> 
> Thanks for these suggestions, I get your first solution and sounds good, but
> I do not understand your last sentence, how does ext4 not updating page state
> properly? Could you explain it more clearly?

The problem with current checkpointing code is that it writes out dirty
buffer heads through submit_bh() function without updating page dirty state
or without setting PageWriteback bit (because we cannot easily grab page
lock in those places due to lock ordering). Thus we can end up with a page
that is dirty but in fact does not hold any dirty data (none of the buffer
heads is dirty) and also locking a page and checking for PageWriteback
isn't enough to be sure page is not under IO. This is ugly and requires
some workarounds in MM code...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
