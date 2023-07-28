Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C80D766773
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 10:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjG1InU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 04:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbjG1InQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:43:16 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BF0269E
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 01:43:12 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9aa1d3029so28149341fa.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 01:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1690533791; x=1691138591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LWjFeLGkUfqQT1ZgNsfv5JPCUcMwsFRiww/cZdMA43A=;
        b=hpENeGp9eq7S67ZijD/HCQx0L1pk8okZm5GWrI77lovgXqvX7nFXB1v/07COp0l3x+
         PofQnb7NLQLHuRWzD40W9pOnsV9nzaJ5hUv2Q9J5N2CidAT7NojJQeGfkqGCkqoMlN2U
         SBjYf0o2AKPy7VZYaBmDitd06U1VrDuHUkinQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690533791; x=1691138591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWjFeLGkUfqQT1ZgNsfv5JPCUcMwsFRiww/cZdMA43A=;
        b=i0m4bN8BO7gEmDgNttlhyPEd7uXaYxJh3JCRRD61myl0WKekB/bfPCbuXP48Soja/7
         XPJnHN0q37BcpY549KT2q5sesbMyychtp4rt42chvfwH64/HMwfGLdQx85OkfM3GTxJ8
         juBEJ+VUeiSGbLllSKh1/4T/qkz7Y+ZZClSFtYG61l5nuzc/drpApDPjGk0p31EX7891
         dQj/uUwiS188e6cycvlHh7MCb1G67hmbsY1PGvjXGDWmRSOc4cEN/xjoskWR3FnM+3El
         A53JSIM6Uj4Ow5Jt90RyFYYWUZLjaOHtBxJL2qX+k1VL/AshKftyp52AvSzO/tqaX0+Q
         aPVg==
X-Gm-Message-State: ABy/qLZTGZreCozqdbDU/fgBIwH4ZsXKo+uSWFpWGgZgq+Of2qJf05Yf
        J5vLuZ3AL1QPFEJiNhQ7LY6NDSOWl307PieLzW+AEY8pqxJvBZ0GX1E=
X-Google-Smtp-Source: APBJJlEcxx+o+5IfVhGHoFcrSdtkzlah3RjlDH62GbqNA6s/70iAKtdHwcYrJ3OX73GsKcHFaTvJJ2+/EW6Ch1UBVO8=
X-Received: by 2002:a2e:9bc3:0:b0:2b6:cd12:24f7 with SMTP id
 w3-20020a2e9bc3000000b002b6cd1224f7mr1151140ljj.44.1690533791076; Fri, 28 Jul
 2023 01:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230726105953.843-1-jaco@uls.co.za> <b5255112-922f-b965-398e-38b9f5fb4892@fastmail.fm>
 <7d762c95-e4ca-d612-f70f-64789d4624cf@uls.co.za> <0731f4b9-cd4e-2cb3-43ba-c74d238b824f@fastmail.fm>
 <831e5a03-7126-3d45-2137-49c1a25769df@spawn.link> <27875beb-bd1c-0087-ac4c-420a9d92a5a9@uls.co.za>
 <CAJfpegtaxHu2RCqStSFyGzEUrQx-cpuQaCCxiB-F6YmBEvNiJw@mail.gmail.com> <21fff874-d4ed-1781-32a6-06f154a4bc99@fastmail.fm>
In-Reply-To: <21fff874-d4ed-1781-32a6-06f154a4bc99@fastmail.fm>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 28 Jul 2023 10:42:59 +0200
Message-ID: <CAJfpegvAZ-A09VKMcKJF1NMcgMf7Jq6yoCQR8ixh2eme6LkOjw@mail.gmail.com>
Subject: Re: [PATCH] fuse: enable larger read buffers for readdir.
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Jaco Kroon <jaco@uls.co.za>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 27 Jul 2023 at 21:43, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 7/27/23 21:21, Miklos Szeredi wrote:
> > On Wed, 26 Jul 2023 at 20:40, Jaco Kroon <jaco@uls.co.za> wrote:
> >
> >> Will look into FUSE_INIT.  The FUSE_INIT as I understand from what I've
> >> read has some expansion constraints or the structure is somehow
> >> negotiated.  Older clients in other words that's not aware of the option
> >> will follow some default.  For backwards compatibility that default
> >> should probably be 1 page.  For performance reasons it makes sense that
> >> this limit be larger.
> >
> > Yes, might need this for backward compatibility.  But perhaps a
> > feature flag is enough and the readdir buf can be limited to
> > fc->max_read.
>
> fc->max_read is set by default to ~0 and only set to something else when
> the max_read mount option is given? So typically that is a large value
> (UINT_MAX)?

That's fine.  It probably still makes sense to limit it to 128k, but
with the ctx->count patch it would be naturally limited by the size of
the userspace buffer.  There's really no downside to enabling a large
buffer, other than an unlikely regression in userspace.    If server
wants to return less entries, it still can.  Unlike plain reads,
filling the buffer to the fullest extent isn't required for readdir.

So the buffer size calculation can be somthing like:

init:
#define FUSE_READDIR_MAX (128*1024)
fc->max_readdir = PAGE_SIZE;
if (flags & FUSE_LARGE_READDIR)
   fc->max_readdir = min(fc->max_read, FUSE_READDIR_MAX);

[...]
readdir:
   bufsize = min(fc->max_readdir, max(ctx->count, PAGE_SIZE));

Thanks,
Miklos
