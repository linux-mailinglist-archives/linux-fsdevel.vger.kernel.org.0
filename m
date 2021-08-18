Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5443F3EF87F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 05:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbhHRDZO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 23:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhHRDZL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 23:25:11 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE69C061764;
        Tue, 17 Aug 2021 20:24:38 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id a21so884472ioq.6;
        Tue, 17 Aug 2021 20:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxgMShP02OzqCyU4HZns8XCd8Gu3vaU5BWxjPBu+pfw=;
        b=u3LYM3iJ/eYoRW9wyogu1URuW3TOynqVuereHTK/XKefc+T4xpqktPy6C2xUiZkYCs
         UUuU+uF2vnD0bGG7/CCa+W3jddLc7xeeHMlrDNS1oFCBMd7gyQyyi2Quu26Vi1SBDlN0
         WSqz3F3tLusStN6TP99VAM3YUQ9qtHrWRcNOTcngExTMOmSmwaM9erbdfKrQAMxISshq
         ijhe7a8eWGaHu8Yy4iL9m5UvUAvcE43B4FsKM7o9eZttd9RLv7iKTQxoS3B0elctGNfU
         vC1BhxJloyEGer+5mMG9jQYHY9kcsse7OvD+h1yLmlEfU46kSr8h+iOsHHLrPfErnAgU
         YQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxgMShP02OzqCyU4HZns8XCd8Gu3vaU5BWxjPBu+pfw=;
        b=LM3FrjaMiiztbUujm+ydRLpTBvSXpTppAULS6yjBRxd4jIRPbHEBngPvW0W+wzgPRb
         NY586c1FhtgQcVPo3YqN3mJ9FpIPZ4zHFRxj6PtArVYzQozO+UUInqnGcZsw1fUCKvLK
         unI0CffWNk0WcB0JCyhX1Y+QAFte2NGHEwmPKcK7k/aA8Mfq+REE8Re86jyFGQih+PYj
         j93EsZtccyZ8swAOheuX7zuom5fWDL77p8rBxTyRwcF3uh2y0y+9AI3QmN4LkYGDgAF+
         +8H0TrBxl3GE+N9G97MpaoIhxc1HO5WhPTmngMUdGVwOTS0Bjvm5xNm+MLS8PnJ9aA7p
         GTcQ==
X-Gm-Message-State: AOAM533FrlVME6J5hdmaYow8xR7hGlsHRhI9ZEzYjnNPAv8td6QjyP8h
        ZjY6NPqfKWbIQGDGH49dPOfKV8aQ8P9HA0GDc2Q=
X-Google-Smtp-Source: ABdhPJxv6T/CBLPV1MDJ7ULTOwIhPYrOUENzcyBXkNceFQSVSmJwF6AYknf2lpKLPYdklXk5c8HN98zdbOJg8uBeErI=
X-Received: by 2002:a05:6602:200f:: with SMTP id y15mr5349155iod.64.1629257077539;
 Tue, 17 Aug 2021 20:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-19-krisman@collabora.com> <20210816214103.GA12664@magnolia>
 <20210817090538.GA26181@quack2.suse.cz> <CAOQ4uxgdJpovZ-zzJkLOdQ=YYF3ta46m0_jrt0QFSdJ9GdXR=g@mail.gmail.com>
 <20210818001632.GD12664@magnolia>
In-Reply-To: <20210818001632.GD12664@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 18 Aug 2021 06:24:26 +0300
Message-ID: <CAOQ4uxhccRchiajjje3C20UOKwxQUapu=RYPsM1Y0uTnS81Vew@mail.gmail.com>
Subject: Re: [PATCH v6 18/21] fanotify: Emit generic error info type for error event
To:     "Darrick J. Wong" <djwong@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[...]

> > Just keep in mind that the current scheme pre-allocates the single event slot
> > on fanotify_mark() time and (I think) we agreed to pre-allocate
> > sizeof(fsnotify_error_event) + MAX_HDNALE_SZ.
> > If filesystems would want to store some variable length fs specific info,
> > a future implementation will have to take that into account.
>
> <nod> I /think/ for the fs and AG metadata we could preallocate these,
> so long as fsnotify doesn't free them out from under us.

fs won't get notified when the event is freed, so fsnotify must
take ownership on the data structure.
I was thinking more along the lines of limiting maximum size for fs
specific info and pre-allocating that size for the event.

> For inodes...
> there are many more of those, so they'd have to be allocated
> dynamically.

The current scheme is that the size of the queue for error events
is one and the single slot is pre-allocated.
The reason for pre-allocate is that the assumption is that fsnotify_error()
could be called from contexts where memory allocation would be
inconvenient.
Therefore, we can store the encoded file handle of the first erroneous
inode, but we do not store any more events until user read this
one event.

