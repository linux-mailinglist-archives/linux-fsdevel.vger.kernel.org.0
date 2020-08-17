Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1491246F86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 19:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388798AbgHQRsb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 13:48:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39198 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390094AbgHQRsU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 13:48:20 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k7jEY-0000AV-7b; Mon, 17 Aug 2020 17:47:46 +0000
Date:   Mon, 17 Aug 2020 19:47:45 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrei Vagin <avagin@gmail.com>, adobriyan@gmail.com,
        viro@zeniv.linux.org.uk, davem@davemloft.net,
        akpm@linux-foundation.org, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: Re: [PATCH 00/23] proc: Introduce /proc/namespaces/ directory to
 expose namespaces lineary
Message-ID: <20200817174745.jssxjdcwoqxeg5pu@wittgenstein>
References: <2d65ca28-bcfa-b217-e201-09163640ebc2@virtuozzo.com>
 <20200810173431.GA68662@gmail.com>
 <33565447-9b97-a820-bc2c-a4ff53a7675a@virtuozzo.com>
 <20200812175338.GA596568@gmail.com>
 <8f3c9414-9efc-cc01-fb2a-4d83266e96b2@virtuozzo.com>
 <20200814011649.GA611947@gmail.com>
 <0af3f2fa-f2c3-fb7d-b57e-9c41fe94ca58@virtuozzo.com>
 <20200814192102.GA786465@gmail.com>
 <56ed1fb9-4f1f-3528-3f09-78478b9dfcf2@virtuozzo.com>
 <87d03pb7f2.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87d03pb7f2.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 17, 2020 at 10:48:01AM -0500, Eric W. Biederman wrote:
> 
> Creating names in the kernel for namespaces is very difficult and
> problematic.  I have not seen anything that looks like  all of the
> problems have been solved with restoring these new names.
> 
> When your filter for your list of namespaces is user namespace creating
> a new directory in proc is highly questionable.
> 
> As everyone uses proc placing this functionality in proc also amplifies
> the problem of creating names.
> 
> 
> Rather than proc having a way to mount a namespace filesystem filter by
> the user namespace of the mounter likely to have many many fewer
> problems.  Especially as we are limiting/not allow new non-process
> things and ideally finding a way to remove the non-process things.
> 
> 
> Kirill you have a good point that taking the case where a pid namespace
> does not exist in a user namespace is likely quite unrealistic.
> 
> Kirill mentioned upthread that the list of namespaces are the list that
> can appear in a container.  Except by discipline in creating containers
> it is not possible to know which namespaces may appear in attached to a
> process.  It is possible to be very creative with setns, and violate any
> constraint you may have.  Which means your filtered list of namespaces
> may not contain all of the namespaces used by a set of processes.  This

Indeed. We use setns() quite creatively when intercepting syscalls and
when attaching to a container.

> further argues that attaching the list of namespaces to proc does not
> make sense.
> 
> Andrei has a good point that placing the names in a hierarchy by
> user namespace has the potential to create more freedom when
> assigning names to namespaces, as it means the names for namespaces
> do not need to be globally unique, and while still allowing the names
> to stay the same.
> 
> 
> To recap the possibilities for names for namespaces that I have seen
> mentioned in this thread are:
>   - Names per mount
>   - Names per user namespace
> 
> I personally suspect that names per mount are likely to be so flexibly
> they are confusing, while names per user namespace are likely to be
> rigid, possibly too rigid to use.
> 
> It all depends upon how everything is used.  I have yet to see a
> complete story of how these names will be generated and used.  So I can
> not really judge.

So I haven't fully understood either what the motivation for this
patchset is.
I can just speak to the use-case I had when I started prototyping
something similar: We needed a way to get a view on all namespaces
that exist on the system because we wanted a way to do namespace
debugging on a live system. This interface could've easily lived in
debugfs. The main point was that it should contain all namespaces.
Note, that it wasn't supposed to be a hierarchical format it was only
mean to list all namespaces and accessible to real root.
The interface here is way more flexible/complex and I haven't yet
figured out what exactly it is supposed to be used for.

> 
> 
> Let me add another take on this idea that might give this work a path
> forward. If I were solving this I would explore giving nsfs directories
> per user namespace, and a way to mount it that exposed the directory of
> the mounters current user namespace (something like btrfs snapshots).
> 
> Hmm.  For the user namespace directory I think I would give it a file
> "ns" that can be opened to get a file handle on the user namespace.
> Plus a set of subdirectories "cgroup", "ipc", "mnt", "net", "pid",
> "user", "uts") for each type of namespace.  In each directory I think
> I would just have a 64bit counter and each new entry I would assign the
> next number from that counter.
> 
> The restore could either have the ability to rename files or simply the
> ability to bump the counter (like we do with pids) so the names of the
> namespaces can be restored.
> 
> That winds up making a user namespace the namespace of namespaces, so
> I am not 100% about the idea. 

I think you're right that we need to understand better what the use-case
is. If I understand your suggestion correctly it wouldn't allow to show
nested user namespaces if the nsfs mount is per-user namespace.

Let me throw in a crazy idea: couldn't we just make the ioctl_ns() walk
a namespace hierarchy? For example, you could pass in a user namespace
fd and then you'd get back a struct with handles for fds for the
namespaces owned by that user namespace and then you could use
NS_GET_USERNS/NS_GET_PARENT to walk upwards from the user namespace fd
passed in initially and so on? Or something similar/simpler. This would
also decouple this from procfs somewhat.

Christian
