Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9F94213DC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Oct 2021 18:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbhJDQUV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Oct 2021 12:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbhJDQUT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Oct 2021 12:20:19 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808E4C061749
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Oct 2021 09:18:30 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id q189so20871076ybq.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Oct 2021 09:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uR9/JpRGdqWxtomN3qJ2Ipc4Ar2OEE4+6BQlZevD6cI=;
        b=JPFCk1ms6o/7kBQKccm81o4ZgoK6OdkO/g95p0M7G1liiYB+paeEDQrq4k5Dg60Nob
         MBxfY6JlKFtdcuaCpXd5rw93a9jsxpwPcqxWPPH8pGSLfEqEYjYEw+LEzyXPpTwKuJRY
         juQfFoljra122sFUwvdtP2H910qu0+G8J/EK3aZl1QTFOeeVo2+abF4VL+1E55Tx/0Pc
         NJFCcT4Km4XWZDtAQgnZMRqthxXH05Risz08/4Cx73OeAEjOhWgBUBK7vgUx+WyzCi6x
         Q4uzFHioQYzr3P321Uko6BfQCKaSGzv669YWPpDqrM0MBx5XzdViRDbUdAQDQkSe+nTJ
         9muA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uR9/JpRGdqWxtomN3qJ2Ipc4Ar2OEE4+6BQlZevD6cI=;
        b=T5Shr43pkCX0yuT6Upfeaxl5rkfMueKFzwroRhewu3DRaOaj0Cbatf12YZLbACki31
         dyFBTle+KLLLMXwJK4M+U79lojrCzHELlpF2yexVsgDERlRNM1O9CZpPOyuzmqFQGo2Q
         8iM1zDgljJ1bbrbh8UiME4rjUVz0DGlOKNMX1bXuAK+N8knkiqY2DP/DZQMZB0H6z/aX
         WRpFo0HfMIT+BsgFo8ml68WFbpjH8HYEbxoq894OSZgGqVFmZCXCrCwQWVsvJecJ+tQy
         1VVr5zr9fRao8cfufX4aVSBla79PYXBW5kp0PFT2pKHH0ehOPg4j3Kq5W11iggihkTtu
         Qt8Q==
X-Gm-Message-State: AOAM530YYOZaQBQzg7shV1UigISwtBxHmxCTsqY9cxZjR8zzv32pq0rT
        C9TzY+YSChfNLKIkmQS/rtjdCdosHQMhjaYj0nUJ6Q==
X-Google-Smtp-Source: ABdhPJwR6U6ARwgKTOtTkiPbCxZEtiw2OiMH0crQotnzwpNIyF9BBjNe/JVFFA1xb/KxcOMSobdm31rcnG0GIHJ8X10=
X-Received: by 2002:a25:552:: with SMTP id 79mr15759580ybf.202.1633364309278;
 Mon, 04 Oct 2021 09:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211001205657.815551-1-surenb@google.com> <5358242.RVGM2oBbkg@devpool47>
In-Reply-To: <5358242.RVGM2oBbkg@devpool47>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 4 Oct 2021 09:18:18 -0700
Message-ID: <CAJuCfpF57Wppc_Si98wEo5cASBgEdS7J=Lt9Ont9+TsVr=KM_w@mail.gmail.com>
Subject: Re: [PATCH v10 1/3] mm: rearrange madvise code to allow for reuse
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
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>,
        Pekka Enberg <penberg@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Jan Glauber <jan.glauber@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Rob Landley <rob@landley.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Serge E. Hallyn" <serge.hallyn@ubuntu.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@suse.de>, Shaohua Li <shli@fusionio.com>,
        Minchan Kim <minchan@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 4, 2021 at 12:03 AM Rolf Eike Beer <eb@emlix.com> wrote:
>
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -63,76 +63,20 @@ static int madvise_need_mmap_write(int behavior)
> >  }
> >
> >  /*
> > - * We can potentially split a vm area into separate
> > - * areas, each area with its own behavior.
> > + * Update the vm_flags on regiion of a vma, splitting it or merging it=
 as
>                                 ^^

Thanks! Will fix in the next version.

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
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
