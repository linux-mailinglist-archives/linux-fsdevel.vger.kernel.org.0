Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2C3525A5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 05:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376879AbiEMDrd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 23:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352228AbiEMDrc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 23:47:32 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C87B5FF01
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 20:47:30 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id e7so3637737vkh.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 20:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zMLk1Ay+Dq4Ta56iDG7dM32hpID8fSkg4kAmLD778ok=;
        b=caPJHttEez05Vmo1EY25yNiTf5aMepNmLUt0WkY3lFFYxKSq/9CC3uVzsYZpO0NFi3
         C/7nRIPjDHSWiqsNmCzOXt6VeBAiJbrxIGgkApZzElmTCg8bhRTG2NO6Tpvx4HhNq+XS
         XGSmBTNh/P2kTShOISVxQfanQqPcZnMo41ouGZAzUSWLp14RzCaQE8O6cjp8heqQ5Dlu
         HAorm7X+ZmMmDRGnTHzwzRc7Un//zcN2uZEH0K0ApmLwDTpoTm71KRlBlxRg4IIAL2F5
         TGPZEZRK97j3RF4thOWAB40zkId+FBDnSRXT8hwzCxl2VPGsu77TiD9ZNdXrtU7ZWXXL
         7zMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zMLk1Ay+Dq4Ta56iDG7dM32hpID8fSkg4kAmLD778ok=;
        b=jBEGwI2UUg38bz9yti5/GuoNrV9zv2jyxDuT0iKtaaW0pznokLjPBgAr833JNxBhSH
         OrPKth7lkjzlqpuePEDlHgVvLtM20pTI4Z6dIyPADOYNf620moGYWYJ5By8C6gZDYMEO
         flVItAAJCGeNDvkgZ3cozPhA23BOeohYSzIr8XuyqTiZK3vOzmbC3tSKaxoEfTL3fN7B
         7O1eMLjOXIVpdNRrAirnB5djznECPGLG8cfh6mTksXynrlTJZN4WC/PigXg1ANL6uiQm
         FfKF3hqoNqBEM4BdaZLmSJK7pkBRlSuBvGJnfkPCfNNeJG9REf8sOsqAbazOVpQ2+uSH
         lM+g==
X-Gm-Message-State: AOAM530jdZFMX1tB0lqhDYgh/OgLHumhOSSUEhumCR0ML5GzyK9zHN0o
        tChqVwUI0RsEZSjEn3KtTX1O00utmlFw/tFciG5Pe390pvs=
X-Google-Smtp-Source: ABdhPJxV0TetOu+mRPeQoHxb7dsAS7IbYg8HeKbEJMIVBQ1No7E0qF1ZLEHUpf0gg4dJuTVuzCor3TMukC/4GEBpEgc=
X-Received: by 2002:a1f:ec45:0:b0:34e:6cdc:334e with SMTP id
 k66-20020a1fec45000000b0034e6cdc334emr1600555vkh.26.1652413649607; Thu, 12
 May 2022 20:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <Yn10Iz1mJX1Mu1rv@casper.infradead.org>
In-Reply-To: <Yn10Iz1mJX1Mu1rv@casper.infradead.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 12 May 2022 21:46:53 -0600
Message-ID: <CAOUHufbF5tLgJF+W8PBv1i1annSb9ySkJbhwQaJOsK04KdYJzg@mail.gmail.com>
Subject: Re: Freeing page flags
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 12, 2022 at 2:55 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> The LWN writeup [1] on merging the MGLRU reminded me that I need to send
> out a plan for removing page flags that we can do without.

Much appreciated.

> 1. PG_error.  It's basically useless.  If the page was read successfully,
> PG_uptodate is set.  If not, PG_uptodate is clear.  The page cache
> doesn't use PG_error.  Some filesystems do, and we need to transition
> them away from using it.
>
> 2. PG_private.  This tells us whether we have anything stored at
> page->private.  We can just check if page->private is NULL or not.
> No need to have this extra bit.  Again, there may be some filesystems
> that are a bit wonky here, but I'm sure they're fixable.
>
> 3. PG_mappedtodisk.  This is really only used by the buffer cache.
> Once the filesystems that use bufferheads have been converted, this can
> go away.
>
> 4. I think I can also consolidate PG_slab and PG_reserved into a "single
> bit" (not really, but change the encoding so that effectively they only
> take a single bit).
>
> That gives us 4 bits back, which should relieve the pressure on page flag
> bits for a while.  I have Thoughts on PG_private_2 and PG_owner_priv_1,
> as well as a suspicion that not all combinations of referenced, lru,
> active, workingset, reclaim and unevictable are possible, and there
> might be scope for a better encoding.  But I don't know that we need to
> do that work; gaining back 4 bits is already a Big Deal.

PG_active, PG_ unevictable and PG_swapbacked seem to be the low
hanging fruit among those you mentioned above. They indicate which LRU
list a folio is currently on, was deleted from or should be added to.
We should be able to use the spare bits in folio->lru for this
purpose. WDYT?

> I'm slowly doing the PG_private transition as part of the folio work.
> For example, eagle eyed reviewers may have spotted that there is no
> folio_has_buffers().  Converted code calls folio_buffers() and checks
> if it's NULL.  Help from filesystem maintainers on removing the uses of
> PG_error gratefully appreciated.
>
> [1] https://lwn.net/Articles/894859/

We'd be very happy to help with testing and reviewing, etc.
