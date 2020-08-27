Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6603B254BD4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 19:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgH0RPV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 13:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgH0RPU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:15:20 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87086C061264
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 10:15:20 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h19so7278714ljg.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 10:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w12LsIONkHiHf1X1dg76GDH+j4flCrQShoTv3VRea1g=;
        b=FdZoS6ucloJ1uweiQFAH2mrrb+1/WJBlhrsgmvjk19P/b7Ljnx16lLT1HpN5JdRdK/
         VrIposFwDAzSuhpYHAVCY+a36L22FJOs6M80hsOnr+RV/TTWtSX6z4ynWZHSRLazKMjY
         vgE93opHLT4CMsYZMN/zJ22KJnlkKof0ZS/+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w12LsIONkHiHf1X1dg76GDH+j4flCrQShoTv3VRea1g=;
        b=L18MuHhoHKIi+zGYVift0lNnDnURzvRHGXjU4rcDgjGwd3FRJsvE7nOb+exXlUpTS8
         QIjojRW32TtAfAzVBkTUuajJif8kdeNpAdIMajoLo1UE2DogcPggilWS9IRO/LtfeAMI
         N9SMjNXveIBaukR2YV1TIUgtpt/jkuf+W+E8Z39zlqZN1FCoPQHmMREq6aHCGZfRyJCs
         5cGwlemueXw+vg14FcJjSbw3KQ8LfzdYoyMShIUxcRzuvdyJiZP/Jtnh3jIu1us3uMM4
         HUUa80lgo6G56aVdpd0fmknJjQjv7f7cTw/M/fl81zLTSPIR/xYhaqSm7JHX2XBhWCIo
         EJ8w==
X-Gm-Message-State: AOAM533KzfzyhlzwoKt7eHwfVmyzairo1Inkcp/Sk/zvHwDWNDABzJdE
        VtbfbEApa1+kb0zYqhTkEr51/8oSZJZ9hA==
X-Google-Smtp-Source: ABdhPJxmF4oKjcufRXg9h087SxLorkmpWJwvU68lG7r3N2hQsWcl8FuFzXUz9qHYLBcfUvC7+Ux0dg==
X-Received: by 2002:a05:651c:505:: with SMTP id o5mr10147034ljp.306.1598548518476;
        Thu, 27 Aug 2020 10:15:18 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id o24sm593679ljg.69.2020.08.27.10.15.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 10:15:18 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id c8so3317592lfh.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 10:15:17 -0700 (PDT)
X-Received: by 2002:ac2:58d5:: with SMTP id u21mr10296558lfo.31.1598548516405;
 Thu, 27 Aug 2020 10:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200827114932.3572699-1-jannh@google.com>
In-Reply-To: <20200827114932.3572699-1-jannh@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Aug 2020 10:15:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2p84Md0dP53NxgBAZcy+x9+fxnQQg9kD4LzZDkYCfXA@mail.gmail.com>
Message-ID: <CAHk-=wj2p84Md0dP53NxgBAZcy+x9+fxnQQg9kD4LzZDkYCfXA@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Fix ELF / FDPIC ELF core dumping, and use
 mmap_lock properly in there
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 4:49 AM Jann Horn <jannh@google.com> wrote:
>
>  13 files changed, 346 insertions(+), 498 deletions(-)

Me likey. I had one comment, but I don't think it really matters for
this series. So ack to all of these as far as I'm concerned.

Does anybody else see any problems?

           Linus
