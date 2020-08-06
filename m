Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF9123D683
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Aug 2020 07:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgHFFoW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Aug 2020 01:44:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30386 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726093AbgHFFoV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Aug 2020 01:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596692659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B1WkhY8QD0f5DxDB9jVqeA3H8Wo7kGb4Rskkut4YioA=;
        b=HP6Mu1Vr9CY1VqEdvQTRQNqNP3EGiSIbfH1nWwef/DU/4Ow5o8dWtF4ixazHGUOkXCyiAH
        hJOb7SPulusgua0E0znzJukJJerR7s6g6sQqqWqQiAZgCPoVlX3L/O9+6CN0CRhs6aD41y
        CZzUNTfFjVNodmV1ENd3PPAnNdvDSPo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-PXGtul31MgaGlojmTDTaXg-1; Thu, 06 Aug 2020 01:44:09 -0400
X-MC-Unique: PXGtul31MgaGlojmTDTaXg-1
Received: by mail-wm1-f72.google.com with SMTP id t26so3662648wmn.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Aug 2020 22:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B1WkhY8QD0f5DxDB9jVqeA3H8Wo7kGb4Rskkut4YioA=;
        b=t8VeD6YVqa4qDgUysIok7I+imxg2JfGcQrwgjEq7oX7IBM1gRGJNRSTisujBlt0p3K
         KSWY+xNjGNA7b9hMS5542wryoA3zwnkhhXFghO/9G2JUE1+89hoZu2YE9AuWZnE3W+wB
         fl3gjd1buoiDGgTGwrszRrj3LFGz8uPJ3O9L8RPhGwiTJg1+rSompsFN+TUO/b1GNNXV
         3C0qNYYv1/gpN25aD8hWGMrf44P85uwky3EXhPqnjUYANjpEEiE56+XXFhEcBC/1Ue1K
         Xq0yFmoNletJog2PiyD5DHsmP4kPaOD/V9L2ySNBcx5XRIkhvUNEV7mtjcmUL0bhXAYD
         iSzg==
X-Gm-Message-State: AOAM531dNdX5WChy31gRXdn0WBPdwK0elBnNXtz1TxtiwGPV0TgAY8rk
        tdPVv8DQ6AGpOZl/ILMWKG0Q2WZP89Gs2/ogn1JT/beC2P+E3WHPQbgboyuzX0WHS6Sr/dFQU6S
        7XE4li20Mn9yUcGFTZqEPY1bjMw==
X-Received: by 2002:a1c:2095:: with SMTP id g143mr6059854wmg.78.1596692647830;
        Wed, 05 Aug 2020 22:44:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmPXCaeMja3+wQqRTRcnR9xvH5V51yW3HFk0DygRewkzwUjPll1ovSwhp2Uz6I/TBHtDNZTQ==
X-Received: by 2002:a1c:2095:: with SMTP id g143mr6059816wmg.78.1596692647427;
        Wed, 05 Aug 2020 22:44:07 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id v12sm5079783wri.47.2020.08.05.22.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 22:44:06 -0700 (PDT)
Date:   Thu, 6 Aug 2020 01:44:01 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Nick Kralevich <nnk@google.com>
Cc:     Lokesh Gidra <lokeshgidra@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
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
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH 2/2] Add a new sysctl knob:
 unprivileged_userfaultfd_user_mode_only
Message-ID: <20200806004351-mutt-send-email-mst@kernel.org>
References: <202005200921.2BD5A0ADD@keescook>
 <20200520194804.GJ26186@redhat.com>
 <20200520195134.GK26186@redhat.com>
 <CA+EESO4wEQz3CMxNLh8mQmTpUHdO+zZbV10zUfYGKEwfRPK2nQ@mail.gmail.com>
 <20200520211634.GL26186@redhat.com>
 <CABXk95A-E4NYqA5qVrPgDF18YW-z4_udzLwa0cdo2OfqVsy=SQ@mail.gmail.com>
 <CA+EESO4kLaje0yTOyMSxHfSLC0n86zAF+M1DWB_XrwFDLOCawQ@mail.gmail.com>
 <CAFJ0LnGfrzvVgtyZQ+UqRM6F3M7iXOhTkUBTc+9sV+=RrFntyQ@mail.gmail.com>
 <20200724093852-mutt-send-email-mst@kernel.org>
 <CAFJ0LnEZghYj=d3w8Fmko4GZAWw6Qc5rgAMmXj-8qgXtyU3bZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFJ0LnEZghYj=d3w8Fmko4GZAWw6Qc5rgAMmXj-8qgXtyU3bZQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 05, 2020 at 05:43:02PM -0700, Nick Kralevich wrote:
