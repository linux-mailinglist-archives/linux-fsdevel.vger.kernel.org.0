Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2567BE8C3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 19:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376891AbjJIR5J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 13:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377093AbjJIR5G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:57:06 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B59991
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Oct 2023 10:57:04 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32167a4adaaso4393915f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Oct 2023 10:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696874222; x=1697479022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HR7i0+7/SsYbq7Xpu0I3F4tMxRg2aNZclcuGtCASF8c=;
        b=fdkxdtEWlW7QEapch5rwJK4HMlZLcFum4UxXs3ovDgjGO+5U9sWPjy092+w4PoQKfq
         WSaMqkAsx2fwSP4nUU3LrHefqxIsCrCUrDcpEyjO3fAgeAeHPfs5PBt1fg2idxI5BbCZ
         RBnn37wS9+0HG2M7chsB4XG1kr2AdEiZF8UG27tE+2cOYGEuZnQfmqo9+zlkpTe1MgoF
         wKOXUoQXTiuMUhxTDi5eAlnhWKCmXmkz4kUBjA1J7zwqpGUmHCQLMzNc6nCrhgMGertS
         MkRDTvkXvTtxRl7oy9LCVHsxFxI4Uz91jfLr7sIJOHz+DipiQowQLvwYDjXWoRlXOBfp
         Tgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696874222; x=1697479022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HR7i0+7/SsYbq7Xpu0I3F4tMxRg2aNZclcuGtCASF8c=;
        b=Y/ZRyhsXXC9KgNyCQ++1fFnBZBUnKkcOgSAoO/L08fRnXcjP7ZApwCXuuS5zX3Pc9J
         4oPFepqC5KsG2U9NP6odP1nd4iFBUgA53vqPYV59plTXLQkNqp07zzZ/Jkqhz9PThGSV
         98mLAAA8jhjWky0F2JsWuWpLfOqsuq08kufaj7UGzfLRYU+dG3TVXPtuOJYpoljYOTuv
         FCWXfhuAVhSopGglvMMIbF3Uy5qAeKJu/CTUKzs+lcxS42p0TyUUd8HYmEkIza5Qslbg
         uATITcWT4Zd+5ZvW6+XwWuVDzy88VloJyUyu3Xqn2w43IPgMENDnU/zpTmvarW6SK9Wj
         xYRg==
X-Gm-Message-State: AOJu0Yz2SdRXA5MET/b/z8NTrAK1mSp26RWZ9AzNcIzxHjvxj0ZY0OKh
        5OZ6otJJKfxyoLb6qmYcTMukjdmQQGOBjY3ADhfEOQ==
X-Google-Smtp-Source: AGHT+IFdugjmpCG+0rz5vOSpRJwP3Q+EaYZkFCxXfXiHgTVi3kGGdp/ap2cjhuKlC0Nv/dcgveGTyVI98G4zOxrgfMg=
X-Received: by 2002:a05:6000:1046:b0:31f:f9fe:e739 with SMTP id
 c6-20020a056000104600b0031ff9fee739mr14684966wrx.59.1696874222386; Mon, 09
 Oct 2023 10:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231009064230.2952396-1-surenb@google.com> <20231009064230.2952396-3-surenb@google.com>
 <214b78ed-3842-5ba1-fa9c-9fa719fca129@redhat.com> <CAJuCfpHzSm+z9b6uxyYFeqr5b5=6LehE9O0g192DZdJnZqmQEw@mail.gmail.com>
 <478697aa-f55c-375a-6888-3abb343c6d9d@redhat.com> <CA+EESO5nvzka0KzFGzdGgiCWPLg7XD-8jA9=NTUOKFy-56orUg@mail.gmail.com>
In-Reply-To: <CA+EESO5nvzka0KzFGzdGgiCWPLg7XD-8jA9=NTUOKFy-56orUg@mail.gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Mon, 9 Oct 2023 10:56:50 -0700
Message-ID: <CA+EESO47LqwMwGgkHQdx1cBdcn_+FWqda8OPcBU-skk9yML_qA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] userfaultfd: UFFDIO_MOVE uABI
To:     David Hildenbrand <david@redhat.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, peterx@redhat.com, hughd@google.com,
        mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
        willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
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

