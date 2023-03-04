Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA346AAB2C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 17:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjCDQlg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Mar 2023 11:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCDQlf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Mar 2023 11:41:35 -0500
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF731D919;
        Sat,  4 Mar 2023 08:41:34 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id ff4so3857683qvb.2;
        Sat, 04 Mar 2023 08:41:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677948093;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P2DqimBr3ac9VX2BbSxkSUKr8QLSMmm6AVDp0wt/2XA=;
        b=jyWpdoTlEbbrM0W9zWWpq0BBKOD4/YTcd2wMti8Edbvz+3/zyXFZI/yWyXedWhOaT/
         SnvEDibWQYFJJH4xPVmwe8H+Zfi91F5+q164V8qw6eQlICeL8gtGeUwiHFAnwspotvCZ
         /vl+h6DZaW/3fT1yle732X/wb38+uN8AdippV8xvW1xR9nr+fzkvN8/XWNWbhAgnF7i5
         FjkNi1cC/AC/+3Sk28igCDO1lIvX1/u5XG2Bz+2EF95Ue42F+GM/fhXD1/q4GE9xTPQ6
         7oMyd3CBaD6WJZ9k6xCJx4Q/hkgdQiY4k+ABDXuen+F0rW8WlgbdvLSicsHt+lEXPvvX
         JT4A==
X-Gm-Message-State: AO0yUKWpuDyIcYuVa67HqMUX2vbkfyoNGAPcJ8NHrg4wYI6Qs8MCv4EI
        gHtm56wkhGT+jk04AYb/+D64KGYMmVZR1T8n
X-Google-Smtp-Source: AK7set/ArPa0FbhqGXIzhCbMGE8HbPmCJBdKZh9394fVz3rCCGuxwqtqhWk/4lFxGCT8A/jj85THwg==
X-Received: by 2002:a05:6214:c84:b0:56e:9dd8:4812 with SMTP id r4-20020a0562140c8400b0056e9dd84812mr9409693qvr.3.1677948092975;
        Sat, 04 Mar 2023 08:41:32 -0800 (PST)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id i3-20020a378603000000b007068b49b8absm3929435qkd.62.2023.03.04.08.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 08:41:32 -0800 (PST)
Date:   Sat, 4 Mar 2023 10:41:30 -0600
From:   David Vernet <void@manifault.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if
 possible
Message-ID: <20230304164130.GA370071@maniforge>
References: <CAG_fn=UQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsYE8xw_WEYGw@mail.gmail.com>
 <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
 <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
 <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
 <CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com>
 <ZAK6Duaf4mlgpZPP@yury-laptop>
 <CAHk-=wh1r3KfATA-JSdt3qt2y3sC=5U9+wZsbabW+dvPsqRCvA@mail.gmail.com>
 <ZALcbQoKA7K8k2gJ@yury-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZALcbQoKA7K8k2gJ@yury-laptop>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 03, 2023 at 09:51:41PM -0800, Yury Norov wrote:
> On Fri, Mar 03, 2023 at 07:42:36PM -0800, Linus Torvalds wrote:
> > ing: quoted-printable
> > Status: O
> > Content-Length: 1593
> > Lines: 41
> > 
> > On Fri, Mar 3, 2023 at 7:25 PM Yury Norov <yury.norov@gmail.com> wrote:
> > >
> > > Did you enable CONFIG_FORCE_NR_CPUS? If you pick it, the kernel will
> > > bind nr_cpu_ids to NR_CPUS at compile time, and the memset() call
> > > should disappear.
> > 
> > I do not believe CONFIG_FORCE_NR_CPUS makes any sense, and I think I
> > told you so at the time.
> 
> At that time you was OK with CONFIG_FORCE_NR_CPUS, only suggested to
> hide it behind CONFIG_EXPERT:
> 
> https://lore.kernel.org/all/Yzx4fSmmr8bh6gdl@yury-laptop/T/#m92d405527636154c3b2000e0105379170d988315
>  
> > This all used to just work *without* some kind of config thing, First
> > removing the automatic "do the right thing", and then adding a config
> > option to "force" doing the right thing seems more than a bit silly to
> > me.
> > 
> > I think CONFIG_FORCE_NR_CPUS should go away, and - once more - become
> > just the "is the cpumask small enough to be just allocated directly"
> > thing.
> 
> This all was just broken. For example, as I mentioned in commit message,
> cpumask_full() was broken. I know because I wrote a test. There were no
> a single user for the function, and nobody complained. Now we have one
> in BPF code. So if we simply revert the aa47a7c215e, it will hurt real
> users.

