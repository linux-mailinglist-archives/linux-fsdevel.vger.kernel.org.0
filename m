Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B152A4F78
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 19:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgKCS5f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 13:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgKCS5d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:57:33 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93490C0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 10:57:31 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id e27so800983lfn.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 10:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pbeatc5+cF8l9jn4Nif5A5jxT3ZqdFyJM4orXf9CoRg=;
        b=Rmd2DlKNjA9/5yL8e0UZqW8fW//GLse1T0BN0FOHJgyLMIq3MQz6Gp/8q/BjctAe4w
         P2EsVJw2+NsEL5aLH7vwmB3JldU+2SOWSty+WtFS0F6V0WGHb4Hbnl/K1q2Haune6VTA
         Ah66R4U6f3TETcnnlCcM0w/fTf7QWJI+C5Qvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pbeatc5+cF8l9jn4Nif5A5jxT3ZqdFyJM4orXf9CoRg=;
        b=eo35VwuVnHIqka6JT6UWlbb/FUdSpGLVMTlRr7y24WIR76YToCpbWYRI3m1AmhLIvE
         YIj04heXQlI+Vl7tZV0wJ8c43ctOPN3bwuVEkiW9027VWaKkMCEw16u7vuKQv0EkYocl
         bhUtPr85XSIX2HxyxcvAmkirpZprOfBHc27NqngAFi4V9EaE5I9PeaeMCYbHfYFhOPLe
         6M70FPbP+sQLjje5HWbGE0Le4ZBGjaPUiVOmDr3F3jTF/bQegHygJrmlFJ9Tl4fVYBjV
         TOyIuYg/oAfaflENFQOlDFkL6Hbeogk+fHm8fadF01HoAJAYu28cnEYvoS37qjriJCb4
         6viw==
X-Gm-Message-State: AOAM533AUI4AN82DCPxC3h0tzQ75MPPt3TVONzw8EOvsVUiCncAX2vNy
        d+4vedUqC58gCT+11hE3cEPbkIE8XHqreg==
X-Google-Smtp-Source: ABdhPJy85yAVZc5O7IGR4NImI7eOwFPctRhmFVm5zxbFyFq0Do7V5xFwUw6kT3kp9GwjwmcfEzmKYA==
X-Received: by 2002:ac2:4d08:: with SMTP id r8mr7510077lfi.353.1604429849595;
        Tue, 03 Nov 2020 10:57:29 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id x4sm4198461lfn.280.2020.11.03.10.57.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 10:57:28 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id x6so20235541ljd.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 10:57:28 -0800 (PST)
X-Received: by 2002:a2e:87d2:: with SMTP id v18mr8668464ljj.371.1604429847760;
 Tue, 03 Nov 2020 10:57:27 -0800 (PST)
MIME-Version: 1.0
References: <20201029100950.46668-1-hch@lst.de> <20201103184815.GA24136@lst.de>
In-Reply-To: <20201103184815.GA24136@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Nov 2020 10:57:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wha+F9-my8=3KO7TNJ7r-fVobMrXRdUuSs5c2bbqk1edA@mail.gmail.com>
Message-ID: <CAHk-=wha+F9-my8=3KO7TNJ7r-fVobMrXRdUuSs5c2bbqk1edA@mail.gmail.com>
Subject: Re: support splice reads on seq_file based procfs files
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 3, 2020 at 10:48 AM Christoph Hellwig <hch@lst.de> wrote:
>
> ping?

It looked fine by me, although honestly, I'd prefer that last patch to
be the minimum possible if we want this for 5.10.

Yeah, that might technically be just cpuinfo, but I'd be ok with the
other read-only core proc files (ie I would *not* add it to anything
that has a .proc_write operation like the ones in proc_net.c).

IOW, I'd start with just cpuinfo_proc_ops, proc_seq_ops,
proc_single_ops, and stat_proc_ops.

Because honestly, I'd rather restrict splice() as much as possible
than try to say "everything should be able to do splice".

Hmm?

               Linus
