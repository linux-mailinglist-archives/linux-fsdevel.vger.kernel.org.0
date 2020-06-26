Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E961E20AA4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 03:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgFZBv1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 21:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgFZBv0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 21:51:26 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB3CC08C5C1;
        Thu, 25 Jun 2020 18:51:26 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x207so3957397pfc.5;
        Thu, 25 Jun 2020 18:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZbdfP/ttYFnO0t8hjvqaCmIEc8PNIiqMUHAFOV+45dk=;
        b=gA9FamS1A5iqARDpi3pFwy7JlDXzxZMhl77gPFD7MXsWqJUqF3ArsskCpXvutjq7bR
         3qpFfnA/6PN+kOIXBR26TAAEpHsbWvXQwpr9BT1mWqLlW1PnU71kGwb0bnd2ZvZ2AeGu
         kGyuxfQZ6/9aG1PSyhI4RVqxkMQVNTd8W1qr8ida47xOjALMRXb7SNS2aBD8yzfdiItU
         HliODUARjv9Bo4z7HnzC/ewpelDMl03DEGeEp1FXKmNWwI2Mymky8rJuDwHBpNniLhz6
         mhJoZv2MT/6ZN7nJwt2vLsULgXE8QmYkG1eBXt21w6Be8TW+kKv3S2trdY4ehB/mBvbk
         1Jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZbdfP/ttYFnO0t8hjvqaCmIEc8PNIiqMUHAFOV+45dk=;
        b=E+mvlgojQGIeEXu05SrsPChWGfhlleowoFhTv+lndFe32nZkE1Ftdd96IOLaUJgidf
         lJROkVtBKZs5k7WWkMzcbbzj3Py0Ic81Z3Rzm7P8Mg/lRP0GwjiTwyl230tNUuJ/o8ho
         lmHA2fxythfFJ8YOF9iq0IG/rEvZ+UCjTwSanlfSV8rtNiIy421NjFr2bJuem7h8eytx
         MmwFgru5v8/eRec8/fjseACyF8WA+ChZXSIvjO5fw+M5ntgYsuAGuFnq40V1ZUSsXAqX
         Z45Zv4jZtwlYXNWXWtpfBR5yrO6sztNgOF0aT7ctGzqwKqOrBCIBvx6k4jBDnqvDCNvS
         1v9g==
X-Gm-Message-State: AOAM530uFyXnblw25nHN7jPB3rn2zMMb3/4X5ljT+XvteZbECaucrQnY
        qTyrbUMvNNpsY6S1UmOqQfg=
X-Google-Smtp-Source: ABdhPJxV8+3Eu4YtbA0pf/GUPg6foxeb1Il5eiU3aMFgAC5tRV8IqQRe7bKKwW1H0573iRCM/FfIqA==
X-Received: by 2002:a62:8f8f:: with SMTP id n137mr551708pfd.270.1593136286195;
        Thu, 25 Jun 2020 18:51:26 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:1ff2])
        by smtp.gmail.com with ESMTPSA id u200sm8638868pfc.43.2020.06.25.18.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 18:51:24 -0700 (PDT)
Date:   Thu, 25 Jun 2020 18:51:22 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
Message-ID: <20200626015121.qpxkdaqtsywe3zqx@ast-mbp.dhcp.thefacebook.com>
References: <20200625095725.GA3303921@kroah.com>
 <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
 <20200625120725.GA3493334@kroah.com>
 <20200625.123437.2219826613137938086.davem@davemloft.net>
 <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 25, 2020 at 06:36:34PM -0700, Linus Torvalds wrote:
> On Thu, Jun 25, 2020 at 12:34 PM David Miller <davem@davemloft.net> wrote:
> >
> > It's kernel code executing in userspace.  If you don't trust the
> > signed code you don't trust the signed code.
> >
> > Nothing is magic about a piece of code executing in userspace.
> 
> Well, there's one real issue: the most likely thing that code is going
> to do is execute llvm to generate more code.
> 
> And that's I think the real security issue here: the context in which
> the code executes. It may be triggered in one namespace, but what
> namespaces and what rules should the thing actually then execute in.
> 
> So no, trying to dismiss this as "there are no security issues" is
> bogus. There very much are security issues.

I think you're referring to:

>>   We might need to invent built-in "protected userspace" because existing
>>   "unprotected userspace" is not trustworthy enough to run kernel modules.
>>   That's not just inventing fork_usermode_blob().

Another root process can modify the memory of usermode_blob process.
I think that's Tetsuo's point about lack of LSM hooks is kernel_sock_shutdown().
Obviously, kernel_sock_shutdown() can be called by kernel only.
I suspect he's imaging a hypothetical situation where kernel bits of kernel module
interact with userblob bits of kernel module.
Then another root process tampers with memory of userblob.
Then userblob interaction with kernel module can do kernel_sock_shutdown()
on something that initial design of kernel+userblob module didn't intend.
I think this is trivially enforceable without creating new features.
Existing security_ptrace_access_check() LSM hook can prevent tampering with
memory of userblob.

As far as userblob calling llvm and other things in sequence.
That is no different from systemd calling things.
security label can carry that execution context.

> My personally strongest argument for remoiving this kernel code is
> that it's been there for a couple of years now, and it has never
> actually done anything useful, and there's no actual sign that it ever
> will, or that there is a solid plan in place for it.

you probably missed the detailed plan:
https://lore.kernel.org/bpf/20200609235631.ukpm3xngbehfqthz@ast-mbp.dhcp.thefacebook.com/

The project #3 is the above is the one we're working on right now.
It should be ready to post in a week.

> We can dance around the "what about security modules", but that
> fundamental problem of "this code hasn't done anything useful for two
> years and we don't even know if it's the right thing to do or what the
> real security issues _will_ be" is I think the real issue here.

Please see above link. bpfilter didn't go anywhere, but fork_usermode_blob()
has plenty of use cases that will materialize soon.
