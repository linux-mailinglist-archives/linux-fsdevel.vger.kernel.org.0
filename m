Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECED142F3C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 15:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbhJONkm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 09:40:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60384 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240019AbhJONkT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:40:19 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3ED411FD4E;
        Fri, 15 Oct 2021 13:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634305092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ea9AcM4Y9HwPFm+/hy1WuVwQrPcBvNHKRLjoVRnGAs4=;
        b=O4jV/jTQ3h1LQurUirP8sxUQhR3y9c/GD9Mq1AL08Ie67AE5L4KcE0CF3cBVUgD0rW9AZa
        uEbN5ak/jvKXc0doHsBVAmwEr1OTui/NmFOF/AmootJt5N1ppzSpTcq77MX+o+pZXjW+1h
        KnYD9U1JI6UBPQ58Ao8YjXc3o6l2s48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634305092;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ea9AcM4Y9HwPFm+/hy1WuVwQrPcBvNHKRLjoVRnGAs4=;
        b=ZnzEkRxVaeZxnjN+gIiYlwymkaDXuk7a7fG9W9oUUkQ1lSZ2x9aW3NryhmQl+yBf55KopU
        nbrv0hkyBJauC+BQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 29475A3B8B;
        Fri, 15 Oct 2021 13:38:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 032831E0A40; Fri, 15 Oct 2021 15:38:11 +0200 (CEST)
Date:   Fri, 15 Oct 2021 15:38:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Jan Kara <jack@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com
Subject: Re: [PATCH v7 23/28] fanotify: Report fid info for file related file
 system errors
Message-ID: <20211015133811.GO23102@quack2.suse.cz>
References: <20211014213646.1139469-1-krisman@collabora.com>
 <20211014213646.1139469-24-krisman@collabora.com>
 <CAOQ4uxgR9jGSyGoHvDEPpSpMVHGssnkXJJ5a8HRKD6nxMyMLmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgR9jGSyGoHvDEPpSpMVHGssnkXJJ5a8HRKD6nxMyMLmA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 15-10-21 10:56:38, Amir Goldstein wrote:
> On Fri, Oct 15, 2021 at 12:39 AM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
> >
> > Plumb the pieces to add a FID report to error records.  Since all error
> > event memory must be pre-allocated, we pre-allocate the maximum file
> > handle size possible, such that it should always fit.
> >
> > For errors that don't expose a file handle report it with an invalid
> > FID.
> >
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> >
> > ---
> > Changes since v6:
> >   - pass fsid from handle_events
> > Changes since v5:
> >   - Use preallocated MAX_HANDLE_SZ FH buffer
> >   - Report superblock errors with a zerolength INVALID FID (jan, amir)
> > ---
> >  fs/notify/fanotify/fanotify.c | 15 +++++++++++++++
> >  fs/notify/fanotify/fanotify.h |  8 ++++++++
> >  2 files changed, 23 insertions(+)
> >
> > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> > index 7032083df62a..8a60c96f5fb2 100644
> > --- a/fs/notify/fanotify/fanotify.c
> > +++ b/fs/notify/fanotify/fanotify.c
> > @@ -611,7 +611,9 @@ static struct fanotify_event *fanotify_alloc_error_event(
> >  {
> >         struct fs_error_report *report =
> >                         fsnotify_data_error_report(data, data_type);
> > +       struct inode *inode = report->inode;
> >         struct fanotify_error_event *fee;
> > +       int fh_len;
> >
> >         if (WARN_ON(!report))
> >                 return NULL;
> > @@ -622,6 +624,19 @@ static struct fanotify_event *fanotify_alloc_error_event(
> >
> >         fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
> >         fee->err_count = 1;
> > +       fee->fsid = *fsid;
> > +
> > +       fh_len = fanotify_encode_fh_len(inode);
> > +       if (WARN_ON(fh_len > MAX_HANDLE_SZ)) {
> 
> WARN_ON_ONCE please and I rather that this sanity check is moved inside
> fanotify_encode_fh_len() where it will return 0 for encoding failure.

Yeah, that's better.

> > diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> > index 2b032b79d5b0..b58400926f92 100644
> > --- a/fs/notify/fanotify/fanotify.h
> > +++ b/fs/notify/fanotify/fanotify.h
> > @@ -202,6 +202,10 @@ struct fanotify_error_event {
> >         u32 err_count; /* Suppressed errors count */
> >
> >         __kernel_fsid_t fsid; /* FSID this error refers to. */
> > +       /* object_fh must be followed by the inline handle buffer. */
> > +       struct fanotify_fh object_fh;
> > +       /* Reserve space in object_fh.buf[] - access with fanotify_fh_buf() */
> > +       unsigned char _inline_fh_buf[MAX_HANDLE_SZ];
> >  };
> 
> This struct duplicates most of struct fanotify_fid_event.
> How about:
> 
> #define FANOTIFY_ERROR_FH_LEN \
>              (MAX_HANDLE_SZ - FANOTIFY_INLINE_FH_LEN)
> 
> struct fanotify_error_event {
>          u32 err_count; /* Suppressed errors count */
>          struct fanotify_event ffe;
>          /* Reserve space in ffe.object_fh.buf[] - access with
> fanotify_fh_buf() */
>          unsigned char _fh_buf[FANOTIFY_ERROR_FH_LEN];
> }
> 
> Or leaving out the struct padding and passing
> FANOTIFY_ERROR_EVENT_SIZE as mempool object size?
> 
> #define FANOTIFY_ERROR_EVENT_SIZE \
>             (sizeof(struct fanotify_error_event) + FANOTIFY_ERROR_FH_LEN)

Hrm, I don't like either of these two options too much as IMHO it's rather
hard to understand what's going on. If we want to avoid the duplication,
then I see two relatively clean ways to do it:

a) Remove _inline_fh_buf from fanotify_fid_event (probably just leave a
comment there explaining how space is preallocated) and make sure kmem
cache for fanotify_fid_event has FANOTIFY_INLINE_FH_LEN in each object for
the fh, similarly error event would have MAX_HANDLE_SZ in the object.

b) Define a macro that expands to a struct definition with appropriate
buffer length.

I guess a) seems a bit more obvious to me but I can live with both...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
