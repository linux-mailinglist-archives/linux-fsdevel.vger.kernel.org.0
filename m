Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873A644F4E2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Nov 2021 20:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbhKMTea (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Nov 2021 14:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbhKMTe3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Nov 2021 14:34:29 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56D4C061766;
        Sat, 13 Nov 2021 11:31:36 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id k21so15672474ioh.4;
        Sat, 13 Nov 2021 11:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xH62f6N2D8MonslPnSeuS7XSOFofmR4zUAjLEMIWzxY=;
        b=XmzoHW6n2tleI5VnZDz7pdwSYkCZ2BcInlwaYbhAhprgBkDpyYC8Vl59IcZYlv8Z+/
         z4VdqbBE4kdnwAhyO1pDK+oLhRNP68/hhdGkfB+C6HOygEhsHrSWLlEBJi2I2dAyolm5
         DJCwnWePpiHWM0kcKgdqUrSq5Pu8Pqqj8eGtBCeprUaTzgUEWQZALGVf2bUz3kykhPVX
         T8kzw32Yq6ukTLDCtRflzfkcG16DBGISt3+lGGCcFsQBJ3oDjeXmn1cRiJieNC/y1HzQ
         coTmfj3KsbhnCWTdhyue5pLqgV766vk1RuZWmxhubVXlam6GKp4/x86JMsJIt/+3xGJ1
         rySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xH62f6N2D8MonslPnSeuS7XSOFofmR4zUAjLEMIWzxY=;
        b=arYlGPpeTj7TYTL3i8vcK0ztwd2Z0qmui/G+eTPB/mmZONAY9KVTW63kOGQcAdSTfE
         2IZges9229vhI2hMbnXt3AQ9OYyn+OSxM1OIHfR80dWZc5RbFI0qIg/8Rt7xJWX0+oUi
         P5OqGgTmZ4xXXHyiAvotrOUjbM7dF5AvPuMnlNq3us7S2is0KgzsiCUA6ovjveB9tyah
         0liYzXOJ7oQKmzkPBvGiPPHf7MF10QtcYJwrLzhUFEPDx+qfadfiSbtpKt4vrRMpm4gW
         3H5LKkgv8L9Kt1a5xjY0wxctav/tw83mzZja+olwMLV6f7XLDZ+CEr47ZDNTB9eP0HHG
         CWXQ==
X-Gm-Message-State: AOAM532mTG3SjSfVRLq+Tqr21nXZa1IznYpzhDGS5CHNJ8Au7//3WKYf
        81kNcGSqsltN1w5kfBPiXmacI6XjUF61SZIchaw=
X-Google-Smtp-Source: ABdhPJwCCxWrlqLr+p42WVnVD69hoNuLmGFq0CFW3SNr8C2GYvfUOqSxtqzaX3WGwsznMYPJRAKBQHi8rQb81rbau78=
X-Received: by 2002:a02:a489:: with SMTP id d9mr19474322jam.47.1636831896258;
 Sat, 13 Nov 2021 11:31:36 -0800 (PST)
MIME-Version: 1.0
References: <20211029114028.569755-1-amir73il@gmail.com> <CAOQ4uxjazEx=bL6ZfLaGCfH6pii=OatQDoeWc+74AthaaUC49g@mail.gmail.com>
 <20211112163955.GA30295@quack2.suse.cz> <CAOQ4uxgT5a7UFUrb5LCcXo77Uda4t5c+1rw+BFDfTAx8szp+HQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgT5a7UFUrb5LCcXo77Uda4t5c+1rw+BFDfTAx8szp+HQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 13 Nov 2021 21:31:25 +0200
Message-ID: <CAOQ4uxgEbjkMMF-xVTdfWcLi4y8DGNit5Eeq=evby2nWCuiDVw@mail.gmail.com>
Subject: Re: [PATCH 0/7] Report more information in fanotify dirent events
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 13, 2021 at 11:49 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Fri, Nov 12, 2021 at 6:39 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Hi Amir!
> >
> > On Sat 06-11-21 18:29:39, Amir Goldstein wrote:
> > > On Fri, Oct 29, 2021 at 2:40 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > This patch set follows up on the discussion on FAN_REPORT_TARGET_FID [1]
> > > > from 3 months ago.
> > > >
> > > > With FAN_REPORT_PIDFD in 5.15 and FAN_FS_ERROR on its way to 5.16,
> > > > I figured we could get an early (re)start of the discussion on
> > > > FAN_REPORT_TARGET_FID towards 5.17.
> > > >
> > > > The added information in dirent events solves problems for my use case -
> > > > It helps getting the following information in a race free manner:
> > > > 1. fid of a created directory on mkdir
> > > > 2. from/to path information on rename of non-dir
> > > >
> > > > I realize those are two different API traits, but they are close enough
> > > > so I preferred not to clutter the REPORT flags space any further than it
> > > > already is. The single added flag FAN_REPORT_TARGET_FID adds:
> > > > 1. child fid info to CREATE/DELETE/MOVED_* events
> > > > 2. new parent+name info to MOVED_FROM event
> > > >
> > > > Instead of going the "inotify way" and trying to join the MOVED_FROM/
> > > > MOVED_TO events using a cookie, I chose to incorporate the new
> > > > parent+name intomation only in the MOVED_FROM event.
> > > > I made this choice for several reasons:
> > > > 1. Availability of the moved dentry in the hook and event data
> > > > 2. First info record is the old parent+name, like FAN_REPORT_DFID_NAME
> > > > 3. Unlike, MOVED_TO, MOVED_FROM was useless for applications that use
> > > >    DFID_NAME info to statat(2) the object as we suggested
> > > >
> > > > I chose to reduce testing complexity and require all other FID
> > > > flags with FAN_REPORT_TARGET_FID and there is a convenience
> > > > macro FAN_REPORT_ALL_FIDS that application can use.
> > >
> > > Self comment - Don't use ALL_ for macro names in uapi...
> > > There are 3 comment of "Deprecated ..."  for ALL flags in fanotify.h alone...
> >
> > Yeah, probably the ALL_FIDS is not worth the possible confusion when we add
> > another FID flag later ;)
> >
> > > BTW, I did not mention the FAN_RENAME event alternative proposal in this posting
> > > not because I object to FAN_RENAME, just because it was simpler to implement
> > > the MOVED_FROM alternative, so I thought I'll start with this proposal
> > > and see how
> > > it goes.
> >
> > I've read through all the patches and I didn't find anything wrong.
> > Thinking about FAN_RENAME proposal - essentially fsnotify_move() would call
> > fsnotify_name() once more with FS_RENAME event and we'd gate addition of
> > second dir+name info just by FS_RENAME instead of FS_MOVED_FROM &&
> > FAN_REPORT_TARGET_FID. Otherwise everything would be the same as in the
> > current patch set, wouldn't it? IMHO it looks like a bit cleaner API so I'd
> > lean a bit more towards that.
>
> I grew to like FAN_RENAME better myself as well.
> To make sure we are talking about the same thing:
> 1. FAN_RENAME always reports 2*(dirfid+name)
> 2. FAN_REPORT_TARGET_FID adds optional child fid record to
>     CREATE/DELETE/RENAME/MOVED_TO/FROM
>

