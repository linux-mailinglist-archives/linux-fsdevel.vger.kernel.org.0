Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BB231ED12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 18:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbhBRROK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 12:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbhBRQ3n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 11:29:43 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8254EC061574;
        Thu, 18 Feb 2021 08:28:59 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id hs11so6718263ejc.1;
        Thu, 18 Feb 2021 08:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y38daONDwdDmDv1VoddeHBWWftl202hO6P8yucZxYa8=;
        b=iNFjWjKl+LQN0COFhBnybPiIzwQZeq8Ix9Q6VeVsYt0rK/aNZ2CJ8MGnct0Nn2Uq44
         HkSGMORn3xukzFLyjCcoKGIp5LxBAd6UeElElN4KqyH6chlqEH2OTZWAMVZey9T/m2ws
         z9wIkKJaekgRy6SOjUdAjB3t3H8GCoyK4yI0XjwpQmOi4Mdm4DvieCwmo4GzDqp5788B
         Eg6Y8VCfYsymemfvGfC7VGF7AJty6+2K26GYFtEdYuZhHrdXANbWixTJG329KJFpE8HM
         Szr4l+twMHlN4WuxLmvOo9yhavF5EE/XWlSHyHrQF+UY3xBcyp9/PSYQQBciIvSR31Y0
         hq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y38daONDwdDmDv1VoddeHBWWftl202hO6P8yucZxYa8=;
        b=Y5o19VpDbqcVFzF6J2Z31otZo0oyeoh2j+6sEpRROLv2GEH68oukY4iezokurCkK8Q
         gmLQVLfZVwEWdaRgu5nHmRjj3k63FGbuCet0TROfeJGy1vxjlPq2JZkxFEX1E+PETmJG
         nMRtNB8HbEmDRJr15++DG2VathV2Xw+A37755PtuMAIxateklFv/rWjOMsuRV6sJ968i
         T+mqjkHsqwjfK4nLsGCTDyKni1RIevgCx6zkYp9Fr7d02taKqt9ARW74dwx+I6nSQfz9
         iaEekpUT0dNolVKnc8ywBJd0EiMS0Y7BHATtktzSTDvU6Tfua0YGuJCEChcL5wdUJgeu
         qG+w==
X-Gm-Message-State: AOAM5313l5uHZwB8VCHhQAiunjfjbyWu6fR3x23LFMe96v7oVeArCs5B
        Xn0R5RG6suRumiQQ1qYrD6SpXqoeA8hOas6y+ls=
X-Google-Smtp-Source: ABdhPJzGgUkLYZUEL1Zpo08T7oMdth0EfHuMaJ6hNGLf8X0W8W6hosNZC+ES+g1w9t5wa73zBypNYGQnlkbDPFG7yko=
X-Received: by 2002:a17:907:35ca:: with SMTP id ap10mr4739637ejc.451.1613665738066;
 Thu, 18 Feb 2021 08:28:58 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxii=7KUKv1w32VbjkwS+Z1a0ge0gezNzpn_BiY6MFWkpA@mail.gmail.com>
 <20210217172654.22519-1-lhenriques@suse.de> <CAN-5tyHVOphSkp3n+V=1gGQ40WNZGHQURSMMdFBS3jRVGfEXhA@mail.gmail.com>
 <CAOQ4uxi08oG9=Oadvt6spA9+zA=dcb-UK8AL-+o2Fn3d57d7iw@mail.gmail.com>
In-Reply-To: <CAOQ4uxi08oG9=Oadvt6spA9+zA=dcb-UK8AL-+o2Fn3d57d7iw@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 18 Feb 2021 11:28:47 -0500
Message-ID: <CAN-5tyExn=N6ii3vK3La9gS_XncrhOqJ5E7QU-T9Tak+EbajLg@mail.gmail.com>
Subject: Re: [PATCH v3] vfs: fix copy_file_range regression in cross-fs copies
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Luis Henriques <lhenriques@suse.de>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 18, 2021 at 1:48 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Feb 18, 2021 at 7:33 AM Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > On Wed, Feb 17, 2021 at 3:30 PM Luis Henriques <lhenriques@suse.de> wrote:
> > >
> > > A regression has been reported by Nicolas Boichat, found while using the
> > > copy_file_range syscall to copy a tracefs file.  Before commit
> > > 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
> > > kernel would return -EXDEV to userspace when trying to copy a file across
> > > different filesystems.  After this commit, the syscall doesn't fail anymore
> > > and instead returns zero (zero bytes copied), as this file's content is
> > > generated on-the-fly and thus reports a size of zero.
> > >
> > > This patch restores some cross-filesystems copy restrictions that existed
> > > prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
> > > devices").  It also introduces a flag (COPY_FILE_SPLICE) that can be used
> > > by filesystems calling directly into the vfs copy_file_range to override
> > > these restrictions.  Right now, only NFS needs to set this flag.
> > >
> > > Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
> > > Link: https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
> > > Link: https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/
> > > Link: https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/
> > > Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> > > Signed-off-by: Luis Henriques <lhenriques@suse.de>
> > > ---
> > > Ok, I've tried to address all the issues and comments.  Hopefully this v3
> > > is a bit closer to the final fix.
> > >
> > > Changes since v2
> > > - do all the required checks earlier, in generic_copy_file_checks(),
> > >   adding new checks for ->remap_file_range
> > > - new COPY_FILE_SPLICE flag
> > > - don't remove filesystem's fallback to generic_copy_file_range()
> > > - updated commit changelog (and subject)
> > > Changes since v1 (after Amir review)
> > > - restored do_copy_file_range() helper
> > > - return -EOPNOTSUPP if fs doesn't implement CFR
> > > - updated commit description
> >
> > In my testing, this patch breaks NFS server-to-server copy file.
>
> Hi Olga,
>
> Can you please provide more details on the failed tests.
>
> Does it fail on the client between two nfs mounts or does it fail
> on the server? If the latter, between which two filesystems on the server?
>

It was a pilot error. V3 worked. I'm having some other issues with
server to server copy code but they seem to be unrelated to this. I
will test the new v6 versions when it comes out.

> Thanks,
> Amir.
