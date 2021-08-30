Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4603FB9E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 18:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237698AbhH3QNK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 12:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237655AbhH3QNJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:13:09 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41489C061575
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Aug 2021 09:12:16 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id k78so25966134ybf.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Aug 2021 09:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1GG6tg8XbUgZaMZCQ5xRATgRnP/jMPvp3jA/MirEbNo=;
        b=twvcbEdVEBll9AfkQNe5af0zQd9ziYfYCKCAn9VET2O5NOWONGcLr3SY6j5VijsHIH
         ApkpmIc6t+2HUtK/lec+2ElqW4bz5E0CDT3wDB1Nue+Mi+6ffiFmM7yZ2qpxSwGNJd+q
         fmdqxrxlR21OU1mv1NMGzHcu4Gx02yL/Q/h+00WNA3OUghz2WZLfSaoNf0kv1agW/zkQ
         H+CD+GGnOnvNeqIQVY9MmHW7E8dlOkbXPZfhTo6j7x8ku2/6VAB4q+ZcFyrv3CGvw2WK
         Y2YR4l69YSC2350Fykt8SGF4QjW7RiDEZVvvjOas0D4IL15nkBVSwyd9vLusrz2TF43D
         WUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1GG6tg8XbUgZaMZCQ5xRATgRnP/jMPvp3jA/MirEbNo=;
        b=nMpjayyygOnhwcgs9lIKbCw7gZuEhSNQYfKe+C33D3QDVBXPDXTZ/bFlj5e8QGCrGG
         f2NO+fxupdgyUfZSJSamTGHWtpE0iaT/HsMZ9EGj5pMCuP/KXHJseE3fPiNPacRWi3UZ
         Hj9CAVjTpgxCALh5FBZgf0U8mIIpSidKmnD2+TJarnd2uduV2+MrC29TD/A4cmzbuLoD
         X7W9Go7cV/UmT3MZvzlViINMTPfpPWUakZ1/gv4Z+9YokmgFetP+zeGO5IzaYxYOygDM
         StGM39YUMulUoUVigNd4DAOv+nrVjTUhXA0cO+bmg2pKWIVhSSTqErBBPjdaALRJMgQb
         jsbA==
X-Gm-Message-State: AOAM5318Jr4gjvKxVdTjHfebpX7oBakcQz7e5MonOhtzmz7TQPN4lqwm
        bX6nQITwkAnyKlIrK8rc5DM00fwmmoI6siNgpCCwCA==
X-Google-Smtp-Source: ABdhPJyZ5H68bvwLbFLqiWFTMo5h8kw5ktkDNCncmkDU7epUUx9pY1a0ha08PueWlXCu+9PrzTDAqwFl5KIme8kL57c=
X-Received: by 2002:a25:810c:: with SMTP id o12mr26240733ybk.250.1630339935154;
 Mon, 30 Aug 2021 09:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210827191858.2037087-1-surenb@google.com> <20210827191858.2037087-4-surenb@google.com>
 <15537178.k4V9gYNSIy@devpool47>
In-Reply-To: <15537178.k4V9gYNSIy@devpool47>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 30 Aug 2021 09:12:04 -0700
Message-ID: <CAJuCfpH+EsqTTok8sT1dXoO6_jz0UJa+PsCbX-_zUty6g-mPYQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] mm: add anonymous vma name refcounting
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Peter Xu <peterx@redhat.com>, rppt@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        vincenzo.frascino@arm.com,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        John Hubbard <jhubbard@nvidia.com>,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        chris.hyser@oracle.com, Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 30, 2021 at 12:03 AM Rolf Eike Beer <eb@emlix.com> wrote:
>
> Am Freitag, 27. August 2021, 21:18:58 CEST schrieb Suren Baghdasaryan:
> > While forking a process with high number (64K) of named anonymous vmas =
the
> > overhead caused by strdup() is noticeable. Experiments with ARM64 Andro=
id
> > device show up to 40% performance regression when forking a process wit=
h
> > 64k unpopulated anonymous vmas using the max name lengths vs the same
> > process with the same number of anonymous vmas having no name.
> > Introduce anon_vma_name refcounted structure to avoid the overhead of
> > copying vma names during fork() and when splitting named anonymous vmas=
.
> > When a vma is duplicated, instead of copying the name we increment the
> > refcount of this structure. Multiple vmas can point to the same
> > anon_vma_name as long as they increment the refcount. The name member o=
f
> > anon_vma_name structure is assigned at structure allocation time and is
> > never changed. If vma name changes then the refcount of the original
> > structure is dropped, a new anon_vma_name structure is allocated
> > to hold the new name and the vma pointer is updated to point to the new
> > structure.
> > With this approach the fork() performance regressions is reduced 3-4x
> > times and with usecases using more reasonable number of VMAs (a few
> > thousand) the regressions is not measurable.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/mm_types.h |  9 ++++++++-
> >  mm/madvise.c             | 42 +++++++++++++++++++++++++++++++++-------
> >  2 files changed, 43 insertions(+), 8 deletions(-)
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index bc029f3fca6a..32ac5dc5ebf3 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -63,6 +63,27 @@ static int madvise_need_mmap_write(int behavior)
> >       }
> >  }
> >
> > +static struct anon_vma_name *anon_vma_name_alloc(const char *name)
> > +{
> > +     struct anon_vma_name *anon_name;
> > +     size_t len =3D strlen(name);
> > +
> > +     /* Add 1 for NUL terminator at the end of the anon_name->name */
> > +     anon_name =3D kzalloc(sizeof(*anon_name) + len + 1,
> > +                         GFP_KERNEL);
> > +     kref_init(&anon_name->kref);
> > +     strcpy(anon_name->name, name);
> > +
> > +     return anon_name;
> > +}
>
> Given that you overwrite anything in that struct anyway this could be red=
uced
> to kmalloc(), no? And it definitely needs a NULL check.

Ack. I'll address both points in the next revision.
Thanks!
Suren.

>
> Eike
> --
> Rolf Eike Beer, emlix GmbH, http://www.emlix.com
> Fon +49 551 30664-0, Fax +49 551 30664-11
> Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
> Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 31=
60
> Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-Id=
Nr.: DE 205 198 055
>
> emlix - smart embedded open source
