Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530C7215AA8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jul 2020 17:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbgGFPYX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 11:24:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:38622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729301AbgGFPYX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:24:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C20F9AAC3;
        Mon,  6 Jul 2020 15:24:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 480A01E1311; Mon,  6 Jul 2020 17:24:21 +0200 (CEST)
Date:   Mon, 6 Jul 2020 17:24:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 19/20] fanotify: move event name into fanotify_fh
Message-ID: <20200706152421.GE3913@quack2.suse.cz>
References: <20200612093343.5669-1-amir73il@gmail.com>
 <20200612093343.5669-20-amir73il@gmail.com>
 <20200703160229.GF21364@quack2.suse.cz>
 <CAOQ4uxjG6pd2_Rd1ssh__0f7=HVc0iOjAkQwaLsD+BOFPz2F=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjG6pd2_Rd1ssh__0f7=HVc0iOjAkQwaLsD+BOFPz2F=A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 06-07-20 11:21:24, Amir Goldstein wrote:
> On Fri, Jul 3, 2020 at 7:02 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 12-06-20 12:33:42, Amir Goldstein wrote:
> > > An fanotify event name is always recorded relative to a dir fh.
> > > Move the name_len members of fanotify_name_event into unused space
> > > in struct fanotify_fh.
> > >
> > > We add a name_offset member to allow packing a binary blob before
> > > the name string in the variable size buffer. We are going to use
> > > that space to store the child fid.
> >
> > So how much is this packing going to save us? Currently it is 1 byte for
> > name events (modulo that fanotify_alloc_name_event_bug() you mention
> > below). With the additional fanotify_fh in the event, we'll save two more
> > bytes by the packing. So that doesn't really seem to be worth it to me.
> > Am I missing some other benefit?
> >
> > Maybe your main motivation (which is not mentioned in the changelog at all
> > BTW) is that the whole game of inline vs out of line file handles is
> > pointless when we kmalloc() the event anyway because of the name?
> 
> The only motivation, which is written in the commit message is to make
> space to store the child file handle. Saving space is just a by product.
> In fact, the new parceling code looses this space back to alignment
> and I am perfectly fine with that.

Yeah, I think the loss is acceptable.

> I tried your suggestion (with the minor modifications above) and I
> like the result.
> Pushed prep series with 2 last patches changed to branch fanotify_prep.
> Old prep series is at fanotify_prep-v2.

Yeah, I like the result as well. I've left some minor comments on github.
Please repost the preparatory series once you address the comments so that
we have something for final review and picking up into my tree.

> Pushed tested full series adapted to this change to fanotify_name_fid.
> Old full series is at fanotify_name_fid-v4.
> 
> There was almost no changes to the fanotify_name_fid patches besides
> adapting the accessors, e.g.:
> -               fanotify_fh_blob(&FANOTIFY_NE(event)->dir_fh);
> +              fanotify_info_file_fh(&FANOTIFY_NE(event)->info);
> 
> Please let me know if you want me to post fanotify_name_fid-v5 with these
> changes.

No need to repost at this point I guess. I can do a high-level check with
what I have...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
