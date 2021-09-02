Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C0D3FF3AE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 20:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347254AbhIBS7S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 14:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347238AbhIBS7Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 14:59:16 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CABDC061575
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Sep 2021 11:58:16 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id s10so6483151lfr.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Sep 2021 11:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=nou0znqimsrLl6OB5c1aMp82GMEqusuNoyOJ20o6LFI=;
        b=Ibpdc46zjQloZ+vX8Jc+8cZvxyZgkNzdSsEJA3RXMKA4Uv115klG8TP44ku0D70EYN
         2ZdHNkPCogYuUgXzzStalGmdzhm6x4HMAJyz6jwygSEzV1uGAEnpH4rb6ZQRdRgWqyQl
         K8bZBGqrT9kuG/VjjS1yasgD0iTr8JY35ybDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=nou0znqimsrLl6OB5c1aMp82GMEqusuNoyOJ20o6LFI=;
        b=c+AvPLQjJwO7FZvKQwRCW3GbvURFpF9qw8mdHiJR+p6j1W76aNM3cHizUaUJNF4D7f
         /ECXm448Vxx8ErBsI46CBkDMxJjGpN3CeFhh7wM2SmepYW7VFEuqTF2n6whHGQaHnuMX
         Ddt3CbVbXVyAko/44WgHkfOk35S80U4Zx/oZ3Lah2OlxnARtImHIlGVkf+pwM0R8nJtY
         A4OeZy2eLYir4xnA6i5PeUvm11Wrk0xjZ6UvveisTvorBwMlvp24s7KvonOD9h1tv5YY
         Y4RjRj62L9NpnNIAnRX9p7iX3TnisJrn1mk0ybJHWgGaFbN9ZUceEyvg8mUEeGvymqxR
         axhQ==
X-Gm-Message-State: AOAM530le3O6R3dmMJenH59IfV00O7jYpDDTg8f1zkePQq9G97gTGtFT
        PDkPOcG5INBTKKupJOWz+V53cPzbhW3L0O2/9Mk=
X-Google-Smtp-Source: ABdhPJyUZNf6I0VanHKQOk8uyOoN0VomIbrrWURX1QcFc+EQBu3+4ddAdsDuGXJYrepURc2JaZz4OA==
X-Received: by 2002:a05:6512:1112:: with SMTP id l18mr3526126lfg.402.1630609094718;
        Thu, 02 Sep 2021 11:58:14 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id v14sm274945lfd.225.2021.09.02.11.58.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 11:58:14 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id h16so3659585lfk.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Sep 2021 11:58:14 -0700 (PDT)
X-Received: by 2002:a05:6512:230b:: with SMTP id o11mr3465517lfu.377.1630609094065;
 Thu, 02 Sep 2021 11:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210831225935.GA26537@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAHk-=wi7gf_afYhx_PYCN-Sgghuw626dBNqxZ6aDQ-a+sg6wag@mail.gmail.com> <20210902182053.GB26537@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20210902182053.GB26537@hsiangkao-HP-ZHAN-66-Pro-G1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Sep 2021 11:57:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgirqjdeuYX+PvL-09UUKtnBaRYTXQrRdjCYxGKirEpug@mail.gmail.com>
Message-ID: <CAHk-=wgirqjdeuYX+PvL-09UUKtnBaRYTXQrRdjCYxGKirEpug@mail.gmail.com>
Subject: Re: [GIT PULL] erofs updates for 5.15-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        Dan Williams <dan.j.williams@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Huang Jianan <huangjianan@oppo.com>,
        Yue Hu <huyue2@yulong.com>, Miao Xie <miaoxie@huawei.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 2, 2021 at 11:21 AM Gao Xiang <xiang@kernel.org> wrote:
>
> Yeah, thanks. That was my first time to merge another tree due to hard
> dependency like this. I've gained some experience from this and will be
> more confident on this if such things happen in the future. :)

Well, being nervous about cross-tree merges is probably a good thing,
and they *should* be fairly rare.

So don't get over-confident and cocky ;^)

                  Linus
