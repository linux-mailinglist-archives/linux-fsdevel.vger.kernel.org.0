Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA39368C40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 06:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbhDWEle (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 00:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDWEld (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 00:41:33 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C98DC06174A
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Apr 2021 21:40:56 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id r1so2898042uat.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Apr 2021 21:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cYjZlbF3DXM7zGnEvoUEauj9qs95JDVKd+qkmT8E5Es=;
        b=Sz162M5Od95RKrPl3X/Ac4xcDjeMsrrM/4Xt3pyER0eWJaPxr1EiE1YWPdfvaRqo8Z
         9BuZXgXl61gDrjkAfvHLKWCwv0Hz3q0z5HGKJCQkDs0zZc1hd1SYYMVD4xhYjVO1eYBK
         nUrplSbXYGSOOCNOwNBzogI6pG1sjmuXCgXbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cYjZlbF3DXM7zGnEvoUEauj9qs95JDVKd+qkmT8E5Es=;
        b=E+xvGFvSqvs2UPwb2SZgqTsVDMEKA1pOWj7VmeA1PxOOd4DfJvvldGU5uAq1NtoAT6
         QLjG4r0OWNhTSrz2Z2HUTiTJZevNbVr5HxscHZITkGMtlrryHSSNAkX2sb+pU1VyUafl
         7OMEWiRn7O7kjqOarxk1UdeuZd7iKY0nCeIP42GScrJV/XSE+M/+9newzqRqv9f5rN34
         wCP3C/iMVNqPHOiBogf8S4XH4CTs9gJ8wU35jGSKr6owULsSNof86C1iNn6EgAImSkoe
         T93BJePBwBX8csDaVdyJrp6zHRlDrQL2Xq9chfIcB45uSQcwJ+f1osMspFfx2BCzORNI
         BOYQ==
X-Gm-Message-State: AOAM533LsvxASNnUrfmp/XokgNgqhOudXZ/Fpq95aQFvkOy+1Gh/Ebs5
        GIH8QD6Ewx6rSlx7Ylm/1phem8pii4nBdgzXhYhHpQ==
X-Google-Smtp-Source: ABdhPJxN50JqYMGhnzwmNIzBqf5XELBKZ9iKqf346L2CEQrzbVJ1FDlyDZ16cLmlLwpKkRZI87JeC+iOPw+JE+Tq628=
X-Received: by 2002:ab0:638e:: with SMTP id y14mr1572161uao.82.1619152855684;
 Thu, 22 Apr 2021 21:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210221195833.23828-1-lhenriques@suse.de> <20210222102456.6692-1-lhenriques@suse.de>
 <CAN-5tyELMY7b7CKO-+an47ydq8r_4+SOyhuvdH0qE0-JmdZ44Q@mail.gmail.com>
 <YDYpHccgM7agpdTQ@suse.de> <CANMq1KBgwEXFh8AxpPW2t1SA0NVsyR45m0paLEU4D4w80dc_fA@mail.gmail.com>
 <CANMq1KDTgnGtNxWj2XxAT3mdsNjc551uUCg6EWnh=Hd0KcVQKQ@mail.gmail.com>
 <8735vzfugn.fsf@suse.de> <CAOQ4uxjdVZywBi6=D1eRfBhRk+nobTz4N87jcejDtvzBMMMKXQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxjdVZywBi6=D1eRfBhRk+nobTz4N87jcejDtvzBMMMKXQ@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 23 Apr 2021 12:40:44 +0800
Message-ID: <CANMq1KAOwj9dJenwF2NadQ73ytfccuPuahBJE7ak6S7XP6nCjg@mail.gmail.com>
Subject: Re: [PATCH v8] vfs: fix copy_file_range regression in cross-fs copies
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Luis Henriques <lhenriques@suse.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Christoph Hellwig <hch@infradead.org>,
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

On Fri, Apr 9, 2021 at 9:50 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Fri, Apr 9, 2021 at 4:39 PM Luis Henriques <lhenriques@suse.de> wrote:
> >
> > Nicolas Boichat <drinkcat@chromium.org> writes:
> >
> > > On Wed, Feb 24, 2021 at 6:44 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
> > >>
> > >> On Wed, Feb 24, 2021 at 6:22 PM Luis Henriques <lhenriques@suse.de> wrote:
> > >> >
> > >> > On Tue, Feb 23, 2021 at 08:00:54PM -0500, Olga Kornievskaia wrote:
> > >> > > On Mon, Feb 22, 2021 at 5:25 AM Luis Henriques <lhenriques@suse.de> wrote:
> > >> > > >
> > >> > > > A regression has been reported by Nicolas Boichat, found while using the
> > >> > > > copy_file_range syscall to copy a tracefs file.  Before commit
> > >> > > > 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
> > >> > > > kernel would return -EXDEV to userspace when trying to copy a file across
> > >> > > > different filesystems.  After this commit, the syscall doesn't fail anymore
> > >> > > > and instead returns zero (zero bytes copied), as this file's content is
> > >> > > > generated on-the-fly and thus reports a size of zero.
> > >> > > >
> > >> > > > This patch restores some cross-filesystem copy restrictions that existed
> > >> > > > prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
> > >> > > > devices").  Filesystems are still allowed to fall-back to the VFS
> > >> > > > generic_copy_file_range() implementation, but that has now to be done
> > >> > > > explicitly.
> > >> > > >
> > >> > > > nfsd is also modified to fall-back into generic_copy_file_range() in case
> > >> > > > vfs_copy_file_range() fails with -EOPNOTSUPP or -EXDEV.
> > >> > > >
> > >> > > > Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
> > >> > > > Link: https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
> > >> > > > Link: https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/
> > >> > > > Link: https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/
> > >> > > > Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> > >> > > > Signed-off-by: Luis Henriques <lhenriques@suse.de>
> > >> > >
> > >> > > I tested v8 and I believe it works for NFS.
> > >> >
> > >> > Thanks a lot for the testing.  And to everyone else for reviews,
> > >> > feedback,... and patience.
> > >>
> > >> Thanks so much to you!!!
> > >>
> > >> Works here, you can add my
> > >> Tested-by: Nicolas Boichat <drinkcat@chromium.org>
> > >
> > > What happened to this patch? It does not seem to have been picked up
> > > yet? Any reason why?
> >
> > Hmm... good question.  I'm not actually sure who would be picking it.  Al,
> > maybe...?
> >
>
> Darrick,
>
> Would you mind taking this through your tree in case Al doesn't pick it up?

Err, sorry for yet another ping... but it would be good to move
forward with those patches ,-P

Thanks!

> Thanks,
> Amir.
