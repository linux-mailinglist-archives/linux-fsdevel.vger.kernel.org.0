Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE7E3EEA9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 12:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbhHQKI6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 06:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbhHQKIw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:08:52 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79686C061764;
        Tue, 17 Aug 2021 03:08:18 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id h18so21575845ilc.5;
        Tue, 17 Aug 2021 03:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NOFCDOixLJY6DwFBePJH88H6/uMJRgdjY55vjUZoo48=;
        b=hoAJ/OkcphMR4GHR50YVWJok6t2Niw1p6DDijPvd5/GgHtcDj0jlzYXp49525ouIJe
         jaBtEBYw78wcDIRJ6n3xKm/rkyzsyAvQwUD5LBXsjSgsYm28/G5S/TtCCcBVl51riUXQ
         YOo80WhlKuGwR9AChmWeRlYxvB7kq6A8vrVpgM3f2y9x8vHtuNGJYoSFiSTXKKRYnPOG
         pKsi1QQZ7Rjl2wtzBVLFE/3/l2oMj7/mBQe5r6rFID2qmumsbK1SuZ+Mh09Qcu161ffH
         iiNq/03UcrHUBGIZds8AnaEjwhnuwR1QfWiq5KXc2l+NHZNJHLK5Yqdfk7PHwsMu6cVB
         TiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NOFCDOixLJY6DwFBePJH88H6/uMJRgdjY55vjUZoo48=;
        b=JtCm8XeqlHfR/LjUf7brkW+hPiXGEn9LAQ/BWCWC6KxFwpRn2Cyanw2ZrCHXYONQlf
         EzZlS23wsggArbQ58Uxxbw4aGdWPchzoaZhS7nzYCbPtuxvYW687tI/vcDMc+BHHZmsK
         iFWNVovHbfhUewtFa27LTcrkeQX43/SWux9VG+yMnifKW6AQhl3WCCluWD9w8/XqzQnW
         CFyfuivYDT9lCx1IrFwEoQdvUK9H7WvLcV3IIC6WHhfICcJ5k8nGhVaj7wBHPpqQ/thl
         NqPYb3OSjFhcYHEWWPm4MW/DPku3oTvA/pzQblHvIe635qy95C3blE/A04Bxciz1Xxgy
         +kxA==
X-Gm-Message-State: AOAM532eBLpla0cQZzu8u/9geby7lg8OCbn5fIbGzLO4+TOFr7w7PJ5F
        ZspihokZEbbygDQP+wIFyebhoozWYvmKx6qkMUo=
X-Google-Smtp-Source: ABdhPJx3s7hVoptraNTTEsNt+0hGavUpuIBZ5hNibbEEGmh3AJQJee5XNa3h9CSQI3nTTv/9NaCZ+/OorF0p48A69Uc=
X-Received: by 2002:a92:cd0a:: with SMTP id z10mr1801660iln.137.1629194897821;
 Tue, 17 Aug 2021 03:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-19-krisman@collabora.com> <20210816214103.GA12664@magnolia>
 <20210817090538.GA26181@quack2.suse.cz>
