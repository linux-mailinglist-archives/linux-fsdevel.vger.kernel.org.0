Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49577B8CE4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245540AbjJDTJF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 15:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245568AbjJDTIt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:08:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CAC4231
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Oct 2023 12:05:17 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9adca291f99so28996366b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Oct 2023 12:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696446316; x=1697051116; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NNnEphU0KlJzc/sSHijWyTL6hsdjXtWiL3Z3UlyPG1A=;
        b=a5HVm/M17ybJ9BgvQKWzGPcWudDKty8PEEbEAsSYLnqT1vBqkuoelkTnKvW2mHxlgl
         eTnPAtcvumPRbh7upsUE1uOSD9tq3S8qZ+76e2nWrnKLDZkpPqXbW14lhTNlpx/YDUsl
         Dwu8ZYvYO1h0w48GXoixwCoG/v22xPe0CFodc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696446316; x=1697051116;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NNnEphU0KlJzc/sSHijWyTL6hsdjXtWiL3Z3UlyPG1A=;
        b=jEzLlqNLaWs+ySA++VQICCNahmnJov4Uq0uoxZ7VO1G74JR2BAiCR+8P3JPgdmZKnz
         fUExD2JmCPetbWdxGRwotYdRMNtYh+7565ZHw2JaAXZplqPYbwvexYtl1Cs+M55IjJ3O
         bcVZzLQffiAbF3H7dxOtg4dX54GyCeP+lFano2KeGkrlv0teoz0dnSYDJ65Mvyf4hDwL
         CbC54bYxE0wuAbkXy1q56CCfsfqhu3KqMP361o5tZc6Qfv8+QN0zT5ks462GRuy2WdqA
         KaAZvLfX84p++U8UlN7C7yEOVRuu+xtJNpemTn9b24OsJPfxCTJZe5DhbfYQl9RG+eDy
         Sjyw==
X-Gm-Message-State: AOJu0YyPWbZ4xI/Pd6G7IcfpOKVORWu4BQ1J4XUaCAHQIxloJofy5kuN
        Ja9T7OqlRV34ByQ4o9MywCfKAQarlZR8uvp0O2t+KA==
X-Google-Smtp-Source: AGHT+IFBNka76T1SJDh/lxNPfdt357u9Vo8bl1Nj+ojOHvgKH81QSPf0G/8i2wV7lm6q/NirRoo1Aw==
X-Received: by 2002:a17:906:8a77:b0:9b3:308:d046 with SMTP id hy23-20020a1709068a7700b009b30308d046mr2773360ejc.61.1696446315908;
        Wed, 04 Oct 2023 12:05:15 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id dt26-20020a170906b79a00b0099290e2c163sm3225349ejb.204.2023.10.04.12.05.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 12:05:14 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5346b64f17aso167394a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Oct 2023 12:05:14 -0700 (PDT)
X-Received: by 2002:a05:6402:28a:b0:538:8d4:2077 with SMTP id
 l10-20020a056402028a00b0053808d42077mr2995123edv.13.1696446314363; Wed, 04
 Oct 2023 12:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231002022815.GQ800259@ZenIV> <20231002022846.GA3389589@ZenIV>
 <20231002023125.GE3389589@ZenIV> <20231002064912.GA2013@lst.de>
 <20231002071401.GT800259@ZenIV> <20231002072143.GU800259@ZenIV> <20231002180925.GZ800259@ZenIV>
In-Reply-To: <20231002180925.GZ800259@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Oct 2023 12:04:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwKZ5V2qb5JgA5UEdJBwDHYzFJ71xj0UZoiCyvBRd9AA@mail.gmail.com>
Message-ID: <CAHk-=whwKZ5V2qb5JgA5UEdJBwDHYzFJ71xj0UZoiCyvBRd9AA@mail.gmail.com>
Subject: Re: [PATCH 04/15] hfsplus: switch to rcu-delayed unloading of nls and
 freeing ->s_fs_info
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve French <sfrench@samba.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2 Oct 2023 at 11:09, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> BTW, is there any reason not to have synchronize_rcu() in delete_module(2),
> just before calling ->exit()?
>
> It's not a hot path, unless something really weird is going on, and it
> would get rid of the need to delay unload_nls() calls...

We already have one - it's hidden in free_module().

It's done after the kallsyms list removal. Is that too late?

Note that module *loading* actually has a few other synchronize_rcu()
calls in the failure path. In fact, load_module() has *two*
"synchronize_rcu()" calls:

 - after ftrace_release_mod(mod)

 - before releasing module_mutex

for the failure path, but there's only one for module unloading.

Adding one to after ftrace_release_mod() - where we have that
async_synchronize_full() - would make module unloading match the
loading error path.

But the synchronize_rcu calls do seem to be a bit randomly sprinkled
about. Maybe the one in free_module() is already sufficient for nls?

             Linus
