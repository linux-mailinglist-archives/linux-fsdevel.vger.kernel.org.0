Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BA73E95CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 18:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhHKQVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 12:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhHKQVE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 12:21:04 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9116BC0613D3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Aug 2021 09:20:40 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id w20so6907529lfu.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Aug 2021 09:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TP3ufg1FSgd52Z8zyecJ3z2FJfxxpEJLtGauUCReCG0=;
        b=EA116gbTFYV7o499N6EJRHWJpCb8E2cDR0KgG9vT5t8Ki0uDt41w7TZRef7nzLjAUy
         UxWG1a3ITXp/zwWJES+A2QmPSrpf6qK3SJgg3e2aC00nDoCc1sPpGjZf8HpjD4pZnot3
         ERmXXUn8oCwiDwA5toJaM50lGWo9uwncEZGX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TP3ufg1FSgd52Z8zyecJ3z2FJfxxpEJLtGauUCReCG0=;
        b=H2YzJJ5kE1ChIXCzjrirGMT+kZI/tmBBmlEmMHhtWXFnrlowDReoEpXqXsGfTvLva8
         5k/XWL1/kbZkirfpH9Wjcp+vX34Mc37jNTFRv9k9Ti0SHOOOAwV90c7hd3zjpfVUqSOP
         eDOYGRPdw8TCaUh3HL0bt6ajYW+OKCi+US/w5nknTFvd9k1gBIAXzyV5PDEheUmKz6bG
         nVDgBjtk58euuKdGUu7dZ5v9EObTjXQbZLJ+bKaxDUrd08aMzOI3GxenJnYbDCuN7WY3
         cAOTEBOnvdzKfXtbE8oe99hCHlOa0e6bWnHQ1d84GCHk7fX/vSXnk5pkISVgQt2QnaWx
         iZfw==
X-Gm-Message-State: AOAM530kOWDjKvCRuZJKVL3ogxEDHSi74oyRkAFp/Dw2rFvavc7sDABr
        tBPbbn020gAZAqagiTCVCEE3NUvno7BP8zv/FAQ=
X-Google-Smtp-Source: ABdhPJy170w2JLx8URU+OchUJ8SqHtn1dXHANog9ottL6IKfpAB7Z63XHDCje2FAhn7pYOh90G5QrA==
X-Received: by 2002:a05:6512:1183:: with SMTP id g3mr27432081lfr.130.1628698838759;
        Wed, 11 Aug 2021 09:20:38 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id e5sm2266271ljk.51.2021.08.11.09.20.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 09:20:37 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id w1so6711694lfq.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Aug 2021 09:20:37 -0700 (PDT)
X-Received: by 2002:a19:491b:: with SMTP id w27mr11814406lfa.421.1628698837270;
 Wed, 11 Aug 2021 09:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <YRPaodsBm3ambw8z@miu.piliscsaba.redhat.com> <c13de127-a7f0-c2c3-cb21-24fce2c90c11@redhat.com>
In-Reply-To: <c13de127-a7f0-c2c3-cb21-24fce2c90c11@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Aug 2021 06:20:21 -1000
X-Gmail-Original-Message-ID: <CAHk-=wg6AAX-uXHZnh_Fy=3dMTQYm_j6PKT3m=7xu-FdJOCxng@mail.gmail.com>
Message-ID: <CAHk-=wg6AAX-uXHZnh_Fy=3dMTQYm_j6PKT3m=7xu-FdJOCxng@mail.gmail.com>
Subject: Re: mmap denywrite mess (Was: [GIT PULL] overlayfs fixes for 5.14-rc6)
To:     David Hildenbrand <david@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 11, 2021 at 4:45 AM David Hildenbrand <david@redhat.com> wrote:
>
> I proposed a while ago to get rid of VM_DENYWRITE completely:
>
> https://lkml.kernel.org/r/20210423131640.20080-1-david@redhat.com
>
> I haven't looked how much it still applies to current upstream, but
> maybe that might help cleaning up that code.

I like it.

I agree that we could - and probably should - just do it this way.

We don't expose MAP_DENYWRITE to user space any more - and the old
legacy library loading code certainly isn't worth it - and so
effectively the only way to set it is with execve().

And yes, it gets rid of all the silly games with the per-mapping flags.

               Linus