In-Reply-To: <20210817090538.GA26181@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 17 Aug 2021 13:08:06 +0300
Message-ID: <CAOQ4uxgdJpovZ-zzJkLOdQ=YYF3ta46m0_jrt0QFSdJ9GdXR=g@mail.gmail.com>
Subject: Re: [PATCH v6 18/21] fanotify: Emit generic error info type for error event
To:     Jan Kara <jack@suse.cz>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Jan Kara <jack@suse.com>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Tso <tytso@mit.edu>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 17, 2021 at 12:05 PM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 16-08-21 14:41:03, Darrick J. Wong wrote:
> > On Thu, Aug 12, 2021 at 05:40:07PM -0400, Gabriel Krisman Bertazi wrote:
> > > The Error info type is a record sent to users on FAN_FS_ERROR events
> > > documenting the type of error.  It also carries an error count,
> > > documenting how many errors were observed since the last reporting.
> > >
> > > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> > >
> > > ---
> > > Changes since v5:
> > >   - Move error code here
> > > ---
> > >  fs/notify/fanotify/fanotify.c      |  1 +
> > >  fs/notify/fanotify/fanotify.h      |  1 +
> > >  fs/notify/fanotify/fanotify_user.c | 36 ++++++++++++++++++++++++++++++
> > >  include/uapi/linux/fanotify.h      |  7 ++++++
> > >  4 files changed, 45 insertions(+)
> >
> > <snip>
> >
> > > diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> > > index 16402037fc7a..80040a92e9d9 100644
> > > --- a/include/uapi/linux/fanotify.h
> > > +++ b/include/uapi/linux/fanotify.h
> > > @@ -124,6 +124,7 @@ struct fanotify_event_metadata {
> > >  #define FAN_EVENT_INFO_TYPE_FID            1
> > >  #define FAN_EVENT_INFO_TYPE_DFID_NAME      2
> > >  #define FAN_EVENT_INFO_TYPE_DFID   3
> > > +#define FAN_EVENT_INFO_TYPE_ERROR  4
> > >
> > >  /* Variable length info record following event metadata */
> > >  struct fanotify_event_info_header {
> > > @@ -149,6 +150,12 @@ struct fanotify_event_info_fid {
> > >     unsigned char handle[0];
> > >  };
> > >
> > > +struct fanotify_event_info_error {
> > > +   struct fanotify_event_info_header hdr;
> > > +   __s32 error;
> > > +   __u32 error_count;
> > > +};
> >
> > My apologies for not having time to review this patchset since it was
> > redesigned to use fanotify.  Someday it would be helpful to be able to
> > export more detailed error reports from XFS, but as I'm not ready to
> > move forward and write that today, I'll try to avoid derailling this at
> > the last minute.
>
> I think we are not quite there and tweaking the passed structure is easy
> enough so no worries. Eventually, passing some filesystem-specific blob
> together with the event was the plan AFAIR. You're right now is a good
> moment to think how exactly we want that passed.
>
> > Eventually, XFS might want to be able to report errors in file data,
> > file metadata, allocation group metadata, and whole-filesystem metadata.
> > Userspace can already gather reports from XFS about corruptions reported
> > by the online fsck code (see xfs_health.c).
>
> Yes, although note that the current plan is that we currently have only one
> error event queue, others are just added to error_count until the event is
> fetched by userspace (on the grounds that the first error is usually the
> most meaningful, the others are usually just cascading problems). But I'm
> not sure if this scheme would be suitable for online fsck usecase since we
> may discard even valid independent errors this way.
>
> > I /think/ we could subclass the file error structure that you've
> > provided like so:
> >
> > struct fanotify_event_info_xfs_filesystem_error {
> >       struct fanotify_event_info_error        base;
> >
> >       __u32 magic; /* 0x58465342 to identify xfs */
> >       __u32 type; /* quotas, realtime bitmap, etc. */
> > };
> >
> > struct fanotify_event_info_xfs_perag_error {
> >       struct fanotify_event_info_error        base;
> >
> >       __u32 magic; /* 0x58465342 to identify xfs */
> >       __u32 type; /* agf, agi, agfl, bno btree, ino btree, etc. */
> >       __u32 agno; /* allocation group number */
> > };
> >
> > struct fanotify_event_info_xfs_file_error {
> >       struct fanotify_event_info_error        base;
> >
> >       __u32 magic; /* 0x58465342 to identify xfs */
> >       __u32 type; /* extent map, dir, attr, etc. */
> >       __u64 offset; /* file data offset, if applicable */
> >       __u64 length; /* file data length, if applicable */
> > };
> >
> > (A real XFS implementation might have one structure with the type code
> > providing for a tagged union or something; I split it into three
> > separate structs here to avoid confusing things.)
>
> The structure of fanotify event as passed to userspace generally is:
>
> struct fanotify_event_metadata {
>         __u32 event_len;
>         __u8 vers;
>         __u8 reserved;
>         __u16 metadata_len;
>         __aligned_u64 mask;
>         __s32 fd;
>         __s32 pid;
> };
>
> If event_len is > sizeof(struct fanotify_event_metadata), userspace is
> expected to look for struct fanotify_event_info_header after struct
> fanotify_event_metadata. struct fanotify_event_info_header looks like:
>
> struct fanotify_event_info_header {
>         __u8 info_type;
>         __u8 pad;
>         __u16 len;
> };
>
> Again if the end of this info (defined by 'len') is smaller than
> 'event_len', there is next header with next payload of data. So for example
> error event will have:
>
> struct fanotify_event_metadata
> struct fanotify_event_info_error
> struct fanotify_event_info_fid
>
> Now either we could add fs specific blob into fanotify_event_info_error
> (but then it would be good to add 'magic' to fanotify_event_info_error now
> and define that if 'len' is larger, fs-specific blob follows after fixed
> data) or we can add another info type FAN_EVENT_INFO_TYPE_ERROR_FS_DATA
> (i.e., attach another structure into the event) which would contain the
> 'magic' and then blob of data. I don't have strong preference.
>
> > I have three questions at this point:
> >
> > 1) What's the maximum size of a fanotify event structure?  None of these
> > structures exceed 36 bytes, which I hope will fit in whatever size
> > constraints?
>
> Whole event must fit into 4G, each event info needs to fit in 64k. At least
> these are the limits of the interface. Practically, it would be difficult
> and inefficient to manipulate such huge events...
>

Just keep in mind that the current scheme pre-allocates the single event slot
on fanotify_mark() time and (I think) we agreed to pre-allocate
sizeof(fsnotify_error_event) + MAX_HDNALE_SZ.
If filesystems would want to store some variable length fs specific info,
a future implementation will have to take that into account.

> > 2) If a program written for today's notification events sees a
> > fanotify_event_info_header from future-XFS with a header length that is
> > larger than FANOTIFY_INFO_ERROR_LEN, will it be able to react
> > appropriately?  Which is to say, ignore it on the grounds that the
> > length is unexpectedly large?
>
> That is the expected behavior :). But I guess separate info type for
> fs-specific blob might be more foolproof in this sense - when parsing
> events, you are expected to just skip info_types you don't understand
> (based on 'len' and 'type' in the common header) and generally different
> events have different sets of infos attached to them so you mostly have to
> implement this logic to be able to process events.
>
> > It /looks/ like this is the case; really I'm just fishing around here
> > to make sure nothing in the design of /this/ patchset would make it Very
> > Difficult(tm) to add more information later.
> >
> > 3) Once we let filesystem implementations create their own extended
> > error notifications, should we have a "u32 magic" to aid in decoding?
> > Or even add it to fanotify_event_info_error now?
>
> If we go via the 'separate info type' route, then the magic can go into
> that structure and there's no great use for 'magic' in
> fanotify_event_info_error.

