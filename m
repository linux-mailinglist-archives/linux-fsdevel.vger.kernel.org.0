Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2866616527D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 23:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgBSW0t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 17:26:49 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59444 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727775AbgBSW0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 17:26:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C0BE18EE3CD;
        Wed, 19 Feb 2020 14:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582151207;
        bh=HfjBNpD2Qt+GaWlMj21Bvlc2JIc3+sF9K8fSWDmjU3M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VlCn7xrsfg8oSw8PolLgzjv9NYhVLFlu3SwPcDfRI/uBgkrT/PuArbELzgAl8IeJZ
         /O/+WU/kEkcD21+xu1idY+w8gtAFQBt4DIFWK86SN5luHD8yK2I3VWLp+/CywLD76v
         IgWfF6+RN7QkEsdb5Dwf+FJ23znFC5DuwNJNiACs=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T7FVyGeyyMJP; Wed, 19 Feb 2020 14:26:47 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DBC208EE144;
        Wed, 19 Feb 2020 14:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582151207;
        bh=HfjBNpD2Qt+GaWlMj21Bvlc2JIc3+sF9K8fSWDmjU3M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VlCn7xrsfg8oSw8PolLgzjv9NYhVLFlu3SwPcDfRI/uBgkrT/PuArbELzgAl8IeJZ
         /O/+WU/kEkcD21+xu1idY+w8gtAFQBt4DIFWK86SN5luHD8yK2I3VWLp+/CywLD76v
         IgWfF6+RN7QkEsdb5Dwf+FJ23znFC5DuwNJNiACs=
Message-ID: <1582151205.3301.27.camel@HansenPartnership.com>
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
Date:   Wed, 19 Feb 2020 14:26:45 -0800
In-Reply-To: <20200219132603.ivuttlgzixis2y2f@wittgenstein>
References: <20200217205307.32256-1-James.Bottomley@HansenPartnership.com>
         <CAOQ4uxjtp7d_xL20pGwvbFKqgAbyQhE=Pbw+e9Kj24wqF2hPfQ@mail.gmail.com>
         <1582042260.3416.19.camel@HansenPartnership.com>
         <20200218172606.ohlj6prhpmhodzqu@wittgenstein>
         <1582052748.16681.34.camel@HansenPartnership.com>
         <20200218200341.tzrehiapskznovx5@wittgenstein>
         <1582069398.16681.53.camel@HansenPartnership.com>
         <20200219132603.ivuttlgzixis2y2f@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-02-19 at 14:26 +0100, Christian Brauner wrote:
> On Tue, Feb 18, 2020 at 03:43:18PM -0800, James Bottomley wrote:
> > On Tue, 2020-02-18 at 21:03 +0100, Christian Brauner wrote:
> > > On Tue, Feb 18, 2020 at 11:05:48AM -0800, James Bottomley wrote:
> > > > On Tue, 2020-02-18 at 18:26 +0100, Christian Brauner wrote:
> > 
> > [...]
> > > > > But way more important: what Amir got right is that your
> > > > > approach and fsid mappings don't stand in each others way at
> > > > > all. Shiftfed bind-mounts can be implemented completely
> > > > > independent of fsid mappings after the fact on top of it.
> > > > > 
> > > > > Your example, does this:
> > > > > 
> > > > > nsfd = open("/proc/567/ns/user", O_RDONLY);  /* note: not
> > > > > O_PATH
> > > > > */
> > > > > configfd_action(fd, CONFIGFD_SET_FD, "ns", NULL, nsfd);
> > > > > 
> > > > > as the ultimate step. Essentially marking a mountpoint as
> > > > > shifted relative to that user namespace. Once fsid mappings
> > > > > are in all that you need to do is replace your
> > > > > make_kuid()/from_kuid()/from_kuid_munged() calls and so on in
> > > > > your patchset with
> > > > > make_kfsuid()/from_kfsuid()/from_kfsuid_munged() and you're
> > > > > done. So I honestly don't currently see any need to block the
> > > > > patchsets on each other. 
> > > > 
> > > > Can I repeat: there's no rush to get upstream on this.  Let's
> > > > pause to get the kernel implementation (the thing we have to
> > > > maintain) right.  I realise we could each work around the other
> > > > and get our implementations bent around each other so they all
> > > > work independently thus making our disjoint user cabals happy
> > > > but I don't think that would lead to the best outcome for
> > > > kernel maintainability.
> > > 
> > > We have had the discussion with all major stakeholders in a
> > > single room on what we need at LPC 2019.
> > 
> > Well, you didn't invite me, so I think "stakeholders" means people
> > we
> 
> I'm confused as you were in the room with everyone. It's even on the
> schedule under your name:
> https://linuxplumbersconf.org/event/4/contributions/474/
> 
> > selected because we like their use case.  More importantly:
> > "stakeholders" traditionally means not only people who want to
> > consume the feature but also people who have to maintain it ... how
> > many VFS stakeholders were present?
> 
> Again, I'm confused you were in the room with at least David and
> Eric.

OK, I think we both got different things out of this, but I've now put
the videos for this on the LPC site so others can judge for themselves.
 The one for this session is here:

https://www.youtube.com/watch?v=LN2CUgp8deo&list=PLVsQ_xZBEyN30ZA3Pc9MZMFzdjwyz26dO&index=9&t=2h12m52s

Although it does make more sense if you watch the Dave Howells session
on the new mount API first:

https://www.youtube.com/watch?v=LN2CUgp8deo&list=PLVsQ_xZBEyN30ZA3Pc9MZMFzdjwyz26dO&index=9&t=1h45m54s

There is lots of discussion of the shared image use case, but nowhere
is there any discussion of separating uid from fsuid in the user
namespace, unless I missed it again in my second viewing?

> In any case, the patches are on the relevant lists. They are actively
> being discussed and visible to everyone and we'll have time for
> proper review which is already happening.

The big issue, though, is that while you've produced a patch set that
covers your use case (shared unprivileged images) it doesn't cover mine
(privileged images).  However, the patch set I produced does cover both
use cases.  Safely handling privileged images is a much bigger security
problem than unprivileged ones, which is why I have more VFS code than
you do.  While I could, in theory, remove your use case from my patch,
doing so would really only reduce it by 38 lines (this is the diffstat
going from v2 to v3).  However, I still need all the code in the v2
patch to handle the backshifts needed for safe privileged images and I
pretty much don't use any of the fsid code you add because I need an
unprivileged fsid and uid, so the shifts are always identical for both
... which is the default before your patch.

This is what I mean about us getting the VFS implementation correct:  I
think I can sweep up s_user_ns into my patch (unproven because I've yet
to write the patch), effectively making it use the mnt_userns I
introduced and eliminating the superblock additions and, for 38
additional VFS lines, I also pick up your use case ... although there
may be subtleties I've missed.

I also think the way I coded it is much easier to use for an
orchestration system.  Basically you create a user_ns for the unpacker,
rendering it unprivileged, and it unpacks your images into the
filesystem so they also become unprivileged and globally shifted.  Then
whenever you use these images for a container with a separate uid
shift, you pass the unpacker userns with the "ns" argument and bind
mount the root into the container's userns: the container gets fake
root and any writes by fake root are shifted correctly into the
unprivileged image.  Everything just works and there's no need to
bother with fsid's.

However, what's still not completely done by any of us is convincing
the VFS community that we've got the correct and maintainable way of
adding all this to their VFS layer.

James