Err, I tried the FAN_RENAME approach and hit a semantic issue:
Users can watch a directory inode and get only MOVED_FROM
when entries are moved from this directory. Same for MOVED_TO.
How would FAN_RENAME behave when setting FAN_RENAME on a
directory inode? Should listeners get events on files renamed in and out of that
directory?

I see several options:
1. Go back to FAN_MOVED_FROM as in this patch set, where semantics are clear
2. Report FAN_RENAME if either old or new dir is watched (or mount/sb)
3. Report FAN_RENAME only if both old and new dirs are watched (or mount/sb)

For option 2, we may need to hide information records, For example, because an
unprivileged listener may not have access to old or new directory.

A variant of option 3, is that FAN_RENAME will be an event mask flag
that can be added to FAN_MOVE events, to request that if both FROM/TO events
are going to be reported, then a single joint event will be reported
instead, e.g:

#define FAN_MOVE (FAN_MOVED_FROM | FAN_MOVED_TO)
#define FAN_RENAME (FAN_MOVE | __FAN_MOVE_JOIN)

Instead of generating an extra FS_RENAME event in fsnotify_move(),
fsnotify() will search for matching marks on the moved->d_parent->d_inode
of MOVED_FROM event add the mark as the FSNOTIFY_OBJ_TYPE_PARENT
mark iterator type and then fanotify_group_event_mask() will be able
to tell if the
event should be reported as FAN_MOVED_FROM, FAN_MOVED_TO or a joint
FAN_RENAME.

If a group has the FAN_RENAME mask on the new parent dir, then
FS_MOVED_TO events can be dropped, because the event was already
reported as FAN_MOVED_TO or FAN_RENAME with the FS_MOVED_FROM
event.

Am I over complicating this?
Do you have a better and clearer semantics to propose?

Thanks,
Amir.
