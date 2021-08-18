Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D823EF697
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 02:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbhHRALM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 20:11:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235496AbhHRALL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 20:11:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19395601FA;
        Wed, 18 Aug 2021 00:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629245438;
        bh=PfbxYciJSghMueLbyDJ7WzGYJEZ6xMkqI/tk1eUfgtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EqA8p/gGGQzD1FFgHgmMd/m6sazkoDnN537+YsO/I8yL4b/MfApQaKcYWSL3pc+bv
         sLdznN0cxLy1xzYQUUR+4m0g6v8kR7QBa/pKFYXi87cWmozF0+nEdvSoKXvmBPM1Us
         mIqqz3i9AHZ/xeDiW1Y5uvZhvw2NYKdLDGlLP9/KyY0fTnkKYATQ7SNjGHlz0D78EK
         z+z2FFHVpWc3hu3JZRrwjnFgtuL0vgyRzTBX2nKsXEKzzbbqIsoyxzvFfuhjGs9Hp2
         ozs9eARfc9dXh9Oc+zOg6iTfwbSrm+A4xh7Uquz478e4MQv54UEg1gh49FnaItbFdY
         8W/LzYyf9MZWQ==
Date:   Tue, 17 Aug 2021 17:10:37 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        amir73il@gmail.com, jack@suse.com, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        khazhy@google.com, dhowells@redhat.com, david@fromorbit.com,
        tytso@mit.edu, repnop@google.com, kernel@collabora.com
Subject: Re: [PATCH v6 18/21] fanotify: Emit generic error info type for
 error event
Message-ID: <20210818001037.GC12664@magnolia>
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-19-krisman@collabora.com>
 <20210816214103.GA12664@magnolia>
 <20210817090538.GA26181@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817090538.GA26181@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 17, 2021 at 11:05:38AM +0200, Jan Kara wrote:
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
> > >  #define FAN_EVENT_INFO_TYPE_FID		1
> > >  #define FAN_EVENT_INFO_TYPE_DFID_NAME	2
> > >  #define FAN_EVENT_INFO_TYPE_DFID	3
> > > +#define FAN_EVENT_INFO_TYPE_ERROR	4
> > >  
> > >  /* Variable length info record following event metadata */
> > >  struct fanotify_event_info_header {
> > > @@ -149,6 +150,12 @@ struct fanotify_event_info_fid {
> > >  	unsigned char handle[0];
> > >  };
> > >  
> > > +struct fanotify_event_info_error {
> > > +	struct fanotify_event_info_header hdr;
> > > +	__s32 error;
> > > +	__u32 error_count;
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

<nod> The use-cases might split here -- we probably don't want online
fsck to be generating fs error events since the only tool that can do
anything about the broken metadata is the online fsck tool itself.

However, for random errors found by regular reader/writer threads, I
have a patchset in djwong-dev that adds recording of those errors;
that's the place where I think I'd want to add the ability to send
notification blobs to userspace.

Hmm.  For handling accumulated errors, can we still access the
fanotify_event_info_* object once we've handed it to fanotify?  If the
user hasn't picked up the event yet, it might be acceptable to set more
bits in the type mask and bump the error count.  In other words, every
time userspace actually reads the event, it'll get the latest error
state.  I /think/ that's where the design of this patchset is going,
right?

> > I /think/ we could subclass the file error structure that you've
> > provided like so:
> > 
> > struct fanotify_event_info_xfs_filesystem_error {
> > 	struct fanotify_event_info_error	base;
> > 
> > 	__u32 magic; /* 0x58465342 to identify xfs */
> > 	__u32 type; /* quotas, realtime bitmap, etc. */
> > };
> > 
> > struct fanotify_event_info_xfs_perag_error {
> > 	struct fanotify_event_info_error	base;
> > 
> > 	__u32 magic; /* 0x58465342 to identify xfs */
> > 	__u32 type; /* agf, agi, agfl, bno btree, ino btree, etc. */
> > 	__u32 agno; /* allocation group number */
> > };
> > 
> > struct fanotify_event_info_xfs_file_error {
> > 	struct fanotify_event_info_error	base;
> > 
> > 	__u32 magic; /* 0x58465342 to identify xfs */
> > 	__u32 type; /* extent map, dir, attr, etc. */
> > 	__u64 offset; /* file data offset, if applicable */
> > 	__u64 length; /* file data length, if applicable */
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

I have a slight preference for the second.  It doesn't make much sense
to have a magic value in fanotify_event_info_error to decode a totally
separate structure.

> > I have three questions at this point:
> > 
> > 1) What's the maximum size of a fanotify event structure?  None of these
> > structures exceed 36 bytes, which I hope will fit in whatever size
> > constraints?
> 
> Whole event must fit into 4G, each event info needs to fit in 64k. At least
> these are the limits of the interface. Practically, it would be difficult
> and inefficient to manipulate such huge events... 

Ok.  I doubt we'll ever get close to a 4k page for a single fs object.

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

Ok, good to hear this. :)

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

Ok.  So far so good; now on to Amir's email...

--D

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