My 0.02$:
With current patch set, filesystem reports error using:
fsnotify_sb_error(sb, inode, error)

The optional @inode argument is encoded to a filesystem opaque
blob using  exportfs_encode_inode_fh(), recorded in the event
as a blob and reported to userspace as a blob.

If filesystem would like to report a different type of opaque blob
(e.g. xfs_perag_info), the interface should be extended to:
fsnotify_sb_error(sb, inode, error, info, info_len)
and the 'separate info type' route seems like the best and most natural
way to deal with the case of information that is only emitted from
a specific filesystem with a specific feature enabled (online fsck).

IOW, there is no need for fanotify_event_info_xfs_perag_error
in fanotify UAPI if you ask me.

Regarding 'magic' in fanotify_event_info_error, I also don't see the
need for that, because the event already has fsid which can be
used to identify the filesystem in question.

Keep in mind that the value of handle_type inside struct file_handle
inside struct fanotify_event_info_fid is not a universal classifier.
Specifically, the type 0x81 means "XFS_FILEID_INO64_GEN"
only in the context of XFS and it can mean something else in the
context of another type of filesystem.

If we add a new info record fanotify_event_info_fs_private
it could even be an alias to fanotify_event_info_fid with the only
difference that the handle[0] member is not expected to be
struct file_handle, but some other fs private struct.

Thanks,
Amir.