> On Fri, Jul 24, 2020 at 6:40 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Jul 23, 2020 at 05:13:28PM -0700, Nick Kralevich wrote:
> > > On Thu, Jul 23, 2020 at 10:30 AM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > > > From the discussion so far it seems that there is a consensus that
> > > > patch 1/2 in this series should be upstreamed in any case. Is there
> > > > anything that is pending on that patch?
> > >
> > > That's my reading of this thread too.
> > >
> > > > > > Unless I'm mistaken that you can already enforce bit 1 of the second
> > > > > > parameter of the userfaultfd syscall to be set with seccomp-bpf, this
> > > > > > would be more a question to the Android userland team.
> > > > > >
> > > > > > The question would be: does it ever happen that a seccomp filter isn't
> > > > > > already applied to unprivileged software running without
> > > > > > SYS_CAP_PTRACE capability?
> > > > >
> > > > > Yes.
> > > > >
> > > > > Android uses selinux as our primary sandboxing mechanism. We do use
> > > > > seccomp on a few processes, but we have found that it has a
> > > > > surprisingly high performance cost [1] on arm64 devices so turning it
> > > > > on system wide is not a good option.
> > > > >
> > > > > [1] https://lore.kernel.org/linux-security-module/202006011116.3F7109A@keescook/T/#m82ace19539ac595682affabdf652c0ffa5d27dad
> > >
> > > As Jeff mentioned, seccomp is used strategically on Android, but is
> > > not applied to all processes. It's too expensive and impractical when
> > > simpler implementations (such as this sysctl) can exist. It's also
> > > significantly simpler to test a sysctl value for correctness as
> > > opposed to a seccomp filter.
> >
> > Given that selinux is already used system-wide on Android, what is wrong
> > with using selinux to control userfaultfd as opposed to seccomp?
> 
> Userfaultfd file descriptors will be generally controlled by SELinux.
> You can see the patchset at
> https://lore.kernel.org/lkml/20200401213903.182112-3-dancol@google.com/
> (which is also referenced in the original commit message for this
> patchset). However, the SELinux patchset doesn't include the ability
> to control FAULT_FLAG_USER / UFFD_USER_MODE_ONLY directly.
> 
> SELinux already has the ability to control who gets CAP_SYS_PTRACE,
> which combined with this patch, is largely equivalent to direct
> UFFD_USER_MODE_ONLY checks. Additionally, with the SELinux patch
> above, movement of userfaultfd file descriptors can be mediated by
> SELinux, preventing one process from acquiring userfaultfd descriptors
> of other processes unless allowed by security policy.
> 
> It's an interesting question whether finer-grain SELinux support for
> controlling UFFD_USER_MODE_ONLY should be added. I can see some
> advantages to implementing this. However, we don't need to decide that
> now.
>
> Kernel security checks generally break down into DAC (discretionary
> access control) and MAC (mandatory access control) controls. Most
> kernel security features check via both of these mechanisms. Security
> attributes of the system should be settable without necessarily
> relying on an LSM such as SELinux. This patch follows the same basic
> model -- system wide control of a hardening feature is provided by the
> unprivileged_userfaultfd_user_mode_only sysctl (DAC), and if needed,
> SELinux support for this can also be implemented on top of the DAC
> controls.
> 
> This DAC/MAC split has been successful in several other security
> features. For example, the ability to map at page zero is controlled
> in DAC via the mmap_min_addr sysctl [1], and via SELinux via the
> mmap_zero access vector [2]. Similarly, access to the kernel ring
> buffer is controlled both via DAC as the dmesg_restrict sysctl [3], as
> well as the SELinux syslog_read [2] check. Indeed, the dmesg_restrict
> sysctl is very similar to this patch -- it introduces a capability
> (CAP_SYSLOG, CAP_SYS_PTRACE) check on access to a sensitive resource.
> 
> If we want to ensure that a security feature will be well tested and
> vetted, it's important to not limit its use to LSMs only. This ensures
> that kernel and application developers will always be able to test the
> effects of a security feature, without relying on LSMs like SELinux.
> It also ensures that all distributions can enable this security
> mitigation should it be necessary for their unique environments,
> without introducing an SELinux dependency. And this patch does not
> preclude an SELinux implementation should it be necessary.
> 
> Even if we decide to implement fine-grain SELinux controls on
> UFFD_USER_MODE_ONLY, we still need this patch. We shouldn't make this
> an either/or choice between SELinux and this patch. Both are
> necessary.
> 
> -- Nick
> 
> [1] https://wiki.debian.org/mmap_min_addr
> [2] https://selinuxproject.org/page/NB_ObjectClassesPermissions
> [3] https://www.kernel.org/doc/Documentation/sysctl/kernel.txt

