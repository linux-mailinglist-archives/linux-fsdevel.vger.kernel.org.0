Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EFF1DBE55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 21:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgETTsT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 15:48:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37985 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726837AbgETTsS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 15:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590004096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5EOIorljduPvmZJ+oMRVQpix8Ow58lyWoCnbTjlvW6I=;
        b=hs33ooMZeg4cuamk6TqQotwrw7ucrCgZJZan1xJ+zrnb9JBGWvGS6H1PWBsKqLLVjs8U98
        KsnKrxXydZBVW0RFGVIwgLet71Mj2v1Lyb5QLIhaOo8UlqMyonBuRp51a8kKMvF3vj9Joa
        7p0VbEFif/K/f0guB8Wpwk2yX6q0HeE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-TtWJfTLYNbSGBo3AUitG0Q-1; Wed, 20 May 2020 15:48:14 -0400
X-MC-Unique: TtWJfTLYNbSGBo3AUitG0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E8278015D1;
        Wed, 20 May 2020 19:48:12 +0000 (UTC)
Received: from mail (ovpn-112-106.rdu2.redhat.com [10.10.112.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E93A25D9CA;
        Wed, 20 May 2020 19:48:04 +0000 (UTC)
Date:   Wed, 20 May 2020 15:48:04 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Daniel Colascione <dancol@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Xu <peterx@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, timmurray@google.com,
        minchan@google.com, sspatil@google.com, lokeshgidra@google.com
Subject: Re: [PATCH 2/2] Add a new sysctl knob:
 unprivileged_userfaultfd_user_mode_only
Message-ID: <20200520194804.GJ26186@redhat.com>
References: <20200423002632.224776-1-dancol@google.com>
 <20200423002632.224776-3-dancol@google.com>
 <20200508125054-mutt-send-email-mst@kernel.org>
 <20200508125314-mutt-send-email-mst@kernel.org>
 <20200520045938.GC26186@redhat.com>
 <202005200921.2BD5A0ADD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005200921.2BD5A0ADD@keescook>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Kees,

On Wed, May 20, 2020 at 11:03:39AM -0700, Kees Cook wrote:
> Err, did I miss a separate 6-patch series? I can't find anything on lore.

Daniel included the link of the previous series I referred to is the
cover letter 0/2:

https://lore.kernel.org/lkml/20200211225547.235083-1-dancol@google.com/

> > If you keep only 1/2, can't seccomp-bpf enforce userfaultfd to be
> > always called with flags==0x1 without requiring extra modifications in
> > the kernel?
> 
> Please no. This is way too much overhead for something that a system
> owner wants to enforce globally. A sysctl is the correct option here,
> IMO. If it needs to be a per-userns sysctl, that would be fine too.

The question is who could be this system owner who prefers "2" to "0"?

per-ns I don't see the point either when all containers already run
with default policies enforcing the same behavior as if the sysctl is
set to "0".

Why exactly is it preferable to enlarge the surface of attack of the
kernel and take the risk there is a real bug in userfaultfd code (not
just a facilitation of exploiting some other kernel bug) that leads to
a privilege escalation, when you still break 99% of userfaultfd users,
if you set with option "2"?

Is the system owner really going to purely run on his systems CRIU
postcopy live migration (which already runs with CAP_SYS_PTRACE) and
nothing else that could break?

Option "2" to me looks with a single possible user, and incidentally
this single user can already enforce model "2" by only tweaking its
seccomp-bpf filters without applying 2/2. It'd be a bug if android
apps runs unprotected by seccomp regardless of 2/2.

System owners I think would be better of to stick to "0" or "1" a far
as I can tell, "2" looks a bad tradeoff as system value, with nearly
all cons of "0", but less secure than "0".

> I'd agree that patch 1 should land, as it appears to be required for any

Agreed about merging 1/2.

> further policy considerations. I'm still a big fan of a sysctl since
> this is the kind of thing I would absolutely turn on globally for all my
> systems.

The sysctl /proc/sys/kernel/unprivileged_bpf_disabled is already there
upstream and you should have already set it to "0" in all your systems
if you can cope with some app features not working.

2/2 as modified with Peter's suggestion, would add a new value "2" (in
addition of "1" and "0"), that still breaks the majority of all
possible users, just like value "0", but that gives less security than
value "0".

It all boils down of how peculiar it is to be able to leverage only
the acceleration (reduction in context switches and enter/exit kernel)
and the vma fragmentation avoidance (to avoid running of vmas in
/proc/sys/vm/max_map_count) provided by userfaultfd (vs sigsegv
trapping) but not the transparency in handling faults in kernel (which
sigsegv can't possibly achieve).

Right now there's a single user that can cope with that limitation,
and it's not your running on your servers but on your phone. Even CRIU
cannot cope with such limitation, the only reason it would cope with
value "2" is that it already runs with CAP_SYS_PTRACE for other
reasons.

If there will be more users that can cope with handling only user
initiated page faults, then yes, I think it'd be fine to add a value
"2" later.

The other benefit of enforcing the policy with seccomp-bpf if that if
you'd run Android userland on a container on a ARM server on top of an
enterprise kernel, it'd already run as safe as if the sysctl value was
tweaked to "2", but without having to also add extra kernel code for
per-ns sysctl. It just looks simpler. The rest of the containers on
the same host are already running today as if the sysctl is set to 0
regardless of this patchset.

If you want to enforce maximum security and override any possible
opt-out of the default podman seccomp profile that blocks userfaultfd,
you already can upstream with the global sysctl by setting it to "0".

Thanks,
Andrea

