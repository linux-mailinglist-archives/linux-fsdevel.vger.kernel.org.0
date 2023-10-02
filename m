Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70627B5B64
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 21:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238880AbjJBTeR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 15:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238877AbjJBTeP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:34:15 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0A4CE
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 12:34:12 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-406402933edso1237385e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Oct 2023 12:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696275251; x=1696880051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Pz/zszYZyE+z1VL1nxPoO+pF7/bzU2CO2PuRnZJXyI=;
        b=AvxWpVWwDLsGAieXe1iULfVyuZN1Sv5x22bBYoK1E14jftZVMlKPTJ23l7zOVhUqM9
         OhL7xjD8eSSs6idfaH6TJAr6FqCpfuSAIi5AiEzytrUkrXLL5NM5ps76QOWgFfzYYtd1
         XC9xkmEDmVWXHW+4qY1xfwppHsTNgfTqFm3ipGsHAuqezUaRIwb68ajLsG0lR258vPCG
         VfxHCQBKlgEAw+UQXs0JGJJ4MyRT856a9Y/McYyQPf3NxTt7wXhZzvdue9r5Cgleo1VH
         ABHRDx8tw5iscMFhdf+kTN/9i+fosFHaaS6G3Tc5yDYBbsv7rIbL0QY8yKy5j5UH+q4d
         2QBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696275251; x=1696880051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Pz/zszYZyE+z1VL1nxPoO+pF7/bzU2CO2PuRnZJXyI=;
        b=DC0syykXJbUD8j2lMQ6gVxe7Snr8vf+Au7TVYXi7KfkRtQhcuGxYRxiLFOwmDZfMVv
         HpnphCIxvVj8RcNR81ygUqZz1YeAA+3Q0i6J15UHpBxUSv4coztHj59THr9bCshvPxcR
         cbxAe9bkSnQUEY74PZqYc3vghZLe5cd9792owmr+oq/N5XCDdWqSpTzZzVav1fxRtDOw
         Zh84RMqb5ZMNWD1AmXSd1vzwoUwjQn+Tp9mm3pCDzoilLFRao7fJAto9DOm3WxwXp2AF
         iuPkVUoRm/VvLFaTgHurHgriMdauaW+955YmqCpCSbSneT3lmwfSqM9bdkyXUFbolCn3
         R/wg==
X-Gm-Message-State: AOJu0YxpYGFqiLICOl2o2aW1fRqPvFGbFx+wotWw5OI5mnEpTkI5jLCW
        2uhn15/YFTZGZj0UzAzLW0t4f6IbYRmnf0JAvenKWQ==
X-Google-Smtp-Source: AGHT+IE/XDcbApgyGi2vWDALA9HVtbtfsl01C0bACjHSTSMxs1si+IYmi0/4MCZOMnKZuuCpOGdPMN+KIKfh0A4NSTs=
X-Received: by 2002:a05:6000:184:b0:31f:ea18:6f6b with SMTP id
 p4-20020a056000018400b0031fea186f6bmr10781947wrx.19.1696275250982; Mon, 02
 Oct 2023 12:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230923013148.1390521-1-surenb@google.com> <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
 <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com> <ZRWo1daWBnwNz0/O@x1n>
 <98b21e78-a90d-8b54-3659-e9b890be094f@redhat.com> <ZRW2CBUDNks9RGQJ@x1n>
 <85e5390c-660c-ef9e-b415-00ee71bc5cbf@redhat.com> <ZRXHK3hbdjfQvCCp@x1n>
 <fc27ce41-bc97-91a7-deb6-67538689021c@redhat.com> <ZRrf8NligMzwqx97@x1n>
 <CA+EESO5VtrfXv-kvDsotPLXcpMgOK5t5c+tbXZ7KWRU2O_0PBQ@mail.gmail.com>
 <CA+EESO4W2jmBSpyHkkqZV0LHnA_OyWQcvwSkfPcWmWCsAF5UWw@mail.gmail.com> <9434ef94-15e8-889c-0c31-3e875060a2f7@redhat.com>
In-Reply-To: <9434ef94-15e8-889c-0c31-3e875060a2f7@redhat.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Mon, 2 Oct 2023 20:33:58 +0100
Message-ID: <CA+EESO4GuDXZ6newN-oF43WOxrfsZ9Ejq8RJNF2wOYq571zmDA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 2, 2023 at 6:43=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 02.10.23 17:55, Lokesh Gidra wrote:
> > On Mon, Oct 2, 2023 at 4:46=E2=80=AFPM Lokesh Gidra <lokeshgidra@google=
.com> wrote:
> >>
> >> On Mon, Oct 2, 2023 at 4:21=E2=80=AFPM Peter Xu <peterx@redhat.com> wr=
ote:
> >>>
> >>> On Mon, Oct 02, 2023 at 10:00:03AM +0200, David Hildenbrand wrote:
> >>>> In case we cannot simply remap the page, the fallback sequence (from=
 the
> >>>> cover letter) would be triggered.
> >>>>
> >>>> 1) UFFDIO_COPY
> >>>> 2) MADV_DONTNEED
> >>>>
> >>>> So we would just handle the operation internally without a fallback.
> >>>
> >>> Note that I think there will be a slight difference on whole remap
> >>> atomicity, on what happens if the page is modified after UFFDIO_COPY =
but
> >>> before DONTNEED.
> >>>
> >>> UFFDIO_REMAP guarantees full atomicity when moving the page, IOW, thr=
eads
> >>> can be updating the pages when ioctl(UFFDIO_REMAP), data won't get lo=
st
> >>> during movement, and it will generate a missing event after moved, wi=
th
> >>> latest data showing up on dest.
> >>>
> >>> I'm not sure that means such a fallback is a problem, Suren may know
> >>> better with the use case.
> >>
> >> Although there is no problem in using fallback with our use case but
> >> as a user of userfaultfd, I'd suggest leaving it to the developer.
> >> Failing with appropriate errno makes more sense. If handled in the
> >> kernel, then the user may assume at the end of the operation that the
> >> src vma is completely unmapped. And if not correctness issues, it
> >> could lead to memory leaks.
> >
> > I meant that in addition to the possibility of correctness issues due
> > to lack of atomicity, it could also lead to memory leaks, as the user
> > may assume that src vma is empty post-operation. IMHO, it's better to
> > fail with errno so that the user would fix the code with necessary
> > changes (like using DONTFORK, if forking).
>
> Leaving the atomicity discussion out because I think this can just be
> handled (e.g., the src_vma would always be empty post-operation):
>
> It might not necessarily be a good idea to only expose micro-operations
> to user space. If the user-space fallback will almost always be
> "UFFDIO_COPY+MADV_DONTNEED", then clearly the logical operation
> performed is moving data, ideally with zero-copy.
>
IMHO, such a fallback will be useful only if it's possible that only
some pages in the src vma fail due to this. But even then it would be
really useful to have a flag maybe like UFFDIO_REMAP_FALLBACK_COPY to
control if the user wants the fallback or not. OTOH, if this is
something that can be detected for the entire src vma, then failing
with errno is more appropriate.

Given that the patch is already quite complicated, I humbly suggest
leaving the fallback for now as a TODO.

> [as said as reply to Peter, one could still have magic flags for users
> that really want to detect when zero-copy is impossible]
>
> With a logical MOVE API users like compaction [as given in the cover
> letter], not every such user has to eventually implement fallback paths.
>
> But just my 2 cents, the UFFDIO_REMAP users probably can share what the
> exact use cases are and if fallbacks are required at all or if no-KSM +
> DONTFORK just does the trick.
>
> --
> Cheers,
>
> David / dhildenb
>
