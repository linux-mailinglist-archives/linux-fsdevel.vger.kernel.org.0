Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B1335A4D6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 19:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbhDIRoE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 13:44:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27794 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233038AbhDIRoE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 13:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617990230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qMoHusWRU3EEFKJLrdPdn6fw7g5fEbxgGHTh4Vd8ET0=;
        b=I6kxOgE8Ko+rYXsYf5aOZ7yh2T5kfKHh+IXlNkAZyPIKYwTjG9yquk3uGTUdfsXzGGpp2X
        gTyaw/WmfmFGgyyT77p3hrz0lagpAeikNJohCRgFV1hx6t2pJ/FU/8gp5mi0BDdxJs6x9n
        T10oX9flDjYP9xwCNbrt3P3Dcky/fS0=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-ikGn5ATsPuuzabPGMxoXgg-1; Fri, 09 Apr 2021 13:43:46 -0400
X-MC-Unique: ikGn5ATsPuuzabPGMxoXgg-1
Received: by mail-yb1-f197.google.com with SMTP id w9so6113739ybw.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Apr 2021 10:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMoHusWRU3EEFKJLrdPdn6fw7g5fEbxgGHTh4Vd8ET0=;
        b=sDitdBQ5Ql+cvhqI0cBZSfYLqUZBtUm6ogFI4wUSrbRId1UdY9aAMIYvwkA9EFROzb
         BhddJybYz60b71fNw5leoVJGZ1peKAkq77lDCAItN6u+xnj6B+qqyHwAQVmQJA34WbD9
         MDOaflSDk1kKNJeN7erBQRHirJTG2aojzJX12bxsYFGT5mlBLNXAUt88qdSE9Ce7LwWI
         w5lXWUNKyDK5Gy7Z8Rc+9jxOKhVgOZHgaG+O7um4KnaH4bE9I1hCPW8hFY53eN9Imh2i
         5RSQ0i3GzP0GGSpBvLlhoQyuQLNzkw2PklFa1ofaN6zxTssDmCq1sQD8glvapd8sLrzi
         Np3Q==
X-Gm-Message-State: AOAM533/dIMhRIdvUg1bfH3CCpg5MFe6vPze2XrA3HiQ4kSB2eA7pMqc
        T1rPwxizSwgbJ0BBNMx6aYHkE4ccOXe88EMlTIbaqigV68EAQKYrL2l57XfvYwyWI1iw7ePx6+i
        P6oUoKzcYIUDMDit9lixq12oLDbgsZPwZlAaDFhNSNg==
X-Received: by 2002:a25:c750:: with SMTP id w77mr18988187ybe.340.1617990226072;
        Fri, 09 Apr 2021 10:43:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyePgBUXoxlCId5qbcbVtMHPFy79XeNQKfpB+vnhzetF47rq1MWoBwqoXUkxzWZFDH1Z8C7fd36q8TbvUNnQx4=
X-Received: by 2002:a25:c750:: with SMTP id w77mr18988165ybe.340.1617990225907;
 Fri, 09 Apr 2021 10:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210409111254.271800-1-omosnace@redhat.com> <53c532c8-fecf-ff13-ac82-7755f11a087d@schaufler-ca.com>
In-Reply-To: <53c532c8-fecf-ff13-ac82-7755f11a087d@schaufler-ca.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 9 Apr 2021 19:43:33 +0200
Message-ID: <CAFqZXNtcMsTMDtT3pvRNp31UPGUgDzz6DPSC+uw=1LRvLrVspw@mail.gmail.com>
Subject: Re: [PATCH 0/2] vfs/security/NFS/btrfs: clean up and fix LSM option handling
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-nfs <linux-nfs@vger.kernel.org>,
        linux-btrfs@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 9, 2021 at 7:00 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 4/9/2021 4:12 AM, Ondrej Mosnacek wrote:
> > This series attempts to clean up part of the mess that has grown around
> > the LSM mount option handling across different subsystems.
> >
> > The original motivation was to fix a NFS+SELinux bug that I found while
> > trying to get the NFS part of the selinux-testsuite [1] to work, which
> > is fixed by patch 2.
> >
> > The first patch paves the way for the second one by eliminating the
> > special case workaround in selinux_set_mnt_opts(), while also
> > simplifying BTRFS's LSM mount option handling.
> >
> > I tested the patches by running the NFS part of the SELinux testsuite
> > (which is now fully passing). I also added the pending patch for
> > broken BTRFS LSM options support with fsconfig(2) [2] and ran the
> > proposed BTRFS SELinux tests for selinux-testsuite [3] (still passing
> > with all patches).
>
> The Smack testsuite can be found at:
>         https://github.com/smack-team/smack-testsuite.git
>
> It might provide another layer of confidence.

Thanks, but that doesn't seem to exercise mounting/remounting btrfs
nor nfs with security options. Anything else should be unaffected.

>
> >
> > [1] https://github.com/SELinuxProject/selinux-testsuite/
> > [2] https://lore.kernel.org/selinux/20210401065403.GA1363493@infradead.org/T/
> > [3] https://lore.kernel.org/selinux/20201103110121.53919-2-richard_c_haines@btinternet.com/
> >     ^^ the original patch no longer applies - a rebased version is here:
> >     https://github.com/WOnder93/selinux-testsuite/commit/212e76b5bd0775c7507c1996bd172de3bcbff139.patch
> >
> > Ondrej Mosnacek (2):
> >   vfs,LSM: introduce the FS_HANDLES_LSM_OPTS flag
> >   selinux: fix SECURITY_LSM_NATIVE_LABELS flag handling on double mount
> >
> >  fs/btrfs/super.c         | 35 ++++++-----------------------------
> >  fs/nfs/fs_context.c      |  6 ++++--
> >  fs/super.c               | 10 ++++++----
> >  include/linux/fs.h       |  3 ++-
> >  security/selinux/hooks.c | 32 +++++++++++++++++---------------
> >  5 files changed, 35 insertions(+), 51 deletions(-)
> >
>


-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

