Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0769E134A91
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 19:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgAHSmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 13:42:13 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:44664 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbgAHSmN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 13:42:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8A2B28EE0CE;
        Wed,  8 Jan 2020 10:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1578508932;
        bh=sTQNuh8yETuFhSa7cYxn6uU9M8YRrujDX7YTGB04J88=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uJ4aLdp44Rak2+Grzl7P91JJpH5oQcTDTZUZuyeQ/8/GaxaXu7zZFv2ObvwHDUVOi
         KkjN9I+UfA1lJIdbMzn4pG2/cQBsTq2LPY017Ul4FyUaRX3hZgvMkV246h/nzIRy6k
         8HtIZvBGUVLNf37B2MN/gjLYyU1wrksLVPfsjkTg=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9ujHps82lEo6; Wed,  8 Jan 2020 10:42:12 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4BB138EE079;
        Wed,  8 Jan 2020 10:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1578508932;
        bh=sTQNuh8yETuFhSa7cYxn6uU9M8YRrujDX7YTGB04J88=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uJ4aLdp44Rak2+Grzl7P91JJpH5oQcTDTZUZuyeQ/8/GaxaXu7zZFv2ObvwHDUVOi
         KkjN9I+UfA1lJIdbMzn4pG2/cQBsTq2LPY017Ul4FyUaRX3hZgvMkV246h/nzIRy6k
         8HtIZvBGUVLNf37B2MN/gjLYyU1wrksLVPfsjkTg=
Message-ID: <1578508929.3260.61.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 0/6] introduce configfd as generalisation of fsconfig
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Date:   Wed, 08 Jan 2020 10:42:09 -0800
In-Reply-To: <20200108170703.zhcuohzdp22y5yma@wittgenstein>
References: <20200104201432.27320-1-James.Bottomley@HansenPartnership.com>
         <20200105162311.sufgft6kthetsz7q@wittgenstein>
         <1578247328.3310.36.camel@HansenPartnership.com>
         <20200108170703.zhcuohzdp22y5yma@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-01-08 at 18:07 +0100, Christian Brauner wrote:
> [extending the Cc a bit]
> 
> On Sun, Jan 05, 2020 at 10:02:08AM -0800, James Bottomley wrote:
> > On Sun, 2020-01-05 at 17:23 +0100, Christian Brauner wrote:
> > > On Sat, Jan 04, 2020 at 12:14:26PM -0800, James Bottomley wrote:
> > > > fsconfig is a very powerful configuration mechanism except that
> > > > it only works for filesystems with superblocks.  This patch
> > > > series generalises the useful concept of a multiple step
> > > > configurationalmechanism carried by a file descriptor.  The
> > > > object of this patch series is to get bind mounts to be
> > > > configurable in the same way that superblock based ones are,
> > > > but it should have utility beyond the filesytem realm.  Patch 4
> > > > also reimplements fsconfig in terms of configfd, but that's not
> > > > a strictly necessary patch, it is merely a useful demonstration
> > > > that configfd is a superset of the properties of fsconfig.
> > > 
> > > Thanks for the patch. I'm glad fsconfig() is picked back up;
> > > either by you or by David. We will need this for sure.
> > > But the configfd approach does not strike me as a great idea.
> > > Anonymous inode fds provide an abstraction mechanism for kernel
> > > objects which we built around fds such as timerfd, pidfd, mountfd
> > > and so on. When you stat an anonfd you get ANON_INODE_FS_MAGIC
> > > and you get the actual type by looking at fdinfo, or - more
> > > common - by parsing out /proc/<pid>/fd/<nr> and discovering
> > > "[fscontext]". So it's already a pretty massive abstraction layer
> > > we have. But configfd would be yet another fd abstraction based
> > > on anonfds.  The idea has been that a new fd type based on
> > > anonfds comes with an api specific to that type of fd. That seems
> > > way nicer from an api design perspective than implementing new
> > > apis as part of yet another generic configfd layer.
> > 
> > Really, it's just a fd that gathers config information and can
> > reserve specific errors (and we should really work out the i18n
> > implications of
> 
> It's rather a complex multiplexer intended to go beyond the realm of
> filesystems/mount api and that's something we have been burned by
> before.
> 
> > the latter).  Whether it's a new fd type or an anonfd with a
> > specific name doesn't seem to be that significant, so the name
> > could be set by the type.
> > 
> > > Another problem is that these syscalls here would be massive
> > > multiplexing syscalls. If they are ever going to be used outside
> > > of filesystem use-cases (which is doubtful) they will quickly
> > > rival prctl(), seccomp(), and ptrace().
> > 
> > Actually, that's partly the point.  We do have several systemcalls
> > with
> 
> Actually I think that's the problem. The keyctl api itself suffers
> from the problem that it already has a complex multiplexer. That
> could either point to bad api design (sorry, David :)) or it's just a
> very complex use-case like the mount api.

I do really think it's a fairly pattern exact use case.  The mount API
has a complex per-fs-type configuration but simple use via the VFS
abstractions, which is why we use a single mount system call instead of
one system call per fs.  The keyctl API exactly mirrors this: creating
keys is complex and highly type dependent but once they're created
they're more generically usable.  This pattern replicates itself across
a lot of subsystems.  Storage being an excellent example.  Once we have
the things configured, we can hide most of the configurational
complexity behind a simple use API: the block abstraction.

And the point that annoys me as someone who has to interact with and
maintain a few of these systems is that we keep reinventing similar but
slightly different solutions for them all.

>  The good thing is that it's restricted to a single domain: keys. And
> that's good. Plumbing both e.g. keys and (parts of) mounts on top of
> another generic api is what strikes me as a bad idea.

Actually, I don't think this holds up to examination given the fact
that the pattern isn't specific to mount.  You can take the view that
the configfd approach is wrong ... but that would mean it's wrong for
the mount use case as well.  I have actually seen people advocate a
per-config type system call approach, but that always sank in the
plumbing complexity.  You could take the view that each problem is a
separate domain and needs a separate solution, which is essentially
what we do today but that solution then tends to leak (using netlink in
SCSI for instance).  We've also tried the configuration as filesystem
(that's the configfs one that iSCSI and USB gadget does) as an approach
to this.

I think the broader question is given the pattern is replicated across
subsystems, can we get a solution that works for all the patterns
instead of our current patchwork.  fsconfig has certain features that
make it an interesting solution.  It also has the problem that the way
its currently constructed means it doesn't apply to a part of its
design coverage (bind mounts).  Configfd was an attempt to extract the
generic part and apply it (initially just on the bit that the coverage
was missing for).

I don't disagree that configuration multiplexors are a user space
annoyance, but we put up with them because we get a simple and very
generic API for the configured object.  Given that they're a necessary
evil and a widespread pattern, I think examining the question of
whether we could cover them all with a single API and what properties
it should have is a useful one.

For instance, I think the cardinal annoying missing property in all our
above attempts is the lack of introspectability.  The inability to
enumerate what types and interfaces are available before you start
configuring.  Even configfs, which is our most introspectable one, has
that problem.

So given that we have to have things like this and they do get spread
widely, what are the desirable properties to make them more manageable?

The reason I liked fsconfig initially was error return: complex
configuration means complex errors and very few of our other solutions
have the ability to send them back.  The other was the observation that
even though fsconfig isn't introspectable, it could be made so.

James

