Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB051DBC3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 20:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgETSDo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 14:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgETSDn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 14:03:43 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE31DC05BD43
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2020 11:03:42 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ci23so1701919pjb.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2020 11:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4gedS5z2xUBNPz+Ub7NmjuaMewCM/6KJ5Nb+BZM0cYA=;
        b=i2gEr4aClpisfvaW3sWRRYnHudnywtDQIglybb1KsEhteuY0ZA+C5QXF9Vn2+gfm4u
         aSgjm29EaaoEB1GVZMwTIr4V930XxzwhlTKSlKueYKSueV5uUB5mb74Pj/mS9rSioi3z
         wlv2GINuwEzIenvfv+tdIb2MObGfqp9IcxGH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4gedS5z2xUBNPz+Ub7NmjuaMewCM/6KJ5Nb+BZM0cYA=;
        b=ocUyS8oXhKNorNhH0JpgX7ndqaP6YVYmao5PHX20Qa6nxyp3rz50wrAFVEnDoXsRGd
         rtGuc24KkKotewlIccG7nX3Ds3eR/YbmCLSefs7gsN5myzwp50MaSJUFJpIMX9ctqh4g
         YhVfXkFE3mRj1j6h6q3VSpmJO/xrhQSvD7wjpuj5fXfxwdquI4SinX+7S/gpyRS9uxXt
         NELqus5YSqBsxnx/LQuB8DHzwvZjJq7y6rvn1yFhqNsgcVua8z99jzPdRqPEm3hvqNH8
         Pp+G/Mrnxdnx6sp7dbItgI7avMNs8spUnVH8CrkVQT9Gxker/rvyuEvdH5gSRJTq29RN
         16MA==
X-Gm-Message-State: AOAM533fv/kbVc64ifu+Xfns1sq5bdHpGAU7EurQb0TIb3aw6M2Palv4
        iTx2Y7URsxunhAMoQG0xbCp51Q==
X-Google-Smtp-Source: ABdhPJywSUMv3OTUOybuNLK/NiW3pp8eDXdsEFZpG/7jR7fa0zoJ1fFAxDsUgkID05OkZNOsz/CHKg==
X-Received: by 2002:a17:902:b907:: with SMTP id bf7mr5718198plb.136.1589997821983;
        Wed, 20 May 2020 11:03:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h7sm2389595pgg.17.2020.05.20.11.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 11:03:40 -0700 (PDT)
Date:   Wed, 20 May 2020 11:03:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrea Arcangeli <aarcange@redhat.com>
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
Message-ID: <202005200921.2BD5A0ADD@keescook>
References: <20200423002632.224776-1-dancol@google.com>
 <20200423002632.224776-3-dancol@google.com>
 <20200508125054-mutt-send-email-mst@kernel.org>
 <20200508125314-mutt-send-email-mst@kernel.org>
 <20200520045938.GC26186@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520045938.GC26186@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 20, 2020 at 12:59:38AM -0400, Andrea Arcangeli wrote:
> Hello everyone,
> 
> On Fri, May 08, 2020 at 12:54:03PM -0400, Michael S. Tsirkin wrote:
> > On Fri, May 08, 2020 at 12:52:34PM -0400, Michael S. Tsirkin wrote:
> > > On Wed, Apr 22, 2020 at 05:26:32PM -0700, Daniel Colascione wrote:
> > > > This sysctl can be set to either zero or one. When zero (the default)
> > > > the system lets all users call userfaultfd with or without
> > > > UFFD_USER_MODE_ONLY, modulo other access controls. When
> > > > unprivileged_userfaultfd_user_mode_only is set to one, users without
> > > > CAP_SYS_PTRACE must pass UFFD_USER_MODE_ONLY to userfaultfd or the API
> > > > will fail with EPERM. This facility allows administrators to reduce
> > > > the likelihood that an attacker with access to userfaultfd can delay
> > > > faulting kernel code to widen timing windows for other exploits.
> > > > 
> > > > Signed-off-by: Daniel Colascione <dancol@google.com>
> > > 
> > > The approach taken looks like a hard-coded security policy.
> > > For example, it won't be possible to set the sysctl knob
> > > in question on any sytem running kvm. So this is
> > > no good for any general purpose system.

Not all systems run unprivileged KVM. :)

> > > What's wrong with using a security policy for this instead?
> > 
> > In fact I see the original thread already mentions selinux,
> > so it's just a question of making this controllable by
> > selinux.
> 
> I agree it'd be preferable if it was not hardcoded, but then this
> patchset is also much simpler than the previous controlling it through
> selinux..
> 
> I was thinking, an alternative policy that could control it without
> hard-coding it, is a seccomp-bpf filter, then you can drop 2/2 as
> well, not just 1/6-4/6.

Err, did I miss a separate 6-patch series? I can't find anything on lore.

> 
> If you keep only 1/2, can't seccomp-bpf enforce userfaultfd to be
> always called with flags==0x1 without requiring extra modifications in
> the kernel?

Please no. This is way too much overhead for something that a system
owner wants to enforce globally. A sysctl is the correct option here,
IMO. If it needs to be a per-userns sysctl, that would be fine too.

> Can't you get the feature party with the CAP_SYS_PTRACE capability
> too, if you don't wrap those tasks with the ptrace capability under
> that seccomp filter?
> 
> As far as I can tell, it's unprecedented to create a flag for a
> syscall API, with the only purpose of implementing a seccomp-bpf
> filter verifying such flag is set, but then if you want to control it
> with LSM it's even more complex than doing it with seccomp-bpf, and it
> requires more kernel code too. We could always add 2/2 later, such
> possibility won't disappear, in fact we could also add 1/6-4/6 later
> too if that is not enough.
> 
> If we could begin by merging only 1/2 from this new series and be done
> with the kernel changes, because we offload the rest of the work to
> the kernel eBPF JIT, I think it'd be ideal.

I'd agree that patch 1 should land, as it appears to be required for any
further policy considerations. I'm still a big fan of a sysctl since
this is the kind of thing I would absolutely turn on globally for all my
systems.

-- 
Kees Cook
