Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DE1366E6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 16:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240393AbhDUOqx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 10:46:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238607AbhDUOqv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:46:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77AF461421;
        Wed, 21 Apr 2021 14:46:16 +0000 (UTC)
Date:   Wed, 21 Apr 2021 16:46:12 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] fanotify: Add pidfd support to the fanotify API
Message-ID: <20210421144612.am2a6rbsogbhzduw@wittgenstein>
References: <e6cd967f45381d20d67c9d5a3e49e3cb9808f65b.1618527437.git.repnop@google.com>
 <20210419132020.ydyb2ly6e3clhe2j@wittgenstein>
 <20210419135550.GH8706@quack2.suse.cz>
 <20210419150233.rgozm4cdbasskatk@wittgenstein>
 <YH4+Swki++PHIwpY@google.com>
 <20210421080449.GK8706@quack2.suse.cz>
 <CAOQ4uxhmJgbSbk_w_gsYg+zLb9GJv6_oGrmfPiNEYao_U3z9=Q@mail.gmail.com>
 <20210421100027.GP8706@quack2.suse.cz>
 <CAOQ4uxjo=b8hp6o2j-HbNhSpehwiQ4fW8y6DLojhNc+QYx6qqA@mail.gmail.com>
 <20210421134814.GU8706@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210421134814.GU8706@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:48:14PM +0200, Jan Kara wrote:
> On Wed 21-04-21 13:12:23, Amir Goldstein wrote:
> > On Wed, Apr 21, 2021 at 1:00 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Wed 21-04-21 12:29:14, Amir Goldstein wrote:
> > > > On Wed, Apr 21, 2021 at 11:04 AM Jan Kara <jack@suse.cz> wrote:
> > > > >
> > > > > On Tue 20-04-21 12:36:59, Matthew Bobrowski wrote:
> > > > > > On Mon, Apr 19, 2021 at 05:02:33PM +0200, Christian Brauner wrote:
> > > > > > > A general question about struct fanotify_event_metadata and its
> > > > > > > extensibility model:
> > > > > > > looking through the code it seems that this struct is read via
> > > > > > > fanotify_rad(). So the user is expected to supply a buffer with at least
> > > > > > >
> > > > > > > #define FAN_EVENT_METADATA_LEN (sizeof(struct fanotify_event_metadata))
> > > > > > >
> > > > > > > bytes. In addition you can return the info to the user about how many
> > > > > > > bytes the kernel has written from fanotify_read().
> > > > > > >
> > > > > > > So afaict extending fanotify_event_metadata should be _fairly_
> > > > > > > straightforward, right? It would essentially the complement to
> > > > > > > copy_struct_from_user() which Aleksa and I added (1 or 2 years ago)
> > > > > > > which deals with user->kernel and you're dealing with kernel->user:
> > > > > > > - If the user supplied a buffer smaller than the minimum known struct
> > > > > > >   size -> reject.
> > > > > > > - If the user supplied a buffer < smaller than what the current kernel
> > > > > > >   supports -> copy only what userspace knows about, and return the size
> > > > > > >   userspace knows about.
> > > > > > > - If the user supplied a buffer that is larger than what the current
> > > > > > >   kernel knows about -> copy only what the kernel knows about, zero the
> > > > > > >   rest, and return the kernel size.
> > > > > > >
> > > > > > > Extension should then be fairly straightforward (64bit aligned
> > > > > > > increments)?
> > > > > >
> > > > > > You'd think that it's fairly straightforward, but I have a feeling
> > > > > > that the whole fanotify_event_metadata extensibility discussion and
> > > > > > the current limitation to do so revolves around whether it can be
> > > > > > achieved in a way which can guarantee that no userspace applications
> > > > > > would break. I think the answer to this is that there's no guarantee
> > > > > > because of <<reasons>>, so the decision to extend fanotify's feature
> > > > > > set was done via other means i.e. introduction of additional
> > > > > > structures.
> > > > >
> > > > > There's no real problem extending fanotify_event_metadata. We already have
> > > > > multiple extended version of that structure in use (see e.g. FAN_REPORT_FID
> > > > > flag and its effect, extended versions of the structure in
> > > > > include/uapi/linux/fanotify.h). The key for backward compatibility is to
> > > > > create extended struct only when explicitely requested by a flag when
> > > > > creating notification group - and that would be the case here -
> > > > > FAN_REPORT_PIDFD or how you called it. It is just that extending the
> > > > > structure means adding 8 bytes to each event and parsing extended structure
> > > > > is more cumbersome than just fetching s32 from a well known location.
> > > > >
> > > > > On the other hand extended structure is self-describing (i.e., you can tell
> > > > > the meaning of all the fields just from the event you receive) while
> > > > > reusing 'pid' field means that you have to know how the notification group
> > > > > was created (whether FAN_REPORT_PIDFD was used or not) to be able to
> > > > > interpret the contents of the event. Actually I think the self-describing
> > > > > feature of fanotify event stream is useful (e.g. when application manages
> > > > > multiple fanotify groups or when fanotify group descriptors are passed
> > > > > among processes) so now I'm more leaning towards using the extended
> > > > > structure instead of reusing 'pid' as Christian suggests. I'm sorry for the
> > > > > confusion.
> > > > >
> > > >
> > > > But there is a middle path option.
> > > > The event metadata can be self described without extending it:
> > > >
> > > >  struct fanotify_event_metadata {
> > > >         __u32 event_len;
> > > >         __u8 vers;
> > > > -       __u8 reserved;
> > > > +#define FANOTIFY_METADATA_FLAG_PIDFD   1
> > > > +       __u8 flags;
> > > >         __u16 metadata_len;
> > > >         __aligned_u64 mask;
> > > >         __s32 fd;
> > >
> > > Well, yes, but do we want another way to describe what fanotify_event_metadata
> > > actually contains? I don't think parsing extended event information is that
> > > bad to make changes like this worth it...
> > 
> > Fine by me.
> > But in that case, we should report pidfd in addition to pid.
> 
> Agreed.

Sounds good to me.

Christian
