Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769273C95AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 03:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhGOBpQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 21:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33752 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229909AbhGOBpQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 21:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626313343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a5H9o3Uo90SFrExZQnEzhsWVBMlknIqUSJrzFwHnmuE=;
        b=eJ8h8IQEXcxoC6myk7+Q5oVHDVOJ9KiP+XHPrDutB8UW+eYmTV1glIIvpIRuiRmxUbtOSK
        ISN2SOU6TeJgJj++M8batuW98qgcobF/hn+BuEyfX+66kpt8ZIumQeieY5bLKpTaZvokEK
        qjDjyhgbwtTFkP4tVs3k4FqdcpUNRLA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-rxV_7Q5RMfKbgklmKFWZoA-1; Wed, 14 Jul 2021 21:42:22 -0400
X-MC-Unique: rxV_7Q5RMfKbgklmKFWZoA-1
Received: by mail-pj1-f70.google.com with SMTP id gc15-20020a17090b310fb0290173c8985d0dso2544978pjb.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 18:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a5H9o3Uo90SFrExZQnEzhsWVBMlknIqUSJrzFwHnmuE=;
        b=eK+WMcPzSgZyHp1RllkwFL10aywJ+8SkZHKP1lIvnYqBaISJzU3aPkxQdkH9ImSff2
         GB1Ei+ZVBYGpS5QBTVes9fzeZ/qOIWQ5OpKwC6ahHZcNeBHzBpFerxJvkzPki0drsc8c
         FaJXGvnVMkqVi1f66KkQqFRY4hPDA2zH/xcAeDcphbaZauvzZ8IdpL9hIYkFqnbczh+T
         /gs4cInF7i8Qdf2xSHCPZyM5fjNA03TzbE4ZxczChwHnPyacoI3HqEeSkwOSO9hMfKSW
         GFUxw4UAGJgmWOhrbFS6q3AyAnkAwOq0rIE2OSSolwJCCpyNw8KEDliA7CPCgt0+QVg8
         0f0Q==
X-Gm-Message-State: AOAM531KPDnAwlZ+pDzGTI/8nG2rkzGo1lMC1ymLuubD3kynyx1JGIvG
        r8ny72/y0ranFDFIz2sFG+ZunMzmU/v+RiQJkNxDA0J2exN0y89odrj48q+IME1PmYNnE9PhlAc
        /x9vLCErc+V/j28U3oRUF4BXRUkQodOVQsRXyT3jp2w==
X-Received: by 2002:a62:154f:0:b029:331:b0d6:9adc with SMTP id 76-20020a62154f0000b0290331b0d69adcmr1254183pfv.73.1626313341020;
        Wed, 14 Jul 2021 18:42:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrDYcrJuNkF4UTr94I8/U/ZMWIkHueW9mm0fljRwvGbFR/TdGj3T/24HpFqJZtU7xZ+sAUi1J1Rv54fCNs/x4=
X-Received: by 2002:a62:154f:0:b029:331:b0d6:9adc with SMTP id
 76-20020a62154f0000b0290331b0d69adcmr1254136pfv.73.1626313340660; Wed, 14 Jul
 2021 18:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAHLe9YZ1_0p_rn+fbXFxU3ySJ_XU=QdSKJAu2j3WD8qmDuNTaQ@mail.gmail.com>
 <YO5kCzI133B/fHiS@carbon.dhcp.thefacebook.com> <CAHLe9YYiNnbyYGHoArJxvCEsqaqt2rwp5OHCSy+gWH+D8OFLQA@mail.gmail.com>
 <20210714092639.GB9457@quack2.suse.cz> <CAHLe9YbKXcF1mkSeK0Fo7wAUN02-_LfLD+2hdmVMJY_-gNq=-A@mail.gmail.com>
 <YO93VTcLDNisdHRf@carbon.dhcp.thefacebook.com>
In-Reply-To: <YO93VTcLDNisdHRf@carbon.dhcp.thefacebook.com>
From:   Boyang Xue <bxue@redhat.com>
Date:   Thu, 15 Jul 2021 09:42:06 +0800
Message-ID: <CAHLe9YaNtmJ8xx=A+6Ki+Fc2Kx=5jL745NJ8PL+w95-WhJrG3g@mail.gmail.com>
Subject: Re: Patch 'writeback, cgroup: release dying cgwbs by switching
 attached inodes' leads to kernel crash
