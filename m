Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69BC1164964
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 17:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgBSQBZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 11:01:25 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37009 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgBSQBZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 11:01:25 -0500
Received: from mail-lf1-f49.google.com ([209.85.167.49])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <stgraber@ubuntu.com>)
        id 1j4Rms-0000b7-Gk
        for linux-fsdevel@vger.kernel.org; Wed, 19 Feb 2020 16:01:22 +0000
Received: by mail-lf1-f49.google.com with SMTP id m30so516522lfp.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2020 08:01:22 -0800 (PST)
X-Gm-Message-State: APjAAAXahdPzAExhYkK9wjmKOAkRqPmB6waSpGI0gQ9hnfwX3i2Tj7/j
        q4cZ9Ko+SN1LkI2yKLDefDtuUXeBS4wPC0zMAIHqJA==
X-Google-Smtp-Source: APXvYqz0Vm+z3EPXlndKr5UO176ZHWvmavasGPsbN44tgf4I3iFqzbvdUawaCfZcYGeIKv77F1XN5A+6MmtC4CM8Mo4=
X-Received: by 2002:a19:cc07:: with SMTP id c7mr14066596lfg.177.1582128081757;
 Wed, 19 Feb 2020 08:01:21 -0800 (PST)
MIME-Version: 1.0
References: <20200217205307.32256-1-James.Bottomley@HansenPartnership.com>
 <CAOQ4uxjtp7d_xL20pGwvbFKqgAbyQhE=Pbw+e9Kj24wqF2hPfQ@mail.gmail.com>
 <1582042260.3416.19.camel@HansenPartnership.com> <20200218172606.ohlj6prhpmhodzqu@wittgenstein>
 <1582052748.16681.34.camel@HansenPartnership.com> <20200218200341.tzrehiapskznovx5@wittgenstein>
 <1582069398.16681.53.camel@HansenPartnership.com>
In-Reply-To: <1582069398.16681.53.camel@HansenPartnership.com>
From:   =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>
Date:   Wed, 19 Feb 2020 11:01:10 -0500
X-Gmail-Original-Message-ID: <CA+enf=vcw=wvhLU0H+Y4fhkhKDsUQnqHPv0Nngx8_mdom2T6TQ@mail.gmail.com>
Message-ID: <CA+enf=vcw=wvhLU0H+Y4fhkhKDsUQnqHPv0Nngx8_mdom2T6TQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] introduce a uid/gid shifting bind mount
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux Containers <containers@lists.linux-foundation.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 6:43 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2020-02-18 at 21:03 +0100, Christian Brauner wrote:
> > On Tue, Feb 18, 2020 at 11:05:48AM -0800, James Bottomley wrote:
> > > On Tue, 2020-02-18 at 18:26 +0100, Christian Brauner wrote:
> [...]
> > > > But way more important: what Amir got right is that your approach
> > > > and fsid mappings don't stand in each others way at all. Shiftfed
> > > > bind-mounts can be implemented completely independent of fsid
> > > > mappings after the fact on top of it.
> > > >
> > > > Your example, does this:
> > > >
> > > > nsfd = open("/proc/567/ns/user", O_RDONLY);  /* note: not O_PATH
> > > > */
> > > > configfd_action(fd, CONFIGFD_SET_FD, "ns", NULL, nsfd);
> > > >
> > > > as the ultimate step. Essentially marking a mountpoint as shifted
> > > > relative to that user namespace. Once fsid mappings are in all
> > > > that you need to do is replace your
> > > > make_kuid()/from_kuid()/from_kuid_munged() calls and so on in
> > > > your patchset with
> > > > make_kfsuid()/from_kfsuid()/from_kfsuid_munged() and you're done.
> > > > So I honestly don't currently see any need to block the patchsets
> > > > on each other.
> > >
> > > Can I repeat: there's no rush to get upstream on this.  Let's pause
> > > to get the kernel implementation (the thing we have to maintain)
> > > right.  I realise we could each work around the other and get our
> > > implementations bent around each other so they all work
> > > independently thus making our disjoint user cabals happy but I
> > > don't think that would lead to the best outcome for kernel
> > > maintainability.
> >
> > We have had the discussion with all major stakeholders in a single
> > room on what we need at LPC 2019.
>
> Well, you didn't invite me, so I think "stakeholders" means people we
> selected because we like their use case.  More importantly:
> "stakeholders" traditionally means not only people who want to consume
> the feature but also people who have to maintain it ... how many VFS
> stakeholders were present?
>
> >  We agreed on what we need and fsids are a concrete proposal for an
> > implementation that appears to solve all discussed major use-cases in
> > a simple and elegant manner, which can also be cleanly extended to
> > cover your approach later.  Imho, there is no need to have the same
> > discussion again at an invite-only event focussed on kernel
> > developers where most of the major stakeholders are unlikely to be
> > able to participate. The patch proposals are here on all relevant
> > list where everyone can participate and we can discuss them right
> > here. I have not yet heard a concrete technical reason why the patch
> > proposal is inadequate and I see no reason to stall this.
>
> You cut the actual justification I gave: tacking together ad hoc
> solutions for particular interests has already lead to a proliferation
> of similar but not quite user_ns captures spreading through the vfs.  I
> didn't say don't do it this way ... all I said was let's get clear what
> we are doing and lets put together a shifting infrastructure that's
> clean, easy to understand and reason about in security terms and which
> can be used to implement all our use cases ... including s_user_ns.
> And when we've done this, lets eject any of the ad hoc stuff we find we
> don't need to make the whole thing simpler.
>
> > > I already think that history shows us that s_user_ns went upstream
> > > too fast and the fact that unprivileged fuse has yet to make it
> > > (and the
> >
> > We've established on the other patchset that fsid mappings in no way
> > interfere nor care about s_user_ns so I'm not going to go into this
> > again here. But for the record, unprivileged fuse mounts are
> > supported since:
>
> I know, but I'm taking the opposite view: not caring about the other
> uses and working around them has lead to the ad hoc userns creep we see
> today and I think we need to roll it back to a consistent and easy to
> reason about implementation.
>
> > commit 4ad769f3c346ec3d458e255548dec26ca5284cf6
> > Author: Eric W. Biederman <ebiederm@xmission.com>
> > Date:   Tue May 29 09:04:46 2018 -0500
> >
> >     fuse: Allow fully unprivileged mounts
>
> I know the patch is there ... I just haven't found any users yet, so I
> think there's still something else missing.   This is really Seth's
> baby so I was hoping he'd have ideas about what.

I'm confused by that part, we have hundreds of thousands of users of
this feature
and it's been backported to older kernels on a number of platforms due
to its usefulness.

It's what's used for installing/running snap packages inside Ubuntu containers,
it's also quite widely used inside Terminal/Crostini on Chromebooks,
performs transparent unprivileged mounts on Travis-CI and is also used by
some of the rootless runtimes to allow for mounting overlayfs, squashfs or
even ext* inside unprivileged containers.

It's certainly not something that's super user visible, it also
doesn't need any particular
support for it to work, just use fuse as usual inside an unprivileged container.
So the lack of noise about it doesn't necessarily indicate that it's not used,
it may just indicate that it's been working as intended :)

> James
>
