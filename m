Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE36A3F69F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 21:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbhHXTj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 15:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhHXTj6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:39:58 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3562C061757
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Aug 2021 12:39:13 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id r9so47870817lfn.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Aug 2021 12:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sg2PeXygntpvBqIKJYVWHWj4D3JPXoTat1Hdlqkmh7U=;
        b=fVGpm4zytOEgKYCiYTv8HiBsEBqkpXonVy0t2eG8CE8JNNbpbZjbUdBL08kDjWv7W+
         Rt6w3znYPC91yDwSJc3FQliDhEAwKpijLzmNopf/row0wktjFdarFGHVG1e0YELcJco5
         +Gw4ptbu76uHIyyI+9wE+qNhCkKyOOB+qGkHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sg2PeXygntpvBqIKJYVWHWj4D3JPXoTat1Hdlqkmh7U=;
        b=CGjpecOr//+zNVapN9fnuSFkra+Iwfz6+zhYuZ7aJ58mVJzcytmOEy5u6Sa4HBIqTP
         upaOAglgZ2+vz+sEIZfzzTQmyPB5/Rfbk4Xn6ofVWHAerdgEmJD4Fda8wKfTPClkHVYT
         EyLtvwF10DBGHIaPVW9WmsRSlEXLeTMl88QCmjHc/N9PHpdH376ianKaz+uIsHKdhzUK
         cDEzw9CCe1aIHPkceSSIZTUjyqzlYuPF8UvRlnjRAIeq4QSFNXKzgcCjGBcMzVInppLQ
         rf+zrnLe7jQ99yxVuJRwBBof39pTrNuUMsczvtA4nLDzrBKtRf5aSptOy5sK8kPNmlwf
         9yUw==
X-Gm-Message-State: AOAM533dyLgI38seMcC4PqMRdasvAIDkYM9KN7IyYvGimirFJt+SYya9
        iqUGsrPD4L9xiR1JDx491s/c07utqZe4yjEt
X-Google-Smtp-Source: ABdhPJx7h+K+6xNf9xR+msPocf9HiBzpU+teyJL/TJNFMfxb0h1D9wvjoVOYOD1WDkTYWIjKw4TgtA==
X-Received: by 2002:a19:5f0f:: with SMTP id t15mr30485536lfb.467.1629833952318;
        Tue, 24 Aug 2021 12:39:12 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id o1sm1839396lfl.67.2021.08.24.12.39.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 12:39:11 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id w4so38045210ljh.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Aug 2021 12:39:11 -0700 (PDT)
X-Received: by 2002:a2e:7d0e:: with SMTP id y14mr32977454ljc.251.1629833951436;
 Tue, 24 Aug 2021 12:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
 <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <1957060.1629820467@warthog.procyon.org.uk> <YSUy2WwO9cuokkW0@casper.infradead.org>
 <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
 <CAHk-=wgRdqtpsbHkKeqpRWUsuJwsfewCL4SZN2udXVgExFZOWw@mail.gmail.com>
 <1966106.1629832273@warthog.procyon.org.uk> <CAHk-=wiZ=wwa4oAA0y=Kztafgp0n+BDTEV6ybLoH2nvLBeJBLA@mail.gmail.com>
In-Reply-To: <CAHk-=wiZ=wwa4oAA0y=Kztafgp0n+BDTEV6ybLoH2nvLBeJBLA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Aug 2021 12:38:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=whd8ugrzMS-3bupkPQz9VS+dWHPpsVssrDfuFgfff+n5A@mail.gmail.com>
Message-ID: <CAHk-=whd8ugrzMS-3bupkPQz9VS+dWHPpsVssrDfuFgfff+n5A@mail.gmail.com>
Subject: Re: [GIT PULL] Memory folios for v5.15
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 24, 2021 at 12:25 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Something like "page_group" or "pageset" sound reasonable to me as type names.

"pageset" is such a great name that we already use it, so I guess that
doesn't work.

            Linus
