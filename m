Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E7F43351F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 13:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbhJSLy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 07:54:57 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44706 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbhJSLy4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 07:54:56 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CBAD31FCA1;
        Tue, 19 Oct 2021 11:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634644362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vZ6SqWivaR7J+dDBdJR9QxTbgDItdfol945P7TBlZUE=;
        b=zObd7a2rc4SIjVkSCsPQj8lWgOtFi1QSA+hc781Sp22V8T6PUnBd+CQtyfxd9V+3ueKJ9z
        5a//M4nSYMqNDrorLvvlWDiz2k56/W7ZGkImcpcx0hn83yWjLEDEQUrsm+WAndfceOZ23S
        2cT6EIYIQHit+A9Ev+9slHYj237qjkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634644362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vZ6SqWivaR7J+dDBdJR9QxTbgDItdfol945P7TBlZUE=;
        b=baSY88UoYqUEcUbmOPWUfM/aisxoqpCiG+aQBVPb4crWXUydpQdDDDa6IknUrL7wBmIaWB
        NgjQ/B2O9oFVmoCQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id B83E1A3B85;
        Tue, 19 Oct 2021 11:52:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 979131E0983; Tue, 19 Oct 2021 13:52:42 +0200 (CEST)
Date:   Tue, 19 Oct 2021 13:52:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Jan Kara <jack@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, kernel@collabora.com
Subject: Re: [PATCH v8 19/32] fanotify: Pre-allocate pool of error events
Message-ID: <20211019115242.GH3255@quack2.suse.cz>
References: <20211019000015.1666608-1-krisman@collabora.com>
 <20211019000015.1666608-20-krisman@collabora.com>
 <CAOQ4uxgpgNqA1CUUuytbwuxNJepvARMjMPAhi3WTXcCxtkMCmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgpgNqA1CUUuytbwuxNJepvARMjMPAhi3WTXcCxtkMCmA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 19-10-21 08:38:34, Amir Goldstein wrote:
> On Tue, Oct 19, 2021 at 3:03 AM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
> >
> > Pre-allocate slots for file system errors to have greater chances of
> > succeeding, since error events can happen in GFP_NOFS context.  This
> > patch introduces a group-wide mempool of error events, shared by all
> > FAN_FS_ERROR marks in this group.
> >
> > For now, just allocate 128 positions.  A future patch allows this
> > array to be dynamically resized when a new mark is added.
> >
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> >
> > ---
> > Changes since v7:
> >   - Expand limit to 128. (Amir)
> 
> I am not sure if Jan was also on board with this request but otherwise
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

I don't really care. I don't see a strong reason to go above original 32
(so I'd slightly prefer that) but OTOH I also don't think those few KB per
notification group using FS_ERROR matter since I don't expect such groups
to be that common.

> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > index 66ee3c2805c7..f77581c5b97f 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -30,6 +30,7 @@
> >  #define FANOTIFY_DEFAULT_MAX_EVENTS    16384
> >  #define FANOTIFY_OLD_DEFAULT_MAX_MARKS 8192
> >  #define FANOTIFY_DEFAULT_MAX_GROUPS    128
> > +#define FANOTIFY_DEFAULT_MAX_FEE_POOL  128

Perhaps FANOTIFY_DEFAULT_FEE_POOL_SIZE would better describe what this
constant is about?

Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
