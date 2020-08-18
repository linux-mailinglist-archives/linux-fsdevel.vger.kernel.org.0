Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E70524867B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 15:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgHRNzh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 09:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgHRNzf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 09:55:35 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2542C061389;
        Tue, 18 Aug 2020 06:55:34 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id v6so16268781ota.13;
        Tue, 18 Aug 2020 06:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PkXVibwANyp1ezoNMRt9ZhpxiQyaMhZ/DtsBrdxHhyQ=;
        b=UETCZL5PsM9y5l4XRE5O4/Wac+je8ocVByP17iujIdAwkf3+vCPZ4X99taR/CeksGj
         b0fsI/Zt5N5alHGwkwFWazLzYdYfDOF9tQaZ7AO01zCHNAFkLqV8u0iK5SXJa3TMQ6yk
         ycN5FRRXF0s9iixv0c8AaMWUHzTFZtXGgzY7iy8z0Y41K9v7jykHzmrDMY18sbyIv0iF
         ItUh3EZ34PyBuDselHHN2ydY/8EmW2zJdHdkyo+o4Wt7PLh3QYjVcAn8kgI1VJICb9zB
         v97UyqT1qXljyoxkNczmUbdp4ceAy2w0l2iEm0nynqr5lWyZih0z+qVz10tDXdwNgcSh
         Ez2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PkXVibwANyp1ezoNMRt9ZhpxiQyaMhZ/DtsBrdxHhyQ=;
        b=MPbmKKvHuDusPQxV0U0sqaQnmqTonIhAjRI/RwYAL/4QznR/Glu+i8512kmh7LspTB
         n8acxIzosqNc7SM0ht+8VFfQymikoG33wgUdnAwer1rlvJ2fAfdmfuI756qjWkapXE+k
         Z5vafvkYdOam7TKiXgw4quek+aj4D3IJqcZVJzyKB+nMdH/JJNo17Qk0R/TjWdVMQccv
         ahKGLko/xh0HCRkDe98hNQVQnER6t4e5gn9KyyiJbnH04140rOoiOMklDj0wd4m9Hp3V
         M/CWOQuACuAry0knPwGAh8yxCB1DBchjKqA8fPQpZngyqS8Frbog+Eym8bgKdOPDjuHw
         2ndQ==
X-Gm-Message-State: AOAM531MEa3BR28/C6fIRyQq7Lfo3TuTfCXq4fUwIK/+kCIm9O0IYAre
        8/WgEmGUTDHOExccii0E5E3KKtmvCihaGIUEMfQ9vRq/Mjw=
X-Google-Smtp-Source: ABdhPJxRSOBcq0xMmRM7gcOpilN+NQcuKvF68z3yOvGPCJ+BmaO6QUVdvWHb5lsfHFSXPw3beKb4Ien/bsqpnEnNBKw=
X-Received: by 2002:a05:6830:1305:: with SMTP id p5mr15527403otq.135.1597758933969;
 Tue, 18 Aug 2020 06:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200812191525.1120850-1-dburgener@linux.microsoft.com>
 <20200812191525.1120850-5-dburgener@linux.microsoft.com> <8540e665-1722-35f9-ec39-f4038e1f90ca@gmail.com>
 <bd7031f8-e4c5-a013-3a00-c89d603be152@linux.microsoft.com>
