Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E243E4E6D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 23:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbhHIVZ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 17:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbhHIVZ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 17:25:57 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557CEC061798
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Aug 2021 14:25:36 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id h9so25710810ljq.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Aug 2021 14:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GciiGnwukZUcZuMgRkuX2+Oq98OfQGEGL0PbIUMdbwY=;
        b=DkW8bjkdCbaSSZSwXUD4dP7zGs+heKPA+Oy5FoJ3PhXwaSYav89OxOAcJNbCZqAFmL
         0h1nLAi6SdzNhvMaS1Nzft4JS4BHDBbOx4s0vutZIhoGZgzoNkz1aA+MU8kA1xMDmbqc
         PFME9G1HDX5AzRGqzhBS/Ml77jddOYE1oapDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GciiGnwukZUcZuMgRkuX2+Oq98OfQGEGL0PbIUMdbwY=;
        b=X6rljn6RrQ7DiS3HBvaoalBEjeIp0wibXxjnlTA5hhvsYUIH/RUatnn/P/q+Qy8SXx
         ZB8O9oIdnc2cO8nyMSpdMfrwaYfPayFRRFq4gZJHXt8V1LpCsG1vw0EQ8wnetLtkJElh
         ft1NdikRZE8NhtKNUBt+gGtUtoDYeURr/cakW173/A3zpPT9xZfuKj1Tt3xKv3i6ltdd
         imO9zdSxM933h2d81LzsRSIcmoxhrPbvlUqO4nwY+428mmZb8Xy2KYyQuisP0wbQOeE9
         4manaSiQIxQoZThXrgTuuauaYcLLXKO+5MAbYL+NO9HkPabRNmpl92PCp8aIe+P2txKK
         yMKQ==
X-Gm-Message-State: AOAM533d6ZjKdFloxehZkdbrzKMqS74w4X2fvhrakkRIidDEnKFKU/8i
        AKUdYyz6Sg7qPTTRH8KTvoUtmNaHUCI5lbJC
X-Google-Smtp-Source: ABdhPJz5Yx3wvgDEWonPePxCvGUThg8jJozY9VKDKY6Ge6EP8/uNMaiIJ4MCFBz5QZdcZsSfLD5Zig==
X-Received: by 2002:a2e:7a09:: with SMTP id v9mr16662008ljc.397.1628544334458;
        Mon, 09 Aug 2021 14:25:34 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id p27sm1844460lfo.296.2021.08.09.14.25.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 14:25:34 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id h11so10639868ljo.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Aug 2021 14:25:33 -0700 (PDT)
X-Received: by 2002:a2e:b703:: with SMTP id j3mr7222089ljo.220.1628544333584;
 Mon, 09 Aug 2021 14:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <YRFfGk5lHL0W27oU@miu.piliscsaba.redhat.com>
In-Reply-To: <YRFfGk5lHL0W27oU@miu.piliscsaba.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Aug 2021 14:25:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wigKQqEqt9ev_1k5b_DwFGp7JmCdCR1xFSJjOyisEJ61A@mail.gmail.com>
Message-ID: <CAHk-=wigKQqEqt9ev_1k5b_DwFGp7JmCdCR1xFSJjOyisEJ61A@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs fixes for 5.14-rc6
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 9, 2021 at 10:00 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
>       ovl: fix mmap denywrite

Ugh. Th edances with denywrite and mapping_unmap_writable are really
really annoying.

I've pulled this, but I really get the feeling that there's duplicated
code for these things, and that all the "if error goto" cases  (some
old, some new) are really really uglky.

I get the feeling that the whole thing with deny_write_access and
mapping_map_writable could possibly be done after-the-fact somehow as
part of actually inserting the vma in the vma tree, rather than done
as the vma is prepared.

And most users of vma_set_file() probably really don't want that whole
thing at all (ie the DRM stuff that just switches out a local thing.
They also don't check for the new error cases you've added.

So I really think this is quite questionable, and those cases should
probably have been done entirely inside ovlfs rather than polluting
the cases that don't care and don't check.

                 Linus
