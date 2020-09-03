Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA15425C5C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 17:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgICPuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 11:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbgICPuQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 11:50:16 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49F1C061245
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2020 08:50:15 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u27so2149000lfm.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Sep 2020 08:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6uN+gKvfGO60O5JMjCBhAHk4zCyy59uX9CdJNtZFrNw=;
        b=hYB6yqqQVYLw5W4wbNtwYxGosDDACrqFPkFRzSxq5GUdwnRcqWSZf+3pDJZG3l4qpj
         XIsM8mhEThCQIKY5Q71Pb3tabJeQfFtxozky3wgH9Fge0iOyyl06stPcVEls4DGKyFgJ
         F0YpC38xMkAjv0zbD8B0d2Ya5VsmSKKtjzeEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6uN+gKvfGO60O5JMjCBhAHk4zCyy59uX9CdJNtZFrNw=;
        b=Lp6cd6EFWwE4KIVCzr9z2kgpTaYzHiXeVOlEHxbi7wSCLCgECzTrYLlZA3Sj8cqiWJ
         AZkSArRm1VLoHcNZuLJFd3yj4gztRork8MGazuBVFTA7iYmUdM4tlQZaTBTxvvFLd9j/
         GsEB6mw7J+LyVR4MmJgfMgwR/X5I2FlSv4XeaLMs5N9rz0T3EHdQETfhhqlhdJg7phx4
         CgnzESKZ5RfgD4KHvqv4tzFaL28iCiA/zfsoLAOesrt6vSNE1966mWkRkEGrAcb0BRPt
         TaWzYxpwG9Dn5Y9aCHLnyxcouSv2WmGHRIan/ZpnWMW+dSZSh0HkeER5lDFbMmR5hswW
         DfjQ==
X-Gm-Message-State: AOAM530GBOyl1iRSSN7b7X+IDh5nzM82RL8LFaC/I8mP8FPUcC7dXJcA
        l4k7/AvaULmpY82yTYbk/lalaGkJL+BIRw==
X-Google-Smtp-Source: ABdhPJz1fvREtbdhLSg3cjiHpIEvVe5phMOvPJ6r5U+uhZs3bh+g96G5eWO2Ltf6DcCUPqzGvrCcmw==
X-Received: by 2002:a19:457:: with SMTP id 84mr1588217lfe.191.1599148213190;
        Thu, 03 Sep 2020 08:50:13 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 206sm679303lfd.72.2020.09.03.08.50.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 08:50:07 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id y2so2153418lfy.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Sep 2020 08:50:07 -0700 (PDT)
X-Received: by 2002:a05:6512:403:: with SMTP id u3mr1627887lfk.10.1599148206752;
 Thu, 03 Sep 2020 08:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200903142242.925828-1-hch@lst.de>
In-Reply-To: <20200903142242.925828-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Sep 2020 08:49:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=jtTcwSox8RY-skN83c40WXZOfwid-91FDgRdk0xwrw@mail.gmail.com>
Message-ID: <CAHk-=wh=jtTcwSox8RY-skN83c40WXZOfwid-91FDgRdk0xwrw@mail.gmail.com>
Subject: Re: remove the last set_fs() in common code, and remove it for x86
 and powerpc v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 3, 2020 at 7:22 AM Christoph Hellwig <hch@lst.de> wrote:
>
> [Note to Linus: I'd like to get this into linux-next rather earlier
> than later.  Do you think it is ok to add this tree to linux-next?]

This whole series looks really good to me now, with each patch looking
like a clear cleanup on its own.

So ack on the whole series, and yes, please get this into linux-next
and ready for 5.10. Whether through Al or something else.

Thanks,

               Linus