In-Reply-To: <bd7031f8-e4c5-a013-3a00-c89d603be152@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 18 Aug 2020 09:55:23 -0400
Message-ID: <CAEjxPJ7pT5NSkVc8gnVoGj=JT-PkrQcGDmPARBU6cs7W+u05TA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] selinux: Create new booleans and class dirs out of tree
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 18, 2020 at 9:49 AM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> On 8/13/20 12:25 PM, Stephen Smalley wrote:
> > On 8/12/20 3:15 PM, Daniel Burgener wrote:
> >
> >> In order to avoid concurrency issues around selinuxfs resource
> >> availability
> >> during policy load, we first create new directories out of tree for
> >> reloaded resources, then swap them in, and finally delete the old
> >> versions.
> >>
> >> This fix focuses on concurrency in each of the three subtrees
> >> swapped, and
> >> not concurrency across the three trees.  This means that it is still
> >> possible
> >> that subsequent reads to eg the booleans directory and the class
> >> directory
> >> during a policy load could see the old state for one and the new for
> >> the other.
> >> The problem of ensuring that policy loads are fully atomic from the
> >> perspective
> >> of userspace is larger than what is dealt with here.  This commit
> >> focuses on
> >> ensuring that the directories contents always match either the new or
> >> the old
> >> policy state from the perspective of userspace.
> >>
> >> In the previous implementation, on policy load /sys/fs/selinux is
> >> updated
> >> by deleting the previous contents of
> >> /sys/fs/selinux/{class,booleans} and then recreating them.  This means
> >> that there is a period of time when the contents of these directories
> >> do not
> >> exist which can cause race conditions as userspace relies on them for
> >> information about the policy.  In addition, it means that error
> >> recovery in
> >> the event of failure is challenging.
> >>
> >> In order to demonstrate the race condition that this series fixes, you
> >> can use the following commands:
> >>
> >> while true; do cat /sys/fs/selinux/class/service/perms/status
> >>> /dev/null; done &
> >> while true; do load_policy; done;
> >>
> >> In the existing code, this will display errors fairly often as the class
> >> lookup fails.  (In normal operation from systemd, this would result in a
> >> permission check which would be allowed or denied based on policy
> >> settings
> >> around unknown object classes.) After applying this patch series you
> >> should expect to no longer see such error messages.
> >>
> >> Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
> >> ---
> >>   security/selinux/selinuxfs.c | 145 +++++++++++++++++++++++++++++------
> >>   1 file changed, 120 insertions(+), 25 deletions(-)
> >>
> >> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> >> index f09afdb90ddd..d3a19170210a 100644
> >> --- a/security/selinux/selinuxfs.c
> >> +++ b/security/selinux/selinuxfs.c
> >> +    tmp_policycap_dir = sel_make_dir(tmp_parent, POLICYCAP_DIR_NAME,
> >> &fsi->last_ino);
> >> +    if (IS_ERR(tmp_policycap_dir)) {
> >> +        ret = PTR_ERR(tmp_policycap_dir);
> >> +        goto out;
> >> +    }
> >
> > No need to re-create this one.
> >
> >> -    return 0;
> >> +    // booleans
> >> +    old_dentry = fsi->bool_dir;
> >> +    lock_rename(tmp_bool_dir, old_dentry);
> >> +    ret = vfs_rename(tmp_parent->d_inode, tmp_bool_dir,
> >> fsi->sb->s_root->d_inode,
> >> +             fsi->bool_dir, NULL, RENAME_EXCHANGE);
> >
> > One issue with using vfs_rename() is that it will trigger all of the
> > permission checks associated with renaming, and previously this was
> > never required for selinuxfs and therefore might not be allowed in
> > some policies even to a process allowed to reload policy.  So if you
> > need to do this, you may want to override creds around this call to
> > use the init cred (which will still require allowing it to the kernel
> > domain but not necessarily to the process that is performing the
> > policy load).  The other issue is that you then have to implement a
> > rename inode operation and thus technically it is possible for
> > userspace to also attempt renames on selinuxfs to the extent allowed
> > by policy.  I see that debugfs has a debugfs_rename() that internally
> > uses simple_rename() but I guess that doesn't cover the
> > RENAME_EXCHANGE case.
>
> Those are good points.  Do you see any problems with just calling
> d_exchange() directly?  It seems to work fine in very limited initial
> testing on my end. That should hopefully address all the problems you
> mentioned here.

I was hoping the vfs folks would chime in but you may have to pose a
more direct question to viro and linux-fsdevel to get a response.
Possibly there should be a lower-level vfs helper that could be used
internally by vfs_rename() and by things like debugfs_rename and a
potential selinuxfs_rename.
