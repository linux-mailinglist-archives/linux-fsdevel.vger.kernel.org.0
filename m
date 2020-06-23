Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483C1205BF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 21:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387433AbgFWTk2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 15:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733248AbgFWTk2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 15:40:28 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2D9C061573;
        Tue, 23 Jun 2020 12:40:27 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i12so1914282pju.3;
        Tue, 23 Jun 2020 12:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W0/5gWMppgD2vCWy1ifOWG13sjOkfYv2ZZfFDgxMieI=;
        b=LEepuVcuNqKScu1r2WZvD+VYrf5Gjx8yg6bPuiCQopiOCoqN/2rMLYrgl3OD8DwAOU
         rG2dwHM9L1InJCKZ0fddjiigxHPZpXLp4KMtgfL1zp3azHhU4t+7HTk23FVrHm3HzS0j
         87DCa0vRgOUUSOtoc6lOJ+2c7V8aYk+dEZ1bnB/cZUxMzkzUtfLgqq0KqykFGVLIpine
         xMKWZ8DvX6dW4MUXSPepIxBlcJ5hx9Gx2dJkBt4wcdVxTW2h3YZk7IzJeGHWno/hvxGJ
         9m5MSQ8iUwmRrWOHnf2XEracX/jZECHVqQmJzwCFBaatT8eRz7FlO9kN5QE0BFLeyLUh
         WnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W0/5gWMppgD2vCWy1ifOWG13sjOkfYv2ZZfFDgxMieI=;
        b=fn0iAJu3gmyri6QvD1cmRoJvLGqG7f4gkhXCob5e04HiVANKoh0gYvx2WgRxmuN5QE
         IP5Oc4XDqM2xAqNsvTDKwis0LzeX3Vph2GOK3R9TabO08OxzM9s4BTqnsbYkAXEpYw01
         Ip+jXQIFhlW7CZjAJ88H+uu3uqpq2LDON5bANM2pdiNMHAsRwFoiP7PDq2Eun5SNsmBG
         gKzZfYCHEf2vgStxPN54ZkPAc0qM/Inf0/j9GcLx1pyXqh6Q5Ts3aix5+e4gKb944TQy
         pEKka3n/HG3/c+lf+sVRDMRre4XjQTSzUcH7jT1OvQfWhISSTcZWGSzB7K5D9IOHjWev
         VnvQ==
X-Gm-Message-State: AOAM530evgfkAfmSnYz/dmGAkZBoFHk6chYqxUZe80T2oA1myoqmJx4j
        ZyeIzHBCv/hX6mat4wspDLo=
X-Google-Smtp-Source: ABdhPJyKmVy2AeOC0TxD8qstnmtKtbhUN3MYZAUYkOcOPaYs1Jj6ox6g9zz76MfIV1e2t4N8vPpIiQ==
X-Received: by 2002:a17:90a:ea86:: with SMTP id h6mr3956068pjz.200.1592941227159;
        Tue, 23 Jun 2020 12:40:27 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:4e7a])
        by smtp.gmail.com with ESMTPSA id r1sm3027172pjd.47.2020.06.23.12.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 12:40:26 -0700 (PDT)
Date:   Tue, 23 Jun 2020 12:40:23 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
Message-ID: <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
References: <87d066vd4y.fsf@x220.int.ebiederm.org>
 <20200611233134.5vofl53dj5wpwp5j@ast-mbp.dhcp.thefacebook.com>
 <87bllngirv.fsf@x220.int.ebiederm.org>
 <CAADnVQ+qNxFjTYBpYW9ZhStMh_oJBS5C_FsxSS=0Mzy=u54MSg@mail.gmail.com>
 <CAADnVQLuGYX=LamARhrZcze1ej4ELj-y99fLzOCgz60XLPw_cQ@mail.gmail.com>
 <87ftaxd7ky.fsf@x220.int.ebiederm.org>
 <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
 <87h7v1pskt.fsf@x220.int.ebiederm.org>
 <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
 <87h7v1mx4z.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7v1mx4z.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 23, 2020 at 01:53:48PM -0500, Eric W. Biederman wrote:
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> 
> > On Tue, Jun 23, 2020 at 01:04:02PM -0500, Eric W. Biederman wrote:
> >> 
> >> Sigh.  I was busy last week so I left reading this until now in the
> >> hopes I would see something reasonable.
> >> 
> >> What I see is rejecting of everything that is said to you.
> >> 
> >> What I do not see are patches fixing issues.  I will await patches.
> >
> > huh?
> > I can say exactly the same. You keep ignoring numerous points I brought up.
> > You still haven't showed what kind of refactoring you have in mind and
> > why fork_blob is in its way.
> 
> That is correct.  What I wind up doing with exec is irrelevant.
> 
> What is relevant is getting correct working code on the fork_blob path.
> Something that is clean enough that whatever weird things it winds up
> doing are readable.  The way things are intermingled today it took 2
> years for someone to realize there was a basic reference counting bug.

There is no refcnt bug. It was a user error on tomoyo side.
fork_blob() works as expected.

> This isn't work anyone else can do because there are not yet any real in
> tree users of fork_blob.  The fact that no one else can make
> substantials changes to the code because it has no users is what gets in
> the way of maintenance.

Not true either.
bpfilter is a full blown user. bpfilter itself didn't go anywhere,
but that's a different story.

> One of the 2 year old bugs that needs to be fixed is that some LSMs
> work in terms of paths.  Tetsuo has been very gracious in pointing that
> out.  Either a path needs to be provided or the LSMs that work in terms
> of paths need to be fixed.

Not true again.
usermode_blob is part of the kernel module.
Kernel module when loaded doesn't have path.
tomoyo has to fix itself.

> Now I really don't care how the bugs are fixed.
> 
> 
> My recomendation for long term maintenance is to split fork_blob into 2
> functions: fs_from_blob, and the ordinary call_usermodehelper_exec.

what is fs_from_blob() ?
If you mean to create a file system from a blob then it makes no sense.
Please read upthread why. I'm not going to repeat the same points.

> So patches to fix the bugs please.

There are bugs. Ok?
This pointless thread is happening because you want to do some refactoring
of the code and somehow believe that fork_blob is in your way.
If you cannot do refactoring without screaming about removal and misreading
implementation details may be you shouldn't be doing that refactoring.
