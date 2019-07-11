Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F533652B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 09:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfGKH5k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 03:57:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:33774 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbfGKH5k (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 03:57:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 41042AC4C;
        Thu, 11 Jul 2019 07:57:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D9EF31E43B9; Thu, 11 Jul 2019 09:48:59 +0200 (CEST)
Date:   Thu, 11 Jul 2019 09:48:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Boaz Harrosh <openosd@gmail.com>,
        stable <stable@vger.kernel.org>,
        Robert Barror <robert.barror@intel.com>,
        Seema Pandit <seema.pandit@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dax: Fix missed PMD wakeups
Message-ID: <20190711074859.GA8727@quack2.suse.cz>
References: <20190703195302.GJ1729@bombadil.infradead.org>
 <CAPcyv4iPNz=oJyc_EoE-mC11=gyBzwMKbmj1ZY_Yna54=cC=Mg@mail.gmail.com>
 <20190704032728.GK1729@bombadil.infradead.org>
 <20190704165450.GH31037@quack2.suse.cz>
 <20190704191407.GM1729@bombadil.infradead.org>
 <CAPcyv4gUiDw8Ma9mvbW5BamQtGZxWVuvBW7UrOLa2uijrXUWaw@mail.gmail.com>
 <20190705191004.GC32320@bombadil.infradead.org>
 <CAPcyv4jVARa38Qc4NjQ04wJ4ZKJ6On9BbJgoL95wQqU-p-Xp_w@mail.gmail.com>
 <20190710190204.GB14701@quack2.suse.cz>
 <20190711030855.GO32320@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711030855.GO32320@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 10-07-19 20:08:55, Matthew Wilcox wrote:
> On Wed, Jul 10, 2019 at 09:02:04PM +0200, Jan Kara wrote:
> > @@ -848,7 +853,7 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
> >  	if (unlikely(dax_is_locked(entry))) {
> >  		void *old_entry = entry;
> >  
> > -		entry = get_unlocked_entry(xas);
> > +		entry = get_unlocked_entry(xas, 0);
> >  
> >  		/* Entry got punched out / reallocated? */
> >  		if (!entry || WARN_ON_ONCE(!xa_is_value(entry)))
> 
> I'm not sure about this one.  Are we sure there will never be a dirty
> PMD entry?  Even if we can't create one today, it feels like a bit of
> a landmine to leave for someone who creates one in the future.

I was thinking about this but dax_writeback_one() doesn't really care what
entry it gets. Yes, in theory it could get a PMD when previously there was
PTE or vice-versa but we check that PFN's match and if they really do
match, there's no harm in doing the flushing whatever entry we got back...
And the checks are simpler this way.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
