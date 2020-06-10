Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFB11F5826
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 17:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbgFJPtB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 11:49:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43498 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgFJPtB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:49:01 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jj2xu-0004Hc-Jb; Wed, 10 Jun 2020 15:48:34 +0000
Date:   Wed, 10 Jun 2020 17:48:33 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Andrei Vagin <avagin@gmail.com>, Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
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
Message-ID: <20200610154833.mb6sypc5dl4yhhe3@wittgenstein>
References: <20200603162328.854164-1-areber@redhat.com>
 <20200603162328.854164-2-areber@redhat.com>
 <20200609034221.GA150921@gmail.com>
 <20200609074422.burwzfgwgqqysrzh@wittgenstein>
 <20200609160627.GA163855@gmail.com>
 <20200609161427.4eoozs3kkgablmaa@wittgenstein>
 <20200610075928.GA172301@gmail.com>
 <37b47c7d-a24e-c453-5168-c383e6c36c9f@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37b47c7d-a24e-c453-5168-c383e6c36c9f@schaufler-ca.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 10, 2020 at 08:41:29AM -0700, Casey Schaufler wrote:
> 
> On 6/10/2020 12:59 AM, Andrei Vagin wrote:
> > On Tue, Jun 09, 2020 at 06:14:27PM +0200, Christian Brauner wrote:
> >> On Tue, Jun 09, 2020 at 09:06:27AM -0700, Andrei Vagin wrote:
> >>> On Tue, Jun 09, 2020 at 09:44:22AM +0200, Christian Brauner wrote:
> >>>> On Mon, Jun 08, 2020 at 08:42:21PM -0700, Andrei Vagin wrote:
> > ...
> >>>>> PTRACE_O_SUSPEND_SECCOMP is needed for C/R and it is protected by
> >>>>> CAP_SYS_ADMIN too.
> >>>> This is currently capable(CAP_SYS_ADMIN) (init_ns capable) why is it
> >>>> safe to allow unprivileged users to suspend security policies? That
> >>>> sounds like a bad idea.
> > ...
> >>> I don't suggest to remove or
> >>> downgrade this capability check. The patch allows all c/r related
> >>> operations if the current has CAP_CHECKPOINT_RESTORE.
> >>>
> >>> So in this case the check:
> >>>      if (!capable(CAP_SYS_ADMIN))
> >>>              return -EPERM;
> >>>
> >>> will be converted in:
> >>>      if (!capable(CAP_SYS_ADMIN) && !capable(CAP_CHECKPOINT_RESTORE))
> >>>              return -EPERM;
> >> Yeah, I got that but what's the goal here? Isn't it that you want to
> >> make it safe to install the criu binary with the CAP_CHECKPOINT_RESTORE
> >> fscap set so that unprivileged users can restore their own processes
> >> without creating a new user namespace or am I missing something? The
> >> use-cases in the cover-letter make it sound like that's what this is
> >> leading up to:
> >>>>>> * Checkpoint/Restore in an HPC environment in combination with a resource
> >>>>>>   manager distributing jobs where users are always running as non-root.
> >>>>>>   There is a desire to provide a way to checkpoint and restore long running
> >>>>>>   jobs.
> >>>>>> * Container migration as non-root
> >>>>>> * We have been in contact with JVM developers who are integrating
> >>>>>>   CRIU into a Java VM to decrease the startup time. These checkpoint/restore
> >>>>>>   applications are not meant to be running with CAP_SYS_ADMIN.
> >> But maybe I'm just misunderstanding crucial bits (likely (TM)).
> > I think you understand this right. The goal is to make it possible to
> > use C/R functionality for unprivileged processes.
> 
> Y'all keep saying "unprivileged processes" when you mean
> "processes with less than root privilege". A process with
> CAP_CHECKPOINT_RESTORE *is* a privileged process. It would

That was me being imprecise. What I mean is "unprivileged user"
not "unprivileged process". It makes me a little uneasy that an
unprivileged _user_ can call the criu binary with the
CAP_CHECKPOINT_RESTORE fscap set and suspend seccomp of a process (Which
is what my original question here was about). Maybe this is paranoia but
shouldn't suspending _security_ mechanisms be kept either under
CAP_SYS_ADMIN or CAP_MAC_ADMIN?

Christian
