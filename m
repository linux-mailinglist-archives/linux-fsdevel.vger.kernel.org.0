Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0FF4688F1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Dec 2021 03:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhLECs7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Dec 2021 21:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbhLECs7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Dec 2021 21:48:59 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3E6C061751;
        Sat,  4 Dec 2021 18:45:32 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id n15so7552490qta.0;
        Sat, 04 Dec 2021 18:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RsJA41B8r6uTnf+Wrmk3w3cuCRFsGJe2oeQmzY1WbO8=;
        b=dMAXUdZapHoGzFL3EcCl167DdKJlPoUlK/xEH7Q5M++yIdHjKwRUSqbHZNuAOJ4dxS
         Ab3ejUlOhAvlFWaaYhlO+DR79ztWZ9D2h+p69USGvr08ixZzLyUu6PBmBWGiMW4aR/zI
         Ru5N/adCCAv8akny+8xgBCv+T2kR0vCg7mSHzwCHO1HU2SdYXt2k9tPA8aqAdlDe2QMN
         yqXaeb4MWHEtczUMmFIZTffAMDRGMAEyxI05lrY0QBc6UrEbu54b5ukKN+zC5Z66iv8L
         0OPxSHAQXKqz9Di6hMONMuK0T8Iz0ZR1+3PxtMEe05zH4K7ujye5omQbF8ULMbC3I+S1
         sg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RsJA41B8r6uTnf+Wrmk3w3cuCRFsGJe2oeQmzY1WbO8=;
        b=jfnsn4DdkuAPL0Uf9htdlXghUid0+G/KFARv68nqdUJHErvMFgDk0r2U9T70b8ea5L
         z1YNrsXzTwIKAk3n3bOZd1znhgDBnJy8SvPYbD9czrsW2P3mJVDbQprsMfFvU7oCAsfO
         oWdGdDhHP748LRGjA03CdcUklkLhhADJSGGSCc+NuUxfKFBTDfnm38pISqxHvJQVaRk3
         pLPjTo3h9y7sfyqg0a5fZpL0oDa06TTZJ4UQrMLebQtuUGIcgjimgEUPZu22wwp3Hixk
         gff2YW7TW9YYxX3NfbVOrg0uezz1JLQsJIGggHcJRo4CvROnzSRAV8zAuhc1Z/s3GUCu
         cZtg==
X-Gm-Message-State: AOAM532pzjt3ekQmXoNoEC+jO8TmUYhvR7m4VcLru7chHWahJqILtkVy
        9e4hIGeaCa/1uqaCyuCYv5islVDGmBHHSZ04ww4=
X-Google-Smtp-Source: ABdhPJydV6WypXFvd9Ut3xKW5BOxUaSHg0tiLKXKlD0Kkgr2/7QYR43Fvjyep00bHReym6MQcAx8yiE8ysa46C1ngAQ=
X-Received: by 2002:a05:622a:1744:: with SMTP id l4mr30592707qtk.418.1638672330785;
 Sat, 04 Dec 2021 18:45:30 -0800 (PST)
MIME-Version: 1.0
References: <20211204095256.78042-1-laoar.shao@gmail.com> <20211204095256.78042-6-laoar.shao@gmail.com>
 <CAADnVQLS4Ev7xChqCMbbJiFZ_kYSB+rbiVT6AJotheFJb1f5=w@mail.gmail.com>
In-Reply-To: <CAADnVQLS4Ev7xChqCMbbJiFZ_kYSB+rbiVT6AJotheFJb1f5=w@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 5 Dec 2021 10:44:54 +0800
Message-ID: <CALOAHbCud62ivvoRuz1SV-d3sL9Y9knEga0N-jiXnM3SYzWxNA@mail.gmail.com>
Subject: Re: [PATCH -mm 5/5] bpf/progs: replace hard-coded 16 with TASK_COMM_LEN
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 5, 2021 at 12:44 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Dec 4, 2021 at 1:53 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> >  static int process_sample(void *ctx, void *data, size_t len)
> >  {
> > -       struct sample *s = data;
> > +       struct sample_ringbuf *s = data;
>
> This is becoming pointless churn.
> Nack.
>
> > index 145028b52ad8..7b1bb73c3501 100644
> > --- a/tools/testing/selftests/bpf/progs/test_core_reloc_kernel.c
> > +++ b/tools/testing/selftests/bpf/progs/test_core_reloc_kernel.c
> > @@ -1,8 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  // Copyright (c) 2019 Facebook
> >
> > -#include <linux/bpf.h>
> > -#include <stdint.h>
> > +#include <vmlinux.h>
> >  #include <stdbool.h>
> >  #include <bpf/bpf_helpers.h>
> >  #include <bpf/bpf_core_read.h>
> > @@ -23,11 +22,11 @@ struct core_reloc_kernel_output {
> >         int comm_len;
> >  };
> >
> > -struct task_struct {
> > +struct task_struct_reloc {
>
> Churn that is not even compile tested.

It is strange that I have successfully compiled it....
Below is the compile log,

$ cat make.log | grep test_core_reloc_kernel
  CLNG-BPF [test_maps] test_core_reloc_kernel.o
  GEN-SKEL [test_progs] test_core_reloc_kernel.skel.h
  CLNG-BPF [test_maps] test_core_reloc_kernel.o
  GEN-SKEL [test_progs-no_alu32] test_core_reloc_kernel.skel.h

Also there's no error in the compile log.

-- 
Thanks
Yafang
