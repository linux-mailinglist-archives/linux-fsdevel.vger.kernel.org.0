Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D3642F1F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 15:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbhJONPx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 09:15:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45762 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhJONPw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:15:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2493C21969;
        Fri, 15 Oct 2021 13:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634303625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ajSbZ5DiLYEvdvWo7bOb8mmIqPddck0dkgiXAnC9Woo=;
        b=bkHqqn6N2bC34NwsInCOa8ldnttMiTEJ4T5JwqkS49Vk/8+QRxQksHgeeuQU8ee2bWRNvO
        E6AXi/3sAgzvDXS9I7wUsFODrO2O1nPYBZHBtpCETlUFYur0C3VPStg5WwdvzXVEKBNAqM
        BoEngq0D3CLKke0+cbk+pzWffYSwkJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634303625;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ajSbZ5DiLYEvdvWo7bOb8mmIqPddck0dkgiXAnC9Woo=;
        b=Gf3iUJDeX7Ol8745DGDUYLnkAOHkciEacR/VmntOlt8gZR7keighsKOZABx+wemjgqSAAY
        IHT+DmuacWRSFiBA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 0FE99A3B85;
        Fri, 15 Oct 2021 13:13:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E519A1E0A40; Fri, 15 Oct 2021 15:13:44 +0200 (CEST)
Date:   Fri, 15 Oct 2021 15:13:44 +0200
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
Subject: Re: [PATCH v7 22/28] fanotify: Report FID entry even for zero-length
 file_handle
Message-ID: <20211015131344.GN23102@quack2.suse.cz>
References: <20211014213646.1139469-1-krisman@collabora.com>
 <20211014213646.1139469-23-krisman@collabora.com>
 <CAOQ4uxjD6CpnDcg3jhVXT5adVJTk-RgiSCayELeTeqJLdWFKOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjD6CpnDcg3jhVXT5adVJTk-RgiSCayELeTeqJLdWFKOw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 15-10-21 11:10:58, Amir Goldstein wrote:
> On Fri, Oct 15, 2021 at 12:39 AM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
> >
> > Non-inode errors will reported with an empty file_handle.  In
> > preparation for that, allow some events to print the FID record even if
> > there isn't any file_handle encoded
> >
> > Even though FILEID_ROOT is used internally, make zero-length file
> > handles be reported as FILEID_INVALID.
> >
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> > ---
> >  fs/notify/fanotify/fanotify_user.c | 23 ++++++++++++++++++-----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > index 5324890500fc..39cf8ba4a6ce 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -127,6 +127,16 @@ static int fanotify_fid_info_len(int fh_len, int name_len)
> >                        FANOTIFY_EVENT_ALIGN);
> >  }
> >
> > +static bool fanotify_event_allows_empty_fh(struct fanotify_event *event)
> > +{
> > +       switch (event->type) {
> > +       case FANOTIFY_EVENT_TYPE_FS_ERROR:
> > +               return true;
> > +       default:
> > +               return false;
> > +       }
> > +}
> > +
> >  static size_t fanotify_event_len(unsigned int info_mode,
> >                                  struct fanotify_event *event)
> >  {
> > @@ -157,7 +167,7 @@ static size_t fanotify_event_len(unsigned int info_mode,
> >         if (info_mode & FAN_REPORT_PIDFD)
> >                 event_len += FANOTIFY_PIDFD_INFO_HDR_LEN;
> >
> > -       if (fh_len)
> > +       if (fh_len || fanotify_event_allows_empty_fh(event))
> >                 event_len += fanotify_fid_info_len(fh_len, dot_len);
> >
> >         return event_len;
> > @@ -338,9 +348,6 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
> >         pr_debug("%s: fh_len=%zu name_len=%zu, info_len=%zu, count=%zu\n",
> >                  __func__, fh_len, name_len, info_len, count);
> >
> > -       if (!fh_len)
> > -               return 0;
> > -
> >         if (WARN_ON_ONCE(len < sizeof(info) || len > count))
> >                 return -EFAULT;
> >
> > @@ -375,6 +382,11 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
> >
> >         handle.handle_type = fh->type;
> >         handle.handle_bytes = fh_len;
> > +
> > +       /* Mangle handle_type for bad file_handle */
> > +       if (!fh_len)
> > +               handle.handle_type = FILEID_INVALID;
> > +
> >         if (copy_to_user(buf, &handle, sizeof(handle)))
> >                 return -EFAULT;
> >
> > @@ -467,7 +479,8 @@ static int copy_info_records_to_user(struct fanotify_event *event,
> >                 total_bytes += ret;
> >         }
> >
> > -       if (fanotify_event_object_fh_len(event)) {
> > +       if (fanotify_event_object_fh_len(event) ||
> > +           fanotify_event_allows_empty_fh(event)) {
> >                 const char *dot = NULL;
> >                 int dot_len = 0;
> >
> 
> I don't like this fanotify_event_allows_empty_fh() implementation so much.
> 
> How about this instead:
> 
> static inline struct fanotify_fh *fanotify_event_object_fh(
>                                                 struct fanotify_event *event)
> {
>         struct fanotify_fh *fh = NULL;
> 
>         /* An error event encodes (a FILEID_INVAL) fh for an empty fh */
>         if (event->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
>                 return &FANOTIFY_EE(event)->object_fh;
>         else if (event->type == FANOTIFY_EVENT_TYPE_FID)
>                 fh = &FANOTIFY_FE(event)->object_fh;
>         else if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME)
>                 fh = fanotify_info_file_fh(&FANOTIFY_NE(event)->info);
> 
>         if (!fh && !fh->len)
>                 return NULL;
> 
>         return fh;
> }
> 
>         struct fanotify_fh *object_fh = fanotify_event_object_fh(event);
> ...
> 
> -       if (fanotify_event_object_fh_len(event)) {
> +       if (object_fh) {
>                 const char *dot = NULL;
> ...
>                 ret = copy_fid_info_to_user(fanotify_event_fsid(event),
> -                                           fanotify_event_object_fh(event),
> +                                          object_fh,
>                                             info_type, dot, dot_len,
>                                             buf, count);
> ...
> 
> And similar change to fanotify_event_len()
> 
> This way, the logic of whether to report fh or not is encoded in
> fanotify_event_object_fh() and fanotify_event_object_fh_len()
> goes back to being a property of the the fh report.

I like this except that AFAICT this will be problematic for
fanotify_event_object_fh_len() because there we want to return 0 (length of
file handle buffer to copy) for error events - so "copy just header to
userspace" is going to be indistiguishable from "copy nothing".

But maybe we need helpers fanotify_event_has_object_fh() and
fanotify_event_has_dir_fh() (for symmetry) instead of directly checking
fh_len? These would then encapsulate all the magic for error events.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
