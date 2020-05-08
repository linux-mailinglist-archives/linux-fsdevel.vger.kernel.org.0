Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512E21CA0A0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 04:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgEHCR6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 22:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgEHCR5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 22:17:57 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162CBC05BD0A
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 19:17:57 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id p12so101849qtn.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2020 19:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gpiccoli-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q181yzRPrb4b19Hrbwu/9thGmuUl9/8sqVdS721JtdI=;
        b=bf4W7j1XqRzdw6xkGA8tp0VlOVCxMWbB+5gcI5x0cv6vhpfQlQbsx1lWrFsQFbOAET
         OiCBzQCpFH38gyWtn9ZHRhJPrcacz9KPTXhelGMveATMxSQHTAC6+frJ1nQFJwsQE+9R
         qzkfmp9k92ODps/zzm2KJEf+JTuPlokJ/NxFobH60O+RWfNcMFGBvjUnRzoNRViTa7Dv
         WuDLScVZzW6k3Fn2UBEMKGqc1H0vSMcx0/1rn+5ilFO8E1Cq4eYFGwlzigbuWXygvnNi
         R/Qs8RtfpEHLxY2L8N3uZ0nOhRNVab9CYgZBapTZ90S+sDyqqej5Saz4pYzCwGjd57gx
         1zXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q181yzRPrb4b19Hrbwu/9thGmuUl9/8sqVdS721JtdI=;
        b=JuqA5fiGLWthRFe5ek1qQmxVAiyNz3A1g9UWQyJwcY75TV8Y+yW0EMYA3UF3OQOHRu
         6hYMnqv2f21jWtq6dOCPGlTaKCJUyOGT7ALLuy5ayOig6hOBsF2DdXpax5ObO+3XR+aX
         Sy7I1ytsAmY5bFyd+zmWO4+ySa8PSx+NAMAORAH9FbuuS4Li4mqEAAARjDJMJoxJWScT
         aind2PURbNdnrz7nq31LyvCZw8T6E9hrSoTq9iJhqSeKQJPtZZlgBMXmjF9kU1jp4Ohk
         CwaTJNcUQ9Kg/z2gTqAz66WP/lNW4JTd3ZwDe4czrGhyaK2F0W7utoj1nHDbAEfVZ+w2
         0cPw==
X-Gm-Message-State: AGi0PuZadsGLXcmzId9LC4vidNg8Cu9+BKAlHaI4wbpuorBTWdmla8tx
        +oWpRGGw9NoOBtx2qpFvHW0p+bOojoX5OHF/r8KcBw==
X-Google-Smtp-Source: APiQypJA/nTNKSOcz66mO4EnbxIFuBZdFfzznNIpAqzztxpk2iMe7jNp61vYGF5COXtBAeI8Y1COIQPYkQTSay/NioY=
X-Received: by 2002:aed:2ea2:: with SMTP id k31mr547064qtd.136.1588904276303;
 Thu, 07 May 2020 19:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200507214624.21911-1-gpiccoli@canonical.com> <20200507160618.43c2825e49dec1df8db30429@linux-foundation.org>
In-Reply-To: <20200507160618.43c2825e49dec1df8db30429@linux-foundation.org>
From:   "Guilherme G. Piccoli" <kernel@gpiccoli.net>
Date:   Thu, 7 May 2020 23:17:19 -0300
Message-ID: <CALJn8nMwQfHdXAQHHqnWA7GxeAN43wG2W42uF6uaHQ--Z40xOw@mail.gmail.com>
Subject: Re: [PATCH] kernel/watchdog.c: convert {soft/hard}lockup boot
 parameters to sysctl aliases
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-kernel@vger.kernel.org,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        keescook@chromium.org, yzaikin@google.com, mcgrof@kernel.org,
        vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 7, 2020 at 8:06 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> We have a lot of sysctls.  What is the motivation for converting these
> particular ones?

No stronger motivation than a regular clean-up - I just liked the
infrastructure provided by Vlastmil and thought in using it. I know we
have plenty of sysctls, but not all of them have identical/duplicate
boot params, so I went with the obvious ones, that I use more.
Cheers,

Guilherme
