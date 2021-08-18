Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346D73EF6D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 02:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbhHRARI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 20:17:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234870AbhHRARG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 20:17:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DD6460240;
        Wed, 18 Aug 2021 00:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629245792;
        bh=Q5w2pL5Af/2oITiQaTLu3p6kxOR+Gu1UXnCqCeGJDSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rkBSfPevgbD53i4cGPYgj5j56W6rALyfO4QH5MamGVoIGAm2AzHOIz+UiFfDWdJAC
         GyUD+LoddyqIgrQyOdhdOS88Nyebli7cXSPYr0+s22Q/a9cLp15lVU3exffQhLYgD7
         qIO7Cf+x8gz68GYDSCQIpq8/oGd6H8eqVGR4/B6HnxhoInu5X0ogmSD62gR5q/j9Zi
         f8xIPR0bQFM8TE/wN6GPuxqrvDhJpiAfTh5RLdMOjyHxxu2qSIyMubbs8QZ30dkea8
         +j6gpmUaDw/9kxmnSUerkb5lsXrbD98KgQ97dloHARkUgWLWasE6333g1oiHeov3OL
         NPh7ZLSHLeiLg==
Date:   Tue, 17 Aug 2021 17:16:32 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
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
Subject: Re: [PATCH v6 18/21] fanotify: Emit generic error info type for
 error event
Message-ID: <20210818001632.GD12664@magnolia>
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-19-krisman@collabora.com>
 <20210816214103.GA12664@magnolia>
 <20210817090538.GA26181@quack2.suse.cz>
 <CAOQ4uxgdJpovZ-zzJkLOdQ=YYF3ta46m0_jrt0QFSdJ9GdXR=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgdJpovZ-zzJkLOdQ=YYF3ta46m0_jrt0QFSdJ9GdXR=g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 17, 2021 at 01:08:06PM +0300, Amir Goldstein wrote:
