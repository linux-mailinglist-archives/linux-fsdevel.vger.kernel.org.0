Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63FD73B9C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 18:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfFJQmx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 12:42:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfFJQmw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 12:42:52 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA88D2145D
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jun 2019 16:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560184971;
        bh=tXbHag/USdm+4mUHgtj4zWsRGotIHMmzJx1x6Cx6xwE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eg/VT6ZIqewlHruvFiwIrW6sxxeaAfyq+pd7qIvGmU+WUps1udbDUIqJ+9K2h0dif
         DJX0ZlsJGLw0TCdbwpEogokcRurDpRAmW/hKGpGS+xsS2DRkbiXmRbpHra7NbxmarJ
         fZhXRLK1uac7cGQhmHU7vQcPaYoXd8gWGwGM4mdk=
Received: by mail-wm1-f49.google.com with SMTP id c6so48537wml.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jun 2019 09:42:50 -0700 (PDT)
X-Gm-Message-State: APjAAAUIXXJneuipj6su49WIEYrJ9I/hOYzRzuvJYTRwBuOgDAcgVBib
        C6ziiJ/6NTLAyyj39fRFYdXaoDGKgvHXkyy8jIGivg==
X-Google-Smtp-Source: APXvYqyv8NSCEyJg2Hv8AHPLVJY9L6V2V/QOLFaZD86SuSFB89IZcrzuIySjt90M5yKSGdxvGrqfW/B+zWfAS5WxmAU=
X-Received: by 2002:a1c:a942:: with SMTP id s63mr14224080wme.76.1560184969283;
 Mon, 10 Jun 2019 09:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
 <be966d9c-e38d-7a30-8d80-fad5f25ab230@tycho.nsa.gov> <0cf7a49d-85f6-fba9-62ec-a378e0b76adf@schaufler-ca.com>
In-Reply-To: <0cf7a49d-85f6-fba9-62ec-a378e0b76adf@schaufler-ca.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 10 Jun 2019 09:42:37 -0700
X-Gmail-Original-Message-ID: <CALCETrX5O18q2=dUeC=hEtK2=t5KQpGBy9XveHxFw36OqkbNOg@mail.gmail.com>
Message-ID: <CALCETrX5O18q2=dUeC=hEtK2=t5KQpGBy9XveHxFw36OqkbNOg@mail.gmail.com>
Subject: Re: [RFC][PATCH 00/13] Mount, FS, Block and Keyrings notifications
 [ver #4]
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        USB list <linux-usb@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        raven@themaw.net, Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 10, 2019 at 9:34 AM Casey Schaufler <casey@schaufler-ca.com> wr=
ote:
>
> On 6/10/2019 8:21 AM, Stephen Smalley wrote:
> > On 6/7/19 10:17 AM, David Howells wrote:
> >>
> >> Hi Al,
> >>
> >> Here's a set of patches to add a general variable-length notification =
queue
> >> concept and to add sources of events for:
> >>
> >>   (1) Mount topology events, such as mounting, unmounting, mount expir=
y,
> >>       mount reconfiguration.
> >>
> >>   (2) Superblock events, such as R/W<->R/O changes, quota overrun and =
I/O
> >>       errors (not complete yet).
> >>
> >>   (3) Key/keyring events, such as creating, linking and removal of key=
s.
> >>
> >>   (4) General device events (single common queue) including:
> >>
> >>       - Block layer events, such as device errors
> >>
> >>       - USB subsystem events, such as device/bus attach/remove, device
> >>         reset, device errors.
> >>
> >> One of the reasons for this is so that we can remove the issue of proc=
esses
> >> having to repeatedly and regularly scan /proc/mounts, which has proven=
 to
> >> be a system performance problem.  To further aid this, the fsinfo() sy=
scall
> >> on which this patch series depends, provides a way to access superbloc=
k and
> >> mount information in binary form without the need to parse /proc/mount=
s.
> >>
> >>
> >> LSM support is included, but controversial:
> >>
> >>   (1) The creds of the process that did the fput() that reduced the re=
fcount
> >>       to zero are cached in the file struct.
> >>
> >>   (2) __fput() overrides the current creds with the creds from (1) whi=
lst
> >>       doing the cleanup, thereby making sure that the creds seen by th=
e
> >>       destruction notification generated by mntput() appears to come f=
rom
> >>       the last fputter.
> >>
> >>   (3) security_post_notification() is called for each queue that we mi=
ght
> >>       want to post a notification into, thereby allowing the LSM to pr=
event
> >>       covert communications.
> >>
> >>   (?) Do I need to add security_set_watch(), say, to rule on whether a=
 watch
> >>       may be set in the first place?  I might need to add a variant pe=
r
> >>       watch-type.
> >>
> >>   (?) Do I really need to keep track of the process creds in which an
> >>       implicit object destruction happened?  For example, imagine you =
create
> >>       an fd with fsopen()/fsmount().  It is marked to dissolve the mou=
nt it
> >>       refers to on close unless move_mount() clears that flag.  Now, i=
magine
> >>       someone looking at that fd through procfs at the same time as yo=
u exit
> >>       due to an error.  The LSM sees the destruction notification come=
 from
> >>       the looker if they happen to do their fput() after yours.
> >
> > I remain unconvinced that (1), (2), (3), and the final (?) above are a =
good idea.
> >
> > For SELinux, I would expect that one would implement a collection of pe=
r watch-type WATCH permission checks on the target object (or to some well-=
defined object label like the kernel SID if there is no object) that allow =
receipt of all notifications of that watch-type for objects related to the =
target object, where "related to" is defined per watch-type.
> >
> > I wouldn't expect SELinux to implement security_post_notification() at =
all.  I can't see how one can construct a meaningful, stable policy for it.=
  I'd argue that the triggering process is not posting the notification; th=
e kernel is posting the notification and the watcher has been authorized to=
 receive it.
>
> I cannot agree. There is an explicit action by a subject that results
> in information being delivered to an object. Just like a signal or a
> UDP packet delivery. Smack handles this kind of thing just fine. The
> internal mechanism that results in the access is irrelevant from
> this viewpoint. I can understand how a mechanism like SELinux that
> works on finer granularity might view it differently.

I think you really need to give an example of a coherent policy that
needs this.  As it stands, your analogy seems confusing.  If someone
changes the system clock, we don't restrict who is allowed to be
notified (via, for example, TFD_TIMER_CANCEL_ON_SET) that the clock
was changed based on who changed the clock.  Similarly, if someone
tries to receive a packet on a socket, we check whether they have the
right to receive on that socket (from the endpoint in question) and,
if the sender is local, whether the sender can send to that socket.
We do not check whether the sender can send to the receiver.

The signal example is inapplicable.  Sending a signal to a process is
an explicit action done to that process, and it can easily adversely
affect the target.  Of course it requires permission.

--Andy
