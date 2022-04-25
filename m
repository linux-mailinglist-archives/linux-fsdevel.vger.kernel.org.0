Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DFC50DA43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 09:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbiDYHlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 03:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbiDYHlR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:41:17 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D382612ACE
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 00:38:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r13so27924156ejd.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 00:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9fsgNEjpNoYMmfQvb9peCMkx3uLXtH/RETf0fq38iDY=;
        b=IQRJVVQ4cUCgFprCDj8PrbLxIBblEhucXMHvx9dN7Wy7nHHmon9c1dzK9NufC/qMdj
         Rn7ec4oSFwafEV7TYki+o8Nj6yMVzEWt3pGVbZOalDdbX1KDVpE/9lqD/D6G429HuiXx
         90gmmSMw8c4JUebDxS735ZUbSx7fZXb25nEv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9fsgNEjpNoYMmfQvb9peCMkx3uLXtH/RETf0fq38iDY=;
        b=S5NxBTzrTqHhyu9kEg7GAodThyZLuIJnlgNiEi5qm6gCrrsM7QUW3V0dCKcmQWDe07
         /tVOTwuvv+tcDwXouRLXeuozBjcb3aPp/D4fbryeC0Xcpk0HymlJ+miaqeQWDfiMbLUB
         PxIf1Ac/2hh/Q74eRGExtM0V7pJHvSd/VnEF+hKo53HZ+wi0vN8fOR68qgAUMYBFd01a
         vx78OPtO+CC+RsrI+KLV19e0pRGUgia8WxdRsvz7+Bh7Vg4/3RK0AHfQNu/oXqFjJ42B
         +NwKaT2mOf6PDPH83FznTP1dpMg74kVPZwqT+scz5bDRqXDuWGhhuhyr5D2OOqHJCei9
         GY6Q==
X-Gm-Message-State: AOAM532Zk0g/VBLgE72PRXYvjvidnOXNIqiWcdVc12xEP7OA6XDEMIqu
        jauo/SsCy3uo5Snjtmcw8S5+hPkyPjJGzp+NYzKGT0nvu8M=
X-Google-Smtp-Source: ABdhPJzk6ikjS/u8XAFvzYYfuwBO1lXtPfgTUzBG2ikP6+kqSM+UWZWkQTnCEGerxhAYKMgQxGVDg0kJXlyuDOsACs4=
X-Received: by 2002:a17:907:1c11:b0:6f0:d63:69b3 with SMTP id
 nc17-20020a1709071c1100b006f00d6369b3mr15162745ejc.691.1650872289459; Mon, 25
 Apr 2022 00:38:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220322115148.3870-1-dharamhans87@gmail.com> <20220322115148.3870-2-dharamhans87@gmail.com>
 <CAJfpegtunCe5hV1b9cKJgPk44B2SQgtK3RG5r2is8V5VrMYeNg@mail.gmail.com> <CACUYsyGmab57_efkXRXD8XvO6Stn4JbJM8+NfBHNKQ+FLcA7nA@mail.gmail.com>
In-Reply-To: <CACUYsyGmab57_efkXRXD8XvO6Stn4JbJM8+NfBHNKQ+FLcA7nA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 25 Apr 2022 09:37:58 +0200
Message-ID: <CAJfpegt5qWE4UepoDj9QBuT--ysT6+7E-6ZQvNeZ+bODRHHCvg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] FUSE: Implement atomic lookup + open
To:     Dharmendra Hans <dharamhans87@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>,
        Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 25 Apr 2022 at 07:26, Dharmendra Hans <dharamhans87@gmail.com> wrote:
>
> On Fri, Apr 22, 2022 at 8:59 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Tue, 22 Mar 2022 at 12:52, Dharmendra Singh <dharamhans87@gmail.com> wrote:
> > >
> > > From: Dharmendra Singh <dsingh@ddn.com>
> > >
> > > There are couple of places in FUSE where we do agressive
> > > lookup.
> > > 1) When we go for creating a file (O_CREAT), we do lookup
> > > for non-existent file. It is very much likely that file
> > > does not exists yet as O_CREAT is passed to open(). This
> > > lookup can be avoided and can be performed  as part of
> > > open call into libfuse.
> > >
> > > 2) When there is normal open for file/dir (dentry is
> > > new/negative). In this case since we are anyway going to open
> > > the file/dir with USER space, avoid this separate lookup call
> > > into libfuse and combine it with open.
> > >
> > > This lookup + open in single call to libfuse and finally to
> > > USER space has been named as atomic open. It is expected
> > > that USER space open the file and fills in the attributes
> > > which are then used to make inode stand/revalidate in the
> > > kernel cache.
> > >
> > > Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
> > > ---
> > > v2 patch includes:
> > > - disabled o-create atomicity when the user space file system
> > >   does not have an atomic_open implemented. In principle lookups
> > >   for O_CREATE also could be optimized out, but there is a risk
> > >   to break existing fuse file systems. Those file system might
> > >   not expect open O_CREATE calls for exiting files, as these calls
> > >   had been so far avoided as lookup was done first.
> >
> > So we enabling atomic lookup+create only if FUSE_DO_ATOMIC_OPEN is
> > set.  This logic is a bit confusing as CREATE is unrelated to
> > ATOMIC_OPEN.   It would be cleaner to have a separate flag for atomic
> > lookup+create.  And in fact FUSE_DO_ATOMIC_OPEN could be dropped and
> > the usual logic of setting fc->no_atomic_open if ENOSYS is returned
> > could be used instead.
>
> I am aware that ATOMIC_OPEN is not directly related to CREATE. But
> This is more of feature enabling by using the flag. If we do not
> FUSE_DO_ATOMIC_OPEN, CREATE calls would not know that it need to
> optimize lookup calls otherwise as we know only from open call that
> atomic open is implemented.

Right.  So because the atomic lookup+crteate would need a new flag to
return whether the file was created or not, this is probably better
implemented as a completely new request type (FUSE_ATOMIC_CREATE?)

No new INIT flags needed at all, since we can use the ENOSYS mechanism
to determine whether the filesystem has atomic open/create ops or not.

Thanks,
Miklos
