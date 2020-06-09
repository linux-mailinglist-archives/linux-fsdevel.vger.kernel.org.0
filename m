Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1021F403E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 18:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbgFIQGc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 12:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgFIQGb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:06:31 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1E2C05BD1E;
        Tue,  9 Jun 2020 09:06:31 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q24so1610242pjd.1;
        Tue, 09 Jun 2020 09:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=upznzRicK8bM+0r52vYWA7QwfS1xzU69CxHqlLRTRT8=;
        b=KuEo119dEbSH3exz0jF0e8zqicmIaCh+YGX2E4EY+i1/6f/MjNk0NTfdXnmRdoB3fV
         5rvusnAbcLW6fNepzSlZtL6hDgUjk7wts7aXKSE+jMl79phrlhlfaeHVld8hHQl9SDxg
         ffmnvGdGFgVoyaTJW7LzcT5wq0UcIuw+h+5K5FVlVDuZzgIqpGPI3IgLImd2pnMi7Az8
         WL/Pft2eN0DAgbl8nQLXxMYxFaUGmByGHOB3WNC313KOqrAbO1aHd8+nYlXjRejU73JX
         MG5pzQadrtn9+SBYzQ+O9w+caRrnkct9jb/fFPvDTwQ53JPu/1RuGDbknFMrvt3kmGCe
         io6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=upznzRicK8bM+0r52vYWA7QwfS1xzU69CxHqlLRTRT8=;
        b=BCGSw0m6Hu0UVJbPLnFgVUKvT/xrLiMM+/jd9SHOGlyHCWMWMAFakdcAb8C93K7J70
         RqtvvfvbHIBtLd7U7MhmXmeQDVWKT5Tsj+QRQ/JR3LFbEUblK7W/NXPKmsLq2Nt+mi3/
         oViQsINvxuml5nH5YvI1cvRLuZR00mz/31MjgJhfyc9FFOPlUj5dILXaGRZpAriIHAoi
         1KK0nubXHNCq26t9AKJZSLL6kqd1qZc3+hsvNmeC8xxt0a1zz+CN9K9tuh+pshHe4fWR
         f7RDm9zOK2ZdAzO16ijfz1SVMuZHyaM8tjj89rbsz2Bb3on7IyCSmvrETYPwn+e9Jyjw
         IHuQ==
X-Gm-Message-State: AOAM532EWTXvFIAR/GyFYtQlV1NXfhILqXl2/KgwOr2uzrEC0BijcX3R
        hO3NF29voiaxsjenv06SP6Q=
X-Google-Smtp-Source: ABdhPJyGG/L+JbnZTjPqIo6VUQfhl2FG2eSEfmVoYEKAPqVGHsvE+qBcAJRzZy7GEB8sKMFZ1semqQ==
X-Received: by 2002:a17:90a:e398:: with SMTP id b24mr5519607pjz.235.1591718790609;
        Tue, 09 Jun 2020 09:06:30 -0700 (PDT)
Received: from gmail.com ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id e26sm9221419pgl.27.2020.06.09.09.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 09:06:29 -0700 (PDT)
Date:   Tue, 9 Jun 2020 09:06:27 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] capabilities: Introduce CAP_CHECKPOINT_RESTORE
Message-ID: <20200609160627.GA163855@gmail.com>
References: <20200603162328.854164-1-areber@redhat.com>
 <20200603162328.854164-2-areber@redhat.com>
 <20200609034221.GA150921@gmail.com>
 <20200609074422.burwzfgwgqqysrzh@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20200609074422.burwzfgwgqqysrzh@wittgenstein>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 09, 2020 at 09:44:22AM +0200, Christian Brauner wrote:
> On Mon, Jun 08, 2020 at 08:42:21PM -0700, Andrei Vagin wrote:
> > On Wed, Jun 03, 2020 at 06:23:26PM +0200, Adrian Reber wrote:
> > > This patch introduces CAP_CHECKPOINT_RESTORE, a new capability facilitating
> > > checkpoint/restore for non-root users.
> > > 
> > > Over the last years, The CRIU (Checkpoint/Restore In Userspace) team has been
> > > asked numerous times if it is possible to checkpoint/restore a process as
> > > non-root. The answer usually was: 'almost'.
> > > 
> > > The main blocker to restore a process as non-root was to control the PID of the
> > > restored process. This feature available via the clone3 system call, or via
> > > /proc/sys/kernel/ns_last_pid is unfortunately guarded by CAP_SYS_ADMIN.
> > > 
> > > In the past two years, requests for non-root checkpoint/restore have increased
> > > due to the following use cases:
> > > * Checkpoint/Restore in an HPC environment in combination with a resource
> > >   manager distributing jobs where users are always running as non-root.
> > >   There is a desire to provide a way to checkpoint and restore long running
> > >   jobs.
> > > * Container migration as non-root
> > > * We have been in contact with JVM developers who are integrating
> > >   CRIU into a Java VM to decrease the startup time. These checkpoint/restore
> > >   applications are not meant to be running with CAP_SYS_ADMIN.
> > > 
> > ...
> > > 
> > > The introduced capability allows to:
> > > * Control PIDs when the current user is CAP_CHECKPOINT_RESTORE capable
> > >   for the corresponding PID namespace via ns_last_pid/clone3.
> > > * Open files in /proc/pid/map_files when the current user is
> > >   CAP_CHECKPOINT_RESTORE capable in the root namespace, useful for recovering
> > >   files that are unreachable via the file system such as deleted files, or memfd
> > >   files.
> > 
> > PTRACE_O_SUSPEND_SECCOMP is needed for C/R and it is protected by
> > CAP_SYS_ADMIN too.
> 
> This is currently capable(CAP_SYS_ADMIN) (init_ns capable) why is it
> safe to allow unprivileged users to suspend security policies? That
> sounds like a bad idea.

Why do you think so bad about me;). I don't suggest to remove or
downgrade this capability check. The patch allows all c/r related
operations if the current has CAP_CHECKPOINT_RESTORE.

So in this case the check:
     if (!capable(CAP_SYS_ADMIN))
             return -EPERM;

will be converted in:
     if (!capable(CAP_SYS_ADMIN) && !capable(CAP_CHECKPOINT_RESTORE))
             return -EPERM;

If we want to think about how to convert this capable to ns_capable, we
need to do this in a separate series. And the logic may be that a
process is able to suspend only filters that have been added from the
current user-namespace or its descendants. But we need to think about
this more carefully, maybe there are more pitfalls.
