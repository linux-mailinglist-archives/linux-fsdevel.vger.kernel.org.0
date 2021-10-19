Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F0E433308
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 12:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbhJSKDV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 06:03:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45712 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbhJSKDU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 06:03:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A0AC521985;
        Tue, 19 Oct 2021 10:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634637666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vHKiN0to6awHSGK/Z0uxe/7akzcjpjOz12RCGHIpgSg=;
        b=lXBDhtOEFUq3cI3E2ynyRLSnyrJbF3R+RoBSlTwO/TcWfTXX2o/5CIRAAn5n62/i3yrSwk
        dGcWocY+2Ar2OQGK/BfxlAANtWGm2Y7SyeU/s+XIr6yL5VRPMpsdU1KhWzmnwouHThsE7D
        m6M837MDmnKegsFKj4GV68oEDoQrexU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634637666;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vHKiN0to6awHSGK/Z0uxe/7akzcjpjOz12RCGHIpgSg=;
        b=rReX5y3wmXZR7MLAWm/ywru97rmPPttTeCIGKc0/rwp/77Ed3X1rp1R/4BUYS3K+bpyCgD
        n+OVJURUNWSARgDg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 897CAA3B84;
        Tue, 19 Oct 2021 10:01:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 609081E0BE5; Tue, 19 Oct 2021 12:01:06 +0200 (CEST)
Date:   Tue, 19 Oct 2021 12:01:06 +0200
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
Subject: Re: [PATCH v8 11/32] fsnotify: Protect fsnotify_handle_inode_event
 from no-inode events
Message-ID: <20211019100106.GG3255@quack2.suse.cz>
References: <20211019000015.1666608-1-krisman@collabora.com>
 <20211019000015.1666608-12-krisman@collabora.com>
 <CAOQ4uxhyW1O6tEKsEvnyV9ovmM=On0KWoe9Oq-HZou7MdR0GaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhyW1O6tEKsEvnyV9ovmM=On0KWoe9Oq-HZou7MdR0GaA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 19-10-21 08:34:41, Amir Goldstein wrote:
> On Tue, Oct 19, 2021 at 3:01 AM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
> >
> > FAN_FS_ERROR allows events without inodes - i.e. for file system-wide
> > errors.  Even though fsnotify_handle_inode_event is not currently used
> > by fanotify, this patch protects this path to handle this new case.
> >
> > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> > ---
> >  fs/notify/fsnotify.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> > index fde3a1115a17..47f931fb571c 100644
> > --- a/fs/notify/fsnotify.c
> > +++ b/fs/notify/fsnotify.c
> > @@ -252,6 +252,9 @@ static int fsnotify_handle_inode_event(struct fsnotify_group *group,
> >         if (WARN_ON_ONCE(!ops->handle_inode_event))
> >                 return 0;
> >
> > +       if (!inode)
> > +               return 0;
> > +
> 
> Sigh.. the plot thickens.
> There are three in-tree backends that implement the ->handle_inode_event()
> interface.
> 
> inotify and dnotify can take NULL inode and the above will make the CREATE
> events on kernfs vanish, so we cannot do that.
> Sorry for not noticing this earlier when I asked for this change.
> 
> nfsd_file_fsnotify_handle_event() can most certainly not take NULL inode,
> but nfsd does not watch for CREATE events.

And furthermore you cannot really export kernfs :)

> I think what we need to do is (Jan please correct me if you think otherwise):
> 1. Document the handle_inode_event() interface that either inode or dir
>     must be non-NULL
> 2. WARN_ON_ONCE(!inode && !dir) instead of just (!inode) above

Yeah, like:
	if (WARN_ON_ONCE(!inode && !dir))
		return 0;

> 3. Add WARN_ON_ONCE(!inode) before trace_nfsd_file_fsnotify_handle_event()
>     in nfsd_file_fsnotify_handle_event()

And:
	if (WARN_ON_ONCE(!inode))
		return 0;

Sounds like a good plan to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
