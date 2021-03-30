Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7485634EE66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 18:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhC3Qrx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 12:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbhC3Qrf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:47:35 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E1CC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Mar 2021 09:47:35 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id f26so20625793ljp.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Mar 2021 09:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Fv2Cj0sTdrdHg6JKWL7elNX4ARZJuRFjo1/0KiYbCM=;
        b=H4VG4Gqc7D0tZlwxnMHEG4j377AxcJrxwpOvJuc8AVvzo8tqJjRcTV6Bqlxnm7tCZr
         6jx44csb8SY+P/mq63jhi1wXXaB2sWSwqRJGf9g7FiP+wuVcKh3E+YKoA6XcCOLIP854
         fhAvhXYplG4L58/PDSMisvC0kLFdoMsrT5+7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Fv2Cj0sTdrdHg6JKWL7elNX4ARZJuRFjo1/0KiYbCM=;
        b=N31b69I3e/8JbEjMI/K8XPLFzXJrGuPljhGas7/b1lhp/zzN+09COO6hA3H7+6+7yb
         8IhXS6/4bM4YJMHhO64y1KmNJvQ9uE40O38WMs6hEkk8LaahfYGaRjSXTOV+Ypq0eE/O
         OS4sEHbfcZM/OfaXFaVioOZa9su2XO/adooUmt3Dz8PnVjMXUSS06Ni/1kMHGngQ3VMK
         kSOrH1JTGKC6JItk275ezs6EzcWeZIX3944AWea7yYoVvy0YEBR/6A1WPKaqmFx4VRxP
         e5EHUTG1m2VSnwBktE5Vt1cRwfD4yyWuHbKAVqWPWwES72a39tIKYNI2yI6WYFil3DRV
         cUDw==
X-Gm-Message-State: AOAM530LNV/zAhFJ6kcL4arHSX3b52nGF1dpNxqAjBk5CpeAE8SXtn8P
        AOOMh7UUjmCTaqokRpSBvN8eeQrvA/BUoKG7
X-Google-Smtp-Source: ABdhPJy7aWzVtpiyZv8Hc0kryKwPY425xGcGZHxQorUkBWs3IMz3Xiumub60HYsKQWp/94uJRbZVAw==
X-Received: by 2002:a2e:5753:: with SMTP id r19mr21339622ljd.126.1617122853853;
        Tue, 30 Mar 2021 09:47:33 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id h3sm2746915ljc.67.2021.03.30.09.47.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 09:47:33 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id u9so20612354ljd.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Mar 2021 09:47:33 -0700 (PDT)
X-Received: by 2002:a2e:a306:: with SMTP id l6mr20884903lje.251.1617122853052;
 Tue, 30 Mar 2021 09:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <CALCv0x1NauG_13DmmzwYaRDaq3qjmvEdyi7=XzF04KR06Q=WHA@mail.gmail.com>
 <m1wnuqhaew.fsf@fess.ebiederm.org> <CALCv0x1Wka10b-mgb1wRHW-W-qRaZOKvJ_-ptq85Hj849PFPSw@mail.gmail.com>
 <m1blc1gxdx.fsf@fess.ebiederm.org> <CALCv0x2-Q9o7k1jhzN73nZ9F5+tcp7T8SkLKQWXW=1gLLJNegA@mail.gmail.com>
 <m1r1kwdyo0.fsf@fess.ebiederm.org> <CALCv0x0FQN+LSUkJaSsV=MCjpFokfgHeqSTHYOTpzA6cOyvQoA@mail.gmail.com>
 <e52b2625-8d33-c081-adeb-f92f64ca1e8e@wanyeetech.com> <CALCv0x29Dvs2R=Hg9FebGUFZpd+vN1Lzz2N6a2Zohgo47ZhsGg@mail.gmail.com>
 <05dc921e-da71-4e71-6132-736eccd35680@wanyeetech.com> <CAHk-=whHhEQW52FYV+J68Z+OZd5tUPv=Fa_o06n9Jj5J4wJU4w@mail.gmail.com>
 <CALCv0x3V5kN_hU2-=XPPo=QETyQ2kSUc+4Z_=2kT7ecE5meA3w@mail.gmail.com>
In-Reply-To: <CALCv0x3V5kN_hU2-=XPPo=QETyQ2kSUc+4Z_=2kT7ecE5meA3w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Mar 2021 09:47:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whYLj4Q4JxybKgnPaCWq0WJbS_Pmr18euOfWAh0E9_Z+Q@mail.gmail.com>
Message-ID: <CAHk-=whYLj4Q4JxybKgnPaCWq0WJbS_Pmr18euOfWAh0E9_Z+Q@mail.gmail.com>
Subject: Re: exec error: BUG: Bad rss-counter
To:     Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
Cc:     Zhou Yanjie <zhouyanjie@wanyeetech.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 30, 2021 at 9:36 AM Ilya Lipnitskiy
<ilya.lipnitskiy@gmail.com> wrote:
>
> Sorry, I could have done better linking it to this thread - I actually
> did submit it recently - please see
> https://lkml.kernel.org/r/20210330044208.8305-1-ilya.lipnitskiy@gmail.com

Oh, ok, that looks fine.

Thanks, applied,

             Linus