> Hmm.  For handling accumulated errors, can we still access the
> fanotify_event_info_* object once we've handed it to fanotify?  If the
> user hasn't picked up the event yet, it might be acceptable to set more
> bits in the type mask and bump the error count.  In other words, every
> time userspace actually reads the event, it'll get the latest error
> state.  I /think/ that's where the design of this patchset is going,
> right?

Sort of.
fsnotify does have a concept of "merging" new event with an event
already in queue.

With most fsnotify events, merge only happens if the info related
to the new event (e.g. sb,inode) is the same as that off the queued
event and the "merge" is only in the event mask
(e.g. FS_OPEN|FS_CLOSE).

However, the current scheme for "merge" of an FS_ERROR event is only
bumping err_count, even if the new reported error or inode do not
match the error/inode in the queued event.

If we define error event subtypes (e.g. FS_ERROR_WRITEBACK,
FS_ERROR_METADATA), then the error event could contain
a field for subtype mask and user could read the subtype mask
along with the accumulated error count, but this cannot be
done by providing the filesystem access to modify an internal
fsnotify event, so those have to be generic UAPI defined subtypes.

If you think that would be useful, then we may want to consider
reserving the subtype mask field in fanotify_event_info_error in
advance.

>
> > > > 2) If a program written for today's notification events sees a
> > > > fanotify_event_info_header from future-XFS with a header length that is
> > > > larger than FANOTIFY_INFO_ERROR_LEN, will it be able to react
> > > > appropriately?  Which is to say, ignore it on the grounds that the
> > > > length is unexpectedly large?
> > >
> > > That is the expected behavior :). But I guess separate info type for
> > > fs-specific blob might be more foolproof in this sense - when parsing
> > > events, you are expected to just skip info_types you don't understand
> > > (based on 'len' and 'type' in the common header) and generally different
> > > events have different sets of infos attached to them so you mostly have to
> > > implement this logic to be able to process events.
> > >
> > > > It /looks/ like this is the case; really I'm just fishing around here
> > > > to make sure nothing in the design of /this/ patchset would make it Very
> > > > Difficult(tm) to add more information later.
> > > >
> > > > 3) Once we let filesystem implementations create their own extended
> > > > error notifications, should we have a "u32 magic" to aid in decoding?
> > > > Or even add it to fanotify_event_info_error now?
> > >
> > > If we go via the 'separate info type' route, then the magic can go into
> > > that structure and there's no great use for 'magic' in
> > > fanotify_event_info_error.
> >
> > My 0.02$:
> > With current patch set, filesystem reports error using:
> > fsnotify_sb_error(sb, inode, error)
> >
> > The optional @inode argument is encoded to a filesystem opaque
> > blob using  exportfs_encode_inode_fh(), recorded in the event
> > as a blob and reported to userspace as a blob.
> >
> > If filesystem would like to report a different type of opaque blob
> > (e.g. xfs_perag_info), the interface should be extended to:
> > fsnotify_sb_error(sb, inode, error, info, info_len)
> > and the 'separate info type' route seems like the best and most natural
> > way to deal with the case of information that is only emitted from
> > a specific filesystem with a specific feature enabled (online fsck).
>
> <nod> This seems reasonable to me.
>
> > IOW, there is no need for fanotify_event_info_xfs_perag_error
> > in fanotify UAPI if you ask me.
> >
> > Regarding 'magic' in fanotify_event_info_error, I also don't see the
> > need for that, because the event already has fsid which can be
> > used to identify the filesystem in question.
> >
> > Keep in mind that the value of handle_type inside struct file_handle
> > inside struct fanotify_event_info_fid is not a universal classifier.
> > Specifically, the type 0x81 means "XFS_FILEID_INO64_GEN"
> > only in the context of XFS and it can mean something else in the
> > context of another type of filesystem.
>
> Can you pass the handle into the kernel to open a fd to file mentioned
> in the report?  I don't think userspace is supposed to know what's
> inside a file handle, and it would be helpful if it didn't matter here
> either. :)
>

User gets a file handle and can do whatever users can do with file
handles... that is, open_by_handle_at() (if filesystem and inode are
still alive and healthy) and for less privileged users, compare with
result of name_to_handle_at() of another object.

Obviously, filesystem specialized tools could parse the file handle
to extract more information.

> > If we add a new info record fanotify_event_info_fs_private
> > it could even be an alias to fanotify_event_info_fid with the only
> > difference that the handle[0] member is not expected to be
> > struct file_handle, but some other fs private struct.
>
> I ... think I prefer it being a separate info blob.
>

Yes. That is what I meant.
Separate info record INFO_TYPE_ERROR_FS_DATA, whose info record
format is quite the same as that of INFO_TYPE_FID, but the blob is a
different type of blob.

Thanks,
Amir.
