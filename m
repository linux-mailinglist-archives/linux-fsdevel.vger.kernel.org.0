Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52495163768
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 00:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgBRXn0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 18:43:26 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35388 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726427AbgBRXn0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:43:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DE16B8EE3CD;
        Tue, 18 Feb 2020 15:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582069404;
        bh=qKODKN4w6qAPCaVhwbDT/vEuMm2E8cKIzmNkd6YK2Ks=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=l17eBV5a9kYFQ3ULtsb8DRfp6QsTqKY6/tbmNzXSaPMgsnKtC3joCO88WX1xGXykP
         xrxxL+FzKufNue40Lnt0BQwgA4j2FomT3pybl8wWPEi/fJDSi9self6qG/6b31DmdZ
         uQjHYZDQ3D+CmUUcHlOb/0TMX5IA+N/7PZLTVXmU=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zIPbXN0w4kOM; Tue, 18 Feb 2020 15:43:22 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B5D5F8EE0D5;
        Tue, 18 Feb 2020 15:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582069400;
        bh=qKODKN4w6qAPCaVhwbDT/vEuMm2E8cKIzmNkd6YK2Ks=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nw712nKolPR5law7ojWVknyk2jZ9vy2ObBetzp5el1U26jCduv2BP7mgHtdAo6CVK
         SPRokUvJeOEmozuZXc5TO4+Oq/x5dC088r9bLt82j4zgMHNh62PCe2eBysz63XCu/n
         fHpqrZAUXbiD3yeYWY4hdb6070I3ZOUM460yHGAY=
Message-ID: <1582069398.16681.53.camel@HansenPartnership.com>
Subject: Re: [PATCH v3 0/3] introduce a uid/gid shifting bind mount
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux Containers <containers@lists.linux-foundation.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>, stgraber@ubuntu.com
Date:   Tue, 18 Feb 2020 15:43:18 -0800
In-Reply-To: <20200218200341.tzrehiapskznovx5@wittgenstein>
References: <20200217205307.32256-1-James.Bottomley@HansenPartnership.com>
         <CAOQ4uxjtp7d_xL20pGwvbFKqgAbyQhE=Pbw+e9Kj24wqF2hPfQ@mail.gmail.com>
         <1582042260.3416.19.camel@HansenPartnership.com>
         <20200218172606.ohlj6prhpmhodzqu@wittgenstein>
         <1582052748.16681.34.camel@HansenPartnership.com>
         <20200218200341.tzrehiapskznovx5@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-02-18 at 21:03 +0100, Christian Brauner wrote:
> On Tue, Feb 18, 2020 at 11:05:48AM -0800, James Bottomley wrote:
> > On Tue, 2020-02-18 at 18:26 +0100, Christian Brauner wrote:
[...]
> > > But way more important: what Amir got right is that your approach
> > > and fsid mappings don't stand in each others way at all. Shiftfed
> > > bind-mounts can be implemented completely independent of fsid
> > > mappings after the fact on top of it.
> > > 
> > > Your example, does this:
> > > 
> > > nsfd = open("/proc/567/ns/user", O_RDONLY);  /* note: not O_PATH
> > > */
> > > configfd_action(fd, CONFIGFD_SET_FD, "ns", NULL, nsfd);
> > > 
> > > as the ultimate step. Essentially marking a mountpoint as shifted
> > > relative to that user namespace. Once fsid mappings are in all
> > > that you need to do is replace your
> > > make_kuid()/from_kuid()/from_kuid_munged() calls and so on in
> > > your patchset with
> > > make_kfsuid()/from_kfsuid()/from_kfsuid_munged() and you're done.
> > > So I honestly don't currently see any need to block the patchsets
> > > on each other. 
> > 
> > Can I repeat: there's no rush to get upstream on this.  Let's pause
> > to get the kernel implementation (the thing we have to maintain)
> > right.  I realise we could each work around the other and get our
> > implementations bent around each other so they all work
> > independently thus making our disjoint user cabals happy but I
> > don't think that would lead to the best outcome for kernel
> > maintainability.
> 
> We have had the discussion with all major stakeholders in a single
> room on what we need at LPC 2019.

Well, you didn't invite me, so I think "stakeholders" means people we
selected because we like their use case.  More importantly:
"stakeholders" traditionally means not only people who want to consume
the feature but also people who have to maintain it ... how many VFS
stakeholders were present?

>  We agreed on what we need and fsids are a concrete proposal for an
> implementation that appears to solve all discussed major use-cases in
> a simple and elegant manner, which can also be cleanly extended to
> cover your approach later.  Imho, there is no need to have the same
> discussion again at an invite-only event focussed on kernel
> developers where most of the major stakeholders are unlikely to be
> able to participate. The patch proposals are here on all relevant
> list where everyone can participate and we can discuss them right
> here. I have not yet heard a concrete technical reason why the patch
> proposal is inadequate and I see no reason to stall this.

You cut the actual justification I gave: tacking together ad hoc
solutions for particular interests has already lead to a proliferation
of similar but not quite user_ns captures spreading through the vfs.  I
didn't say don't do it this way ... all I said was let's get clear what
we are doing and lets put together a shifting infrastructure that's
clean, easy to understand and reason about in security terms and which
can be used to implement all our use cases ... including s_user_ns. 
And when we've done this, lets eject any of the ad hoc stuff we find we
don't need to make the whole thing simpler.

> > I already think that history shows us that s_user_ns went upstream
> > too fast and the fact that unprivileged fuse has yet to make it
> > (and the
> 
> We've established on the other patchset that fsid mappings in no way
> interfere nor care about s_user_ns so I'm not going to go into this
> again here. But for the record, unprivileged fuse mounts are
> supported since:

I know, but I'm taking the opposite view: not caring about the other
uses and working around them has lead to the ad hoc userns creep we see
today and I think we need to roll it back to a consistent and easy to
reason about implementation.

> commit 4ad769f3c346ec3d458e255548dec26ca5284cf6
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Tue May 29 09:04:46 2018 -0500
> 
>     fuse: Allow fully unprivileged mounts

I know the patch is there ... I just haven't found any users yet, so I
think there's still something else missing.   This is really Seth's
baby so I was hoping he'd have ideas about what.

James