To:     Roman Gushchin <guro@fb.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 15, 2021 at 7:46 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Thu, Jul 15, 2021 at 12:22:28AM +0800, Boyang Xue wrote:
> > Hi Jan,
> >
> > On Wed, Jul 14, 2021 at 5:26 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Wed 14-07-21 16:44:33, Boyang Xue wrote:
> > > > Hi Roman,
> > > >
> > > > On Wed, Jul 14, 2021 at 12:12 PM Roman Gushchin <guro@fb.com> wrote:
> > > > >
> > > > > On Wed, Jul 14, 2021 at 11:21:12AM +0800, Boyang Xue wrote:
> > > > > > Hello,
> > > > > >
> > > > > > I'm not sure if this is the right place to report this bug, please
> > > > > > correct me if I'm wrong.
> > > > > >
> > > > > > I found kernel-5.14.0-rc1 (built from the Linus tree) crash when it's
> > > > > > running xfstests generic/256 on ext4 [1]. Looking at the call trace,
> > > > > > it looks like the bug had been introduced by the commit
> > > > > >
> > > > > > c22d70a162d3 writeback, cgroup: release dying cgwbs by switching attached inodes
> > > > > >
> > > > > > It only happens on aarch64, not on x86_64, ppc64le and s390x. Testing
> > > > > > was performed with the latest xfstests, and the bug can be reproduced
> > > > > > on ext{2, 3, 4} with {1k, 2k, 4k} block sizes.
> > > > >
> > > > > Hello Boyang,
> > > > >
> > > > > thank you for the report!
> > > > >
> > > > > Do you know on which line the oops happens?
> > > >
> > > > I was trying to inspect the vmcore with crash utility, but
> > > > unfortunately it doesn't work.
> > >
> > > Thanks for report!  Have you tried addr2line utility? Looking at the oops I
> > > can see:
> >
> > Thanks for the tips!
> >
> > It's unclear to me that where to find the required address in the
> > addr2line command line, i.e.
> >
> > addr2line -e /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux
> > <what address here?>
>
> You can use $nm <vmlinux> to get an address of cleanup_offline_cgwbs_workfn()
> and then add 0x320.

Thanks! Hope the following helps:

# grep  cleanup_offline_cgwbs_workfn
/boot/System.map-5.14.0-0.rc1.15.bx.el9.aarch64
ffff8000102d6ab0 t cleanup_offline_cgwbs_workfn

## ffff8000102d6ab0+0x320=FFFF8000102D6DD0

# addr2line -e /usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux
FFFF8000102D6DD0
/usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/atomic-arch-fallback.h:2265
# vi /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/atomic-arch-fallback.h
```
arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
{
        s64 c = arch_atomic64_read(v); <=== line#2265

        do {
                if (unlikely(c == u))
                        break;
        } while (!arch_atomic64_try_cmpxchg(v, &c, c + a));

        return c;
}
```

# addr2line -i -e
/usr/lib/debug/lib/modules/5.14.0-0.rc1.15.bx.el9.aarch64/vmlinux
FFFF8000102D6DD0
/usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/atomic-arch-fallback.h:2265
/usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/atomic-arch-fallback.h:2290
/usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/asm-generic/atomic-instrumented.h:1149
/usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/asm-generic/atomic-long.h:491
/usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/percpu-refcount.h:247
/usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/percpu-refcount.h:266
/usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/backing-dev-defs.h:227
/usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/./include/linux/backing-dev-defs.h:224
/usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/mm/backing-dev.c:679
# vi /usr/src/debug/kernel-5.14.0-0.rc1.15.bx/linux-5.14.0-0.rc1.15.bx.el9.aarch64/mm/backing-dev.c
```
static void cleanup_offline_cgwbs_workfn(struct work_struct *work)
{
        struct bdi_writeback *wb;
        LIST_HEAD(processed);

        spin_lock_irq(&cgwb_lock);

        while (!list_empty(&offline_cgwbs)) {
                wb = list_first_entry(&offline_cgwbs, struct bdi_writeback,
                                      offline_node);
                list_move(&wb->offline_node, &processed);

                /*
                 * If wb is dirty, cleaning up the writeback by switching
                 * attached inodes will result in an effective removal of any
                 * bandwidth restrictions, which isn't the goal.  Instead,
                 * it can be postponed until the next time, when all io
                 * will be likely completed.  If in the meantime some inodes
                 * will get re-dirtied, they should be eventually switched to
                 * a new cgwb.
                 */
                if (wb_has_dirty_io(wb))
                        continue;

                if (!wb_tryget(wb))  <=== line#679
                        continue;

                spin_unlock_irq(&cgwb_lock);
                while (cleanup_offline_cgwb(wb))
                        cond_resched();
                spin_lock_irq(&cgwb_lock);

                wb_put(wb);
        }

        if (!list_empty(&processed))
                list_splice_tail(&processed, &offline_cgwbs);

        spin_unlock_irq(&cgwb_lock);
}
```

>
> Alternatively, maybe you can put the image you're using somewhere?

I put those rpms in the Google Drive
https://drive.google.com/drive/folders/1aw-WK2yWD11UWB059bJt6WKNW1OP_fex?usp=sharing

>
> I'm working on getting my arm64 setup and reproduce the problem, but it takes
> time, and I'm not sure I'll be able to reproduce it in qemu running on top of x86.

Thanks! It's only reproducible on aarch64 and ppc64le in my test. I'm
happy to help test patch, if it would help.

>
> Thanks!
>

