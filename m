Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C72F40C3A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 12:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbhIOKdD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 06:33:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35732 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbhIOKdC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 06:33:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8A0E11FE50;
        Wed, 15 Sep 2021 10:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631701902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OBqVQGnFWgtPG9Q+UphQmLlXVL6BaYYUbmftNzq04iQ=;
        b=vCIxgPTi6OMDqQ1ajFPPws6U/nEaOZXbNreE5vLj0ORZVg9SGJK5j03eyv1Pm/qcwe8Lul
        zUSA36no50k4583wA4oRhu13+NFroEoBYuq2Ymiujc9Cj8pkGoJdk9VkNNBNFavQhvy8eK
        jqk/KMIUfFBs0odiRg8c66j8c+i81Z8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631701902;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OBqVQGnFWgtPG9Q+UphQmLlXVL6BaYYUbmftNzq04iQ=;
        b=e/WnNShqk62O0dQZnZD9WPguIsQYzduDCgskdnNv9m/4hbEBfdiHXgi+hGDxnaudXKibAb
        jiWMOVYTfo8QVvCQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 6D872A3B90;
        Wed, 15 Sep 2021 10:31:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 02FF31E4318; Wed, 15 Sep 2021 12:31:40 +0200 (CEST)
Date:   Wed, 15 Sep 2021 12:31:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com
Subject: Re: [PATCH v6 15/21] fanotify: Preallocate per superblock mark error
 event
Message-ID: <20210915103140.GA6166@quack2.suse.cz>
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-16-krisman@collabora.com>
 <20210816155758.GF30215@quack2.suse.cz>
 <877dg6rbtn.fsf@collabora.com>
 <87a6kusmar.fsf@collabora.com>
 <CAOQ4uxjDtA45nn4iT9LFbbavuGa=vMPQJFp7GOJHdqrst8y+1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjDtA45nn4iT9LFbbavuGa=vMPQJFp7GOJHdqrst8y+1A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 03-09-21 07:16:33, Amir Goldstein wrote:
> On Fri, Sep 3, 2021 at 12:24 AM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
> > Actually, I don't think this will work for insertion unless we keep a
> > bounce buffer for the file_handle, because we need to keep the
> > group->notification_lock to ensure the fee doesn't go away with the mark
> > (since it is not yet enqueued) but, as discussed before, we don't want
> > to hold that lock when generating the FH.
> >
> > I think the correct way is to have some sort of refcount of the error
> > event slot.  We could use err_count for that and change the suggestion
> > above to:
> >
> > if (mark->flags & FANOTIFY_MARK_FLAG_SB_MARK) {
> >         struct fanotify_sb_mark *fa_mark = FANOTIFY_SB_MARK(mark);
> >
> >         spin_lock(&group->notification_lock);
> >         if (fa_mark->fee_slot) {
> >                 if (!fee->err_count) {
> >                         kfree(fa_mark->fee_slot);
> >                         fa_mark->fee_slot = NULL;
> >                 } else {
> >                         fa_mark->fee_slot->mark_alive = 0;
> >                 }
> >         }
> >         spin_unlock(&group->notification_lock);
> > }
> >
> > And insertion would look like this:
> >
> > static int fanotify_handle_error_event(....) {
> >
> >         spin_lock(&group->notification_lock);
> >
> >         if (!mark->fee || (mark->fee->err_count++) {
> >                 spin_unlock(&group->notification_lock);
> >                 return 0;
> >         }
> >
> >         spin_unlock(&group->notification_lock);
> >
> >         mark->fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
> >
> >         /* ... Write report data to error event ... */
> >
> >         fanotify_encode_fh(&fee->object_fh, fanotify_encode_fh_len(inode),
> >                            NULL, 0);
> >
> >         fsnotify_add_event(group, &fee->fae.fse, NULL);
> >    }
> >
> > Unless you think this is too hack-ish.
> >
> > To be fair, I think it is hack-ish.
> 
> Actually, I wouldn't mind the hack-ish-ness if it would simplify things,
> but I do not see how this is the case here.
> I still cannot wrap my head around the semantics, which is a big red light.
> First of all a suggestion should start with the lifetime rules:
> - Possible states
> - State transition rules
> 
> Speaking for myself, I simply cannot review a proposal without these
> documented rules.

Hum, getting back up to speed on this after vacation is tough which
suggests maybe we've indeed overengineered this :) So let's try to simplify
things.

> > I would add a proper refcount_t
> > to the error event, and let the mark own a reference to it, which is
> > dropped when the mark goes away.  Enqueue and Dequeue will acquire and
> > drop references, respectively. In this case, err_count is not
> > overloaded.
> >
> > Will it work?
> 
> Maybe, I still don't see the full picture, but if this can get us to a state
> where error events handling is simpler then it's a good idea.
> Saving the space of refcount_t in error event struct is not important at all.
> 
> But if Jan's option #1 (mempool) brings us to less special casing
> of enqueue/dequeue of error events, then I think that would be
> my preference.

Yes, I think mempools would result in a simpler code overall (the
complexity of recycling events would be handled by mempool for us). Maybe
we would not even need to play tricks with mempool resizing? We could just
make sure it has couple of events reserved and if it ever happens that
mempool_alloc() cannot give us any event, we'd report queue overflow (like
we already do for other event types if that happens). I think we could
require that callers generating error events are in a context where GFP_NOFS
allocation is OK - this should be achievable target for filesystems and
allocation failures should be rare with such mask.

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
