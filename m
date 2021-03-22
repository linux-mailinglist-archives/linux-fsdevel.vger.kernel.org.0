Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D82344B53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 17:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhCVQ33 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 12:29:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57234 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhCVQ27 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:28:59 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lONQG-00082c-Mx; Mon, 22 Mar 2021 16:28:56 +0000
Date:   Mon, 22 Mar 2021 17:28:55 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] unprivileged fanotify listener
Message-ID: <20210322162855.mz7h2hvececu4rma@wittgenstein>
References: <20210317114207.GB2541@quack2.suse.cz>
 <CAOQ4uxi7ZXJW3_6SN=vw_XJC+wy4eMTayN6X5yRy_HOV6323MA@mail.gmail.com>
 <20210317174532.cllfsiagoudoz42m@wittgenstein>
 <CAOQ4uxjCjapuAHbYuP8Q_k0XD59UmURbmkGC1qcPkPAgQbQ8DA@mail.gmail.com>
 <20210318143140.jxycfn3fpqntq34z@wittgenstein>
 <CAOQ4uxiRHwmxTKsLteH_sBW_dSPshVE8SohJYEmpszxaAwjEyg@mail.gmail.com>
 <20210319134043.c2wcpn4lbefrkhkg@wittgenstein>
 <CAOQ4uxhLYdWOUmpWP+c_JzVeGDbkJ5eUM+1-hhq7zFq23g5J1g@mail.gmail.com>
 <CAOQ4uxhetKeEZX=_iAcREjibaR0ZcOdeZyR8mFEoHM+WRsuVtg@mail.gmail.com>
 <CAOQ4uxhfx012GtvXMfiaHSk1M7+gTqkz3LsT0i_cHLnZLMk8nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhfx012GtvXMfiaHSk1M7+gTqkz3LsT0i_cHLnZLMk8nw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 02:44:20PM +0200, Amir Goldstein wrote:
> On Sat, Mar 20, 2021 at 2:57 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > > > > The code that sits in linux-next can give you pretty much a drop-in
> > > > > replacement of inotify and nothing more. See example code:
> > > > > https://github.com/amir73il/inotify-tools/commits/fanotify_name_fid
> > > >
> > > > This is really great. Thank you for doing that work this will help quite
> > > > a lot of use-cases and make things way simpler. I created a TODO to port
> > > > our path-hotplug to this once this feature lands.
> > > >
> > >
> > > FWIW, I just tried to build this branch on Ubuntu 20.04.2 with LTS kernel
> > > and there were some build issues, so rebased my branch on upstream
> > > inotify-tools to fix those build issues.
> > >
> > > I was not aware that the inotify-tools project is alive, I never intended
> > > to upstream this demo code and never created a github pull request
> > > but rebasing on upstream brought in some CI scripts, when I pushed the
> > > branch to my github it triggered some tests that reported build failures on
> > > Ubuntu 16.04 and 18.04.
> > >
> > > Anyway, there is a pre-rebase branch 'fanotify_name' and the post rebase
> > > branch 'fanotify_name_fid'. You can try whichever works for you.
> 
> FYI, fixed the CI build errors on fanotify_name_fid branch.
> 
> > >
> > > You can look at the test script src/test_demo.sh for usage example.
> > > Or just cd into a writable directory and run the script to see the demo.
> > > The demo determines whether to use a recursive watch or "global"
> > > watch by the uid of the user.
> > >
> > > > >
> > > > > > > If you think that is useful and you want to play with this feature I can
> > > > > > > provide a WIP branch soon.
> > > > > >
> > > > > > I would like to first play with the support for unprivileged fanotify
> > > > > > but sure, it does sound useful!
> > > > >
> > > > > Just so you have an idea what I am talking about, this is a very early
> > > > > POC branch:
> > > > > https://github.com/amir73il/linux/commits/fanotify_userns
> > > >
> > > > Thanks!  I'll try to pull this and take a look next week. I hope that's
> > > > ok.
> > > >
> > >
> > > Fine. I'm curious to know what it does.
> > > Did not get to test it with userns yet :)
> >
> > Now tested FAN_MARK_FILESYSTEM watch on tmpfs mounted
> > inside userns and works fine, with two wrinkles I needed to iron:
> >
> > 1. FAN_REPORT_FID not supported on tmpfs because tmpfs has
> >     zero f_fsid (easy to fix)
> > 2. open_by_handle_at() is not userns aware (can relax for
> >     FS_USERNS_MOUNT fs)
> >
> > Pushed these two fixes to branch fanotify_userns.
> 
> Pushed another fix to mnt refcount bug in WIP and another commit to
> add the last piece that could make fanotify usable for systemd-homed
> setup - a filesystem watch filtered by mnt_userns (not tested yet).

Sounds interesting.

So I'm looking and commenting on that branch a little.
One general question, when fanotify FANOTIFY_PERM_EVENTS is set fanotify
will return a file descriptor (for relevant events) referring to the
file/directory that e.g. got created. And there are no permissions
checks other than the capable(CAP_SYS_ADMIN) check when the fanotify
instance is created, right?

> 
> One thing I am struggling with is the language to describe user ns
> and idmapped mounts related logic. I have a feeling that I am getting
> the vocabulary all wrong. See my commit message text below.

The lingo seems legit. :)

I need some time thinking about the concepts to convince myself that
this is safe. But I like the direction as this is going to be really
useful.

Christian
