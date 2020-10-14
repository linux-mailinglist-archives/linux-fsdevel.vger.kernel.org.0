Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CFB28EA08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 03:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388743AbgJOB3x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 21:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388232AbgJOB3k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:29:40 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3293C0613B6
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 14:49:37 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a5so966889ljj.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 14:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HeA545JHkumJvp2vsCHk2yunYiCvO0ipKJnKrSnCtIA=;
        b=g+63cfS60C2BkSY+gwVeR7vMl97bsv1IQGRh6EJKNoeFEa6XKQGTfjY4KphKtzenwi
         fgv3PqPlIj0FA/ulDIEm+3G2Gferh1d68pORa8D1ERInDuhw+ymz7MsyEvN54yg39J26
         rG2Fwdtv8ESAe/MsPrELWQV6dHYKUvg88BNRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HeA545JHkumJvp2vsCHk2yunYiCvO0ipKJnKrSnCtIA=;
        b=cVbGgK2clwqSN0PFvjGwps0mPJPPgImTsRY73OOht2I8WXpuo2sgZPK388wVu8qftV
         0WmsBBVm8Vk16gm3gTC7IxDtiAYIVSjwxgNYDtuYBX/QNoqmqOp1JNAuqaeeYercZ5SS
         baZjLOQtRrZ9dcM4eBLbL/a+QU08KKjRrVOLqqwNUvsmu0X4TrIAL6YMDBY/nZ932Q9O
         MdZzjAxK4APTwKQMZUoujifaiHDe+58BogMnBhI1ucbeBLTu9aB5k2ZbOzKnQyykxJ5b
         +wELDl/XRw6oktWGhnee2qki2uTKhgieDCCYC9V1ml5IhdO4IeMx8h1m45edp0vQ6tEB
         V3Hg==
X-Gm-Message-State: AOAM532Mied6s1YEStnDOnT/C4C7kwO0hJMz0MsIDMrQu8r3gZjH/r3W
        MfMF6ocTZm9eZdPbgcH927hqZ7ujm4isAw==
X-Google-Smtp-Source: ABdhPJwYlKxH1uuvxdPu73tsVie+WE4NhPToXizHh1KE1TGG5HF4I/Qb7aPJIDr7+5sZdEFae99YTA==
X-Received: by 2002:a2e:b889:: with SMTP id r9mr77139ljp.378.1602712175338;
        Wed, 14 Oct 2020 14:49:35 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id r133sm206795lff.77.2020.10.14.14.49.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 14:49:34 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 77so1174951lfl.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2020 14:49:34 -0700 (PDT)
X-Received: by 2002:a19:9142:: with SMTP id y2mr31716lfj.352.1602712173956;
 Wed, 14 Oct 2020 14:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201014204529.934574-1-andrii@kernel.org>
In-Reply-To: <20201014204529.934574-1-andrii@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Oct 2020 14:49:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiE04vsfJmZ-AyWJHfNdGa=WmBYt4bP3aN+sTP05=QXXA@mail.gmail.com>
Message-ID: <CAHk-=wiE04vsfJmZ-AyWJHfNdGa=WmBYt4bP3aN+sTP05=QXXA@mail.gmail.com>
Subject: Re: [PATCH] fs: fix NULL dereference due to data race in prepend_path()
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel-team@fb.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 2:40 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Fix data race in prepend_path() with re-reading mnt->mnt_ns twice without
> holding the lock. is_mounted() does check for NULL, but is_anon_ns(mnt->mnt_ns)
> might re-read the pointer again which could be NULL already, if in between
> reads one of kern_unmount()/kern_unmount_array()/umount_tree() sets mnt->mnt_ns
> to NULL.

This seems like the obviously correct fix, so I think I'll just apply
it directly.

Al? Holler if you have any issues with this..

             Linus
