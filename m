Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71824154061
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 09:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgBFIgF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 03:36:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:55112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727947AbgBFIgF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:36:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4195DAC67;
        Thu,  6 Feb 2020 08:36:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E87211E0E31; Thu,  6 Feb 2020 09:36:02 +0100 (CET)
Date:   Thu, 6 Feb 2020 09:36:02 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 8/8] xarray: Don't clear marks in xas_store()
Message-ID: <20200206083602.GD14001@quack2.suse.cz>
References: <20200204142514.15826-1-jack@suse.cz>
 <20200204142514.15826-9-jack@suse.cz>
 <8ea2682b-7240-dca3-b123-2df7d0c994ba@nvidia.com>
 <20200206022144.GU8731@bombadil.infradead.org>
 <01e577b2-3349-15bc-32c7-b556e9f08536@nvidia.com>
 <20200206042801.GV8731@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206042801.GV8731@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-02-20 20:28:01, Matthew Wilcox wrote:
> On Wed, Feb 05, 2020 at 07:48:57PM -0800, John Hubbard wrote:
> > You can then set entries using xa_store() and get entries
> > using xa_load().  xa_store will overwrite any entry with the
> > new entry and return the previous entry stored at that index.  You can
> > use xa_erase(), instead of calling xa_store() with a
> > ``NULL`` entry followed by xas_init_marks().  There is no difference between
> > an entry that has never been stored to and one that has been erased. Those,
> > in turn, are the same as an entry that has had ``NULL`` stored to it and
> > also had its marks erased via xas_init_marks().
> 
> There's a fundamental misunderstanding here.  If you store a NULL, the
> marks go away.  There is no such thing as a marked NULL entry.  If you
> observe such a thing, it can only exist through some kind of permitted
> RCU race, and the entry must be ignored.  If you're holding the xa_lock,
> there is no way to observe a NULL entry with a search mark set.
> 
> What Jan is trying to do is allow code that knows what it's doing
> the ability to say "Skip clearing the marks for performance reasons.
> The marks are already clear."
> 
> I'm still mulling over the patches from Jan.  There's something I don't
> like about them, but I can't articulate it in a useful way yet.  I'm on
> board with the general principle, and obviously the xas_for_each_marked()
> bug needs to be fixed.

There are different ways how to look at what I'm doing :) I was thinking
about it more like "xas_store() is for storing value at some index",
"xas_erase() is when I want the value at some index removed from the data
structure". Because these are principially different operations for any
data structure (as much as erasing can be *implemented* by just storing
NULL at some index). You seem to recognize this for xa_ functions but you
probably considered xas_ functions internal enough that they follow more
the "how it is implemented" way of thinking.

Now I agree that there are holes in my way of thinking about xas_store()
because if you happen to store NULL at some index, marks may get destroyed
as a side-effect. And some users of __xa_cmpxchg() (BTW nobody seems to be
using xa_cmpxchg_bh()) do use the fact that storing NULL does effectively
erase an entry which is BTW inconsistent with xa_store() itself as well...

You've been probably thinking more about xarray API semantics than I was so
I can be convinced otherwise but at this point, I'd rather move the API
more towards "erase is different from storing NULL".

									Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
