Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00223467A66
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 16:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381843AbhLCPla (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 10:41:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45418 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1381839AbhLCPl3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:41:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638545885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V+VJ5JlbIEyr1e3uqTsmZjyZeTTKiBCM30K4YPw1YD0=;
        b=IKFORxhPDrvUqcxflQatszWq8U4wStgEN2C18BtjpBPXgPJADNjuGNtpbztsJ+j9Qj72Nm
        /mrB1h/jwyLu9MtGce78d7cd4CU/HKvFqgpnab+/6YOCF+ZspXW4bGuHp9n/arU5DyjUYk
        aPHl5XP559k8bBd4wdlRZXFztf0wuqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-220-1JFi4bo7OCWr98heLdvL8g-1; Fri, 03 Dec 2021 10:38:02 -0500
X-MC-Unique: 1JFi4bo7OCWr98heLdvL8g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A74A310168C0;
        Fri,  3 Dec 2021 15:37:59 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1E6C5DAA5;
        Fri,  3 Dec 2021 15:37:58 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 61623225EC0; Fri,  3 Dec 2021 10:37:58 -0500 (EST)
Date:   Fri, 3 Dec 2021 10:37:58 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     David Anderson <dvander@google.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Stultz <john.stultz@linaro.org>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        kernel-team <kernel-team@android.com>, selinux@vger.kernel.org,
        paulmoore@microsoft.com, Luca.Boccassi@microsoft.com
Subject: Re: [PATCH v19 0/4] overlayfs override_creds=off & nested get xattr
 fix
Message-ID: <Yao51m9EXszPsxNN@redhat.com>
References: <20211117015806.2192263-1-dvander@google.com>
 <CAOQ4uxjjapFeOAFGLmsXObdgFVYLfNer-rnnee1RR+joxK3xYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjjapFeOAFGLmsXObdgFVYLfNer-rnnee1RR+joxK3xYg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 17, 2021 at 09:36:42AM +0200, Amir Goldstein wrote:
> On Wed, Nov 17, 2021 at 3:58 AM David Anderson <dvander@google.com> wrote:
> >
> > Mark Salyzyn (3):
> >   Add flags option to get xattr method paired to __vfs_getxattr
> >   overlayfs: handle XATTR_NOSECURITY flag for get xattr method
> >   overlayfs: override_creds=off option bypass creator_cred
> >
> > Mark Salyzyn + John Stultz (1):
> >   overlayfs: inode_owner_or_capable called during execv
> >
> > The first three patches address fundamental security issues that should
> > be solved regardless of the override_creds=off feature.
> >
> > The fourth adds the feature depends on these other fixes.
> >
> > By default, all access to the upper, lower and work directories is the
> > recorded mounter's MAC and DAC credentials.  The incoming accesses are
> > checked against the caller's credentials.
> >
> > If the principles of least privilege are applied for sepolicy, the
> > mounter's credentials might not overlap the credentials of the caller's
> > when accessing the overlayfs filesystem.  For example, a file that a
> > lower DAC privileged caller can execute, is MAC denied to the
> > generally higher DAC privileged mounter, to prevent an attack vector.
> >
> > We add the option to turn off override_creds in the mount options; all
> > subsequent operations after mount on the filesystem will be only the
> > caller's credentials.  The module boolean parameter and mount option
> > override_creds is also added as a presence check for this "feature",
> > existence of /sys/module/overlay/parameters/overlay_creds
> >
> > Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> > Signed-off-by: David Anderson <dvander@google.com>
> > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Cc: Eric W. Biederman <ebiederm@xmission.com>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Stephen Smalley <sds@tycho.nsa.gov>
> > Cc: John Stultz <john.stultz@linaro.org>
> > Cc: linux-doc@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-unionfs@vger.kernel.org
> > Cc: linux-security-module@vger.kernel.org
> > Cc: kernel-team@android.com
> > Cc: selinux@vger.kernel.org
> > Cc: paulmoore@microsoft.com
> > Cc: Luca.Boccassi@microsoft.com
> >
> > ---
> >
> > v19
> > - rebase.
> >
> 
> Hi David,
> 
> I see that the patch set has changed hands (presumably to Android upstreaming
> team), but you just rebased v18 without addressing the maintainers concerns [1].
> 

BTW, where is patch 1 of the series. I can't seem to find it.

I think I was running into issues with getxattr() on underlying filesystem
as well (if mounter did not have sufficient privileges) and tried to fix
it. But did not find a good solution at that point of time.

https://lore.kernel.org/linux-unionfs/1467733854-6314-6-git-send-email-vgoyal@redhat.com/

So basically when overlay inode is being initialized, code will try to
query "security.selinux" xattr on underlying file to initialize selinux
label on the overlay inode. For regular filesystems, they bypass the
security check by calling __vfs_getxattr() when trying to initialize
this selinux security label. But with layered filesystem, it still
ends up calling vfs_getxattr() on underlying filesyste. Which means
it checks for caller's creds and if caller is not priviliged enough,
access will be denied.

To solve this problem, looks like this patch set is passing a flag
XATTR_NOSECUROTY so that permission checks are skipped in getxattr()
path in underlying filesystem. As long as this information is
not leaked to user space (and remains in overlayfs), it probably is
fine? And if information is not going to user space, then it probably
is fine for unprivileged overlayfs mounts as well?

I see a comment from Miklos as well as you that it is not safe to
do for unprivileged mounts. Can you help me understand why that's
the case.


> Specifically, the patch 2/4 is very wrong for unprivileged mount and

Can you help me understand why it is wrong. (/me should spend more
time reading the patch. But I am taking easy route of asking you. :-)).

