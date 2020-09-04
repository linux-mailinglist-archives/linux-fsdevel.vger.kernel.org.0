Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1553925CFD1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 05:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgIDDe4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 23:34:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52962 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729554AbgIDDex (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 23:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599190492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Sivd+X8sSjHVFUEdDJB8sFaPEg6xaM+EZovO2ogqnQ=;
        b=dZ2s5akagYVMMSuu4Zgn4mOhSnkUm2D3IEnV8kfVQkHcxE0YUlbqUlbDLpaYFTB3Hv6Uby
        UjzOAgeuMKdG8KoXXqSTqGnAVbSkFQktbPQzQ57eolmwjcWDJId9TW3UjpFiwg/AYriTST
        3TIkAu+kIHNZrivvps3KYEJ2Q2V9GSc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-h8uTNWP-NaKEZHA0lwJCVQ-1; Thu, 03 Sep 2020 23:34:48 -0400
X-MC-Unique: h8uTNWP-NaKEZHA0lwJCVQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 193DF107465A;
        Fri,  4 Sep 2020 03:34:45 +0000 (UTC)
Received: from mail (ovpn-113-36.rdu2.redhat.com [10.10.113.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 02E12100239F;
        Fri,  4 Sep 2020 03:34:39 +0000 (UTC)
Date:   Thu, 3 Sep 2020 23:34:38 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Nick Kralevich <nnk@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>,
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
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Minchan Kim <minchan@google.com>,
        Sandeep Patil <sspatil@google.com>, kernel@android.com,
        Daniel Colascione <dancol@dancol.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 2/2] Add a new sysctl knob:
 unprivileged_userfaultfd_user_mode_only
Message-ID: <20200904033438.GI9411@redhat.com>
References: <20200520195134.GK26186@redhat.com>
 <CA+EESO4wEQz3CMxNLh8mQmTpUHdO+zZbV10zUfYGKEwfRPK2nQ@mail.gmail.com>
 <20200520211634.GL26186@redhat.com>
 <CABXk95A-E4NYqA5qVrPgDF18YW-z4_udzLwa0cdo2OfqVsy=SQ@mail.gmail.com>
 <CA+EESO4kLaje0yTOyMSxHfSLC0n86zAF+M1DWB_XrwFDLOCawQ@mail.gmail.com>
 <CAFJ0LnGfrzvVgtyZQ+UqRM6F3M7iXOhTkUBTc+9sV+=RrFntyQ@mail.gmail.com>
 <20200724093852-mutt-send-email-mst@kernel.org>
 <CAFJ0LnEZghYj=d3w8Fmko4GZAWw6Qc5rgAMmXj-8qgXtyU3bZQ@mail.gmail.com>
 <20200806004351-mutt-send-email-mst@kernel.org>
 <CA+EESO6bxhKf5123feNX1LZyyN2QL4Ti5ApPAu=xb3pHXd7cwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+EESO6bxhKf5123feNX1LZyyN2QL4Ti5ApPAu=xb3pHXd7cwQ@mail.gmail.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Mon, Aug 17, 2020 at 03:11:16PM -0700, Lokesh Gidra wrote:
> There has been an emphasis that Android is probably the only user for
> the restriction of userfaults from kernel-space and that it wouldn’t
> be useful anywhere else. I humbly disagree! There are various areas
> where the PROT_NONE+SIGSEGV trick is (and can be) used in a purely
> user-space setting. Basically, any lazy, on-demand,

For the record what I said is quoted below
https://lkml.kernel.org/r/20200520194804.GJ26186@redhat.com :

"""It all boils down of how peculiar it is to be able to leverage only
the acceleration [..] Right now there's a single user that can cope
with that limitation [..] If there will be more users [..]  it'd be
fine to add a value "2" later."""

Specifically I never said "that it wouldn’t be useful anywhere else.".

Also I'm only arguing about the sysctl visible kABI change in patch
2/2: the flag passed as parameter to the syscall in patch 1/2 is all
great, because seccomp needs it in the scalar parameter of the syscall
to implement a filter equivalent to your sysctl "2" policy with only
patch 1/2 applied.

I've two more questions now:

1) why don't you enforce the block of kernel initiated faults with
   seccomp-bpf instead of adding a sysctl value 2? Is the sysctl just
   an optimization to remove a few instructions per syscall in the bpf
   execution of Android unprivileged apps? You should block a lot of
   other syscalls by default to all unprivileged processes, including
   vmsplice.

   In other words if it's just for Android, why can't Android solve it
   with only patch 1/2 by tweaking the seccomp filter?

2) given that Android is secure enough with the sysctl at value 2, why
   should we even retain the current sysctl 0 semantics? Why can't
   more secure systems just use seccomp and block userfaultfd, as it
   is already happens by default in the podman default seccomp
   whitelist (for those containers that don't define a new json
   whitelist in the OCI schema)? Shouldn't we focus our energy in
   making containers more secure by preventing the OCI schema of a
   random container to re-enable userfaultfd in the container seccomp
   filter instead of trying to solve this with a global sysctl?

   What's missing in my view is a kubernetes hard allowlist/denylist
   that cannot be overridden with the OCI schema in case people has
   the bad idea of running containers downloaded from a not fully
   trusted source, without adding virt isolation and that's an
   userland problem to be solved in the container runtime, not a
   kernel issue. Then you'd just add userfaultfd to the json of the
   k8s hard seccomp denylist instead of going around tweaking sysctl.

