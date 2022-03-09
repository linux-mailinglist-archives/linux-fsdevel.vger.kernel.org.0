Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E234D3B58
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 21:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbiCIUtW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 15:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbiCIUtW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:49:22 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8B133E2D
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 12:48:22 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id r4so5951648lfr.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Mar 2022 12:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zGqeo2LtdIlvNqnd6R2s5eetiuT+hRt9mmDkO0Tckbg=;
        b=PWCsZlVycSx5+VU2FvKPokNaZvFARLZhdR+NloChOOsE5FG1pZlOARqcts3qtbEfiV
         Jac1mG8KWnbOw9MoSqlVRYlGu7wFIW/+vbmcBNGZj0T73vPlbfb4IVtymATFS/oyXcfM
         wPhJl5v4zoMSVNsy37CGUm/kJgR6HBdYc0ick=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zGqeo2LtdIlvNqnd6R2s5eetiuT+hRt9mmDkO0Tckbg=;
        b=qBzxHF4O2QjHiJks9F+3IP80k2KER0uL+uHu52KihAkdXCM1Euf5KObGXSYQqxdTrA
         lYba6gmau3XSjgWd3EYtMtCt/IeYxwREH8tZPaAEJrBIG01aCh3t35VjvFLCZsmFSVNg
         GLYy6lCeMpvaplo2IvcgSW9XtquZx+Lk3SGHw/BjNo4qWXOayBUls7tl4X3q1/IfjS3R
         r8/vSd/8TPdgK+als/MUiUe+4j/16/CcrrLOVFv0dweDyq7i3g/adihTzm5Jrbyua6nh
         diad3luITFCRxrn7XkoizrQhW5WFqpvZOZ8Pduz/3TAhT+/JufqUvx0Kadit4rsHQA+G
         X1Tg==
X-Gm-Message-State: AOAM533z8/HUbaih27j7pj4pVsZH5mRi1m11yL4LVE+gaM+0P9UGbLD5
        6HMjCWEdDJMjl8Cbc/0VJi9RwfUQhKfbzoNZTZQ=
X-Google-Smtp-Source: ABdhPJy3SXclShsM9q1Ah57uuoaYQl2txk5vJPfL7lItgi8XUMhkbC1hnXhQbAsYONO4Do75QvHKKw==
X-Received: by 2002:a05:6512:32b9:b0:448:27f8:3e67 with SMTP id q25-20020a05651232b900b0044827f83e67mr916185lfe.106.1646858900649;
        Wed, 09 Mar 2022 12:48:20 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id b41-20020a0565120ba900b00442f16bb051sm579571lfv.18.2022.03.09.12.48.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 12:48:19 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id w27so5917094lfa.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Mar 2022 12:48:19 -0800 (PST)
X-Received: by 2002:ac2:41cf:0:b0:448:1eaa:296c with SMTP id
 d15-20020ac241cf000000b004481eaa296cmr917150lfi.52.1646858899041; Wed, 09 Mar
 2022 12:48:19 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
 <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
 <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com> <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
 <CAHk-=wi1jrn=sds1doASepf55-wiBEiQ_z6OatOojXj6Gtntyg@mail.gmail.com>
 <CAHc6FU6L8c9UCJF_qcqY=USK_CqyKnpDSJvrAGput=62h0djDw@mail.gmail.com>
 <CAHk-=whaoxuCPg4foD_4VBVr+LVgmW7qScjYFRppvHqnni0EMA@mail.gmail.com>
 <20220309184238.1583093-1-agruenba@redhat.com> <CAHk-=wixOLK1Xp-LKhqEWEh3SxGak_ziwR0_fi8uMzY5ZYBzbg@mail.gmail.com>
 <CAHc6FU6aqqYO4d5x3=73bxr+9yfL6CLJeGGzFwCZCy9wzApgwQ@mail.gmail.com>
 <CAHk-=wj4Av2gecvTfExCq-d2cXx0m7fdO0sG6JC1DxdCCDT7ig@mail.gmail.com> <CAHc6FU4uzG+HR1doK5p+6kVW9GS0JGbCrbZnAvBhWuLZe8DGUw@mail.gmail.com>
In-Reply-To: <CAHc6FU4uzG+HR1doK5p+6kVW9GS0JGbCrbZnAvBhWuLZe8DGUw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Mar 2022 12:48:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=whycC7kUa=_CiDr9pPpPp8g+9u7kKe1ssSsgGGkhBTvVg@mail.gmail.com>
Message-ID: <CAHk-=whycC7kUa=_CiDr9pPpPp8g+9u7kKe1ssSsgGGkhBTvVg@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 9, 2022 at 12:37 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> It's a moot point now, but I don't think handle_mm_fault would have
> returned VM_FAULT_RETRY without FAULT_FLAG_ALLOW_RETRY, so there
> wouldn't have been any NULL pointer accesses.

No, it really does - FAULT_FLAG_KILLABLE will trigger the code in
page_lock_or_retry() (->__folio_lock_or_retry) even without
FAULT_FLAG_ALLOW_RETRY.

So lock_page_or_retry() will drop the mmap_sem and return false, and
then you have

        locked = lock_page_or_retry(page, vma->vm_mm, vmf->flags);

        if (!locked) {
                ret |= VM_FAULT_RETRY;
                goto out_release;
        }

for the swapin case.

And mm/filemap.c has essentially the same logic in
lock_folio_maybe_drop_mmap(), although the syntax is quite different.

Basically FAULT_FLAG_KILLABLE implies a kind of "half-way ALLOW_RETRY"
- allow aborting, but only for the fatal signal case.

                  Linus
