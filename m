Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43093BF033
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 21:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhGGTZH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 15:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbhGGTZG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 15:25:06 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDFAC061574
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jul 2021 12:22:24 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id q18so6926999lfc.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jul 2021 12:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QWz6j7aQDicZF+8YuVqNXjaVMSD+f6gQ3hDARWuwoZw=;
        b=Vo43/qNbhMYCKn8reADLJoDDeEmatxkzxuMGmzH36T18+UunKRPkZXhu7Onj0iGd1m
         DyhjmfsKcNwvaEw9wj0bn5veD9VgTj37YFXTnQRqjNu+7E0+d/h1IdSaFWgJo+WXaxPt
         n9iKdaXWHIyihVRQYNxdY2/my8u598J8vlEng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QWz6j7aQDicZF+8YuVqNXjaVMSD+f6gQ3hDARWuwoZw=;
        b=KxKn+aBDBlU2hQDBjcj7qPvO535d4tSa19IfjI5Pw5aMcaRUXHOuRK+yCp/QF4foMd
         JmI1kHGhiOgLrlsGDaQyF0M8wnwYxYypPeM5V40Uur+EWd2GrieIln72cXC6GSUtbfq0
         AURm6OMd8hk3JoAmK+LtEGqD8jLT+jT/ScwQrqCgANSVf658CxZjxznkdWLHsaF+cvaz
         cB90nNKthftuPDghw/ZN6DJiirlc5oVwFU6ZElskA7Xww2xqaTPNeMXG4WYtM3xc6XOb
         oFLbRZnmEYClvELens6D+JUnpd7BVcTRE7Q67CQc+51PY7MhGmKTaxEAjosXb9s0xTuB
         5+HA==
X-Gm-Message-State: AOAM530OWUNziVRvn18C19wHDCJ4/i4Gzg97DSA5KzBXUE2KT1PH3Stq
        qOgdkFEt184Ab3HJPTFwniNjJi2ZTldDPZD1wok=
X-Google-Smtp-Source: ABdhPJxBzY/pEDbz2qzEnu3L18/1H3K3omOmYws/HirhXNsbkn+HjF/e2eTICPE4upTS4BMMyK/hGA==
X-Received: by 2002:ac2:5f70:: with SMTP id c16mr19025183lfc.114.1625685742882;
        Wed, 07 Jul 2021 12:22:22 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id p17sm4965lfu.192.2021.07.07.12.22.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 12:22:22 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id p21so6872353lfj.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jul 2021 12:22:22 -0700 (PDT)
X-Received: by 2002:a2e:50b:: with SMTP id 11mr21108241ljf.220.1625685742103;
 Wed, 07 Jul 2021 12:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210707122747.3292388-1-dkadashev@gmail.com> <20210707122747.3292388-6-dkadashev@gmail.com>
In-Reply-To: <20210707122747.3292388-6-dkadashev@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 7 Jul 2021 12:22:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiG+sN+2zSoAOggKCGue2kOJvw3rQySvQXsZstRQFTN+g@mail.gmail.com>
Message-ID: <CAHk-=wiG+sN+2zSoAOggKCGue2kOJvw3rQySvQXsZstRQFTN+g@mail.gmail.com>
Subject: Re: [PATCH v8 05/11] fs: make do_mknodat() take struct filename
To:     Dmitry Kadashev <dkadashev@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 7, 2021 at 5:28 AM Dmitry Kadashev <dkadashev@gmail.com> wrote:
>
> Pass in the struct filename pointers instead of the user string, for
> uniformity with the recently converted do_unlinkat(), do_renameat(),
> do_mkdirat().

Yup. And the uniformity continues with that "we could avoid the goto
retry/out1 with a mknodat_helper() function for the inner meat of the
function.

               Linus
