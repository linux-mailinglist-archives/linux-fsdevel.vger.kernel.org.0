Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64A16173C36
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 16:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgB1Pw6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 10:52:58 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54444 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgB1Pw6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:52:58 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j7hwT-0008I1-Db; Fri, 28 Feb 2020 15:52:45 +0000
Date:   Fri, 28 Feb 2020 16:52:44 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        David Howells <dhowells@redhat.com>,
        viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver
 #17]
Message-ID: <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein>
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
 <1582316494.3376.45.camel@HansenPartnership.com>
 <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
 <1582556135.3384.4.camel@HansenPartnership.com>
 <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
 <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com>
 <1582644535.3361.8.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1582644535.3361.8.camel@HansenPartnership.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 25, 2020 at 07:28:55AM -0800, James Bottomley wrote:
> On Tue, 2020-02-25 at 12:13 +0000, Steven Whitehouse wrote:
> > Hi,
> > 
> > On 24/02/2020 15:28, Miklos Szeredi wrote:
> > > On Mon, Feb 24, 2020 at 3:55 PM James Bottomley
> > > <James.Bottomley@hansenpartnership.com> wrote:
> > > 
> > > > Once it's table driven, certainly a sysfs directory becomes
> > > > possible. The problem with ST_DEV is filesystems like btrfs and
> > > > xfs that may have multiple devices.
> > > 
> > > For XFS there's always  a single sb->s_dev though, that's what
> > > st_dev will be set to on all files.
> > > 
> > > Btrfs subvolume is sort of a lightweight superblock, so basically
> > > all such st_dev's are aliases of the same master superblock.  So
> > > lookup of all subvolume st_dev's could result in referencing the
> > > same underlying struct super_block (just like /proc/$PID will
> > > reference the same underlying task group regardless of which of the
> > > task group member's PID is used).
> > > 
> > > Having this info in sysfs would spare us a number of issues that a
> > > set of new syscalls would bring.  The question is, would that be
> > > enough, or is there a reason that sysfs can't be used to present
> > > the various filesystem related information that fsinfo is supposed
> > > to present?
> > > 
> > > Thanks,
> > > Miklos
> > > 
> > 
> > We need a unique id for superblocks anyway. I had wondered about
> > using s_dev some time back, but for the reasons mentioned earlier in
> > this thread I think it might just land up being confusing and
> > difficult to manage. While fake s_devs are created for sbs that don't
> > have a device, I can't help thinking that something closer to
> > ifindex, but for superblocks, is needed here. That would avoid the
> > issue of which device number to use.
> > 
> > In fact we need that anyway for the notifications, since without
> > that  there is a race that can lead to missing remounts of the same
> > device, in  case a umount/mount pair is missed due to an overrun, and
> > then fsinfo returns the same device as before, with potentially the
> > same mount options too. So I think a unique id for a superblock is a
> > generically useful feature, which would also allow for sensible sysfs
> > directory naming, if required,
> 
> But would this be informative and useful for the user?  I'm sure we can
> find a persistent id for a persistent superblock, but what about tmpfs
> ... that's going to have to change with every reboot.  It's going to be
> remarkably inconvenient if I want to get fsinfo on /run to have to keep
> finding what the id is.
> 
> The other thing a file descriptor does that sysfs doesn't is that it
> solves the information leak: if I'm in a mount namespace that has no
> access to certain mounts, I can't fspick them and thus I can't see the
> information.  By default, with sysfs I can.

Difficult to figure out which part of the thread to reply too. :)

sysfs strikes me as fundamentally misguided for this task.

Init systems or any large-scale daemon will hate parsing things, there's
that and parts of the reason why mountinfo sucks is because of parsing a
possibly a potentially enormous file. Exposing information in sysfs will
require parsing again one way or the other. I've been discussing these
bottlenecks with Lennart quite a bit and reliable and performant mount
notifications without needing to parse stuff is very high on the issue
list. But even if that isn't an issue for some reason the namespace
aspect is definitely something I'd consider a no-go.
James has been poking at this a little already and I agree. More
specifically, sysfs and proc already are a security nightmare for
namespace-aware workloads and require special care. Not leaking
information in any way is a difficult task. I mean, over the last two
years I sent quite a lot of patches to the networking-namespace aware
part of sysfs alone either fixing information leaks, or making other
parts namespace aware that weren't and were causing issues (There's
another large-ish series sitting in Dave's tree right now.). And tbh,
network namespacing in sysfs is imho trivial compared to what we would
need to do to handle mount namespacing and especially mount propagation.
fsinfo() is way cleaner and ultimately simpler approach. We very much
want it file-descriptor based. The mount api opens up the road to secure
and _delegatable_ querying of filesystem information.

Christian
