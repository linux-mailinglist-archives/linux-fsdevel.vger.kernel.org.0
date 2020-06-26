Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4BF20B02E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 13:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgFZLGt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 07:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgFZLGt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 07:06:49 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F90C08C5C1;
        Fri, 26 Jun 2020 04:06:49 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id a12so9348946ion.13;
        Fri, 26 Jun 2020 04:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZxJSNiVJljMSZlttjeLGjziarAsabqoWyvIVxjZ500=;
        b=vPfQSoqC4wM0IULyfq4K6up92dOYz9h7g9/NJcnuewoVE4EMMMi+RwkSYXnEmTezz4
         BJaQ3+28bh+DDUA8n7guY9k5kNoMNi5rwVE1F9pcAjuhhimjppFIbi4GR2G0EzOO7KTj
         cLWBN06XM+SAm6LW0UMY3RzM+R2RkUZ2iV7uLZkJcRnM2uOGXW6dO4qU9YodDCwkNIXf
         q67/Ej2tklcBJYhUq5W3EraikqqSUBhn6Q161uwbMPhGIiRevmgOZLnf74mdmLaUDbN0
         mmEl82pOQknqx06RQTOiexYHh2ujk1II96sk4i96KibnlQmRhm2Ue1r98Tzfo4CJNJfW
         GSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZxJSNiVJljMSZlttjeLGjziarAsabqoWyvIVxjZ500=;
        b=LxFBfrp3z+5XY3DGbzul5uJ5vTfvGmAKelHLJBw46YH2khuXzIJaqcj1wJpXylryii
         5Y6nLR5SBEy8a4XeXg77YOeTfabAMdYk5h/q5TY8gvsrxl9LSBdY+US4ZkAJ3i+oLo92
         7rVfyJqiKUpgUU67kUI98eNbxWZgjLfxVdtgQXh+Zxt9mRJf4TyDs2KK7/lZCvtVy3Ze
         skMJliP7k+RMjexU/U1N0q8Jp3pH95sj7OmaepHIIbAnWZHyQgH2y/Vho5PT8CtNCvly
         ZPRMvmeXr9DghLygOitBuscwWV2is6P5MKyBymRhSBsZQn2chhdFAMk80OT9wAux9dh6
         jJlw==
X-Gm-Message-State: AOAM531Fi4tWPfBzcVbf2IHFUKZDuDLY5zMRtmc9NgLeFPE98yJGexFz
        jNtKFyPT9BsVQUbYi8+0BuypPbJD9BWQ5bQhxfxGTA==
X-Google-Smtp-Source: ABdhPJzCziC8bUsxA7H+tJ9Vd6pdGWh51RwAnXNoHLh8YAEQCaH5lHnhrHuKb6Un7RaDasKJZzwzo+Z9e2LDBsHUUV8=
X-Received: by 2002:a02:83c3:: with SMTP id j3mr2753687jah.81.1593169608402;
 Fri, 26 Jun 2020 04:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxgn=YNj8cJuccx2KqxEVGZy1z3DBVYXrD=Mc7Dc=Je+-w@mail.gmail.com>
 <20190416154513.GB13422@quack2.suse.cz> <CAOQ4uxh66kAozqseiEokqM3wDJws7=cnY-aFXH_0515nvsi2-A@mail.gmail.com>
 <20190417113012.GC26435@quack2.suse.cz>
In-Reply-To: <20190417113012.GC26435@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 26 Jun 2020 14:06:37 +0300
Message-ID: <CAOQ4uxgsJ7NRtFbRYyBj_RW-trysOrUTKUnkYKYR5OMyq-+HXQ@mail.gmail.com>
Subject: Re: fsnotify pre-modify VFS hooks (Was: fanotify and LSM path hooks)
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Subject changed and removed LSM list]

On Wed, Apr 17, 2019 at 2:30 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 16-04-19 21:24:44, Amir Goldstein wrote:
> > > I'm not so sure about directory pre-modification hooks. Given the amount of
> > > problems we face with applications using fanotify permission events and
> > > deadlocking the system, I'm not very fond of expanding that API... AFAIU
> > > you want to use such hooks for recording (and persisting) that some change
> > > is going to happen and provide crash-consistency guarantees for such
> > > journal?
> > >
> >
> > That's the general idea.
> > I have two use cases for pre-modification hooks:
> > 1. VFS level snapshots
> > 2. persistent change tracking
> >
> > TBH, I did not consider implementing any of the above in userspace,
> > so I do not have a specific interest in extending the fanotify API.
> > I am actually interested in pre-modify fsnotify hooks (not fanotify),
> > that a snapshot or change tracking subsystem can register with.
> > An in-kernel fsnotify event handler can set a flag in current task
> > struct to circumvent system deadlocks on nested filesystem access.
>
> OK, I'm not opposed to fsnotify pre-modify hooks as such. As long as
> handlers stay within the kernel, I'm fine with that. After all this is what
> LSMs are already doing. Just exposing this to userspace for arbitration is
> what I have a problem with.
>

Short update on that.

I decided to ditch the LSM hooks approach because I realized that for
the purpose of persistent change tracking, the pre-modify hooks need
to be called before the caller is taking filesystem locks.

So I added hooks inside mnt_want_write and file_start_write wrappers:
https://github.com/amir73il/linux/commits/fsnotify_pre_modify

The conversion of Overlayfs snapshots to use pre-modify events is
WIP and still has some big open questions.

The purpose of this email is to solicit early feedback on the VFS changes.
If anyone thinks this approach is wrong please shout it out.

Thanks,
Amir.
