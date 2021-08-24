Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5979B3F636F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 18:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbhHXQyW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 12:54:22 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35746 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbhHXQyO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:54:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id EACED1F42F33
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Jan Kara <jack@suse.cz>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, amir73il@gmail.com,
        jack@suse.com, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        khazhy@google.com, dhowells@redhat.com, david@fromorbit.com,
        tytso@mit.edu, repnop@google.com, kernel@collabora.com
Subject: Re: [PATCH v6 18/21] fanotify: Emit generic error info type for
 error event
Organization: Collabora
References: <20210812214010.3197279-1-krisman@collabora.com>
        <20210812214010.3197279-19-krisman@collabora.com>
        <20210816214103.GA12664@magnolia>
        <20210817090538.GA26181@quack2.suse.cz>
Date:   Tue, 24 Aug 2021 12:53:24 -0400
In-Reply-To: <20210817090538.GA26181@quack2.suse.cz> (Jan Kara's message of
        "Tue, 17 Aug 2021 11:05:38 +0200")
Message-ID: <871r6i2397.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan Kara <jack@suse.cz> writes:

> On Mon 16-08-21 14:41:03, Darrick J. Wong wrote:
>> On Thu, Aug 12, 2021 at 05:40:07PM -0400, Gabriel Krisman Bertazi wrote:
>> > The Error info type is a record sent to users on FAN_FS_ERROR events
>> > documenting the type of error.  It also carries an error count,
>> > documenting how many errors were observed since the last reporting.
>> > 
>> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>> > 
>> > ---
>> > Changes since v5:
>> >   - Move error code here
>> > ---
>> >  fs/notify/fanotify/fanotify.c      |  1 +
>> >  fs/notify/fanotify/fanotify.h      |  1 +
>> >  fs/notify/fanotify/fanotify_user.c | 36 ++++++++++++++++++++++++++++++
>> >  include/uapi/linux/fanotify.h      |  7 ++++++
>> >  4 files changed, 45 insertions(+)
>> 
>> <snip>
>> 
>> > diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
>> > index 16402037fc7a..80040a92e9d9 100644
>> > --- a/include/uapi/linux/fanotify.h
>> > +++ b/include/uapi/linux/fanotify.h
>> > @@ -124,6 +124,7 @@ struct fanotify_event_metadata {
>> >  #define FAN_EVENT_INFO_TYPE_FID		1
>> >  #define FAN_EVENT_INFO_TYPE_DFID_NAME	2
>> >  #define FAN_EVENT_INFO_TYPE_DFID	3
>> > +#define FAN_EVENT_INFO_TYPE_ERROR	4
>> >  
>> >  /* Variable length info record following event metadata */
>> >  struct fanotify_event_info_header {
>> > @@ -149,6 +150,12 @@ struct fanotify_event_info_fid {
>> >  	unsigned char handle[0];
>> >  };
>> >  
>> > +struct fanotify_event_info_error {
>> > +	struct fanotify_event_info_header hdr;
>> > +	__s32 error;
>> > +	__u32 error_count;
>> > +};
>> 
>> My apologies for not having time to review this patchset since it was
>> redesigned to use fanotify.  Someday it would be helpful to be able to
>> export more detailed error reports from XFS, but as I'm not ready to
>> move forward and write that today, I'll try to avoid derailling this at
>> the last minute.
>
> I think we are not quite there and tweaking the passed structure is easy
> enough so no worries. Eventually, passing some filesystem-specific blob
> together with the event was the plan AFAIR. You're right now is a good
> moment to think how exactly we want that passed.
>
>> Eventually, XFS might want to be able to report errors in file data,
>> file metadata, allocation group metadata, and whole-filesystem metadata.
>> Userspace can already gather reports from XFS about corruptions reported
>> by the online fsck code (see xfs_health.c).
>
> Yes, although note that the current plan is that we currently have only one
> error event queue, others are just added to error_count until the event is
> fetched by userspace (on the grounds that the first error is usually the
> most meaningful, the others are usually just cascading problems). But I'm
> not sure if this scheme would be suitable for online fsck usecase since we
> may discard even valid independent errors this way.
>
>> I /think/ we could subclass the file error structure that you've
>> provided like so:
>> 
>> struct fanotify_event_info_xfs_filesystem_error {
>> 	struct fanotify_event_info_error	base;
>> 
>> 	__u32 magic; /* 0x58465342 to identify xfs */
>> 	__u32 type; /* quotas, realtime bitmap, etc. */
>> };
>> 
>> struct fanotify_event_info_xfs_perag_error {
>> 	struct fanotify_event_info_error	base;
>> 
>> 	__u32 magic; /* 0x58465342 to identify xfs */
>> 	__u32 type; /* agf, agi, agfl, bno btree, ino btree, etc. */
>> 	__u32 agno; /* allocation group number */
>> };
>> 
>> struct fanotify_event_info_xfs_file_error {
>> 	struct fanotify_event_info_error	base;
>> 
>> 	__u32 magic; /* 0x58465342 to identify xfs */
>> 	__u32 type; /* extent map, dir, attr, etc. */
>> 	__u64 offset; /* file data offset, if applicable */
>> 	__u64 length; /* file data length, if applicable */
>> };
>> 
>> (A real XFS implementation might have one structure with the type code
>> providing for a tagged union or something; I split it into three
>> separate structs here to avoid confusing things.)
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

In the v1 of this patchset [1] I implemented the later option, a new
info type that the filesystem could provide as a blob.  It was dropped
by Amir's request to leave it out of the discussion at that moment.  Should I
ressucitate it for the next iteration?  I believe it would attend to XFS needs.

[1] https://lwn.net/ml/linux-fsdevel/20210426184201.4177978-12-krisman@collabora.com/

-- 
Gabriel Krisman Bertazi
