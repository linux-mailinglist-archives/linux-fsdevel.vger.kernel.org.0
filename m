Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE7E1E6C8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 22:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407216AbgE1UaE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 16:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407191AbgE1U35 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 16:29:57 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BA7C08C5C6;
        Thu, 28 May 2020 13:29:54 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id k11so1351089ejr.9;
        Thu, 28 May 2020 13:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jubbYLeXvUFozWJ2dGJv9BknYxFFydhKvrR5dq59bYc=;
        b=lEvgWoFZbktWMVKAq2OjNpu1lz4P+/FVRhfbKVnDN42Z4qcQJBgHPikzonc97XyPOb
         hI6vQxJIfmoQcwlXslbmhgNwhMXV3k6TJd9ytmzYg6kv7uGgWWMGgtCg9CmjToKoXKDf
         OqgXMZJ1ssR7O4C5rTfnmZUgl2rNmJ6SYStDAd72pGxrg/1pLxVnkP53VdVIovQ2pqZq
         aorHs+mPxzHeUHZziDmqb9ail4EOQx/Txh5AQX1QhPCg1fAi+IMOTp0RLkHaDWi87Qwg
         cU22Sanfo7Wa/mm36qpi4cbk4nmS/0CS6Oj920ctvl0TmrH58OfL0MK0qqKc7CHQID5D
         n4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jubbYLeXvUFozWJ2dGJv9BknYxFFydhKvrR5dq59bYc=;
        b=sTa3LdDehcRjOyKUMFPQl1/w98ngv7l826QReU+r5CoDi5zx0Kl50+2t+Zzmf/OmiD
         InmRDTgZOz8K+pyfm50Q8tPiUtmbA0h8eaEoy4MbebgOr/fCxwjvWg8NBWvKRmFvfmf/
         MIi6Mny8QKdQPZgQrloIYafCs24cRlpwaQ78aek9hFEWxB6k3yP63uYD8V43trrVMk5m
         m68H5BwFociF/ZFQbFs5XSxCSxAGpdF/lKsQXL3odWtwqw2uAnfp+qll5ZDRXOZS9SUj
         lX9KMVMwF8oHOVFM8RHiLYZKpPOOqxxlHxAeAZWUzp9zIgTj3knLcAQif7RFxRwfkW0F
         +23w==
X-Gm-Message-State: AOAM531SJYbNLxwJu12ntH/1y7evBj4kOhQEbxkqbJUlUg9o5KrWQorP
        KZllKpQifyURi0PSam/l7y5vUflCn3zqTR/18K0hcJII
X-Google-Smtp-Source: ABdhPJwBNoY2pCnaFWbbxsOYLa0Gov4fBr3XnIMoiOKDk6nJlaCbfvysQTfONH9RBPB7UA/a5zYQ94brdDrD2jJgEKU=
X-Received: by 2002:a17:906:c9d6:: with SMTP id hk22mr4657328ejb.101.1590697793606;
 Thu, 28 May 2020 13:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200528054043.621510-1-hch@lst.de> <CAHk-=wj3iGQqjpvc+gf6+C29Jo4COj6OQQFzdY0h5qvYKTdCow@mail.gmail.com>
 <f68b7797aa73452d99508bdaf2801b3d141e7a69.camel@perches.com> <20200528193340.GR23230@ZenIV.linux.org.uk>
In-Reply-To: <20200528193340.GR23230@ZenIV.linux.org.uk>
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 29 May 2020 06:29:42 +1000
Message-ID: <CAPM=9twsu9bUpaCUVfb2sgHQsvSJiE5qRyiigLBJe5+3WMq8aQ@mail.gmail.com>
Subject: Re: clean up kernel_{read,write} & friends v2
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 29 May 2020 at 05:35, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, May 28, 2020 at 12:22:08PM -0700, Joe Perches wrote:
>
> > Hard limits at 80 really don't work well, especially with
> > some of the 25+ character length identifiers used today.
>
> IMO any such identifier is a good reason for a warning.
>
> The litmus test is actually very simple: how unpleasant would it be
> to mention the identifiers while discussing the code over the phone?

That doesn't make sense though,

if you write the full english words out for something it'll be long
but easier to say over the phone,
if you use shortened kernel abbreviations it will be short but you'd
have to read out every letter.

To take an example:
this would read pretty well on the phone, maybe params could be parameters
amdgpu_atombios_get_leakage_vddc_based_on_leakage_params

vddc would be a stumbler.

try saying O_CREAT over the phone to someone not steeped in UNIX folklore.

Dave.
