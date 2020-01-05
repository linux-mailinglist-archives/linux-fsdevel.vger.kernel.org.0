Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 379CC13095D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jan 2020 19:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgAESCL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jan 2020 13:02:11 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35432 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726376AbgAESCK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jan 2020 13:02:10 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6DCC88EE148;
        Sun,  5 Jan 2020 10:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1578247330;
        bh=BbaBBLhbSsjTslD+BkwBTL57JjaPLHlnMLLax/45S2s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FukxtxPFUSKxuIoWc9IXCCf4LoKq0SCKQ1mTYNE6YqmF3l6PTH6wDQrmkrzQli3UB
         WFvRgdqMmn20Tg2iJ0nknVCj1yOSL45rpQqr2eqA6B81t0nIp/0744Sw+jQJFkETRQ
         9yygNbmCR84N3VBj1Q4uRSIPsfbPo5Mz+GhFlwZU=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VB4l_GFjjMEU; Sun,  5 Jan 2020 10:02:10 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C38828EE0D2;
        Sun,  5 Jan 2020 10:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1578247330;
        bh=BbaBBLhbSsjTslD+BkwBTL57JjaPLHlnMLLax/45S2s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FukxtxPFUSKxuIoWc9IXCCf4LoKq0SCKQ1mTYNE6YqmF3l6PTH6wDQrmkrzQli3UB
         WFvRgdqMmn20Tg2iJ0nknVCj1yOSL45rpQqr2eqA6B81t0nIp/0744Sw+jQJFkETRQ
         9yygNbmCR84N3VBj1Q4uRSIPsfbPo5Mz+GhFlwZU=
Message-ID: <1578247328.3310.36.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 0/6] introduce configfd as generalisation of fsconfig
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Miklos Szeredi <miklos@szeredi.hu>
Date:   Sun, 05 Jan 2020 10:02:08 -0800
In-Reply-To: <20200105162311.sufgft6kthetsz7q@wittgenstein>
References: <20200104201432.27320-1-James.Bottomley@HansenPartnership.com>
         <20200105162311.sufgft6kthetsz7q@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2020-01-05 at 17:23 +0100, Christian Brauner wrote:
> On Sat, Jan 04, 2020 at 12:14:26PM -0800, James Bottomley wrote:
> > fsconfig is a very powerful configuration mechanism except that it
> > only works for filesystems with superblocks.  This patch series
> > generalises the useful concept of a multiple step configurational
> > mechanism carried by a file descriptor.  The object of this patch
> > series is to get bind mounts to be configurable in the same way
> > that superblock based ones are, but it should have utility beyond
> > the filesytem realm.  Patch 4 also reimplements fsconfig in terms
> > of configfd, but that's not a strictly necessary patch, it is
> > merely a useful demonstration that configfd is a superset of the
> > properties of fsconfig.
> 
> Thanks for the patch. I'm glad fsconfig() is picked back up; either
> by you or by David. We will need this for sure.
> But the configfd approach does not strike me as a great idea.
> Anonymous inode fds provide an abstraction mechanism for kernel
> objects which we built around fds such as timerfd, pidfd, mountfd and
> so on. When you stat an anonfd you get ANON_INODE_FS_MAGIC and you
> get the actual type by looking at fdinfo, or - more common - by
> parsing out /proc/<pid>/fd/<nr> and discovering "[fscontext]". So
> it's already a pretty massive abstraction layer we have. But configfd
> would be yet another fd abstraction based on anonfds.
> The idea has been that a new fd type based on anonfds comes with an
> api specific to that type of fd. That seems way nicer from an api
> design perspective than implementing new apis as part of yet another
> generic configfd layer.

Really, it's just a fd that gathers config information and can reserve
specific errors (and we should really work out the i18n implications of
the latter).  Whether it's a new fd type or an anonfd with a specific
name doesn't seem to be that significant, so the name could be set by
the type.

> Another problem is that these syscalls here would be massive
> multiplexing syscalls. If they are ever going to be used outside of
> filesystem use-cases (which is doubtful) they will quickly rival
> prctl(), seccomp(), and ptrace().

Actually, that's partly the point.  We do have several systemcalls with
variable argument parsing that would benefit from an approach like
this.  keyctl springs immediately to mind.

>  That's not a great thing. Especially, since we recently (a few
> months ago with Linus chiming in too) had long discussions with the
> conclusion that multiplexing syscalls are discouraged, from a
> security and api design perspective. Especially when they are not
> tied to a specific API (e.g. seccomp() and bpf() are at least tied to
> a specific API). libcs such as glibc and musl had reservations in
> that regard as well.
> 
> This would also spread the mount api across even more fd types than
> it already does now which is cumbersome for userspace.
> 
> A generic API like that also makes it hard to do interception in
> userspace which is important for brokers such as e.g. used in Firefox
> or what we do in various container use-cases.
> 
> So I have strong reservations about configfd and would strongly favor
> the revival of the original fsconfig() patchset.

Ah well, I did have plans for configfd to be self describing, so the
arguments accepted by each type would be typed and pre-registered and
thus parseable generically, so instead of being the usual anonymous
multiplex sink, it would at least be an introspectable multiplexed
sink.  The problem there was I can't make fsconfig fit into that
framework but, as I said, it was only done to demo that configfd was a
superset, I'm not wedded to that part.

James