What's your take in changing your 2/2 patch to just replace value "0"
and avoid introducing a new value "2"?

The value "0" was motivated by the concern that uffd can enlarge the
race window for use after free by providing one more additional way to
block kernel faults, but value "2" is already enough to solve that
concern completely and it'll be the default on all Android.

In other words by adding "2" you're effectively doing a more
finegrined and more optimal implementation of "0" that remains useful
and available to unprivileged apps and it already resolves all
"robustness against side effects other kernel bugs" concerns. Clearly
"0" is even more secure statistically but that would apply to every
other syscall including vmsplice, and there's no
/proc/sys/vm/unprivileged_vmsplice sysctl out there.

The next issue we have now is with the pipe mutex (which is not a
major concern but we need to solve it somehow for correctness). So I
wonder if should make the default value to be "0" (or "2" if think we
should not replace "0") and to allow only user initiated faults by
default.

Changing the sysctl default to be 0, will make live migration fail to
switch to postcopy which will be (unnoticeable to the guest), instead
of risking the VM to be killed because of network latency
outlier. Then we wouldn't need to change the pipe code at all.

Alternatively we could still fix the pipe code so it runs better (but
it'll be more complex) or to disable uffd faults only in the pipe
code.

One thing to keep in mind is that if we change the default, then
hypervisor hosts running QEMU would need to set:

vm.userfaultfd = 1

in /etc/sysctl.conf if postcopy live migration is required, that's not
particularly concerning constraint for qemu (there are likely other
tweaks required and it looks less risky than an arbitrary timeout
which could kill the VM: if the above is forgotten the postcopy live
migration won't even start and it'll be unnoticeable to the guest).

The main concern really are future apps that may want to use uffd for
kernel initiated faults won't be allowed to do so by default anymore,
those apps will be heavily incentivated to use bounce buffers before
passing data to syscalls, similarly to the current use case of patch 2/2.

Comments welcome,
Andrea

PS. Another usage of uffd that remains possible without privilege with
the 2/2 patch sysctl "2" behavior (besides the strict SIGSEGV
acceleration) is the UFFD_FEATURE_SIGBUS. That's good so a malloc lib
will remain possible without requiring extra privileges, by adding a
UFFDIO_POPULATE to use in combination with UFFD_FEATURE_SIGBUS
(UFFDIO_POPULATE just needs to zero out a page and map it, it'll be
indistinguishable to UFFDIO_ZEROPAGE but it will solve the last
performance bottleneck by avoiding a wrprotect fault after the
allocation and it will be THP capable too). Memory will be freed with
MADV_DONTNEED, without ever having to call mmap/mumap. It could move
memory around with UFFDIO_COPY+MADV_DONTNEED or by adding UFFDIO_REMAP
which already exists.

