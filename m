Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12B1137F8D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 23:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfFFV2G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 17:28:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:42696 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728398AbfFFV2G (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 17:28:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4F94BAF5F;
        Thu,  6 Jun 2019 21:28:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D99731E3FC9; Thu,  6 Jun 2019 23:28:04 +0200 (CEST)
Date:   Thu, 6 Jun 2019 23:28:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jan Kara <jack@suse.cz>, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH] dax: Fix xarray entry association for mixed mappings
Message-ID: <20190606212804.GA10674@quack2.suse.cz>
References: <20190606091028.31715-1-jack@suse.cz>
 <CAPcyv4jxBoDUyuEFjY=1TcN_8ufjM8tqF1Yj0AN=xHfQ0NpdDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jxBoDUyuEFjY=1TcN_8ufjM8tqF1Yj0AN=xHfQ0NpdDQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 06-06-19 10:00:01, Dan Williams wrote:
> On Thu, Jun 6, 2019 at 2:10 AM Jan Kara <jack@suse.cz> wrote:
> >
> > When inserting entry into xarray, we store mapping and index in
> > corresponding struct pages for memory error handling. When it happened
> > that one process was mapping file at PMD granularity while another
> > process at PTE granularity, we could wrongly deassociate PMD range and
> > then reassociate PTE range leaving the rest of struct pages in PMD range
> > without mapping information which could later cause missed notifications
> > about memory errors. Fix the problem by calling the association /
> > deassociation code if and only if we are really going to update the
> > xarray (deassociating and associating zero or empty entries is just
> > no-op so there's no reason to complicate the code with trying to avoid
> > the calls for these cases).
> 
> Looks good to me, I assume this also needs:
> 
> Cc: <stable@vger.kernel.org>
> Fixes: d2c997c0f145 ("fs, dax: use page->mapping to warn if truncate
> collides with a busy page")

Yes, thanks for that.

								Honza

> 
> >
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/dax.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/dax.c b/fs/dax.c
> > index f74386293632..9fd908f3df32 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -728,12 +728,11 @@ static void *dax_insert_entry(struct xa_state *xas,
> >
> >         xas_reset(xas);
> >         xas_lock_irq(xas);
> > -       if (dax_entry_size(entry) != dax_entry_size(new_entry)) {
> > +       if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
> > +               void *old;
> > +
> >                 dax_disassociate_entry(entry, mapping, false);
> >                 dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address);
> > -       }
> > -
> > -       if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
> >                 /*
> >                  * Only swap our new entry into the page cache if the current
> >                  * entry is a zero page or an empty entry.  If a normal PTE or
> > @@ -742,7 +741,7 @@ static void *dax_insert_entry(struct xa_state *xas,
> >                  * existing entry is a PMD, we will just leave the PMD in the
> >                  * tree and dirty it if necessary.
> >                  */
> > -               void *old = dax_lock_entry(xas, new_entry);
> > +               old = dax_lock_entry(xas, new_entry);
> >                 WARN_ON_ONCE(old != xa_mk_value(xa_to_value(entry) |
> >                                         DAX_LOCKED));
> >                 entry = new_entry;
> > --
> > 2.16.4
> >
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
