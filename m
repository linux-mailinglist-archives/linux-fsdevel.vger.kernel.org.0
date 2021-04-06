Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E663355761
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 17:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345481AbhDFPKU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 11:10:20 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:40685 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhDFPKT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:10:19 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MQ5nE-1lGVe444tE-00M82P; Tue, 06 Apr 2021 17:10:09 +0200
Received: by mail-ot1-f42.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso14919233oti.11;
        Tue, 06 Apr 2021 08:10:08 -0700 (PDT)
X-Gm-Message-State: AOAM5339u61P3hcDQHSMv4Bb3Vc6UeOaPqfPKECpFig1uCct5fovZUts
        XPwTqmkcSBGX/Hjod6hc9kc3/Hsfqq4PeYD4X4Y=
X-Google-Smtp-Source: ABdhPJymivlM3E85H8Q+0NCLICsUYllvqqVKgV6xTox+xVrAvu7QQQ8spiRatNW1320IbQIk/CTiHARLx2Yc4o/NYxk=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr28037074otq.251.1617721807123;
 Tue, 06 Apr 2021 08:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Apr 2021 17:09:50 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3PBvj_JEgxqSD6fg_J8kZzUz_KthZ66RdA5tF4CPPbdg@mail.gmail.com>
Message-ID: <CAK8P3a3PBvj_JEgxqSD6fg_J8kZzUz_KthZ66RdA5tF4CPPbdg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] kernel.h: Split out panic and oops helpers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Joerg Roedel <jroedel@suse.de>, Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>,
        Corey Minyard <cminyard@mvista.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-remoteproc@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        kexec@lists.infradead.org, rcu@vger.kernel.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Corey Minyard <minyard@acm.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:j4MYXLrEq3uWqMv+X0D99JwRTObPxDHDhULsj99en1zd/J0IS/M
 9DH+aY6RDqyTbtsxdBcUfZb+VnY8T9dkC4Ci3fV4yaKiT3GP45iRwVaY38uzag+7e1eYfKy
 q/Sp50e+En2buLkJEK/wbFqVNilXsvIYeIUaIPF0vQBDu1+1gy8WogTZT+70k09VATRurYk
 GmKsn/l8oe0Pk4pW5dtGg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GP+1VYp8m50=:bsgZllEAEV+Im6+kBThy/N
 JRso7MC3s7MZECvcG6PxvLGm48/w8u+AwOaEEM1TpolGdUeWEn/hhpdt6UWGtWJGzy0NgHb1b
 ECWpueBJLTVs7fSSrUUnujvbDiNbQeSq3j5DI0JIYFPG8qaXZquoG+NcbGehYjTJtibfwbaa4
 MhR08FPn0d9M6hcsAB8DWsEtr0KwkviFgvGkVMxMp7zB46YO9hPgBKPRtUiGdXjiY35QA422Z
 pI220xkX3UXgAJmZlsfT8lnTiwhJ6goIM5u4qGHoy1wGPTrwW0CvNzx+k8+QpKfm/nEmZcla/
 AY6TjYhY9EjBCHJ7tEnvJf+fKCFAdKwrH0GRt8ecy2tD99Z62l4JNkIlY0FoL0FqrCGA5R3Tl
 N5lgSxJoiGwhOxR1ax5wKVmJ8zCsMuMh925Jl7s4XakMqWmL5Dg62rWCzcp1sDnC/q+1gTyps
 xxdNyBrccocNyELt3aLU2Tv7JuleTWM=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 6, 2021 at 3:31 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> kernel.h is being used as a dump for all kinds of stuff for a long time.
> Here is the attempt to start cleaning it up by splitting out panic and
> oops helpers.
>
> At the same time convert users in header and lib folder to use new header.
> Though for time being include new header back to kernel.h to avoid twisted
> indirected includes for existing users.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Nice!

Acked-by: Arnd Bergmann <arnd@arndb.de>