On Mon, Oct 9, 2023 at 9:29=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.com=
> wrote:
>
> On Mon, Oct 9, 2023 at 5:24=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
> >
> > On 09.10.23 18:21, Suren Baghdasaryan wrote:
> > > On Mon, Oct 9, 2023 at 7:38=E2=80=AFAM David Hildenbrand <david@redha=
t.com> wrote:
> > >>
> > >> On 09.10.23 08:42, Suren Baghdasaryan wrote:
> > >>> From: Andrea Arcangeli <aarcange@redhat.com>
> > >>>
> > >>> Implement the uABI of UFFDIO_MOVE ioctl.
> > >>> UFFDIO_COPY performs ~20% better than UFFDIO_MOVE when the applicat=
ion
> > >>> needs pages to be allocated [1]. However, with UFFDIO_MOVE, if page=
s are
> > >>> available (in userspace) for recycling, as is usually the case in h=
eap
> > >>> compaction algorithms, then we can avoid the page allocation and me=
mcpy
> > >>> (done by UFFDIO_COPY). Also, since the pages are recycled in the
> > >>> userspace, we avoid the need to release (via madvise) the pages bac=
k to
> > >>> the kernel [2].
> > >>> We see over 40% reduction (on a Google pixel 6 device) in the compa=
cting
> > >>> thread=E2=80=99s completion time by using UFFDIO_MOVE vs. UFFDIO_CO=
PY. This was
> > >>> measured using a benchmark that emulates a heap compaction implemen=
tation
> > >>> using userfaultfd (to allow concurrent accesses by application thre=
ads).
> > >>> More details of the usecase are explained in [2].
> > >>> Furthermore, UFFDIO_MOVE enables moving swapped-out pages without
> > >>> touching them within the same vma. Today, it can only be done by mr=
emap,
> > >>> however it forces splitting the vma.
> > >>>
> > >>> [1] https://lore.kernel.org/all/1425575884-2574-1-git-send-email-aa=
rcange@redhat.com/
> > >>> [2] https://lore.kernel.org/linux-mm/CA+EESO4uO84SSnBhArH4HvLNhaUQ5=
nZKNKXqxRCyjniNVjp0Aw@mail.gmail.com/
> > >>>
> > >>> Update for the ioctl_userfaultfd(2)  manpage:
> > >>>
> > >>>      UFFDIO_MOVE
> > >>>          (Since Linux xxx)  Move a continuous memory chunk into the
> > >>>          userfault registered range and optionally wake up the bloc=
ked
> > >>>          thread. The source and destination addresses and the numbe=
r of
> > >>>          bytes to move are specified by the src, dst, and len field=
s of
> > >>>          the uffdio_move structure pointed to by argp:
> > >>>
> > >>>              struct uffdio_move {
> > >>>                  __u64 dst;    /* Destination of move */
> > >>>                  __u64 src;    /* Source of move */
> > >>>                  __u64 len;    /* Number of bytes to move */
> > >>>                  __u64 mode;   /* Flags controlling behavior of mov=
e */
> > >>>                  __s64 move;   /* Number of bytes moved, or negated=
 error */
> > >>>              };
> > >>>
> > >>>          The following value may be bitwise ORed in mode to change =
the
> > >>>          behavior of the UFFDIO_MOVE operation:
> > >>>
> > >>>          UFFDIO_MOVE_MODE_DONTWAKE
> > >>>                 Do not wake up the thread that waits for page-fault
> > >>>                 resolution
> > >>>
> > >>>          UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES
> > >>>                 Allow holes in the source virtual range that is bei=
ng moved.
> > >>>                 When not specified, the holes will result in ENOENT=
 error.
> > >>>                 When specified, the holes will be accounted as succ=
essfully
> > >>>                 moved memory. This is mostly useful to move hugepag=
e aligned
> > >>>                 virtual regions without knowing if there are transp=
arent
> > >>>                 hugepages in the regions or not, but preventing the=
 risk of