I am not sure I agree this is similar to dmesg access.

The reason I say it is this: it is pretty easy for admins to know
whether they run something that needs to access the kernel ring buffer.
Or if it's a tool developer poking at dmesg, they can tell admins "we
need these permissions".  But it seems impossible for either an admin to
know that a userfaultfd page e.g. used with shared memory is accessed
from the kernel.

So I guess the question is: how does anyone not running Android
know to set this flag?

I got the feeling it's not really possible, and so for a single-user
feature like this a single API seems enough.  Given a choice between a
knob an admin is supposed to set and selinux policy written by
presumably knowledgeable OS vendors, I'd opt for a second option.

Hope this helps.

> >
> >
> > > > > >
> > > > > >
> > > > > > If answer is "no" the behavior of the new sysctl in patch 2/2 (in
> > > > > > subject) should be enforceable with minor changes to the BPF
> > > > > > assembly. Otherwise it'd require more changes.
> > >
> > > It would be good to understand what these changes are.
> > >
> > > > > > Why exactly is it preferable to enlarge the surface of attack of the
> > > > > > kernel and take the risk there is a real bug in userfaultfd code (not
> > > > > > just a facilitation of exploiting some other kernel bug) that leads to
> > > > > > a privilege escalation, when you still break 99% of userfaultfd users,
> > > > > > if you set with option "2"?
> > >
> > > I can see your point if you think about the feature as a whole.
> > > However, distributions (such as Android) have specialized knowledge of
> > > their security environments, and may not want to support the typical
> > > usages of userfaultfd. For such distributions, providing a mechanism
> > > to prevent userfaultfd from being useful as an exploit primitive,
> > > while still allowing the very limited use of userfaultfd for userspace
> > > faults only, is desirable. Distributions shouldn't be forced into
> > > supporting 100% of the use cases envisioned by userfaultfd when their
> > > needs may be more specialized, and this sysctl knob empowers
> > > distributions to make this choice for themselves.
> > >
> > > > > > Is the system owner really going to purely run on his systems CRIU
> > > > > > postcopy live migration (which already runs with CAP_SYS_PTRACE) and
> > > > > > nothing else that could break?
> > >
> > > This is a great example of a capability which a distribution may not
> > > want to support, due to distribution specific security policies.
> > >
> > > > > >
> > > > > > Option "2" to me looks with a single possible user, and incidentally
> > > > > > this single user can already enforce model "2" by only tweaking its
> > > > > > seccomp-bpf filters without applying 2/2. It'd be a bug if android
> > > > > > apps runs unprotected by seccomp regardless of 2/2.
> > >
> > > Can you elaborate on what bug is present by processes being
> > > unprotected by seccomp?
> > >
> > > Seccomp cannot be universally applied on Android due to previously
> > > mentioned performance concerns. Seccomp is used in Android primarily
> > > as a tool to enforce the list of allowed syscalls, so that such
> > > syscalls can be audited before being included as part of the Android
> > > API.
> > >
> > > -- Nick
> > >
> > > --
> > > Nick Kralevich | nnk@google.com
> >
> 
> 
> -- 
> Nick Kralevich | nnk@google.com

