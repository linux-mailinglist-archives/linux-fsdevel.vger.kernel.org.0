Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8A56AA83A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 06:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjCDFvq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Mar 2023 00:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDFvo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Mar 2023 00:51:44 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3A7584BE;
        Fri,  3 Mar 2023 21:51:43 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1720433ba75so5536666fac.5;
        Fri, 03 Mar 2023 21:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677909103;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lV4xSWA6B/kZCLMPP9P6bGMix2r6oXMxC3w0PVfN1xU=;
        b=C7xz1+8VtvgucFIr60EgZ6jCOfu1Qo49vvVA6fcNeOGRm/evXbdAyuhzRsS8Trw7IS
         whmb3FXNk1GD3qSX4csrB0G0NIB+Eq+fvEpJ655XcoNZXqzGv+hvKg9RYQzk12X3maoC
         y1rUytcxZi5hlqJhbhIJRdrXZrXPZn/a/bM7aE0XnHusKvjyP4pkY6p0RUXqOuAH5l0A
         A1cx2PkpGj3F3YKRj05dmScPqp7pYA1jmcLmJ/4Vt53KdTo7aGuZTmdBzGUJJPww7Fdw
         TEDVg3CsmNAq/uZ2OfTnkemoSKT6GKo4tPUFvKUuIKIkw2TdSP/nnEwDE4RC34kX9+2Q
         qePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677909103;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lV4xSWA6B/kZCLMPP9P6bGMix2r6oXMxC3w0PVfN1xU=;
        b=TQbcy68hkVqZ42kw0WH5fV5+AD2Jp+92/N/ILR4GYXYKpjQk0qYLGHBojdbYBN34ZA
         sAaZzPNqEcw6fdtZ6TVd+X1cnbCUGJs2sWFoYlSgduV0ts1IjoPDg1QDLJ45lQDP3SfF
         jC8ZUMZ2samQLv32KCvhDkY44ngbVhfLGRRDnVDnsJzXJwx9BmJvJupS/jqJQV+/8RJ+
         fMDltIE7StLpm11ky0IGBfH0xz0GjENLz8FOoSzC21x/zXu7wRWC5QUnt/FP1Gdf2ZEc
         2/2zjYcYvhoPj1/Wxit1xQ1vQ++WKqV4WRQIbIpQsYlb4wef9qU7WlYqpS4eLMvZtXCp
         EEuQ==
X-Gm-Message-State: AO0yUKVN4DYyOqF4Y/Kf8Kp7VtlelhR6DRwTZMfjzUnHZ2Bg1vqehw3u
        LEDzlt1uzxioRTBcnVfncy6CyLYdOu4=
X-Google-Smtp-Source: AK7set+Ny18RNUVYFJ5StTLqD9YWTaDTF7ZnHU8oVq1cPCy6qioPO3rC7SJ19SH95kE0zCgnGwD/pg==
X-Received: by 2002:a05:6870:8090:b0:176:5089:4fc8 with SMTP id q16-20020a056870809000b0017650894fc8mr2971720oab.34.1677909102859;
        Fri, 03 Mar 2023 21:51:42 -0800 (PST)
Received: from localhost ([50.208.89.9])
        by smtp.gmail.com with ESMTPSA id d44-20020a056870d2ac00b00172473f9fe0sm1826004oae.13.2023.03.03.21.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 21:51:42 -0800 (PST)
Date:   Fri, 3 Mar 2023 21:51:41 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if
 possible
Message-ID: <ZALcbQoKA7K8k2gJ@yury-laptop>
References: <ZAEC3LN6oUe6BKSN@ZenIV>
 <CAG_fn=UQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsYE8xw_WEYGw@mail.gmail.com>
 <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
 <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
 <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
 <CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com>
 <ZAK6Duaf4mlgpZPP@yury-laptop>
 <CAHk-=wh1r3KfATA-JSdt3qt2y3sC=5U9+wZsbabW+dvPsqRCvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wh1r3KfATA-JSdt3qt2y3sC=5U9+wZsbabW+dvPsqRCvA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 03, 2023 at 07:42:36PM -0800, Linus Torvalds wrote:
