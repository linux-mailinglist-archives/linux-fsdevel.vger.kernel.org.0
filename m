Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CFF37A3C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 11:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhEKJfT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 05:35:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:60054 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231220AbhEKJfS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 05:35:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9D934AFEC;
        Tue, 11 May 2021 09:34:11 +0000 (UTC)
Date:   Tue, 11 May 2021 11:34:07 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Jan Kara <jack@suse.cz>
Cc:     yangerkun <yangerkun@huawei.com>, naoya.horiguchi@nec.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk, tytso@mit.edu,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        yi.zhang@huawei.com, yukuai3@huawei.com, houtao1@huawei.com,
        yebin10@huawei.com
Subject: Re: [PATCH] mm/memory-failure: make sure wait for page writeback in
 memory_failure
Message-ID: <YJpPj3dGxk4TFL4b@localhost.localdomain>
References: <20210511070329.2002597-1-yangerkun@huawei.com>
 <20210511084600.GG24154@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511084600.GG24154@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 11, 2021 at 10:46:00AM +0200, Jan Kara wrote:
> We definitely need to wait for writeback of these pages and the change you
> suggest makes sense to me. I'm just not sure whether the only problem with
> these "pages in the process of being munlocked()" cannot confuse the state
> machinery in memory_failure() also in some other way. Also I'm not sure if
> are really allowed to call wait_on_page_writeback() on just any page that
> hits memory_failure() - there can be slab pages, anon pages, completely
> unknown pages given out by page allocator to device drivers etc. That needs
> someone more familiar with these MM details than me.

I am not really into mm/writeback stuff, but:

shake_page() a few lines before tries to identifiy the page, and
make those sitting in lruvec real PageLRU, and then we take page's lock.

I thought that such pages (pages on writeback) are stored in the file
LRU, and maybe the code was written with that in mind? And given that
we are under the PageLock, such state could not have changed.

But if such pages are allowed to not be in the LRU (maybe they are taken
off before initiating the writeback?), I guess the change is correct.
Checking wait_on_page_writeback(), it seems it first checks for
Writeback bit, and since that bit is not "shared" and only being set
in mm/writeback code, it should be fine to call that.

But alternatively, we could also modify the check and go with:

if (!PageTransTail(p) && !PageLRU(p) && !PageWriteBack(p))
		goto identify_page_state;

and stating why a page under writeback might not be in the LRU, as I
think the code assumes.

AFAUI, mm/writeback locks the page before setting the bit, and since we
hold the lock, we could not race here.

-- 
Oscar Salvador
SUSE L3