> > >>>                 having to split the hugepage during the operation.
> > >>>
> > >>>          The move field is used by the kernel to return the number =
of
> > >>>          bytes that was actually moved, or an error (a negated errn=
o-
> > >>>          style value).  If the value returned in move doesn't match=
 the
> > >>>          value that was specified in len, the operation fails with =
the
> > >>>          error EAGAIN.  The move field is output-only; it is not re=
ad by
> > >>>          the UFFDIO_MOVE operation.
> > >>>
> > >>>          The operation may fail for various reasons. Usually, remap=
ping of
> > >>>          pages that are not exclusive to the given process fail; on=
ce KSM
> > >>>          might deduplicate pages or fork() COW-shares pages during =
fork()
> > >>>          with child processes, they are no longer exclusive. Furthe=
r, the
> > >>>          kernel might only perform lightweight checks for detecting=
 whether
> > >>>          the pages are exclusive, and return -EBUSY in case that ch=
eck fails.
> > >>>          To make the operation more likely to succeed, KSM should b=
e
> > >>>          disabled, fork() should be avoided or MADV_DONTFORK should=
 be
> > >>>          configured for the source VMA before fork().
> > >>>
> > >>>          This ioctl(2) operation returns 0 on success.  In this cas=
e, the
> > >>>          entire area was moved.  On error, -1 is returned and errno=
 is
> > >>>          set to indicate the error.  Possible errors include:
> > >>>
> > >>>          EAGAIN The number of bytes moved (i.e., the value returned=
 in
> > >>>                 the move field) does not equal the value that was
> > >>>                 specified in the len field.
> > >>>
> > >>>          EINVAL Either dst or len was not a multiple of the system =
page
> > >>>                 size, or the range specified by src and len or dst =
and len
> > >>>                 was invalid.
> > >>>
> > >>>          EINVAL An invalid bit was specified in the mode field.
> > >>>
> > >>>          ENOENT
> > >>>                 The source virtual memory range has unmapped holes =
and
> > >>>                 UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES is not set.
> > >>>
> > >>>          EEXIST
> > >>>                 The destination virtual memory range is fully or pa=
rtially
> > >>>                 mapped.
> > >>>
> > >>>          EBUSY
> > >>>                 The pages in the source virtual memory range are no=
t
> > >>>                 exclusive to the process. The kernel might only per=
form
> > >>>                 lightweight checks for detecting whether the pages =
are
> > >>>                 exclusive. To make the operation more likely to suc=
ceed,
> > >>>                 KSM should be disabled, fork() should be avoided or
> > >>>                 MADV_DONTFORK should be configured for the source v=
irtual
> > >>>                 memory area before fork().
> > >>>
> > >>>          ENOMEM Allocating memory needed for the operation failed.
> > >>>
> > >>>          ESRCH
> > >>>                 The faulting process has exited at the time of a
> > >>>                 UFFDIO_MOVE operation.
> > >>>
> > >>
> > >> A general comment simply because I realized that just now: does anyt=
hing
> > >> speak against limiting the operations now to a single MM?
> > >>
> > >> The use cases I heard so far don't need it. If ever required, we cou=
ld
> > >> consider extending it.
> > >>
> > >> Let's reduce complexity and KIS unless really required.
> > >
> > > Let me check if there are use cases that require moves between MMs.
> > > Andrea seems to have put considerable effort to make it work between
> > > MMs and it would be a pity to lose that. I can send a follow-up patch
> > > to recover that functionality and even if it does not get merged, it
> > > can be used in the future as a reference. But first let me check if w=
e
> > > can drop it.
>
> For the compaction use case that we have it's fine to limit it to
> single MM. However, for general use I think Peter will have a better
> idea.
> >
> > Yes, that sounds reasonable. Unless the big important use cases require=
s
> > moving pages between processes, let's leave that as future work for now=
.
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >

While going through mremap's move_page_tables code, which is pretty
similar to what we do here, I noticed that cache is flushed as well,
whereas we are not doing that here. Is that OK? I'm not a MM expert by
any means, so it's a question rather than a comment :)