> On Tue, Aug 17, 2021 at 12:05 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 16-08-21 14:41:03, Darrick J. Wong wrote:
> > > On Thu, Aug 12, 2021 at 05:40:07PM -0400, Gabriel Krisman Bertazi wrote:
> > > > The Error info type is a record sent to users on FAN_FS_ERROR events
> > > > documenting the type of error.  It also carries an error count,
> > > > documenting how many errors were observed since the last reporting.
> > > >
> > > > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> > > >
> > > > ---
> > > > Changes since v5:
> > > >   - Move error code here
> > > > ---
> > > >  fs/notify/fanotify/fanotify.c      |  1 +
> > > >  fs/notify/fanotify/fanotify.h      |  1 +
> > > >  fs/notify/fanotify/fanotify_user.c | 36 ++++++++++++++++++++++++++++++
> > > >  include/uapi/linux/fanotify.h      |  7 ++++++
> > > >  4 files changed, 45 insertions(+)
> > >
> > > <snip>
> > >
> > > > diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> > > > index 16402037fc7a..80040a92e9d9 100644
> > > > --- a/include/uapi/linux/fanotify.h
> > > > +++ b/include/uapi/linux/fanotify.h
> > > > @@ -124,6 +124,7 @@ struct fanotify_event_metadata {
> > > >  #define FAN_EVENT_INFO_TYPE_FID            1
> > > >  #define FAN_EVENT_INFO_TYPE_DFID_NAME      2
> > > >  #define FAN_EVENT_INFO_TYPE_DFID   3
> > > > +#define FAN_EVENT_INFO_TYPE_ERROR  4
> > > >
> > > >  /* Variable length info record following event metadata */
> > > >  struct fanotify_event_info_header {
> > > > @@ -149,6 +150,12 @@ struct fanotify_event_info_fid {
> > > >     unsigned char handle[0];
> > > >  };
> > > >
> > > > +struct fanotify_event_info_error {
> > > > +   struct fanotify_event_info_header hdr;
> > > > +   __s32 error;
> > > > +   __u32 error_count;
> > > > +};
> > >
> > > My apologies for not having time to review this patchset since it was
> > > redesigned to use fanotify.  Someday it would be helpful to be able to
> > > export more detailed error reports from XFS, but as I'm not ready to
> > > move forward and write that today, I'll try to avoid derailling this at
> > > the last minute.
> >
> > I think we are not quite there and tweaking the passed structure is easy
> > enough so no worries. Eventually, passing some filesystem-specific blob
> > together with the event was the plan AFAIR. You're right now is a good
> > moment to think how exactly we want that passed.
> >
> > > Eventually, XFS might want to be able to report errors in file data,
> > > file metadata, allocation group metadata, and whole-filesystem metadata.
> > > Userspace can already gather reports from XFS about corruptions reported
> > > by the online fsck code (see xfs_health.c).
> >
> > Yes, although note that the current plan is that we currently have only one
> > error event queue, others are just added to error_count until the event is
> > fetched by userspace (on the grounds that the first error is usually the
> > most meaningful, the others are usually just cascading problems). But I'm
> > not sure if this scheme would be suitable for online fsck usecase since we
> > may discard even valid independent errors this way.
> >
> > > I /think/ we could subclass the file error structure that you've
> > > provided like so:
> > >
> > > struct fanotify_event_info_xfs_filesystem_error {
> > >       struct fanotify_event_info_error        base;
> > >
> > >       __u32 magic; /* 0x58465342 to identify xfs */
> > >       __u32 type; /* quotas, realtime bitmap, etc. */
> > > };
> > >
> > > struct fanotify_event_info_xfs_perag_error {
> > >       struct fanotify_event_info_error        base;
> > >
> > >       __u32 magic; /* 0x58465342 to identify xfs */
> > >       __u32 type; /* agf, agi, agfl, bno btree, ino btree, etc. */
> > >       __u32 agno; /* allocation group number */
> > > };
> > >
> > > struct fanotify_event_info_xfs_file_error {
> > >       struct fanotify_event_info_error        base;
> > >
> > >       __u32 magic; /* 0x58465342 to identify xfs */
> > >       __u32 type; /* extent map, dir, attr, etc. */
> > >       __u64 offset; /* file data offset, if applicable */
> > >       __u64 length; /* file data length, if applicable */
> > > };
> > >
> > > (A real XFS implementation might have one structure with the type code
> > > providing for a tagged union or something; I split it into three
> > > separate structs here to avoid confusing things.)
> >
> > The structure of fanotify event as passed to userspace generally is:
> >
> > struct fanotify_event_metadata {
> >         __u32 event_len;
> >         __u8 vers;
> >         __u8 reserved;
> >         __u16 metadata_len;
> >         __aligned_u64 mask;
> >         __s32 fd;
> >         __s32 pid;
> > };
> >
> > If event_len is > sizeof(struct fanotify_event_metadata), userspace is
> > expected to look for struct fanotify_event_info_header after struct
> > fanotify_event_metadata. struct fanotify_event_info_header looks like:
> >
> > struct fanotify_event_info_header {
> >         __u8 info_type;
> >         __u8 pad;
> >         __u16 len;
> > };
> >
> > Again if the end of this info (defined by 'len') is smaller than
> > 'event_len', there is next header with next payload of data. So for example
> > error event will have:
> >
> > struct fanotify_event_metadata
> > struct fanotify_event_info_error
> > struct fanotify_event_info_fid
> >
> > Now either we could add fs specific blob into fanotify_event_info_error
> > (but then it would be good to add 'magic' to fanotify_event_info_error now
> > and define that if 'len' is larger, fs-specific blob follows after fixed
> > data) or we can add another info type FAN_EVENT_INFO_TYPE_ERROR_FS_DATA
> > (i.e., attach another structure into the event) which would contain the
> > 'magic' and then blob of data. I don't have strong preference.
> >
> > > I have three questions at this point:
> > >
> > > 1) What's the maximum size of a fanotify event structure?  None of these
> > > structures exceed 36 bytes, which I hope will fit in whatever size
> > > constraints?
> >
> > Whole event must fit into 4G, each event info needs to fit in 64k. At least
> > these are the limits of the interface. Practically, it would be difficult
> > and inefficient to manipulate such huge events...
> >
> 
> Just keep in mind that the current scheme pre-allocates the single event slot
> on fanotify_mark() time and (I think) we agreed to pre-allocate
> sizeof(fsnotify_error_event) + MAX_HDNALE_SZ.
> If filesystems would want to store some variable length fs specific info,
> a future implementation will have to take that into account.

<nod> I /think/ for the fs and AG metadata we could preallocate these,
so long as fsnotify doesn't free them out from under us.  For inodes...
there are many more of those, so they'd have to be allocated
dynamically.

> > > 2) If a program written for today's notification events sees a
> > > fanotify_event_info_header from future-XFS with a header length that is
> > > larger than FANOTIFY_INFO_ERROR_LEN, will it be able to react
> > > appropriately?  Which is to say, ignore it on the grounds that the
> > > length is unexpectedly large?
> >
> > That is the expected behavior :). But I guess separate info type for
> > fs-specific blob might be more foolproof in this sense - when parsing
> > events, you are expected to just skip info_types you don't understand
> > (based on 'len' and 'type' in the common header) and generally different
> > events have different sets of infos attached to them so you mostly have to
> > implement this logic to be able to process events.
> >
> > > It /looks/ like this is the case; really I'm just fishing around here
> > > to make sure nothing in the design of /this/ patchset would make it Very
> > > Difficult(tm) to add more information later.
> > >
> > > 3) Once we let filesystem implementations create their own extended
> > > error notifications, should we have a "u32 magic" to aid in decoding?
> > > Or even add it to fanotify_event_info_error now?
> >
> > If we go via the 'separate info type' route, then the magic can go into
> > that structure and there's no great use for 'magic' in
> > fanotify_event_info_error.
> 
> My 0.02$:
> With current patch set, filesystem reports error using:
> fsnotify_sb_error(sb, inode, error)
> 
> The optional @inode argument is encoded to a filesystem opaque
> blob using  exportfs_encode_inode_fh(), recorded in the event
> as a blob and reported to userspace as a blob.
> 
> If filesystem would like to report a different type of opaque blob
> (e.g. xfs_perag_info), the interface should be extended to:
> fsnotify_sb_error(sb, inode, error, info, info_len)
> and the 'separate info type' route seems like the best and most natural
> way to deal with the case of information that is only emitted from
> a specific filesystem with a specific feature enabled (online fsck).

<nod> This seems reasonable to me.

> IOW, there is no need for fanotify_event_info_xfs_perag_error
> in fanotify UAPI if you ask me.
> 
> Regarding 'magic' in fanotify_event_info_error, I also don't see the
> need for that, because the event already has fsid which can be
> used to identify the filesystem in question.
> 
> Keep in mind that the value of handle_type inside struct file_handle
> inside struct fanotify_event_info_fid is not a universal classifier.
> Specifically, the type 0x81 means "XFS_FILEID_INO64_GEN"
> only in the context of XFS and it can mean something else in the
> context of another type of filesystem.

Can you pass the handle into the kernel to open a fd to file mentioned
in the report?  I don't think userspace is supposed to know what's
inside a file handle, and it would be helpful if it didn't matter here
either. :)

> If we add a new info record fanotify_event_info_fs_private
> it could even be an alias to fanotify_event_info_fid with the only
> difference that the handle[0] member is not expected to be
> struct file_handle, but some other fs private struct.

I ... think I prefer it being a separate info blob.

--D

> 
> Thanks,
> Amir.
