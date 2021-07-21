Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44DB3D16B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 20:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhGUSPe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 14:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbhGUSPd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 14:15:33 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23311C061575
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jul 2021 11:56:09 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id j1so4263858ljo.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jul 2021 11:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aJkW/Rt80/ziMvbn4832hKqXFcNOrBwlbkHciUUuUEQ=;
        b=h3o4hzJQWX+TGJxM1Jtx5rcowiFdFpFGP1bJrbF2mhXZ6Iahjbd/JUD501V9ekEXeH
         AKH+TPFtDIlarocczD/aWA1pu8wLGBLaRHpy4i/siBaSki9h5jCAgNQpFt/qJnD1htBB
         mATXWGOEBa84HmjBZUdJpk8shmsNjxHoAmmV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aJkW/Rt80/ziMvbn4832hKqXFcNOrBwlbkHciUUuUEQ=;
        b=lQ5TZEaxAdPftgDlUBbcjOKRYMVReCcgYLfPMTlCMaNg1L5VaCVVRLhPv9ShydHr5S
         0lKgOAph4lwo6gw9dftOTAik2IvqWWTOhHSUqzJYSY1ctAlIqPjbo/bMig22UftA95Te
         Sqr3g1V0NPXdsvfqBOEKohDcpi5OHxy2nfaKi5h/LL0iimcbTrLKcFa6NwfEKTgpc8E2
         QKL6it4iKEUdSwwW+Zq/jC08nq67cmjROfEnTEx4AwaJFawVx/ByHbjrH1OPCZOTDjn3
         k2lLQvH714YILphUP257VLV2wtOuPbhlcJIyFdmvTLDzIv41iMGesYGvt9WddLvU14r6
         JmNA==
X-Gm-Message-State: AOAM533kEjr7DUrTC0s7dtKLoCTxNfhxLK8RUWxWbfYM5m4wcC5b/Gb/
        qYddc9GbCMRu/S8BsJhMV1lBKZ7CVROTVyrT
X-Google-Smtp-Source: ABdhPJw+QsprpFkv+5shYy7Tgmi8+I6SpwDoJqaYQH/vdefnRFOqdZpkseo7LhOm0jZdDW5B6AKBiA==
X-Received: by 2002:a05:651c:297:: with SMTP id b23mr32868384ljo.364.1626893767396;
        Wed, 21 Jul 2021 11:56:07 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id o8sm1758069lfu.25.2021.07.21.11.56.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 11:56:06 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id a12so4679436lfb.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jul 2021 11:56:06 -0700 (PDT)
X-Received: by 2002:a05:6512:404:: with SMTP id u4mr25898153lfk.40.1626893766677;
 Wed, 21 Jul 2021 11:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210721135926.602840-1-nborisov@suse.com> <CAHk-=whqJKKc9wUacLEkvTzXYfYOUDt=kHKX6Fa8Kb4kQftbbQ@mail.gmail.com>
 <b24b5a9d-69a0-43b9-2ceb-8e4ee3bf2f17@suse.com> <CAHk-=wgMyXh3gGuSzj_Dgw=Gn_XPxGSTPq6Pz7dEyx6JNuAh9g@mail.gmail.com>
In-Reply-To: <CAHk-=wgMyXh3gGuSzj_Dgw=Gn_XPxGSTPq6Pz7dEyx6JNuAh9g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Jul 2021 11:55:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=whhThPq-ETzyepM0OteV480FcVExxPMoU0ntaH-mX_BrQ@mail.gmail.com>
Message-ID: <CAHk-=whhThPq-ETzyepM0OteV480FcVExxPMoU0ntaH-mX_BrQ@mail.gmail.com>
Subject: Re: [PATCH] lib/string: Bring optimized memcmp from glibc
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 11:45 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>  - the code generation is actually quite good with both gcc and clang.

Side note: I only looked at whether the code looked good, I didn't
check whether it looked *correct*.

So caveat emptor.  It looks trivially correct both on the source and
assembly level, but it's entirely untested, which probably means that
it has some stupid bug.

               Linus
