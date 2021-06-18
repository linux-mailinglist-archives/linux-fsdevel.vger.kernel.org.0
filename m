Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BB83AD3EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 22:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbhFRUzL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 16:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbhFRUzL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 16:55:11 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBECEC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 13:53:00 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id q23so5257784ljh.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 13:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n7mevbUgr3RCVzXux42b3N2xAphxAT+zbkeqT9c1pc0=;
        b=QnOg9hEpzwYDkgbeB18VAZPpyaKsXlB8pgO8LGFvc40lkbKeUnvRWKmOpOuu2Dq89C
         GOA3Dw+cME79YQRp1MTd58mG6Hf9u8y33ysWyJB+KHEcJC+mfKVB/dRPt2ehsxJcJqeP
         qNhZhmZOPrJf2cbe5gHdGfEyc6X/QX93uk++w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n7mevbUgr3RCVzXux42b3N2xAphxAT+zbkeqT9c1pc0=;
        b=EcYd9twciChZHqWQdk0vWoDSovGzo7XFhxzA/HCLb1rSDuK8/jqCfOGEIAtdj90H3A
         rtfj2PqMlk5fVLYjKmo0vmM9BWiaL4q+YvGQ34ClJXWss1pqld5Ox6Dru82e62kSbr3V
         9IZIuKsNu4cVg3G36QHhXP20jflqpY9HxMFgzVzGC/0/FeStXQ8cv3xHNbYlQaoXxG9J
         5nF8BJOCHvGvo0ZZNSlBbPx5/eNSDkcD33cvPTYVXygAOko5kioy3B7E0/ADmEpRXLDi
         P0FTAQ3oZCnFKl8pTm9h42pf+WGmQNuh67USHXEW3Wgmbcd40Pi9MuBz4z2vKnq2xrfg
         +lGg==
X-Gm-Message-State: AOAM5328jCcYqM2HKz/svC+cye4zZr4fcFr+mVz+RtmN4XccZnZ65fUU
        oEbdsjWCRMrrm5JccrYLVjL5ATsK5bFVBsvB
X-Google-Smtp-Source: ABdhPJxdteQmlub7fAF4iDiKpomaksoZDLVgyZZkIhrm+TU8UyAOdCfXsn2OvZH+KGcEpuoAc77UNQ==
X-Received: by 2002:a2e:9b10:: with SMTP id u16mr10840038lji.167.1624049579119;
        Fri, 18 Jun 2021 13:52:59 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id s12sm1109441lfi.40.2021.06.18.13.52.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 13:52:58 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id g13so5377945ljj.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 13:52:58 -0700 (PDT)
X-Received: by 2002:a2e:9644:: with SMTP id z4mr10901542ljh.507.1624049578156;
 Fri, 18 Jun 2021 13:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <162387854886.1035841.15139736369962171742.stgit@warthog.procyon.org.uk>
In-Reply-To: <162387854886.1035841.15139736369962171742.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Jun 2021 13:52:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whRiXMUEtyeHVCT7hp0ZZV-VLAG00Osw6qbUEyi7sWpuw@mail.gmail.com>
Message-ID: <CAHk-=whRiXMUEtyeHVCT7hp0ZZV-VLAG00Osw6qbUEyi7sWpuw@mail.gmail.com>
Subject: Re: [PATCH] afs: Re-enable freezing once a page fault is interrupted
To:     David Howells <dhowells@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-afs@lists.infradead.org,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 16, 2021 at 2:22 PM David Howells <dhowells@redhat.com> wrote:
>
> If a task is killed during a page fault, it does not currently call
> sb_end_pagefault(), which means that the filesystem cannot be frozen
> at any time thereafter.  This may be reported by lockdep like this:

I've applied this patch.

Everything in my screams "the sb_start/end_pagefault() code is
completely broken", but in the meantime this patch fixes the immediate
bug.

I suspect that the whole sb_start/end_pagefault thing should just go
away entirely, and the freezer should be re-examined. Alternatively,
it should just be done by generic code, not by the filesystem.

But it is what it is.

           Linus