> I think that the very noisy patch 1/4 could be completely avoided:

How can it completely avoided. If mounter is not privileged then 
vfs_getxattr() on underlying filesystem will fail. Or if
override_creds=off, then caller might not be privileged enough to
do getxattr() but we still should be able to initialize overlay
inode security label. 

> Can't you use -o userxattr mount option

user xattrs done't work for device nodes and symlinks.

BTW, how will userxattr solve the problem completely. It can be used
to store overlay specific xattrs but accessing security xattrs on
underlying filesystem will still be a problem?

Thanks
Vivek

> for Android use case and limit
> the manipulation of user.ovrelay.* xattr based on sepolicy for actors
> that are allowed
> to make changes in overlayfs mount? or not limit at all?
> The access to those xattr is forbidden via "incoming" xattr ops on
> overlay inodes.
> 
> Also, IMO, the Documentation section about "Non overlapping credentials" does
> not hold the same standards as the section about "Permission model" -
> it does not
> state the requirements clear enough for my non-security-oriented brain to be
> able to understand if the "Ignore mounter's credentials" model can be exploited.
> 
> Can an unprivileged user create an overlay over a directory that they have
> access to and redirect an innocent looking file name to an underlying file that
> said the mounting user has no access to and by doing that, tricking a privileged
> user to modify the innocent looking file on the  mounter's behalf?
> Of course this could be avoided by forbidding unprivileged mount with
> override_creds=off, but there could be other scenarios, so a clear model
> would help to understand the risks.
> 
> For example:
> If user 1 was able to read in lower dir A, now the content of overlay dir A
> is cached and user 2, that has permissions to read upper dir A and does
> not have read permissions on lower dir A will see the content of lower dir A.
> 
> I think that the core problem with the approach is using Non-uniform
> credentials to access underlying layers. I don't see a simple way around
> a big audit that checks all those cases, but maybe I'm missing some quick
> shortcut or maybe your use case can add some restrictions about the
> users that could access this overlay that would simplify the generic problem.
> 
> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/linux-unionfs/CAJfpegtMoD85j5namV592sJD23QeUMD=+tq4SvFDqjVxsAszYQ@mail.gmail.com/
> 

