Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BA94DBB23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 00:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242047AbiCPXgr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 19:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237131AbiCPXgr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 19:36:47 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2261115A3B
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Mar 2022 16:35:31 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s25so5179026lji.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Mar 2022 16:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PUaRSZQS7aa+6y7Z0BXGANEI06keATxi49n2iARU7lI=;
        b=EKlOY+SlMv2j0eOUgqh3ARh4ND5wmiDDKtt3IIZB2Urcq6zLbFbsExxmvs2pRJIagQ
         T5/iBkJNAo7L4u6lyqVYxRKKUd2SrngFuYxld5zAO6g+XJE/gHRb031PUrlSDxugt6g6
         sXnTQP1qpiqJLmqZ1f6IVSLVb2p4BjMoqTklk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PUaRSZQS7aa+6y7Z0BXGANEI06keATxi49n2iARU7lI=;
        b=520S4P+4UqMKSQEP5dSwgj3+lTQS+LL9gH3sFsLa4JOCpDHzhcB4OLf1T+SfotNH3/
         MmOz876eorG+CymhXOOiZ0VBx9Wsz6LJ4W5ihk/MvKcKZuKh+tWvKqhxa96ePifjth4Z
         WE4XoajO8a1oSPjf/8M0+ZWik4S5me4WLgch9ZUyic/l3OCPcOjmDymjrL09l55n5sAK
         +73PT58oys008V76S7NhZhniXI4RBeGHh/kZFU8eStGX5g/mf25s54i5pUR8hcRkXDRq
         wl9gr1KcLInCRDSoFnvbEJSGnSWpeK6kxyhwXXWPwbPKUDAWM1vkQmHLaktEmhkazkt+
         90Cg==
X-Gm-Message-State: AOAM530ANQ1aspQT7J90kk44Srs9v/q5Wu/RP3OW9mQlgJvD1viu6i2U
        ezXb0LZxHgY8+BgsDortvMI8CxFaLL4rgOah2jg=
X-Google-Smtp-Source: ABdhPJxnSeOCoFaNCOWkxMDiJ4PqIOhl9LCVUoCS+/bu3oTRMrYuOBymq7XtY3QhOxuGN+iE5FMKVQ==
X-Received: by 2002:a2e:a804:0:b0:248:646:4481 with SMTP id l4-20020a2ea804000000b0024806464481mr1144413ljq.403.1647473728998;
        Wed, 16 Mar 2022 16:35:28 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id p1-20020a05651238c100b004435d1d47fasm286070lft.102.2022.03.16.16.35.26
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 16:35:26 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id n19so6275080lfh.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Mar 2022 16:35:26 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr1106390lfh.687.1647473726276; Wed, 16
 Mar 2022 16:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <YjDj3lvlNJK/IPiU@bfoster> <YjJPu/3tYnuKK888@casper.infradead.org>
In-Reply-To: <YjJPu/3tYnuKK888@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Mar 2022 16:35:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPTWoXCa=JembExs8Y7fw7YUi9XR0zn1xaxWLSXBN_vg@mail.gmail.com>
Message-ID: <CAHk-=wgPTWoXCa=JembExs8Y7fw7YUi9XR0zn1xaxWLSXBN_vg@mail.gmail.com>
Subject: Re: writeback completion soft lockup BUG in folio_wake_bit()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Brian Foster <bfoster@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
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

On Wed, Mar 16, 2022 at 1:59 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> As I recall, the bookmark hack was introduced in order to handle
> lock_page() problems.  It wasn't really supposed to handle writeback,
> but nobody thought it would cause any harm (and indeed, it didn't at the
> time).  So how about we only use bookmarks for lock_page(), since
> lock_page() usually doesn't have the multiple-waker semantics that
> writeback has?

I was hoping that some of the page lock problems are gone and we could
maybe try to get rid of the bookmarks entirely.

But the page lock issues only ever showed up on some private
proprietary load and machine, so we never really got confirmation that
they are fixed. There were lots of strong signs to them being related
to the migration page locking, and it may be that the bookmark code is
only hurting these days.

See for example commit 9a1ea439b16b ("mm:
put_and_wait_on_page_locked() while page is migrated") which doesn't
actually change the *locking* side, but drops the page reference when
waiting for the locked page to be unlocked, which in turn removes a
"loop and try again when migration". And that may have been the real
_fix_ for the problem.

Because while the bookmark thing avoids the NMI lockup detector firing
due to excessive hold times, the bookmarking also _causes_ that "we
now will see the same page multiple times because we dropped the lock
and somebody re-added it at the end of the queue" issue. Which seems
to be the problem here.

Ugh. I wish we had some way to test "could we just remove the bookmark
code entirely again".

Of course, the PG_lock case also works fairly hard to not actually
remove and re-add the lock waiter to the queue, but having an actual
"wait for and get the lock" operation. The writeback bit isn't done
that way.

I do hate how we had to make folio_wait_writeback{_killable}() use
"while" rather than an "if". It *almost* works with just a "wait for
current writeback", but not quite. See commit c2407cf7d22d ("mm: make
wait_on_page_writeback() wait for multiple pending writebacks") for
why we have to loop. Ugly, ugly.

Because I do think that "while" in the writeback waiting is a problem.
Maybe _the_ problem.

                        Linus
