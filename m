Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A996E5F3180
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Oct 2022 15:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiJCNw6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 09:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiJCNw5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 09:52:57 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E503A499;
        Mon,  3 Oct 2022 06:52:56 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id i17so4128958uaq.9;
        Mon, 03 Oct 2022 06:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SWaeV/ybx1EEPzgA7mLfnQ6qvSq0W9UmA+imh17h5mU=;
        b=erdEkb3Er6D92QZa5NGTjNKHu/4J1A9VrE06RdpSXQFqt9vzlpDzeQaZR0PJNqD5i0
         Tvz2FrwcSJ8iabakFYWDBbw9bkY39F9CLDQw5mDqVDrDKR1blXQEF1U3kvcmePD8brJ1
         ITzLApDRpc+MbyEU0nPZmwxnCOoRvfe3yv1DHznMO8LflTK/nPXLd2olCILD7zc3vp77
         p6s0MJj9k8uw9sLWG531v1jwUu9Yokox3G9QwMYa96UyEJUwG47jLUMs8b4GmBwjE24u
         dTHA0JQjQKOiPNZOf4U3X7SFiyqW++jWWYhkJtBhvkrRi/1cMjt/3XjizKORUxRq1OI8
         Kmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SWaeV/ybx1EEPzgA7mLfnQ6qvSq0W9UmA+imh17h5mU=;
        b=O1K41nT4WwX/y5CJmMJ4jed2qUvaSHEuvb0PmJQ8gBhSBJi1VM9ogS65SsDMWzzQwy
         K2eyJNYzNb4+FbiXMoCsp/fO2e6vBEEfbHuOb0vNZdWGn4VO1E4xKLzKOk653wx/lDQ2
         J83ILVA7CvyhHW8jnmYPJ+7hUAfCvBgjHrL4gsN1LY+ud3dYqL45S8JYycQjiJ34nN0G
         sTKhV7cgVjXvR71ZwMN5WLAdGrGFFPFl6mcVZMLj3Ewv/j6UdUDipasRVn7HtCAFiy8w
         AyP7rvM9VcroYMVeIhV+xVkpUlK1tlK7o6limfRGF8RHKV/zxy/wwBAdCEtS4MNryd5c
         6B9g==
X-Gm-Message-State: ACrzQf0pZCp1THf94IQ1dNTJjSxZnBM/GTdOoGHAGVkVtKYw4whSBQjc
        2RlLZJKiMBhxchbUsLE9gCIQodSDFPXqKUjKGtM=
X-Google-Smtp-Source: AMsMyM6DL0nf8mEAa5UKqrqukdOAMa4uFbSl2mR3cT+W3Lp5sQTTos0pz3zqwsJEXklBiGSniCAIMxHbXngHQoE8sQE=
X-Received: by 2002:ab0:6056:0:b0:3d8:e58:4c34 with SMTP id
 o22-20020ab06056000000b003d80e584c34mr3020938ual.114.1664805175371; Mon, 03
 Oct 2022 06:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220930111840.10695-1-jlayton@kernel.org> <20220930111840.10695-9-jlayton@kernel.org>
 <CAOQ4uxgofERYwN7AfYFWqQMpQH5y3LV+6UuGfjU29gZXNf7-vQ@mail.gmail.com> <df91b9ec61bc49aa5330714e3319dcea2531953b.camel@kernel.org>
In-Reply-To: <df91b9ec61bc49aa5330714e3319dcea2531953b.camel@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 3 Oct 2022 16:52:43 +0300
Message-ID: <CAOQ4uxi6pPDexF7Z1wshnpV0kbSKsHUeawaUkhjq4FNGbqWU+A@mail.gmail.com>
Subject: Re: [PATCH v6 8/9] vfs: update times after copying data in __generic_file_write_iter
To:     Jeff Layton <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 3, 2022 at 4:01 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Sun, 2022-10-02 at 10:08 +0300, Amir Goldstein wrote:
> > On Fri, Sep 30, 2022 at 2:30 PM Jeff Layton <jlayton@kernel.org> wrote:
> > >
> > > The c/mtime and i_version currently get updated before the data is
> > > copied (or a DIO write is issued), which is problematic for NFS.
> > >
> > > READ+GETATTR can race with a write (even a local one) in such a way as
> > > to make the client associate the state of the file with the wrong change
> > > attribute. That association can persist indefinitely if the file sees no
> > > further changes.
> > >
> > > Move the setting of times to the bottom of the function in
> > > __generic_file_write_iter and only update it if something was
> > > successfully written.
> > >
> >
> > This solution is wrong for several reasons:
> >
> > 1. There is still file_update_time() in ->page_mkwrite() so you haven't
> >     solved the problem completely
>
> Right. I don't think there is a way to solve the problem vs. mmap.
> Userland can write to a writeable mmap'ed page at any time and we'd
> never know. We have to specifically carve out mmap as an exception here.
> I'll plan to add something to the manpage patch for this.
>
> > 2. The other side of the coin is that post crash state is more likely to end
> >     up data changes without mtime/ctime change
> >
>
> Is this really something filesystems rely on? I suppose the danger is
> that some cached data gets written to disk before the write returns and
> the inode on disk never gets updated.
>
> But...isn't that a danger now? Some of the cached data could get written
> out and the updated inode just never makes it to disk before a crash
> (AFAIU). I'm not sure that this increases our exposure to that problem.
>
>

You are correct that that danger exists, but it only exists for overwriting
to allocated blocks.

For writing to new blocks, mtime change is recorded in transaction
before the block mapping is recorded in transaction so there is no
danger in this case (before your patch).

Also, observing size change without observing mtime change
after crash seems like a very bad outcome that may be possible
after your change.

These are just a few cases that I could think of, they may be filesystem
dependent, but my gut feeling is that if you remove the time update before
the operation, that has been like that forever, a lot of s#!t is going to float
for various filesystems and applications.

And it is not one of those things that are discovered  during rc or even
stable kernel testing - they are discovered much later when users start to
realize their applications got bogged up after crash, so it feels like to me
like playing with fire.

> > If I read the problem description correctly, then a solution that invalidates
> > the NFS cache before AND after the write would be acceptable. Right?
> > Would an extra i_version bump after the write solve the race?
> >
>
> I based this patch on Neil's assertion that updating the time before an
> operation was pointless if we were going to do it afterward. The NFS
> client only really cares about seeing it change after a write.
>

Pointless to NFS client maybe.
Whether or not this is not changing user behavior for other applications
is up to you to prove and I doubt that you can prove it because I doubt
that it is true.

> Doing both would be fine from a correctness standpoint, and in most
> cases, the second would be a no-op anyway since a query would have to
> race in between the two for that to happen.
>
> FWIW, I think we should update the m/ctime and version at the same time.
> If the version changes, then there is always the potential that a timer
> tick has occurred. So, that would translate to a second call to
> file_update_time in here.
>
> The downside of bumping the times/version both before and after is that
> these are hot codepaths, and we'd be adding extra operations there. Even
> in the case where nothing has changed, we'd have to call
> inode_needs_update_time a second time for every write. Is that worth the
> cost?

Is there a practical cost for iversion bump AFTER write as I suggested?
If you NEED m/ctime update AFTER write and iversion update is not enough
then I did not understand from your commit message why that is.

Thanks,
Amir.