FWIW, we can remove bpf_cpumask_full() and any other affected
bpf_cpumask kfuncs if we need to. kfuncs have no strict stability
guarantees (they're kernel symbols meant for use by kernel programs, see
[0]), so we can remove them without worrying about user space breakages
or stability issues. They were also added relatively recently, and as
far as I know, Tejun and I are thus far the only people using them.

[0]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/Documentation/bpf/kfuncs.rst#n350

Of course, I'd prefer that we didn't remove any of them, but if we have
to then BPF won't get in the way. As you pointed out below, there are
scenarios beyond cpumask_full() where (many) non-BPF callers could trip
on this as well, so IMO what we have today makes sense (assuming there's
not some other clever way to correctly optimize for NR_CPUS without the
extra config option, as you also said below).

Thanks,
David

> The pre-CONFIG_FORCE_NR_CPUS cpumask machinery would work only if you
> set NR_CPUS to the number that matches to the actual number of CPUs as
> detected at boot time.
> 
> In your example, if you have NR_CPUS == 64, and for some reason disable
> hyper threading, nr_cpumask_bits will be set to 64 at compile time, but
> nr_cpu_ids will be set to 32 at boot time, assuming
> CONFIG_CPUMASK_OFFSTACK is disabled.
> 
> And the following code will be broken:
> 
> cpumask_t m1, m2;
> 
> cpumask_setall(m1); // m1 is ffff ffff ffff ffff because it uses
>                     // compile-time optimized nr_cpumask_bits
> 
> for_each_cpu(cpu, m1) // 32 iterations because it relied on nr_cpu_ids
>         cpumask_set_cpu(cpu, m2); // m2 is ffff ffff XXXX XXXX
> 
> BUG_ON(!cpumask_equal(m1, m2)); // Bug because it will test all 64 bits
>
> Today with CONFIG_FORCE_NR_CPUS disabled, kernel consistently relies
> on boot-time defined nr_cpu_ids in functions like cpumask_equal()
> with the cost of disabled runtime optimizations.
> 
> If CONFIG_FORCE_NR_CPUS is enabled, it wires nr_cpu_ids to NR_CPUS
> at compile time, which allows compile-time optimization.
> 
> If CONFIG_FORCE_NR_CPUS is enabled, but actual number of CPUs doesn't
> match to NR_CPUS, the kernel throws a warning at boot time - better
> than nothing.
> 
> I'm not happy bothering people with a new config parameter in such a
> simple case. I just don't know how to fix it better. Is there a safe
> way to teach compiler to optimize against NR_CPUS other than telling
> it explicitly?
> 
> > Of course, the problem for others remain that distros will do that
> > CONFIG_CPUMASK_OFFSTACK thing, and then things will suck regardless.
> > 
> > I was *so* happy with our clever "you can have large cpumasks, and
> > we'll just allocate them off the stack" long long ago, because it
> > meant that we could have one single source tree where this was all
> > cleanly abstracted away, and we even had nice types and type safety
> > for it all.
> > 
> > That meant that we could support all the fancy SGI machines with
> > several thousand cores, and it all "JustWorked(tm)", and didn't make
> > the normal case any worse.
> > 
> > I didn't expect distros to then go "ooh, we want that too", and enable
> > it all by default, and make all our clever "you only see this
> > indirection if you need it" go away, and now the normal case is the
> > *bad* case, unless you just build your own kernel and pick sane
> > defaults.
> >
> > Oh well.
> 
> From distro people's perspective, 'one size fits all' is the best
> approach. It's hard to blame them.
> 
> Thanks,
> Yury
