Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7F01154BAD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 20:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgBFTKt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 14:10:49 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34050 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgBFTKt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:10:49 -0500
Received: by mail-io1-f67.google.com with SMTP id z193so7480567iof.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2020 11:10:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y0pT29ClCf7RkfthHwCY2/Eag9Xi+xiynNVAeKgXOlY=;
        b=h7dL7xcghgKkRR7tICZ0GGO+nTWwUgsajh8TnxjPVHZHC0U8Y4H5eXmc/AC6n24jZ6
         VWt6FZFmrWRqfOysWEw3E/NQiTgNB45BkOoUlI/DshxAcbsRuMmCs1c2yTHTO8H2cw8M
         e34MUFqkt28ZXW30XOn62MzWUO949HS8QhWtyLKsQB9+boYGdfq9k7PB09TpVS+0ZGxZ
         WEXz1cjaJQsiq2s9GCUpSDsPFYUJUkfD2qj8EEb2073zZIFrdaWkND28HB4Se+6RgYtk
         wfwTOIDQySQy0ENTfLGFbO+OK24UTGbK4vZ9tz7skMCap+XbwcEMHHyTeluG6MMTkPLb
         tR4Q==
X-Gm-Message-State: APjAAAXHXAzqrGnG3iG/sJqE31OStwLrF35UNcgA0ei42U1TqFv92l/m
        9tYhLSpNnExDVMbSnVt33ho5kg==
X-Google-Smtp-Source: APXvYqyGXBfghUSAnRhU+Yv6sx9UWbwCJXoKK3btsfmruC8+t5jUcRXKs89cA13OHPFVQoDAR3LGuA==
X-Received: by 2002:a6b:e601:: with SMTP id g1mr34051816ioh.55.1581016248293;
        Thu, 06 Feb 2020 11:10:48 -0800 (PST)
Received: from google.com ([2620:15c:183:200:855f:8919:84a7:4794])
        by smtp.gmail.com with ESMTPSA id d18sm121599iom.39.2020.02.06.11.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 11:10:47 -0800 (PST)
Date:   Thu, 6 Feb 2020 12:10:45 -0700
From:   Ross Zwisler <zwisler@chromium.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Raul Rangel <rrangel@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mattias Nissler <mnissler@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Benjamin Gordon <bmgordon@google.com>,
        Micah Morton <mortonm@google.com>,
        Dmitry Torokhov <dtor@google.com>, Jan Kara <jack@suse.cz>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH v5] Add a "nosymfollow" mount option.
Message-ID: <CAGRrVHxRdLMx5axcB1Fyea8RZhfd-EO3TTpQtOvpOP0yxnAsbQ@mail.gmail.com>
References: <20200204215014.257377-1-zwisler@google.com>
 <CAHQZ30BgsCodGofui2kLwtpgzmpqcDnaWpS4hYf7Z+mGgwxWQw@mail.gmail.com>
 <CAGRrVHwQimihNNVs434jNGF3BL5_Qov+1eYqBYKPCecQ0yjxpw@mail.gmail.com>
 <CAGRrVHyzX4zOpO2nniv42BHOCbyCdPV9U7GE3FVhjzeFonb0bQ@mail.gmail.com>
 <20200205032110.GR8731@bombadil.infradead.org>
 <20200205034500.x3omkziqwu3g5gpx@yavin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205034500.x3omkziqwu3g5gpx@yavin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 4, 2020 at 8:45 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2020-02-04, Matthew Wilcox <willy@infradead.org> wrote:
