Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394C8471B8E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Dec 2021 17:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhLLQ0o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Dec 2021 11:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhLLQ0n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Dec 2021 11:26:43 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4342C061714;
        Sun, 12 Dec 2021 08:26:43 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id kl8so12486537qvb.3;
        Sun, 12 Dec 2021 08:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bNwHjQhCMbCngDQX0H2Ckug8Srm3laq1CXvl0Hu0lM4=;
        b=TN+GNEmKaM7kZ83XqRhVGt6qR97dFjj2J2am6DzEXDqdOCFKNJ7/f4op+u4uknQvtE
         LZMq3wH8qQk3WE/BcbZe6Zh2Xhm2Miy2dnLuy/5/Y7ITxSNSuq+4TZS18qpuJLXdSKBr
         FNBky3Sz17QI0vaTJ7y/T6uPtk5gnjBw8/2eCvmn+F+xjesAV3S9r9kKWHksA8CvznMZ
         AqpH69+Y7r82RSNyl3AWz7cAnVodlsuk68rVVfbXtiAdcW9gv9CaV3YuNxaV+SXM+eq+
         mHbJZeSN/yoT8a4L9dkv7793323d86qrOZzQUbPVv8NKNF5sCT2DDPPt8WOCh0FC0LEA
         IRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bNwHjQhCMbCngDQX0H2Ckug8Srm3laq1CXvl0Hu0lM4=;
        b=aT9nuvwK4rbzWeDXa3zfOIof6SQOxjPr2WACpGdXHjElUJLBZNrtXG0ifHPh/2mUoI
         00FyFJz1ovRWOOSSdjIgnCBctvXrHDB7TRQd/xxojAqMhOnQ26B5ezG/7y2RQtLNqQk4
         i8+Cw6CBqVUsqCx1ZFzE7yt405YjC9BvNkVWAZ0Wy0teKahr76vDqbllPeU4Al57kfic
         4E7ROmmFSJJd3r9BH1I7D24FeTp+SOuEHyY1008hkNypYW69AK4s4YHvBVgfmWsX/sp3
         O79KRsm7c/jlpNhmMZ27gplj3uTFdbrFf8WtwCSRk+noxuSBVj1ErHSaOdwv2bMrIvU9
         cFKA==
X-Gm-Message-State: AOAM532OQuXFp+cyDdlDEj6uhGzabrVqWSyxNUVnRMVXXtsyrAmuoobF
        WImT8NTsENRdKJqkWoEYYai/W5fo3P6Dzo67Pbg=
X-Google-Smtp-Source: ABdhPJz5keJkRw3D5mHm9P4v597lE0nNgF4GdVDHC/Rk0AvaTN8JHYTdOZU++IiRJNA0ndiLIg1li+HMZ/66oZZqZeE=
X-Received: by 2002:a05:6214:3019:: with SMTP id ke25mr36724071qvb.69.1639326402741;
 Sun, 12 Dec 2021 08:26:42 -0800 (PST)
MIME-Version: 1.0
References: <20211211063949.49533-1-laoar.shao@gmail.com> <20211211063949.49533-3-laoar.shao@gmail.com>
 <YbWSQy0pmO9RgRUu@qmqm.qmqm.pl>
In-Reply-To: <YbWSQy0pmO9RgRUu@qmqm.qmqm.pl>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 13 Dec 2021 00:26:04 +0800
Message-ID: <CALOAHbA+i96zO+XHOBM+k3F1viOnhe=e=z=Vobc+1Bh8NAP9SA@mail.gmail.com>
Subject: Re: [PATCH -mm v2 2/3] cn_proc: replaced old hard-coded 16 with TASK_COMM_LEN_16
To:     Michal Miroslaw <mirq-linux@rere.qmqm.pl>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Linux MM <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 12, 2021 at 2:10 PM Michal Miroslaw <mirq-linux@rere.qmqm.pl> wrote:
>
> On Sat, Dec 11, 2021 at 06:39:48AM +0000, Yafang Shao wrote:
> > This TASK_COMM_LEN_16 has the same meaning with the macro defined in
> > linux/sched.h, but we can't include linux/sched.h in a UAPI header, so
> > we should specifically define it in the cn_proc.h.
> [...]
> > index db210625cee8..6dcccaed383f 100644
> > --- a/include/uapi/linux/cn_proc.h
> > +++ b/include/uapi/linux/cn_proc.h
> > @@ -21,6 +21,8 @@
> >
> >  #include <linux/types.h>
> >
> > +#define TASK_COMM_LEN_16 16
>
> Hi,
>
> Since this is added to UAPI header, maybe you could make it a single
> instance also used elsewhere? Even though this is constant and not
> going to change I don't really like multiplying the sources of truth.
>

Hmm, what about defining it in include/uapi/linux/sched.h ?
Then include "sched.h" in cn_proc.h
And we also define it in tools/include/uapi/linux/sched.h for the
usage in tools.

-- 
Thanks
Yafang
