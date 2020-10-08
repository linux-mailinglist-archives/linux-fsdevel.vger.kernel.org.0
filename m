Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55EF286D75
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 06:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgJHEB4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 00:01:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43617 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbgJHEB4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 00:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602129713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ayx0RH2EmuBsF+SJ5HofbKfMYekN3xbWZ4RAelYIgVk=;
        b=ayzd5qHBY0a2gXTY4IHQaCHWVvW8FyF3Bkwn9qgGttMwP8Afzek8VqHmzD+NfU+u8sqouV
        p6nMdHHpXnhlru62hznHRf+PHDOwL7xFM+ALkL9zSetlFyWRZ7iXIVJKgq1FBVpKpI1H+C
        U7i6TfqsvTTWKuq3l6dGZljHy/ZY8dc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-a7s1O-dAOYmcHUo2I-Ik1g-1; Thu, 08 Oct 2020 00:01:49 -0400
X-MC-Unique: a7s1O-dAOYmcHUo2I-Ik1g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8216425D0;
        Thu,  8 Oct 2020 04:01:45 +0000 (UTC)
Received: from mail (ovpn-112-72.rdu2.redhat.com [10.10.112.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 29B7D76650;
        Thu,  8 Oct 2020 04:01:42 +0000 (UTC)
Date:   Thu, 8 Oct 2020 00:01:41 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, Peter Xu <peterx@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Daniel Colascione <dancol@dancol.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Nick Kralevich <nnk@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Jerome Glisse <jglisse@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nitin Gupta <nigupta@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v4 0/2] Control over userfaultfd kernel-fault handling
Message-ID: <20201008040141.GA17076@redhat.com>
References: <20200924065606.3351177-1-lokeshgidra@google.com>
 <CA+EESO7kCqtJf+ApoOcceFT+NX8pBwGmOr0q0PVnJf9Dnkrp6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+EESO7kCqtJf+ApoOcceFT+NX8pBwGmOr0q0PVnJf9Dnkrp6A@mail.gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Lokesh,

On Wed, Oct 07, 2020 at 01:26:55PM -0700, Lokesh Gidra wrote:
> On Wed, Sep 23, 2020 at 11:56 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> >
> > This patch series is split from [1]. The other series enables SELinux
> > support for userfaultfd file descriptors so that its creation and
> > movement can be controlled.
> >
> > It has been demonstrated on various occasions that suspending kernel
> > code execution for an arbitrary amount of time at any access to
> > userspace memory (copy_from_user()/copy_to_user()/...) can be exploited
> > to change the intended behavior of the kernel. For instance, handling
> > page faults in kernel-mode using userfaultfd has been exploited in [2, 3].
> > Likewise, FUSE, which is similar to userfaultfd in this respect, has been
> > exploited in [4, 5] for similar outcome.
> >
> > This small patch series adds a new flag to userfaultfd(2) that allows
> > callers to give up the ability to handle kernel-mode faults with the
> > resulting UFFD file object. It then adds a 'user-mode only' option to
> > the unprivileged_userfaultfd sysctl knob to require unprivileged
> > callers to use this new flag.
> >
> > The purpose of this new interface is to decrease the chance of an
> > unprivileged userfaultfd user taking advantage of userfaultfd to
> > enhance security vulnerabilities by lengthening the race window in
> > kernel code.
> >
> > [1] https://lore.kernel.org/lkml/20200211225547.235083-1-dancol@google.com/
> > [2] https://duasynt.com/blog/linux-kernel-heap-spray
> > [3] https://duasynt.com/blog/cve-2016-6187-heap-off-by-one-exploit

I've looking at those links and I've been trying to verify the link
[3] is relevant.

Specifically I've been trying to verify if 1) current state of the art
modern SLUB randomization techniques already enabled in production and
rightfully wasting some CPU in all enterprise kernels to prevent
things like above to become an issue in practice 2) combined with the
fact different memcg need to share the same kmemcaches (which was
incidentally fixed a few months ago upstream) and 3) further
robustness enhancements against exploits in the slub metadata, may
already render the exploit [3] from 2016 irrelevant in practice.

So I started by trying to reproduce [3] by building 4.5.1 with a
.config with no robustness features and I booted it on fedora-32 or
gentoo userland and I cannot even invoke call_usermodehelper. Calling
socket(22, AF_INET, 0) won't invoke such function. Can you reproduce
on 4.5.1? Which kernel .config should I use to build 4.5.1 in order
for call_usermodehelper to be invoked by the exploit? Could you help
to verify it?

It even has uninitialized variable spawning random perrors so it
doesn't give a warm fuzzy feeling:

====
int main(int argc, char **argv) {
	void *region, *map;
	              ^^^^^
	pthread_t uffd_thread;
	int uffd, msqid, i;

	region = (void *)mmap((void *)0x40000000, 0x2000, PROT_READ|PROT_WRITE,
                               MAP_FIXED|MAP_PRIVATE|MAP_ANON, -1, 0);

	if (!region) {
		perror("mmap");
		exit(2);
	}

	setup_pagefault(region + 0x1000, 0x1000, 1);

	printf("my pid = %d\n", getpid());

	if (!map) {
	^^^^^^^^
		perror("mmap");
====

The whole point of being able to reproduce on 4.5.1 is then to
simulate if the same exploit would also reproduce on current kernels
with all enterprise default robustness features enabled. Or did
anybody already verify it?

Anyway the links I was playing with are all in the cover letter, the
cover letter is not as important as the actual patches. The actual
patches looks fine to me.

The only improvement I can think of is, what about to add a
printk_once to suggest to toggle the sysctl if userfaultfd bails out
because the process lacks the CAP_SYS_PTRACE capability? That would
facilitate the /etc/sysctl.conf or tuned tweaking in case the apps
aren't verbose enough.

It's not relevant anymore with this latest patchset, but about the
previous argument that seccomp couldn't be used in all Android
processes because of performance concern, I'm slightly confused.

https://android-developers.googleblog.com/2017/07/seccomp-filter-in-android-o.html

"Android O includes a single seccomp filter installed into zygote, the
process from which all the Android applications are derived. Because
the filter is installed into zygote—and therefore all apps—the Android
security team took extra caution to not break existing apps"

Example:

$ uname -mo
aarch64 Android
$ cat swapoff.c
#include <sys/swap.h>

int main()
{
        swapoff("");
}
$ gcc swapoff.c -o swapoff -O2
$ ./swapoff
Bad system call
$

It's hard to imagine what is more performance critical than the zygote
process and the actual apps as above?

It's also hard to imagine what kind of performance concern can arise
by adding seccomp filters also to background system apps that
generally should consume ~0% of CPU.

If performance is really a concern, the BPF JIT representation with
the bitmap to be able to run the filter in O(1) sounds a better
solution than not adding ad-hoc filters and it's being worked on for
x86-64 and can be ported to aarch64 too. Many of the standalone
background processes likely wouldn't even use uffd at all so you could
block the user initiated faults too that way.

Ultimately because of issues as [3] (be them still relevant or not, to
be double checked), no matter if through selinux, seccomp or a
different sysctl value, without this patchset applied the default
behavior of the userfaultfd syscall for all Linux binaries running on
Android kernels, would deviate from the upstream kernel. So even if we
would make the pipe mutex logic more complex the deviation would
remain. Your patchset adds much less risk of breakage than adding a
timeout to kernel initiated userfaults and it resolves all concerns as
well as a timeout. We'll also make better use of the "0" value this
way. So while I'm not certain this is the best for the long term, this
looks the sweet spot for the short term to resolve many issues at
once.

Thanks!
Andrea

