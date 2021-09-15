Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9655740CB50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 19:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhIORBR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 13:01:17 -0400
Received: from wind.enjellic.com ([76.10.64.91]:58928 "EHLO wind.enjellic.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhIORBQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 13:01:16 -0400
X-Greylist: delayed 1542 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Sep 2021 13:01:15 EDT
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 18FGXT0I002910;
        Wed, 15 Sep 2021 11:33:29 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 18FGXRgh002909;
        Wed, 15 Sep 2021 11:33:27 -0500
Date:   Wed, 15 Sep 2021 11:33:27 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Bruce Fields <bfields@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, virtio-fs@redhat.com,
        Daniel Walsh <dwalsh@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        stephen.smalley.work@gmail.com,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v3 0/1] Relax restrictions on user.* xattr
Message-ID: <20210915163327.GA2324@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <YTEEPZJ3kxWkcM9x@redhat.com> <YTENEAv6dw9QoYcY@redhat.com> <3bca47d0-747d-dd49-a03f-e0fa98eaa2f7@schaufler-ca.com> <YTEur7h6fe4xBJRb@redhat.com> <1f33e6ef-e896-09ef-43b1-6c5fac40ba5f@schaufler-ca.com> <YTYr4MgWnOgf/SWY@work-vm> <496e92bf-bf9e-a56b-bd73-3c1d0994a064@schaufler-ca.com> <YUCa6pWpr5cjCNrU@redhat.com> <CAPL3RVHB=E_s1AW1sQMEgrLYJ8ADCdr=qaKsDrpYjVzW-Apq8w@mail.gmail.com> <YUCybaYK/0RLvY9J@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUCybaYK/0RLvY9J@redhat.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Wed, 15 Sep 2021 11:33:29 -0500 (CDT)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 14, 2021 at 10:32:13AM -0400, Vivek Goyal wrote:

Good morning, I hope the day is going well for everyone.

> On Tue, Sep 14, 2021 at 09:59:19AM -0400, Bruce Fields wrote:
> > On Tue, Sep 14, 2021 at 8:52 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > Same is the requirement for regular containers and that's why
> > > podman (and possibly other container managers), make top level
> > > storage directory only readable and searchable by root, so that
> > > unpriveleged entities on host can not access container root filesystem
> > > data.
> > 
> > Note--if that directory is on NFS, making it readable and searchable
> > by root is very weak protection, since it's often possible for an
> > attacker to guess filehandles and access objects without the need for
> > directory lookups.

> open_by_handle_at() requires CAP_DAC_READ_SEARCH. And if you have
> CAP_DAC_READ_SEARCH, you don't need to even guess file handles. You
> should be able to read/search through all directories, IIUC.
>
> So how does one make sure that shared directory on host is not
> accessible to unprivileged entities. If making directory accessible
> to root only is weaker security, what are the options for stronger
> security.

I've been watching this thread, with some interest, given what we have
been working on with respect to providing a new security framework
that merges IMA and LSM and external security co-processor technology.

Some observations based on those experiences and this thread.

Casey is an expert on MAC and capability based security systems,
unfortunately for our industry, particularly bog standard system
administrators, a rarefied set of skills.  It may be helpful to
consider his concerns and position on the issues involved in the
framework of the number of systems that have, and blog posts that
recommend, setting 'selinux=0' on the kernel command-line.

I believe the best summary of his position on this issue, is the
notion that placing security labels, even in transitive form in user
accessible attributes, subordinates the security of the guest system,
regardless of the MAC policy it implements, to the DAC based policy on
the host system.

Given that, there are no legitimate security guarantees that are
inferrable based on the guest MAC policy.

A legitimate pundit, could and probably should question, in the face
of container filesystems and virtual machine images, whether any type
of inferrable security guarantees are possible, but that is a question
and argument for another day.

I didn't see any mention of EVM brought up in these discussions, which
may provide some options to improve the security integrity state of
the guest.

The 800 pound gorilla in the corner in all of this, is that inferrable
security guarantees in guests require a certifiable chain of trust
from the creator of the object to the kernel context that is making
the security gating decisions on the object.  A hard to implement and
prove concept in bare metal trusted systems, let alone the myriad of
edge cases lurking in namespaced and virtual environments.

Which, in a nod to the other corner of the ring, may simply mean, with
our current state of deployable technology, you pay your money and
take your chances in these virtual environments.  Which would in turn
support the notion of a minimum security, ie. DAC, based effort.

> Vivek

Have a good remainder of the week.

Dr. Greg

As always,
Dr. Greg Wettstein, Ph.D, Worker      Autonomously self-defensive
Enjellic Systems Development, LLC     IOT platforms and edge devices.
4206 N. 19th Ave.
Fargo, ND  58102
PH: 701-281-1686                      EMAIL: dg@enjellic.com
------------------------------------------------------------------------------
"This place is so screwed up.  It's just like the Titanic, only
 we don't even have a band playing.
                                -- Terrance George Wieland
                                   Resurrection.
