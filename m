Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA2D457363
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 17:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbhKSQul (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 11:50:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:51984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230296AbhKSQul (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 11:50:41 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFE7A61B43;
        Fri, 19 Nov 2021 16:47:37 +0000 (UTC)
Date:   Fri, 19 Nov 2021 11:47:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Yordan@web.codeaurora.org, Karadzhov@web.codeaurora.org,
        VMware <" <y.karadz"@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        mingo@redhat.com, hagen@jauu.net, rppt@kernel.org,
        akpm@linux-foundation.org, vvs@virtuozzo.com, shakeelb@google.com,
        christian.brauner@ubuntu.com, mkoutny@suse.com,
        "Linux Containers <containers@lists.linux.dev>" 
        <""@web.codeaurora.org>
Subject: Re: [RFC PATCH 0/4] namespacefs: Proof-of-Concept
Message-ID: <20211119114736.5d9dcf6c@gandalf.local.home>
In-Reply-To: <f6ca1f5bdb3b516688f291d9685a6a59f49f1393.camel@HansenPartnership.com>
References: <20211118181210.281359-1-y.karadz@gmail.com>
        <87a6i1xpis.fsf@email.froward.int.ebiederm.org>
        <20211118142440.31da20b3@gandalf.local.home>
        <1349346e1d5daca991724603d1495ec311cac058.camel@HansenPartnership.com>
        <20211119092758.1012073e@gandalf.local.home>
        <f6ca1f5bdb3b516688f291d9685a6a59f49f1393.camel@HansenPartnership.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[ Fixed strange email header ]

On Fri, 19 Nov 2021 11:30:43 -0500
James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> On Fri, 2021-11-19 at 09:27 -0500, Steven Rostedt wrote:
> > On Fri, 19 Nov 2021 07:45:01 -0500
> > James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> >   
> > > On Thu, 2021-11-18 at 14:24 -0500, Steven Rostedt wrote:  
> > > > On Thu, 18 Nov 2021 12:55:07 -0600
> > > > ebiederm@xmission.com (Eric W. Biederman) wrote:
> > > >     
> > > > > It is not correct to use inode numbers as the actual names for
> > > > > namespaces.
> > > > > 
> > > > > I can not see anything else you can possibly uses as names for
> > > > > namespaces.    
> > > > 
> > > > This is why we used inode numbers.
> > > >     
> > > > > To allow container migration between machines and similar
> > > > > things the you wind up needing a namespace for your names of
> > > > > namespaces.    
> > > > 
> > > > Is this why you say inode numbers are incorrect?    
> > > 
> > > The problem is you seem to have picked on one orchestration system
> > > without considering all the uses of namespaces and how this would
> > > impact them.  So let me explain why inode numbers are incorrect and
> > > it will possibly illuminate some of the cans of worms you're
> > > opening.
> > > 
> > > We have a container checkpoint/restore system called CRIU that can
> > > be used to snapshot the state of a pid subtree and restore it.  It
> > > can be used for the entire system or piece of it.  It is also used
> > > by some orchestration systems to live migrate containers.  Any
> > > property of a container system that has meaning must be saved and
> > > restored by CRIU.
> > > 
> > > The inode number is simply a semi random number assigned to the
> > > namespace.  it shows up in /proc/<pid>/ns but nowhere else and
> > > isn't used by anything.  When CRIU migrates or restores containers,
> > > all the namespaces that compose them get different inode values on
> > > the restore.  If you want to make the inode number equivalent to
> > > the container name, they'd have to restore to the previous number
> > > because you've made it a property of the namespace.  The way
> > > everything is set up now, that's just not possible and never will
> > > be.  Inode numbers are a 32 bit space and can't be globally
> > > unique.  If you want a container name, it will have to be something
> > > like a new UUID and that's the first problem you should tackle.  
> > 
> > So everyone seems to be all upset about using inode number. We could
> > do what Kirill suggested and just create some random UUID and use
> > that. We could have a file in the directory called inode that has the
> > inode number (as that's what both docker and podman use to identify
> > their containers, and it's nice to have something to map back to
> > them).
> > 
> > On checkpoint restore, only the directories that represent the
> > container that migrated matter, so as Kirill said, make sure they get
> > the old UUID name, and expose that as the directory.
> > 
> > If a container is looking at directories of other containers on the
> > system, then it gets migrated to another system, it should be treated
> > as though those directories were deleted under them.
> > 
> > I still do not see what the issue is here.  
> 
> The issue is you're introducing a new core property for namespaces they
> didn't have before.  Everyone has different use cases for containers
> and we need to make sure the new property works with all of them.

What new core property is this? We simply want a way to see what namespaces
are defined in the kernel from a systems point of view. This just defines a
file system to show that.

> 
> Having a "name" for a namespace has been discussed before which is the
> landmine you stepped on when you advocated using the inode number as
> the name, because that's already known to be unworkable.

We don't care what name it is, or if it is a name at all. We just want to
know what is there, and not hidden behind tasks that create namespaces.

> 
> Can we back up and ask what problem you're trying to solve before we
> start introducing new objects like namespace name?  The problem

Again, this has nothing to do with naming namespaces.

> statement just seems to be "Being able to see the structure of the
> namespaces can be very useful in the context of the containerized
> workloads."  which you later expanded on as "trying to add more
> visibility into the working of things like kubernetes".  If you just
> want to see the namespace "tree" you can script that (as root) by
> matching the process tree and the /proc/<pid>/ns changes without
> actually needing to construct it in the kernel.  This can also be done
> without introducing the concept of a namespace name.  However, there is
> a subtlety of doing this matching in the way I described in that you
> don't get proper parenting to the user namespace ownership ... but that
> seems to be something you don't want anyway?

Can a privileged container be able to create a full tree of all current
namespaces defined in the system, by just installing it, and reading the
host procfs system?  If so, then that's all we want, and will look at doing
that. But from our initial approach it's not obvious how to do so.

-- Steve
