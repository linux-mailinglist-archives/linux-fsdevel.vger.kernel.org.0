Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9BC36B1A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 12:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhDZK1y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 06:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbhDZK1x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 06:27:53 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89185C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Apr 2021 03:27:12 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s22so18656677pgk.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Apr 2021 03:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fCq7GuwqxWrfP0zG2BPEk4vgQibkYkXRTf/6CONjF7w=;
        b=DTjN/6J2o556h9+s0z3fLOtkfNzVv9SCgICxXgIPLFX8+AoKgPqACuTq4k1VsONxd3
         v0O4S1e5BGAGciKXqm+56etmpe5wqBOwGoDadVNYWw0tDJS3uhlsvL0zIl9dxJecAlcl
         KQx6qZVNw6m1pfJ3XTCiNogW9HWyGDykDW4diOPL5Gf6rikNjmBJoe04ADwnLyEghU+b
         aoidb7YDzGVE9CVYolLZ5Ky4Keeq5HA8RmUbzL0+Q7+7Z3gjog6SuRbOV9rK8oJQQZO7
         Op6lzhbYUH5PIT97XQHxWRUHhf3Kb7DAcHL7xqDwlaHBAINiEDWiUXqqgq8PKuspd9XV
         XCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fCq7GuwqxWrfP0zG2BPEk4vgQibkYkXRTf/6CONjF7w=;
        b=SQ3FyrSgo2IztZ+Y0Qeq0U0QrRMARDXD9Rca23DgzfIggaCBtaWYgnIUadid7cKkk/
         zT1WRcSuqYQGoGBjBzlBPxcmRtBVSI2tyKWSEUI5nKIl44wFbIN7qeqqQT8zqhvPdat7
         Tpx46ysKf1wOCj1qwQqPnTWnI7T4yO8kN8SGhZzqjQbwiiEeoGb/p4M0eAOaBAgQQ2pN
         WWtel7ErIE+8SOG1CKgpEp0ToTawkwZjVJ7Gk3dDPXh/Pg3rEO5nDu+ZVgMwgHtY0m19
         km9bV0Dkwzn+SFdde3FKU/cEMbo3yu0eXqcgmjPgM/H+qWc+ZhRo674zVQjM3zkG4OTC
         ka7Q==
X-Gm-Message-State: AOAM531g7iBEkiweihl6XyA8eZj23824veFA7Ygxp9Qz88JBfnZMpT/D
        uKNBWlUKPIiI6ipS+E95nzqCiQ==
X-Google-Smtp-Source: ABdhPJyJR0whQZLY4qriE+qC8b4jR9IpHivd9Pv/u7Gb9sW4QiBEtei9pm7ucR/kZZmImf3ROb4hcg==
X-Received: by 2002:a63:5c19:: with SMTP id q25mr16710460pgb.402.1619432831858;
        Mon, 26 Apr 2021 03:27:11 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:5345:1783:3859:c0bf])
        by smtp.gmail.com with ESMTPSA id f71sm5219603pfa.91.2021.04.26.03.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 03:27:11 -0700 (PDT)
Date:   Mon, 26 Apr 2021 20:26:53 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] fanotify: Add pidfd support to the fanotify API
Message-ID: <YIaVbWu8up3RY7gf@google.com>
References: <e6cd967f45381d20d67c9d5a3e49e3cb9808f65b.1618527437.git.repnop@google.com>
 <20210419132020.ydyb2ly6e3clhe2j@wittgenstein>
 <20210419135550.GH8706@quack2.suse.cz>
 <20210419150233.rgozm4cdbasskatk@wittgenstein>
 <YH4+Swki++PHIwpY@google.com>
 <20210421080449.GK8706@quack2.suse.cz>
 <YIIBheuHHCJeY6wJ@google.com>
 <CAOQ4uxhUcefbu+5pLKfx7b-kOPP2OB+_RRPMPDX1vLk36xkZnQ@mail.gmail.com>
 <YIJ/JHdaPv2oD+Jd@google.com>
 <CAOQ4uxhyGKSM3LFKRtgNe+HmkUJRCFwafXdgC_8ysg7Bs43rWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhyGKSM3LFKRtgNe+HmkUJRCFwafXdgC_8ysg7Bs43rWg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 23, 2021 at 11:14:34AM +0300, Amir Goldstein wrote:
> On Fri, Apr 23, 2021 at 11:02 AM Matthew Bobrowski <repnop@google.com> wrote:
> >
> > On Fri, Apr 23, 2021 at 10:39:46AM +0300, Amir Goldstein wrote:
> > > On Fri, Apr 23, 2021 at 2:06 AM Matthew Bobrowski <repnop@google.com> wrote:
> > > >
> > > > On Wed, Apr 21, 2021 at 10:04:49AM +0200, Jan Kara wrote:
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
> > > >
> > > > This approach makes sense to me.
> > > >
> > > > Jan/Amir, just to be clear, we've agreed to go ahead with the extended
> > > > struct approach whereby specifying the FAN_REPORT_PIDFD flag will
> > > > result in an event which includes an additional struct
> > > > (i.e. fanotify_event_info_pid) alongside the generic existing
> > >
> > > struct fanotify_event_info_pidfd?
> >
> > Well, yeah? I mean, my line of thought was that we'd also need to
> > include struct fanotify_event_info_header alongside the event to
> > provide more meta-information about the additional event you'd expect
> > to receive when FAN_REPORT_PIDFD is provided, so we'd end up with
> > something like:
> >
> > struct fanotify_event_info_pidfd {
> >        struct fanotify_event_info_header hdr;
> >        __s32 pidfd;
> > }
> >
> > Unless this of course is overbaking it and there's no need to do this?
> >
> 
> We need this. I was just pointing out that you wrote fanotify_event_info_pid
> must have been a typo.

Oh, right, that sure was a typo! :)

Amir, I was just thinking about this a little over the weekend and I
don't think we discussed how to handle the FAN_REPORT_PIDFD |
FAN_REPORT_FID and friends case? My immediate thought is to make
FAN_REPORT_PIDFD mutually exclusive with FAN_REPORT_FID and friends,
but then again receiving a pidfd along with FID events may be also
useful for some? What are your thoughts on this? If we don't go ahead
with mutual exclusion, then this multiple event types alongside struct
fanotify_event_metadata starts getting a little clunky, don't you
think?

/M
