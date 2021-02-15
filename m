Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3F531C086
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 18:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhBOR05 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 12:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbhBORZ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 12:25:26 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D0EC061788;
        Mon, 15 Feb 2021 09:24:44 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e7so6086957ile.7;
        Mon, 15 Feb 2021 09:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=As9syGKeS8VicVqj8x+9+NIbGNI174mKBlFqRorjxMU=;
        b=Nj7vSYL8CgpybKQ+Q9LX7Ux9NuBxbcmlsUwaWY2aB+oPm9yzHNYdxWC8ElT4jg5lep
         Ktx3PvLCKOBUWeGkILBZoh3J1YA4dkVN821auLypTNmuts+BTA+v0uGmkqf+QdxFxHfP
         +Rs+bS+1ue0KttvzcmYgt/MjjnonsjvO8wGdPrOAeudhgZtUzuuj2lcrWOl0JQVwZcKm
         aqeJFdyp6BIHmpDrs9Td1wsqx97DgcYO2JD6TYMZr2yV2NC5jpovL5Ja+Ywgwur/JeDW
         qyNnyTSxdPpvEMwgb2HlMC+BF3ljnP0PlBcihGbtJbnt+YsknChbiXK5/vN0txOQ7B/m
         oN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=As9syGKeS8VicVqj8x+9+NIbGNI174mKBlFqRorjxMU=;
        b=hZbxmh43BqH2fziCaaqix68fK6uQerLDCcnhbjjnYrpqP1VRtGnuVznmqBwcN+FhpN
         /kthe84iRkaIp4k+XRsCW7HDpqUkasuWUw2VjMaSIw5GKHt9CekWOMFHa5ae7TWYx5O+
         trBK5IFOWJbCWyHQrQD2vaYy2KZGfj6+AArs+bnrjk+Us5nxlGx5DNrm2sL5p/v8uu/h
         E1wXcKmPwch+mBQXp0gXu1VUpO6AonD998uJ8ZH55slfmE7FGUXsKyr1d1RxlFeI6O+6
         7Qak2tCRVgepPTORtyB1bsyj6FY/94Zj5Lvqp1IgIIWoKINhSnEzRWbWb9tog/ZZoV9N
         pXNg==
X-Gm-Message-State: AOAM533UjiBC/sX28qJejp95HNHDWFfzRqJQtA7ZQ4jUCFnR7G58k4ZV
        F4duMcIdRjyG07tRi9vLpX/kLXJUHptRACCQJag=
X-Google-Smtp-Source: ABdhPJyS0gg9wa1MhtvivwZaHgvvfmhIjg4ematsrIzr026LqeDgZZJICHfG2UVQFit/iYOcTM0dnl0qk6xqffDOJmI=
X-Received: by 2002:a92:c90b:: with SMTP id t11mr14031289ilp.275.1613409883706;
 Mon, 15 Feb 2021 09:24:43 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxiFGjdvX2-zh5o46pn7RZhvbGHH0wpzLPuPOom91FwWeQ@mail.gmail.com>
 <20210215154317.8590-1-lhenriques@suse.de> <CAOQ4uxgjcCrzDkj-0ukhvHRgQ-D+A3zU5EAe0A=s1Gw2dnTJSA@mail.gmail.com>
 <73ab4951f48d69f0183548c7a82f7ae37e286d1c.camel@hammerspace.com>
In-Reply-To: <73ab4951f48d69f0183548c7a82f7ae37e286d1c.camel@hammerspace.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 15 Feb 2021 19:24:32 +0200
Message-ID: <CAOQ4uxgPtqG6eTi2AnAV4jTAaNDbeez+Xi2858mz1KLGMFntfg@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: prevent copy_file_range to copy across devices
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "lhenriques@suse.de" <lhenriques@suse.de>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "drinkcat@chromium.org" <drinkcat@chromium.org>,
        "iant@google.com" <iant@google.com>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "llozano@chromium.org" <llozano@chromium.org>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "sfrench@samba.org" <sfrench@samba.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 15, 2021 at 6:53 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Mon, 2021-02-15 at 18:34 +0200, Amir Goldstein wrote:
> > On Mon, Feb 15, 2021 at 5:42 PM Luis Henriques <lhenriques@suse.de>
> > wrote:
> > >
> > > Nicolas Boichat reported an issue when trying to use the
> > > copy_file_range
> > > syscall on a tracefs file.  It failed silently because the file
> > > content is
> > > generated on-the-fly (reporting a size of zero) and copy_file_range
> > > needs
> > > to know in advance how much data is present.
> > >
> > > This commit restores the cross-fs restrictions that existed prior
> > > to
> > > 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
> > > and
> > > removes generic_copy_file_range() calls from ceph, cifs, fuse, and
> > > nfs.
> > >
> > > Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
> > > devices")
> > > Link:
> > > https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
> > > Cc: Nicolas Boichat <drinkcat@chromium.org>
> > > Signed-off-by: Luis Henriques <lhenriques@suse.de>
> >
> > Code looks ok.
> > You may add:
> >
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> >
> > I agree with Trond that the first paragraph of the commit message
> > could
> > be improved.
> > The purpose of this change is to fix the change of behavior that
> > caused the regression.
> >
> > Before v5.3, behavior was -EXDEV and userspace could fallback to
> > read.
> > After v5.3, behavior is zero size copy.
> >
> > It does not matter so much what makes sense for CFR to do in this
> > case (generic cross-fs copy).  What matters is that nobody asked for
> > this change and that it caused problems.
> >
>
> No. I'm saying that this patch should be NACKed unless there is a real
> explanation for why we give crap about this tracefs corner case and why
> it can't be fixed.
>
> There are plenty of reasons why copy offload across filesystems makes
> sense, and particularly when you're doing NAS. Clone just doesn't cut
> it when it comes to disaster recovery (whereas backup to a different
> storage unit does). If the client has to do the copy, then you're
> effectively doubling the load on the server, and you're adding
> potentially unnecessary network traffic (or at the very least you are
> doubling that traffic).
>

I don't understand the use case you are describing.

Which filesystem types are you talking about for source and target
of copy_file_range()?

To be clear, the original change was done to support NFS/CIFS server-side
copy and those should not be affected by this change.

Thanks,
Amir.
