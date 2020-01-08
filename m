Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1991348D9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 18:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbgAHRJV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 12:09:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36501 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgAHRJV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:09:21 -0500
Received: from host.242.234.23.62.rev.coltfrance.com ([62.23.234.242] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ipEnM-00052V-PD; Wed, 08 Jan 2020 17:07:00 +0000
Date:   Wed, 8 Jan 2020 18:07:04 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v2 0/6] introduce configfd as generalisation of fsconfig
Message-ID: <20200108170703.zhcuohzdp22y5yma@wittgenstein>
References: <20200104201432.27320-1-James.Bottomley@HansenPartnership.com>
 <20200105162311.sufgft6kthetsz7q@wittgenstein>
 <1578247328.3310.36.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1578247328.3310.36.camel@HansenPartnership.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[extending the Cc a bit]

On Sun, Jan 05, 2020 at 10:02:08AM -0800, James Bottomley wrote:
> On Sun, 2020-01-05 at 17:23 +0100, Christian Brauner wrote:
> > On Sat, Jan 04, 2020 at 12:14:26PM -0800, James Bottomley wrote:
> > > fsconfig is a very powerful configuration mechanism except that it
> > > only works for filesystems with superblocks.  This patch series
> > > generalises the useful concept of a multiple step configurational
> > > mechanism carried by a file descriptor.  The object of this patch
> > > series is to get bind mounts to be configurable in the same way
> > > that superblock based ones are, but it should have utility beyond
> > > the filesytem realm.  Patch 4 also reimplements fsconfig in terms
> > > of configfd, but that's not a strictly necessary patch, it is
> > > merely a useful demonstration that configfd is a superset of the
> > > properties of fsconfig.
> > 
> > Thanks for the patch. I'm glad fsconfig() is picked back up; either
> > by you or by David. We will need this for sure.
> > But the configfd approach does not strike me as a great idea.
> > Anonymous inode fds provide an abstraction mechanism for kernel
> > objects which we built around fds such as timerfd, pidfd, mountfd and
> > so on. When you stat an anonfd you get ANON_INODE_FS_MAGIC and you
> > get the actual type by looking at fdinfo, or - more common - by
> > parsing out /proc/<pid>/fd/<nr> and discovering "[fscontext]". So
> > it's already a pretty massive abstraction layer we have. But configfd
> > would be yet another fd abstraction based on anonfds.
> > The idea has been that a new fd type based on anonfds comes with an
> > api specific to that type of fd. That seems way nicer from an api
> > design perspective than implementing new apis as part of yet another
> > generic configfd layer.
> 
> Really, it's just a fd that gathers config information and can reserve
> specific errors (and we should really work out the i18n implications of

It's rather a complex multiplexer intended to go beyond the realm of
filesystems/mount api and that's something we have been burned by before.

> the latter).  Whether it's a new fd type or an anonfd with a specific
> name doesn't seem to be that significant, so the name could be set by
> the type.
> 
> > Another problem is that these syscalls here would be massive
> > multiplexing syscalls. If they are ever going to be used outside of
> > filesystem use-cases (which is doubtful) they will quickly rival
> > prctl(), seccomp(), and ptrace().
> 
> Actually, that's partly the point.  We do have several systemcalls with

Actually I think that's the problem. The keyctl api itself suffers
from the problem that it already has a complex multiplexer. That could
either point to bad api design (sorry, David :)) or it's just a very
complex use-case like the mount api. The good thing is that it's
restricted to a single domain: keys. And that's good. Plumbing both e.g.
keys and (parts of) mounts on top of another generic api is what strikes
me as a bad idea.

> variable argument parsing that would benefit from an approach like
> this.  keyctl springs immediately to mind.
> 
> >  That's not a great thing. Especially, since we recently (a few
> > months ago with Linus chiming in too) had long discussions with the
> > conclusion that multiplexing syscalls are discouraged, from a
> > security and api design perspective. Especially when they are not
> > tied to a specific API (e.g. seccomp() and bpf() are at least tied to
> > a specific API). libcs such as glibc and musl had reservations in
> > that regard as well.
> > 
> > This would also spread the mount api across even more fd types than
> > it already does now which is cumbersome for userspace.
> > 
> > A generic API like that also makes it hard to do interception in
> > userspace which is important for brokers such as e.g. used in Firefox
> > or what we do in various container use-cases.
> > 
> > So I have strong reservations about configfd and would strongly favor
> > the revival of the original fsconfig() patchset.
> 
> Ah well, I did have plans for configfd to be self describing, so the
> arguments accepted by each type would be typed and pre-registered and
> thus parseable generically, so instead of being the usual anonymous
> multiplex sink, it would at least be an introspectable multiplexed
> sink.  The problem there was I can't make fsconfig fit into that

We already have fsconfig() to configure mounts so it seems odd to now
spread the mount api onto configfd imho.

Christian
