Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459517B7069
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 19:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240724AbjJCR4W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 13:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240715AbjJCR4V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:56:21 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3B0B4
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Oct 2023 10:56:17 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a1f00b75aaso14278627b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Oct 2023 10:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696355776; x=1696960576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vl0fsz4J68Cnn2M5AWsY3O6OVBkAbz573ZVyP6v8RU=;
        b=byIujj7LX5PdeWfGJNc840K2lhqEXxX9Prx44oyQiYxprBc+c79C24Yfsuy/14+W5i
         3mLVJHJoBLxL3OHxgR0SzsZV37HwJ6PCKYVRLSYWkt/EcEIMYhXGm8vgNCqO9S99VBH0
         RzAINzChqyw3qR0lUi1Hkp/hx+EERiZLtQr6hiGefnz/ySUbSHxK+BOC7rkEIpxvY+2D
         smBTwwQLcQnnLubr3WJ5i3hp1wjn8p/PODzy5ynz4lZhyEwoPMHQBpVVw7wKVogXFB+Y
         uw50S/J9pZG/pejizAewVKuznLAg/ueFWjPhZ/Hjw47icvKe4ddL5t+U46U8BFgPN0g1
         Ho9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696355776; x=1696960576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vl0fsz4J68Cnn2M5AWsY3O6OVBkAbz573ZVyP6v8RU=;
        b=QrGdxzun8zT07plMMUXX0uMwZxq5oV88OfB1FVspp8WLOI4VR2AFseiWVoh3Uw1oGr
         fuwb0AW7HsXmvpMPnDYptjxrwJJm/n1k42z3m35k6nXikNGAas4LRQ3fKcLnwJryMCZZ
         P8jqFeYuwLv3e/jfMLEPvRdMEj9hsHBUqeG8XhDHu764uFapHT3tNcM27xkvzXcuqJpo
         hOVwAXSbrTbciT6LzVurxt8mXRDd70vKaAbujqJnt4ngZ3Th5i/9gyNRyUm03JvyKLQz
         PN1HCukXH1L+i46AOZa6qZ6AOddPYpkjpfQJEBzYd2e0e0d2e1d7g8bvRCP1CoMhrpbj
         jN1Q==
X-Gm-Message-State: AOJu0Yw4sxA10gFK5m4OlWpR63Omgv3DrPGQZn/Hu9yjL9YSp4u/LCRV
        tXUi0fFHyKQDn4uUD/hDRETDxQV2TCbkcDuhzkG86A==
X-Google-Smtp-Source: AGHT+IEifyQz0qts6gjrIdCK30AQEhCj5PiL6BEQwSEb2u68tS34wFFdTdChNXs/1KRYo9kZ+DiSyEy6xlNrljCDdCQ=
X-Received: by 2002:a0d:df46:0:b0:5a0:c0d0:1c48 with SMTP id
 i67-20020a0ddf46000000b005a0c0d01c48mr331306ywe.6.1696355776271; Tue, 03 Oct
 2023 10:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230923013148.1390521-1-surenb@google.com> <20230923013148.1390521-2-surenb@google.com>
 <27f177c9-1035-3277-cd62-dc81c12acec4@redhat.com> <ZRrgWVgjVfQu4RGX@x1n> <e5d41fbe-a91b-9491-7b93-733f67e75a54@redhat.com>
In-Reply-To: <e5d41fbe-a91b-9491-7b93-733f67e75a54@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 3 Oct 2023 10:56:01 -0700
Message-ID: <CAJuCfpEaz_6T0uShTYn-PMzNrs1waCRhCFceyYUn7rKZZGPAtQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] userfaultfd: UFFDIO_REMAP: rmap preparation
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, hughd@google.com,
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 2, 2023 at 10:30=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 02.10.23 17:23, Peter Xu wrote:
> > On Mon, Oct 02, 2023 at 04:42:50PM +0200, David Hildenbrand wrote:
> >> On 23.09.23 03:31, Suren Baghdasaryan wrote:
> >>> From: Andrea Arcangeli <aarcange@redhat.com>
> >>>
> >>> As far as the rmap code is concerned, UFFDIO_REMAP only alters the
> >>> page->mapping and page->index. It does it while holding the page
> >>> lock. However folio_referenced() is doing rmap walks without taking t=
he
> >>> folio lock first, so folio_lock_anon_vma_read() must be updated to
> >>> re-check that the folio->mapping didn't change after we obtained the
> >>> anon_vma read lock.
> >>
> >> I'm curious: why don't we need this for existing users of
> >> page_move_anon_rmap()? What's special about UFFDIO_REMAP?
> >
> > Totally no expert on anon vma so I'm prone to errors, but IIUC the
> > difference here is root anon vma cannot change in page_move_anon_rmap()=
,
> > while UFFDIO_REMAP can.
>
> That does sound reasonable, thanks.
>
> Probably we can do better with the patch description (once [1] is used
> to move the folio to the other anon_vma).

I'll develop the next version with your patches in the baseline.
Hopefully by the time of my posting your patches will be in the
mm-unstable.

>
> "mm/rmap: support move to different root anon_vma in folio_move_anon_rmap=
()
>
> For now, folio_move_anon_rmap() was only used to move a folio to a
> different anon_vma after fork(), whereby the root anon_vma stayed
> unchanged. For that, it was sufficient to hold the page lock when
> calling folio_move_anon_rmap().
>
> However, we want to make use of folio_move_anon_rmap() to move folios
> between VMAs that have a different root anon_vma. As folio_referenced()
> performs an RMAP walk without holding the page lock but only holding the
> anon_vma in read mode, holding the page lock is insufficient.
>
> When moving to an anon_vma with a different root anon_vma, we'll have to
> hold both, the page lock and the anon_vma lock in write mode.
> Consequently, whenever we succeeded in folio_lock_anon_vma_read() to
> read-lock the anon_vma, we have to re-check if the mapping was changed
> in the meantime. If that was the case, we have to retry.
>
> Note that folio_move_anon_rmap() must only be called if the anon page is
> exclusive to a process, and must not be called on KSM folios.
>
> This is a preparation for UFFDIO_REMAP, which will hold the page lock,
> the anon_vma lock in write mode, and the mmap_lock in read mode.
> "

Thanks for taking time to write this up! Looks really clear to me.
I'll reuse it.

>
> In addition, we should document these locking details for
> folio_move_anon_rmap() and probably not mention UFFDIO_REMAP in the
> comment in folio_lock_anon_vma_read(), but instead say
> "folio_move_anon_rmap() might have changed the anon_vma as we might not
> hold the page lock here."

Sounds good. Will add.

>
>
> [1] https://lkml.kernel.org/r/20231002142949.235104-3-david@redhat.com
>
> --
> Cheers,
>
> David / dhildenb
>