> ing: quoted-printable
> Status: O
> Content-Length: 1593
> Lines: 41
> 
> On Fri, Mar 3, 2023 at 7:25 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > Did you enable CONFIG_FORCE_NR_CPUS? If you pick it, the kernel will
> > bind nr_cpu_ids to NR_CPUS at compile time, and the memset() call
> > should disappear.
> 
> I do not believe CONFIG_FORCE_NR_CPUS makes any sense, and I think I
> told you so at the time.

At that time you was OK with CONFIG_FORCE_NR_CPUS, only suggested to
hide it behind CONFIG_EXPERT:

https://lore.kernel.org/all/Yzx4fSmmr8bh6gdl@yury-laptop/T/#m92d405527636154c3b2000e0105379170d988315
 
> This all used to just work *without* some kind of config thing, First
> removing the automatic "do the right thing", and then adding a config
> option to "force" doing the right thing seems more than a bit silly to
> me.
> 
> I think CONFIG_FORCE_NR_CPUS should go away, and - once more - become
> just the "is the cpumask small enough to be just allocated directly"
> thing.

This all was just broken. For example, as I mentioned in commit message,
cpumask_full() was broken. I know because I wrote a test. There were no
a single user for the function, and nobody complained. Now we have one
in BPF code. So if we simply revert the aa47a7c215e, it will hurt real
users.

The pre-CONFIG_FORCE_NR_CPUS cpumask machinery would work only if you
set NR_CPUS to the number that matches to the actual number of CPUs as
detected at boot time.

In your example, if you have NR_CPUS == 64, and for some reason disable
hyper threading, nr_cpumask_bits will be set to 64 at compile time, but
nr_cpu_ids will be set to 32 at boot time, assuming
CONFIG_CPUMASK_OFFSTACK is disabled.

And the following code will be broken:

cpumask_t m1, m2;

cpumask_setall(m1); // m1 is ffff ffff ffff ffff because it uses
                    // compile-time optimized nr_cpumask_bits

for_each_cpu(cpu, m1) // 32 iterations because it relied on nr_cpu_ids
        cpumask_set_cpu(cpu, m2); // m2 is ffff ffff XXXX XXXX

BUG_ON(!cpumask_equal(m1, m2)); // Bug because it will test all 64 bits

Today with CONFIG_FORCE_NR_CPUS disabled, kernel consistently relies
on boot-time defined nr_cpu_ids in functions like cpumask_equal()
with the cost of disabled runtime optimizations.

If CONFIG_FORCE_NR_CPUS is enabled, it wires nr_cpu_ids to NR_CPUS
at compile time, which allows compile-time optimization.

If CONFIG_FORCE_NR_CPUS is enabled, but actual number of CPUs doesn't
match to NR_CPUS, the kernel throws a warning at boot time - better
than nothing.

I'm not happy bothering people with a new config parameter in such a
simple case. I just don't know how to fix it better. Is there a safe
way to teach compiler to optimize against NR_CPUS other than telling
it explicitly?

> Of course, the problem for others remain that distros will do that
> CONFIG_CPUMASK_OFFSTACK thing, and then things will suck regardless.
> 
> I was *so* happy with our clever "you can have large cpumasks, and
> we'll just allocate them off the stack" long long ago, because it
> meant that we could have one single source tree where this was all
> cleanly abstracted away, and we even had nice types and type safety
> for it all.
> 
> That meant that we could support all the fancy SGI machines with
> several thousand cores, and it all "JustWorked(tm)", and didn't make
> the normal case any worse.
> 
> I didn't expect distros to then go "ooh, we want that too", and enable
> it all by default, and make all our clever "you only see this
> indirection if you need it" go away, and now the normal case is the
> *bad* case, unless you just build your own kernel and pick sane
> defaults.
>
> Oh well.

From distro people's perspective, 'one size fits all' is the best
approach. It's hard to blame them.

Thanks,
Yury
