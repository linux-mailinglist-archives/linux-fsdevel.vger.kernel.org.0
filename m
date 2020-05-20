Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EE51DA991
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 06:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgETE7x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 00:59:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51680 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726403AbgETE7w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 00:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589950791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NzRuCXGE7RhfvXL+xzJ6ifDK+x2b4dBICd6MmzRaGuA=;
        b=WZ0SrHK1RtL0keVbKSw9Txj7emNDY8qT0NT2n+po9NUQIUA70QaQSTaG1esBi4NDS1ORrW
        itaqI0axKf7pOdF/FMmYxtDr2zUqrlAtUhloVC7k3yUeYuXigLzrV1+aUT+0EKKlweZ9pv
        Uc2doZ7MczMBYYE30qcndMfUnoNOwOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-tFFgHWsFOBaAec_iH28Mfg-1; Wed, 20 May 2020 00:59:47 -0400
X-MC-Unique: tFFgHWsFOBaAec_iH28Mfg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0791835B44;
        Wed, 20 May 2020 04:59:44 +0000 (UTC)
Received: from mail (ovpn-112-106.rdu2.redhat.com [10.10.112.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CD1783841;
        Wed, 20 May 2020 04:59:39 +0000 (UTC)
Date:   Wed, 20 May 2020 00:59:38 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Daniel Colascione <dancol@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
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
Message-ID: <20200520045938.GC26186@redhat.com>
References: <20200423002632.224776-1-dancol@google.com>
 <20200423002632.224776-3-dancol@google.com>
 <20200508125054-mutt-send-email-mst@kernel.org>
 <20200508125314-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508125314-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello everyone,

On Fri, May 08, 2020 at 12:54:03PM -0400, Michael S. Tsirkin wrote:
> On Fri, May 08, 2020 at 12:52:34PM -0400, Michael S. Tsirkin wrote:
> > On Wed, Apr 22, 2020 at 05:26:32PM -0700, Daniel Colascione wrote:
> > > This sysctl can be set to either zero or one. When zero (the default)
> > > the system lets all users call userfaultfd with or without
> > > UFFD_USER_MODE_ONLY, modulo other access controls. When
> > > unprivileged_userfaultfd_user_mode_only is set to one, users without
> > > CAP_SYS_PTRACE must pass UFFD_USER_MODE_ONLY to userfaultfd or the API
> > > will fail with EPERM. This facility allows administrators to reduce
> > > the likelihood that an attacker with access to userfaultfd can delay
> > > faulting kernel code to widen timing windows for other exploits.
> > > 
> > > Signed-off-by: Daniel Colascione <dancol@google.com>
> > 
> > The approach taken looks like a hard-coded security policy.
> > For example, it won't be possible to set the sysctl knob
> > in question on any sytem running kvm. So this is
> > no good for any general purpose system.
> > 
> > What's wrong with using a security policy for this instead?
> 
> In fact I see the original thread already mentions selinux,
> so it's just a question of making this controllable by
> selinux.

I agree it'd be preferable if it was not hardcoded, but then this
patchset is also much simpler than the previous controlling it through
selinux..

I was thinking, an alternative policy that could control it without
hard-coding it, is a seccomp-bpf filter, then you can drop 2/2 as
well, not just 1/6-4/6.

If you keep only 1/2, can't seccomp-bpf enforce userfaultfd to be
always called with flags==0x1 without requiring extra modifications in
the kernel?

Can't you get the feature party with the CAP_SYS_PTRACE capability
too, if you don't wrap those tasks with the ptrace capability under
that seccomp filter?

As far as I can tell, it's unprecedented to create a flag for a
syscall API, with the only purpose of implementing a seccomp-bpf
filter verifying such flag is set, but then if you want to control it
with LSM it's even more complex than doing it with seccomp-bpf, and it
requires more kernel code too. We could always add 2/2 later, such
possibility won't disappear, in fact we could also add 1/6-4/6 later
too if that is not enough.

If we could begin by merging only 1/2 from this new series and be done
with the kernel changes, because we offload the rest of the work to
the kernel eBPF JIT, I think it'd be ideal.

Thanks,
Andrea

