Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE42E47F8B3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Dec 2021 21:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhLZUB7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Dec 2021 15:01:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40015 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229658AbhLZUB7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Dec 2021 15:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640548918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1sCzD6+SSnKLzL6PVX7wEDXnEX887jFzjv7HjlKTFkY=;
        b=X7/IiP9RKSynqQI+/OsufhE3tHTs0zK3r9+/y+IbOH6gJbUUmCMpEgcNyc0yGKz9J7cQVG
        HxPf4n05CevGc5itjTm9RE+sG3W4EDEocfKhIRu8NWQlAd7PzTJvXpyJHYHcnQAbOVUIDs
        9nIk5kZKrMzjGHePkvvXXAdTEZ3OcbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-jR4ZcoKHPTK4n_CrKsnmQw-1; Sun, 26 Dec 2021 15:01:54 -0500
X-MC-Unique: jR4ZcoKHPTK4n_CrKsnmQw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCBBF1006AA0;
        Sun, 26 Dec 2021 20:01:53 +0000 (UTC)
Received: from work (unknown [10.40.192.52])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A3B115DD68;
        Sun, 26 Dec 2021 20:01:52 +0000 (UTC)
Date:   Sun, 26 Dec 2021 21:01:48 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: Problem with data=ordered ext4 mount option in linux-next
Message-ID: <20211226200148.bvtvfufzaaj5tay3@work>
References: <b5817114-8122-cf0e-ca8e-b5d1c9f43bc2@gmail.com>
 <20211217152456.l7b2mbefdkk64fkj@work>
 <b1fa8d59-02e8-16b7-7218-a3f6ac66e3fa@gmail.com>
 <df69973d-47c5-fbd6-f83d-4d7d8a261c4c@gmail.com>
 <d05a95a9-0bbd-3495-2b81-18673909edd4@gmail.com>
 <20211220111231.ncdfcynvoiidl7is@work>
 <CA+icZUXBBgaeF3NhoVZ7YSg9F66XJSPsbfCgSR5RB6x5-s55gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUXBBgaeF3NhoVZ7YSg9F66XJSPsbfCgSR5RB6x5-s55gA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 25, 2021 at 09:11:14PM +0100, Sedat Dilek wrote:
> On Mon, Dec 20, 2021 at 12:53 PM Lukas Czerner <lczerner@redhat.com> wrote:
> >
> > On Fri, Dec 17, 2021 at 07:26:30PM +0100, Heiner Kallweit wrote:
> > > On 17.12.2021 18:02, Heiner Kallweit wrote:
> > > > On 17.12.2021 16:34, Heiner Kallweit wrote:
> > > >> On 17.12.2021 16:24, Lukas Czerner wrote:
> > > >>> On Fri, Dec 17, 2021 at 04:11:32PM +0100, Heiner Kallweit wrote:
> > > >>>> On linux-next systemd-remount-fs complains about an invalid mount option
> > > >>>> here, resulting in a r/o root fs. After playing with the mount options
> > > >>>> it turned out that data=ordered causes the problem. linux-next from Dec
> > > >>>> 1st was ok, so it seems to be related to the new mount API patches.
> > > >>>>
> > > >>>> At a first glance I saw no obvious problem, the following looks good.
> > > >>>> Maybe you have an idea where to look ..
> > > >>>>
> > > >>>> static const struct constant_table ext4_param_data[] = {
> > > >>>>  {"journal",     EXT4_MOUNT_JOURNAL_DATA},
> > > >>>>  {"ordered",     EXT4_MOUNT_ORDERED_DATA},
> > > >>>>  {"writeback",   EXT4_MOUNT_WRITEBACK_DATA},
> > > >>>>  {}
> > > >>>> };
> > > >>>>
> > > >>>>  fsparam_enum    ("data",                Opt_data, ext4_param_data),
> > > >>>>
> > > >>>
> > > >>> Thank you for the report!
> > > >>>
> > > >>> The ext4 mount has been reworked to use the new mount api and the work
> > > >>> has been applied to linux-next couple of days ago so I definitelly
> > > >>> assume there is a bug in there that I've missed. I will be looking into
> > > >>> it.
> > > >>>
> > > >>> Can you be a little bit more specific about how to reproduce the problem
> > > >>> as well as the error it generates in the logs ? Any other mount options
> > > >>> used simultaneously, non-default file system features, or mount options
> > > >>> stored within the superblock ?
> > > >>>
> > > >>> Can you reproduce it outside of the systemd unit, say a script ?
> > > >>>
> > > >> Yes:
> > > >>
> > > >> [root@zotac ~]# mount -o remount,data=ordered /
> > > >> mount: /: mount point not mounted or bad option.
> > > >> [root@zotac ~]# mount -o remount,discard /
> > > >> [root@zotac ~]#
> > > >>
> > > >> "systemctl status systemd-remount-fs" shows the same error.
> > > >>
> > > >> Following options I had in my fstab (ext4 fs):
> > > >> rw,relatime,data=ordered,discard
> > > >>
> > > >> No non-default system features.
> > > >>
> > > >>> Thanks!
> > > >>> -Lukas
> > > >>>
> > > >> Heiner
> > > >
> > > > Sorry, should have looked at dmesg earlier. There I see:
> > > > EXT4-fs: Cannot change data mode on remount
> > > > Message seems to be triggered from ext4_check_opt_consistency().
> > > > Not sure why this error doesn't occur with old mount API.
> > > > And actually I don't change the data mode.
> > >
> > > Based on the old API code: Maybe we need something like this?
> > > At least it works for me.
> > >
> > > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > > index b72d989b7..9ec7e526c 100644
> > > --- a/fs/ext4/super.c
> > > +++ b/fs/ext4/super.c
> > > @@ -2821,7 +2821,9 @@ static int ext4_check_opt_consistency(struct fs_context *fc,
> > >                                  "Remounting file system with no journal "
> > >                                  "so ignoring journalled data option");
> > >                         ctx_clear_mount_opt(ctx, EXT4_MOUNT_DATA_FLAGS);
> > > -               } else if (ctx->mask_s_mount_opt & EXT4_MOUNT_DATA_FLAGS) {
> > > +               } else if (ctx->mask_s_mount_opt & EXT4_MOUNT_DATA_FLAGS &&
> > > +                          (ctx->vals_s_mount_opt & EXT4_MOUNT_DATA_FLAGS) !=
> > > +                          (sbi->s_mount_opt & EXT4_MOUNT_DATA_FLAGS)) {
> >
> > Hi,
> >
> > indeed that's where the problem is. It's not enogh to check whether
> > we have a data= mount options set, we also have to check whether it's
> > the same as it already is set on the file system during remount. In
> > which case we just ignore it, rather then error out.
> >
> > Thanks for tracking it down. I think the condition can be simplified a
> > bit. I also have to update the xfstest test to check for plain remount
> > without changing anything to catch errors like these. I'll send patch
> > soon.
> >
> 
> Is "ext4: don't fail remount if journalling mode didn't change" the
> fix for the issue reported by Heiner?

Yes, it is.

-Lukas

> 
> - Sedat -
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?h=dev&id=4c2467287779f744cdd70c8ec70903034d6584f0
> 
> > Thanks!
> > -Lukas
> >
> > >                         ext4_msg(NULL, KERN_ERR, "Cannot change data mode "
> > >                                  "on remount");
> > >                         return -EINVAL;
> > >
> >
> 

