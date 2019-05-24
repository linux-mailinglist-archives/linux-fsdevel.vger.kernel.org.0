Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80C1229E8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2019 20:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391723AbfEXS4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 May 2019 14:56:04 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42205 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391712AbfEXS4D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 May 2019 14:56:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id 188so9541326ljf.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 May 2019 11:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csmB0SVtlpuGlEdBBr9KglbwXGniIuOaWROmVBN2nig=;
        b=BDFiVmjeU9znvacKUoSeXzX6qILwjm/Koo/XJlf9jEsNo3fWFjyqRx6KkAqAlbbhaa
         D3mTInlmrbdbdoCf3qsYio4ivCLh38fXEFGzOYPndAsHXOGkLuikM8ojUqHIc1ii5QFu
         jbhG67yHeawfxde2WC1KkJlI96daxBp+KkPH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csmB0SVtlpuGlEdBBr9KglbwXGniIuOaWROmVBN2nig=;
        b=F+3FTuu7h7GKXAWkemZ8Daf/w+ju1oNkw+sl9ZPkthO8r0QeZR2ehGJO/1uxdwXLt1
         //bhi8TPtEP+8qp+mF2QVuWls2SbwW6Rz65/JJt9r9uyyC2Zp3J+lc58WY6Mf6kVmGer
         HgNsbO7/P8Pr+/GfEx7Dy0WPPLSuX/vbcWuNpOeSN8L1ThQxubNNPVPEHFS0d+DR3EvA
         N9/Enn+iQrDuN6mrO246D4dz3G4dpNsvlU3eWvOPjyDTIRCbCOt7cYHDtQHbQS6CLm0M
         fxGTXz4T5+xFcTFU8+p0qjCkpuoUATl+dFdAfdgwa48WASWrPk9qulX9aybBDj4qonhB
         GKHg==
X-Gm-Message-State: APjAAAWVhRhPhrD3ReiRCamjACdULBBGgoQ9BR3rDvpqZsnl+al+lqr6
        o+c+4v951gyuAY4tvFK3xxAoFCE46zM=
X-Google-Smtp-Source: APXvYqxM3SR+gPO1Flbcgu9sDs1NgvSbpvt+f79A3ZyHIyn8OWT+bpHmMcgBN2b2snNOCHVMDsiNIA==
X-Received: by 2002:a2e:321a:: with SMTP id y26mr56073545ljy.109.1558724161360;
        Fri, 24 May 2019 11:56:01 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id w2sm827596ljh.54.2019.05.24.11.56.00
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 11:56:00 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id q62so9555537ljq.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 May 2019 11:56:00 -0700 (PDT)
X-Received: by 2002:a2e:4246:: with SMTP id p67mr40005336lja.44.1558724160052;
 Fri, 24 May 2019 11:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190523182152.GA6875@avx2> <CAHk-=wj5YZQ=ox+T1kc4RWp3KP+4VvXzvr8vOBbqcht6cOXufw@mail.gmail.com>
 <20190524183903.GB2658@avx2>
In-Reply-To: <20190524183903.GB2658@avx2>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 May 2019 11:55:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjaCygWXyGP-D2=ER0x8UbwdvyifH2Jfnf1KHUwR3sedw@mail.gmail.com>
Message-ID: <CAHk-=wjaCygWXyGP-D2=ER0x8UbwdvyifH2Jfnf1KHUwR3sedw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] close_range()
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 24, 2019 at 11:39 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> > Would there ever be any other reason to traverse unknown open files
> > than to close them?
>
> This is what lsof(1) does:

I repeat: Would there ever be any other reason to traverse unknown
open files than to close them?

lsof is not AT ALL a relevant argument.

lsof fundamentally wants /proc, because lsof looks at *other*
processes. That has absolutely zero to do with fdmap. lsof does *not*
want fdmap at all. It wants "list other processes files". Which is
very much what /proc is all about.

So your argument that "fdmap is more generic" is bogus.

fdmap is entirely pointless unless you can show a real and relevant
(to performance) use of it.

When you would *possibly* have a "let me get a list of all the file
descriptors I have open, because I didn't track them myself"
situation?  That makes no sense. Particularly from a performance
standpoint.

In contrast, "close_range()" makes sense as an operation. I can
explain exactly when it would be used, and I can easily see a
situation where "I've opened a ton of files, now I want to release
them" is a valid model of operation. And it's a valid optimization to
do a bulk operation like that.

IOW, close_range() makes sense as an operation even if you could just
say "ok, I know exactly what files I have open". But it also makes
sense as an operation for the case of "I don't even care what files I
have open, I just want to close them".

In contrast, the "I have opened a ton of files, and I don't even know
what the hell I did, so can you list them for me" makes no sense.

Because outside of "close them", there's no bulk operation that makes
sense on random file handles that you don't know what they are. Unless
you iterate over them and do the stat thing or whatever to figure it
out - which is lsof, but as mentioned, it's about *other* peoples
files.

               Linus
