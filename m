Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7043F6E1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Aug 2021 06:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhHYEKa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Aug 2021 00:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229379AbhHYEK3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Aug 2021 00:10:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EF976128A;
        Wed, 25 Aug 2021 04:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629864584;
        bh=q4CZczZ6yHtjNAN4pZWATkm+2V/iisboWueuQzZu/lg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WCu7njjXw6mJCEYmrE1MxjEtX/TXJBIe6OC1Ud9uT+P0VzjxsK0mPusvZ2B4dpCpd
         QW8UzxsXDz2cTJoJbG1b357gvcFC+z5L6qdhR1ORAXn93GPRIJ87oAeOl4lxO4YDRy
         GMDpfxLqGtDbAOLoLxMayhgOPK4FgH+0rcSFE+Slmb9hfiGLVcMoJ00C7r6Z4O94QE
         iXoZw/URRBgg/iR8g8Onzb1ef6m186SBLYdqEX8dQfhR4DyepCaLE7t5n1mwFuo1aq
         9JmnjoEmuMPa0vrSbEzjwNMm65VczJ0MVxJHID73KKUV+8LPjGZE5Evn2TjSuRV58p
         MQ9oouMWhmlQA==
Date:   Tue, 24 Aug 2021 21:09:43 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.cz>, amir73il@gmail.com, jack@suse.com,
        linux-api@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, khazhy@google.com,
        dhowells@redhat.com, david@fromorbit.com, tytso@mit.edu,
        repnop@google.com, kernel@collabora.com
Subject: Re: [PATCH v6 18/21] fanotify: Emit generic error info type for
 error event
Message-ID: <20210825040943.GC12586@magnolia>
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-19-krisman@collabora.com>
 <20210816214103.GA12664@magnolia>
 <20210817090538.GA26181@quack2.suse.cz>
 <871r6i2397.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871r6i2397.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 24, 2021 at 12:53:24PM -0400, Gabriel Krisman Bertazi wrote:
> Jan Kara <jack@suse.cz> writes:
> 
> > On Mon 16-08-21 14:41:03, Darrick J. Wong wrote:
> >> On Thu, Aug 12, 2021 at 05:40:07PM -0400, Gabriel Krisman Bertazi wrote:
> >> > The Error info type is a record sent to users on FAN_FS_ERROR events
> >> > documenting the type of error.  It also carries an error count,
> >> > documenting how many errors were observed since the last reporting.
> >> > 
> >> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> >> > 
> >> > ---
> >> > Changes since v5:
> >> >   - Move error code here
> >> > ---
> >> >  fs/notify/fanotify/fanotify.c      |  1 +
> >> >  fs/notify/fanotify/fanotify.h      |  1 +
> >> >  fs/notify/fanotify/fanotify_user.c | 36 ++++++++++++++++++++++++++++++
> >> >  include/uapi/linux/fanotify.h      |  7 ++++++
> >> >  4 files changed, 45 insertions(+)
> >> 
> >> <snip>
> >> 
> >> > diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> >> > index 16402037fc7a..80040a92e9d9 100644
> >> > --- a/include/uapi/linux/fanotify.h
> >> > +++ b/include/uapi/linux/fanotify.h
> >> > @@ -124,6 +124,7 @@ struct fanotify_event_metadata {
> >> >  #define FAN_EVENT_INFO_TYPE_FID		1
> >> >  #define FAN_EVENT_INFO_TYPE_DFID_NAME	2
> >> >  #define FAN_EVENT_INFO_TYPE_DFID	3
> >> > +#define FAN_EVENT_INFO_TYPE_ERROR	4
> >> >  
> >> >  /* Variable length info record following event metadata */
> >> >  struct fanotify_event_info_header {
> >> > @@ -149,6 +150,12 @@ struct fanotify_event_info_fid {
> >> >  	unsigned char handle[0];
> >> >  };
> >> >  
> >> > +struct fanotify_event_info_error {
> >> > +	struct fanotify_event_info_header hdr;
> >> > +	__s32 error;
> >> > +	__u32 error_count;
> >> > +};
> >> 
> >> My apologies for not having time to review this patchset since it was
> >> redesigned to use fanotify.  Someday it would be helpful to be able to
> >> export more detailed error reports from XFS, but as I'm not ready to
> >> move forward and write that today, I'll try to avoid derailling this at
> >> the last minute.
> >
> > I think we are not quite there and tweaking the passed structure is easy
> > enough so no worries. Eventually, passing some filesystem-specific blob
> > together with the event was the plan AFAIR. You're right now is a good
> > moment to think how exactly we want that passed.
> >
> >> Eventually, XFS might want to be able to report errors in file data,
> >> file metadata, allocation group metadata, and whole-filesystem metadata.
> >> Userspace can already gather reports from XFS about corruptions reported
> >> by the online fsck code (see xfs_health.c).
> >
> > Yes, although note that the current plan is that we currently have only one
> > error event queue, others are just added to error_count until the event is
> > fetched by userspace (on the grounds that the first error is usually the
> > most meaningful, the others are usually just cascading problems). But I'm
> > not sure if this scheme would be suitable for online fsck usecase since we
> > may discard even valid independent errors this way.
> >
> >> I /think/ we could subclass the file error structure that you've
> >> provided like so:
> >> 
> >> struct fanotify_event_info_xfs_filesystem_error {
> >> 	struct fanotify_event_info_error	base;
> >> 
> >> 	__u32 magic; /* 0x58465342 to identify xfs */
> >> 	__u32 type; /* quotas, realtime bitmap, etc. */
> >> };
> >> 
> >> struct fanotify_event_info_xfs_perag_error {
> >> 	struct fanotify_event_info_error	base;
> >> 
> >> 	__u32 magic; /* 0x58465342 to identify xfs */
> >> 	__u32 type; /* agf, agi, agfl, bno btree, ino btree, etc. */
> >> 	__u32 agno; /* allocation group number */
> >> };
> >> 
> >> struct fanotify_event_info_xfs_file_error {
> >> 	struct fanotify_event_info_error	base;
> >> 
> >> 	__u32 magic; /* 0x58465342 to identify xfs */
> >> 	__u32 type; /* extent map, dir, attr, etc. */
> >> 	__u64 offset; /* file data offset, if applicable */
> >> 	__u64 length; /* file data length, if applicable */
> >> };
> >> 
> >> (A real XFS implementation might have one structure with the type code
> >> providing for a tagged union or something; I split it into three
> >> separate structs here to avoid confusing things.)
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
> 
> In the v1 of this patchset [1] I implemented the later option, a new
> info type that the filesystem could provide as a blob.  It was dropped
> by Amir's request to leave it out of the discussion at that moment.  Should I
> ressucitate it for the next iteration?  I believe it would attend to XFS needs.

I don't think it's necessary at this time.  We (XFS community) would
have a bit more work to do before we get to the point of needing those
sorts of hooks in upstream. :)

--D

> 
> [1] https://lwn.net/ml/linux-fsdevel/20210426184201.4177978-12-krisman@collabora.com/
> 
> -- 
> Gabriel Krisman Bertazi
