Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15123B949B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jul 2021 18:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhGAQWM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jul 2021 12:22:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57018 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhGAQWM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jul 2021 12:22:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 55B7C22776;
        Thu,  1 Jul 2021 16:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625156381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NI411+lZVg/kfY6i+HxzJiLtUW34MQ0s71hOf+u+/S8=;
        b=wkw1P57w+QixXUxD+pYzvOdAPtb/ZrxaTY7DDfvGhtfycU342KS/dY83DR1HXbk4n6A7Ng
        ACj8G863QvMf07sRrDuzh/qBjBR5TRre8DKeNfLfAsgBiNEW0BaIo7NV4Lc1Huzko93thf
        9s3DXyUfHh5snLACXVjN97RLfvZjFiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625156381;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NI411+lZVg/kfY6i+HxzJiLtUW34MQ0s71hOf+u+/S8=;
        b=fixFcNwTUYcuB2UJ9d4N805WDxyvRm9CbqEgOEl0sqjL0DQp1rKmDrU4aNCn7PQG9CNbZa
        Xa8b0tvl/8wWa0CA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 47512A3B8C;
        Thu,  1 Jul 2021 16:19:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2C5881F2CCE; Thu,  1 Jul 2021 18:19:41 +0200 (CEST)
Date:   Thu, 1 Jul 2021 18:19:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [GIT PULL] Hole puch vs page cache filling races fixes for
 5.14-rc1
Message-ID: <20210701161941.GA29014@quack2.suse.cz>
References: <20210630172529.GB13951@quack2.suse.cz>
 <CAHk-=whuUxfoYj=dRnzRybg_sOdFPMDx_t06Lz936Pgnh6QCTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whuUxfoYj=dRnzRybg_sOdFPMDx_t06Lz936Pgnh6QCTQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 30-06-21 18:15:09, Linus Torvalds wrote:
> On Wed, Jun 30, 2021 at 10:25 AM Jan Kara <jack@suse.cz> wrote:
> >
> >   could you please pull from
> 
> No.
> 
> There is no way I'll merge something this broken.
> 
> Looking up a page in the page cache is just about the most critical
> thing there is, and this introduces a completely pointless lock for
> that situation.
> 
> Does it take the lock only when it creates the page? No. It takes the
> lock in filemap_fault() even if it found a valid page in the page
> cache.

Hum, fair point. I did filemap_fault() the way it is because I was mostly
just lifting fs-private lock into the VFS one in that code path and
ext4/xfs/f2fs and others grabbed this lock unconditionally in their fault
paths (before calling into filemap_fault()). But you are right that now
that we have the lock in VFS, we can actually do better and have a fast
path when everything is cached and uptodate where we can avoid grabbing the
lock. That being said I don't expect the optimization to matter too much
because in do_read_fault() we first call do_fault_around() which will
exactly map pages that are already in cache and uptodate so we usually get
into filemap_fault() only for pages that are not present or not uptodate.
So do you think the optimization is still worth it despite
do_fault_around()? I guess I can try to see how many times I can see a page
that would benefit from this optimization in filemap_fault() on my test
machine - there are also write faults that don't call do_fault_around() -
and if it's noticeable fraction reorganize filemap_fault() so that we don't
take the lock if the page is present and uptodate...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
