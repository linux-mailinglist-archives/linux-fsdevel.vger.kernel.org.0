Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4346B3134
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 23:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjCIWms (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 17:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjCIWm1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:42:27 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F762ED67
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Mar 2023 14:41:41 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id f18so4292033lfa.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Mar 2023 14:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678401610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbAikeIdL+omb6y11NKt1vr7KucGsxizbqoLplhFCoo=;
        b=DkAi09PuPVTp0hxHpLSz4t87TRBgGLDjZ9W4eKqEWOosoh7NEt2ji+IrV4y/BdgcY9
         skLeabsKW4jeG2GzdbXYXwyO+MsKjGqXldrPeDdFRmTSd/uFUS8ec7Bn2+AjYHuCaESx
         weJLsbQ1qHUJ5RAtAOYTNaviRtR1X+0QPCY9OhbKxhB5nDmp5wOWw4UBRzy/bMgQNQBr
         dPgZGHl4IojX9goLytD6PJVC92GxsOh2TfNXEjmmQDB3qTrtDDjxUPQM2+DUAJiE1LLR
         YFdepkGF4YX3sbCfx6WYuiNAH/RneZ17WAP7RBd1anbeQX0C5MJ+HkeqWIRf3rAB6pZx
         /djw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678401610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbAikeIdL+omb6y11NKt1vr7KucGsxizbqoLplhFCoo=;
        b=bw0CQocZx9EabdZaWZYUcFuC9mD1mXFOqNogxDU4IkR5c1JX+dYKVRST7m5lNiQVdN
         krZMobWirFRp3LJzHqa4i4kczDETGDcgiZd6hHP2bjlzaI02rABU8TDRImTf3ijfbjfx
         WMJ7Lb8CzGKdc1Ym7Imhbbo9Yo0z+fsiq1zjICMDTXmfjGkeIGqZ/Ni7VcHXS2TdotPA
         wv5oyeRylSPUqQqLOCCTWURkvg3W5a3ny57lSIaCLHeTqFMVMo7On7wUw968al+JfgLm
         JtrMoBk6d19qZIcinTqd8xXVa22XSkSyMlk1z3PIv7XcrWjkL+MCr6YNWn645H+Hpi9y
         ljZA==
X-Gm-Message-State: AO0yUKXZlS4HJ6EBdZloQePDBuWhXJalqX9Hyn2uB6X8JLaGaO8wkB1c
        iLo6DqMXFRKywcNMdYQmKR1Zh6oMPfGaQ6g0vCNkcw==
X-Google-Smtp-Source: AK7set9wPQ7n+O+qozP441kYgMXEWRqd09XR/uf9pCcC+fLMi9lyfYb5jxqy2HTgbAi1e6AGJJ6CFWpaMh2S7PfTWlM=
X-Received: by 2002:a05:6512:3c99:b0:4d8:86c2:75ea with SMTP id
 h25-20020a0565123c9900b004d886c275eamr149481lfv.3.1678401609928; Thu, 09 Mar
 2023 14:40:09 -0800 (PST)
MIME-Version: 1.0
References: <20230308221932.1548827-1-axelrasmussen@google.com>
 <20230308221932.1548827-4-axelrasmussen@google.com> <ZAkPmy0EqcW6Mfvn@x1n>
In-Reply-To: <ZAkPmy0EqcW6Mfvn@x1n>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 9 Mar 2023 14:39:33 -0800
Message-ID: <CAJHvVcjDtt0CEEyihViUeQYHr8zV97kZEr+zPFBRVmqwMXZzSg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] mm: userfaultfd: combine 'mode' and 'wp_copy' arguments
To:     Peter Xu <peterx@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>, Shuah Khan <shuah@kernel.org>,
        James Houghton <jthoughton@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 8, 2023 at 2:43=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> All nitpicks below.
>
> On Wed, Mar 08, 2023 at 02:19:31PM -0800, Axel Rasmussen wrote:
> > +static inline bool uffd_flags_has_mode(uffd_flags_t flags, enum mfill_=
atomic_mode expected)
> > +{
> > +     return (flags & MFILL_ATOMIC_MODE_MASK) =3D=3D ((__force uffd_fla=
gs_t) expected);
> > +}
>
> I would still call it uffd_flags_get_mode() or uffd_flags_mode(), "has"
> sounds a bit like there can be >1 modes set but it's not.

I want a helper which does the comparison, instead of just returning
the mode, because it avoids all callers needing to do the __force cast
themselves to appease sparse.

How about uffd_flags_mode_is() ?

>
> > +
> > +static inline uffd_flags_t uffd_flags_set_mode(uffd_flags_t flags, enu=
m mfill_atomic_mode mode)
> > +{
> > +     return flags | ((__force uffd_flags_t) mode);
> > +}
>
> IIUC this __force mostly won't work in any way because it protects
> e.g. illegal math ops upon it (to only allow bitops, iiuc) but here it's =
an
> OR so it's always legal..
>
> So I'd just drop it and also clear the mode mask to be very clear it sets
> the mode right, rather than any chance of messing up when set twice:
>
>     flags &=3D ~MFILL_ATOMIC_MODE_MASK;
>     return flags | mode;

Without this __force, "make C=3D1" gives errors like this:

./include/linux/userfaultfd_k.h:66:16: warning: restricted
uffd_flags_t degrades to integer
./include/linux/userfaultfd_k.h:66:22: warning: incorrect type in
return expression (different base types)
./include/linux/userfaultfd_k.h:66:22:    expected restricted uffd_flags_t
./include/linux/userfaultfd_k.h:66:22:    got unsigned int

This is because the mode being passed in is effectively an integer, so
the | expression loses the restricted type. Casting the mode first
like this appeases sparse.

An alternative would be to do the cast in the definition of the mode
values up-front; but as we noticed before, we can't really usefully do
that with it still being an enum (so we'd have to hard-code things
like the mode mask, etc.)

I do completely agree about clearing the mask bits first, to avoid
mistakes. I'll send an updated version with that change. If we're
going to have an inline helper anyway to do that, for me it makes less
sense to switch away from the num approach (basically the benefit of
that would be to avoid needing this cast, and therefore the helper;
but if we want the helper anyway for other reasons ...).

>
> But feel free to ignore this if there's no other reason to repost, I don'=
t
> think it matters a huge deal.
>
> Acked-by: Peter Xu <peterx@redhat.com>
>
> Thanks,
>
> --
> Peter Xu
>