> > On Tue, Feb 04, 2020 at 04:49:48PM -0700, Ross Zwisler wrote:
> > > On Tue, Feb 4, 2020 at 3:11 PM Ross Zwisler <zwisler@chromium.org> wrote:
> > > > On Tue, Feb 4, 2020 at 2:53 PM Raul Rangel <rrangel@google.com> wrote:
> > > > > > --- a/include/uapi/linux/mount.h
> > > > > > +++ b/include/uapi/linux/mount.h
> > > > > > @@ -34,6 +34,7 @@
> > > > > >  #define MS_I_VERSION   (1<<23) /* Update inode I_version field */
> > > > > >  #define MS_STRICTATIME (1<<24) /* Always perform atime updates */
> > > > > >  #define MS_LAZYTIME    (1<<25) /* Update the on-disk [acm]times lazily */
> > > > > > +#define MS_NOSYMFOLLOW (1<<26) /* Do not follow symlinks */
> > > > > Doesn't this conflict with MS_SUBMOUNT below?
> > > > > >
> > > > > >  /* These sb flags are internal to the kernel */
> > > > > >  #define MS_SUBMOUNT     (1<<26)
> > > >
> > > > Yep.  Thanks for the catch, v6 on it's way.
> > >
> > > It actually looks like most of the flags which are internal to the
> > > kernel are actually unused (MS_SUBMOUNT, MS_NOREMOTELOCK, MS_NOSEC,
> > > MS_BORN and MS_ACTIVE).  Several are unused completely, and the rest
> > > are just part of the AA_MS_IGNORE_MASK which masks them off in the
> > > apparmor LSM, but I'm pretty sure they couldn't have been set anyway.
> > >
> > > I'll just take over (1<<26) for MS_NOSYMFOLLOW, and remove the rest in
> > > a second patch.
> > >
> > > If someone thinks these flags are actually used by something and I'm
> > > just missing it, please let me know.
> >
> > Afraid you did miss it ...
> >
> > /*
> >  * sb->s_flags.  Note that these mirror the equivalent MS_* flags where
> >  * represented in both.
> >  */
> > ...
> > #define SB_SUBMOUNT     (1<<26)
> >
> > It's not entirely clear to me why they need to be the same, but I haven't
> > been paying close attention to the separation of superblock and mount
> > flags, so someone else can probably explain the why of it.
>
> I could be wrong, but I believe this is historic and originates from the
> kernel setting certain flags internally (similar to the whole O_* flag,
> "internal" O_* flag, and FMODE_NOTIFY mixup).
>
> Also, one of the arguments for the new mount API was that we'd run out
> MS_* bits so it's possible that you have to enable this new mount option
> in the new mount API only. (Though Howells is the right person to talk
> to on this point.)

As far as I can tell, SB_SUBMOUNT doesn't actually have any dependence on
MS_SUBMOUNT. Nothing ever sets or checks MS_SUBMOUNT from within the kernel,
and whether or not it's set from userspace has no bearing on how SB_SUBMOUNT
is used.  SB_SUBMOUNT is set independently inside of the kernel in
vfs_submount().

I agree that their association seems to be historical, introduced in this
commit from David Howells:

e462ec50cb5fa VFS: Differentiate mount flags (MS_*) from internal superblock flags

In that commit message David notes:

     (1) Some MS_* flags get translated to MNT_* flags (such as MS_NODEV ->
         MNT_NODEV) without passing this on to the filesystem, but some
         filesystems set such flags anyway.

I think this is sort of what we are trying to do with MS_NOSYMFOLLOW: have a
userspace flag that translates to MNT_NOSYMFOLLOW, but which doesn't need an
associated SB_* flag.  Is it okay to reclaim the bit currently owned by
MS_SUBMOUNT and use it for MS_NOSYMFOLLOW.

A second option would be to choose one of the unused MS_* values from the
middle of the range, such as 256 or 512.  Looking back as far as git will let
me, I don't think that these flags have been used for MS_* values at least
since v2.6.12:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/fs.h?id=1da177e4c3f41524e886b7f1b8a0c1fc7321cac2

I think maybe these used to be S_WRITE and S_APPEND, which weren't filesystem
mount flags?

https://sites.uclouvain.be/SystInfo/usr/include/sys/mount.h.html

A third option would be to create this flag using the new mount system:

https://lwn.net/Articles/753473/
https://lwn.net/Articles/759499/

My main concern with this option is that for Chrome OS we'd like to be able to
backport whatever solution we come up with to a variety of older kernels, and
if we go with the new mount system this would require us to backport the
entire new mount system to those kernels, which I think is infeasible.  

David, what are your thoughts on this?  Of these three options for supporting
a new MS_NOSYMFOLLOW flag:

1) reclaim the bit currently used by MS_SUBMOUNT
2) use a smaller unused value for the flag, 256 or 512
3) implement the new flag only in the new mount system

do you think either #1 or #2 are workable?  If so, which would you prefer?
