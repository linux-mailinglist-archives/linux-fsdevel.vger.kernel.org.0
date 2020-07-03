Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20761213FFA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 21:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgGCTZC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 15:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgGCTZC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 15:25:02 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904E5C08C5DD
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2020 12:25:01 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id t9so19075485lfl.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jul 2020 12:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nEMPMKHktF+3GiPNxFWdeLrXOxNE07nmroDOEVThA4A=;
        b=EhC1qDxGOcHnqhdTefcfYAg7Ihgd+dyuCofQ5oRzGgTrAnhAQqF7OzcfuyTH4ovLGg
         lVeESWYyUkkno7e5pvU5gocokHSLu0r0EG8L+u7jkct0aI3QhIpJFf9k8NwIciFyX7/7
         9XeVBI0g2czxapfWKmluX0h7W/Jh645iHYlCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nEMPMKHktF+3GiPNxFWdeLrXOxNE07nmroDOEVThA4A=;
        b=C4Iw7lcvNM9+KIfKNAsjV3hdt523hs2CfvdwpSDmVFDwn71mbujTlLjIGk6oCbpghV
         ZIxMoSdTjkqh0cSoJtezgkDrVDNcZSX39TVpVyNsRzRZdBEfyBj5XGgwRgoDfivjMTv+
         n4Sliq4ZN6BaUTRY2s8Iq6Xc4KkwFt4rjUFYOzkWHT41Sqajhexy8c2EUyFZzOf0Y5L9
         19fmwB2k9P/jT7AUJJ+TzEfUqTzppWe8iUkThoGYweKX87bQmXWmvO1X45nJ6orSvZHm
         gr/cjhyAs3jJTQyAXJ7ag48MQxWJk82YwddKfh4zwg1GSlDjwdFv9ix5Gxnxq9PffK5K
         YAZg==
X-Gm-Message-State: AOAM531MfklqlJycHCD/7SI1oGlnU0KlbzpaHDjNyk4Y4J/gsw34+U5p
        l0yj7Hfo1PS0+AEpA8TzHg+FY8jzCfw=
X-Google-Smtp-Source: ABdhPJwopu4EqX/UZW75tTMf4+x6Hen3f2HA2SDNBqoXZm0OGh4A6NpkePIdiM3uYA/oH0CCVp9+wg==
X-Received: by 2002:a05:6512:214f:: with SMTP id s15mr6388996lfr.101.1593804299458;
        Fri, 03 Jul 2020 12:24:59 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id f24sm4388796ljk.125.2020.07.03.12.24.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 12:24:58 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id t25so33591842lji.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jul 2020 12:24:58 -0700 (PDT)
X-Received: by 2002:a2e:991:: with SMTP id 139mr20104619ljj.314.1593804298028;
 Fri, 03 Jul 2020 12:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200703095325.1491832-1-agruenba@redhat.com>
In-Reply-To: <20200703095325.1491832-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Jul 2020 12:24:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9ObgMYF8QhPCJrHBBgVXG1J75-r8CgyQm88BbfSVYcg@mail.gmail.com>
Message-ID: <CAHk-=wj9ObgMYF8QhPCJrHBBgVXG1J75-r8CgyQm88BbfSVYcg@mail.gmail.com>
Subject: Re: [RFC v2 0/2] Fix gfs2 readahead deadlocks
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 3, 2020 at 2:53 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> Here's an improved version.  If the IOCB_NOIO flag can be added right
> away, we can just fix the locking in gfs2.

I see nothing wrong with this, and would be ok with getting the
patches as pulls from the gfs2 tree despite touching generic code.

Maybe wait a bit for others to comment (I see Willy already did), but
it seems like a fairly straightforward improvement, and the IOCB_NOIO
flag conceptually seems to match well with the IOCB_NOWAIT one, so
this all makes sense to me.

              Linus
