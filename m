Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046E63AC3FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 08:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhFRGgk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 02:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhFRGgj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 02:36:39 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EC7C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jun 2021 23:34:30 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id w4so4474383ior.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jun 2021 23:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZvotrOY1+J4zuQC43YmApYUw5++sfgFymUtmcDXqmKc=;
        b=hY68nO0+2AQR4/R1zXKiWJVzRVvNdIKSMCTlzobEwVVW91J7Ul3zDpbFIwhf7qfkAO
         eZUboKVF3ZMQEwsZp/PqXXNElDkb+fLOgd3MFFdGaczwuH4TR3kZc9FvlIF185MsOVTB
         JTQmz7gZYBcrq+rhj54uTwVxwHADKtl2koCbFpYXVSxx2k6fEgC6kqfZ5o8AauhhYtNV
         N3WE2js+G8OtykXd27Zy1w4EMiyfvkaT2OPtZTJ1F6VD4LrDgwZG1lNOs73pVyqs3F4o
         8DQRIi0FSTyrLTiAL08nwQptDHSAnA4gtjkGmwjNG30DpX+5xwYpynbGzWFBSMqcB5di
         EA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZvotrOY1+J4zuQC43YmApYUw5++sfgFymUtmcDXqmKc=;
        b=rY49UY3EzYlDvvyJabbiLVDc0hK0GqeYFgUwZrFq1owr4ad8Z63jYVrpUcHGlqmcTv
         diO4WBbOv5XHpg9fRItUX/zJsWPsAZ644vKB9BO1++H4TOuUIzoKm6jFZPwPsX9kC7L9
         urCpKxC9Rd9w90q06FVoBOpUNorb3A4THaYdd0o7EHS0AB7zN4w303xDZanxfA9KPI3I
         RtBVcC8yfrt4FfgGKQdtO+YFdbaHbyCI4ru1ssaEnLT/dQeoS97O5QUW0UWDuqlrb+lt
         4AKtcfYuOKgZ7tKHYUXxRsdi1gQ1jmZFGy8a66IL8H+nlHi+1F0VraObZnmFh6v6POOi
         wVIw==
X-Gm-Message-State: AOAM5312dNgIvIa6hKVW/Aykm/zzCNoe0A4DNK1e5f4oOL0sm+JF5A6d
        twCZAua4Jm15WlgAqo9M5b68pKvPNERH80RQrws=
X-Google-Smtp-Source: ABdhPJw2l6MghQr2hZwA5iDBDl81fczJsYlnfAZLwpw5sa4pe8ybfUUSinc8kxecS2d/TMso+GC2fnrlyof4BaDyx3I=
X-Received: by 2002:a05:6638:358e:: with SMTP id v14mr1912060jal.120.1623998069659;
 Thu, 17 Jun 2021 23:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210609181158.479781-1-amir73il@gmail.com> <20210617212801.GE1142820@redhat.com>
In-Reply-To: <20210617212801.GE1142820@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 18 Jun 2021 09:34:18 +0300
Message-ID: <CAOQ4uxiJdqAisS+ShC1+QmXAoUjGG_mrnFPRWHLNKFMoYCfqFA@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix illegal access to inode with reused nodeid
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Max Reitz <mreitz@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 18, 2021 at 12:28 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Jun 09, 2021 at 09:11:58PM +0300, Amir Goldstein wrote:
> > Server responds to LOOKUP and other ops (READDIRPLUS/CREATE/MKNOD/...)
> > with outarg containing nodeid and generation.
> >
> > If a fuse inode is found in inode cache with the same nodeid but
> > different generation, the existing fuse inode should be unhashed and
> > marked "bad" and a new inode with the new generation should be hashed
> > instead.
> >
> > This can happen, for example, with passhrough fuse filesystem that
> > returns the real filesystem ino/generation on lookup and where real inode
> > numbers can get recycled due to real files being unlinked not via the fuse
> > passthrough filesystem.
>
> Hi Amir,
>
> Is the code for filesystem you have written is public? If yes, can you
> please provide a link.

Yes, I provided the link in the discussion about the bug:

[1] https://github.com/amir73il/libfuse/commits/cachegwfs

>
> Is there an API to lookup generation number from host filesystem. Or

There is FS_IOC_GETVERSION which a few fs implement
(ext4/xfs/btrfs/f2fs), but I don't use it.

> that's something your file server updates based on file handle has
> changed.
>

My filesystem takes ino/gen from file handle.
The file handle format is filesystem specific - but my filesystem only
has support for ext4 and xfs, so it makes used of that to extract
the generation from file handle.

When inode number is 32bit (ext4) the entire file handle is encoded
into 64bit nodeid.

Thanks,
Amir.
