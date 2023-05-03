Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B476F5F0F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 21:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjECTYL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 15:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjECTYK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 15:24:10 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3ADE59F1
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 12:24:09 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so10028395a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 May 2023 12:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683141848; x=1685733848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnk0azjKtvGmutcc0sPTCISsVHec16NyojRU9ojJrvg=;
        b=YlhkUv7SObfAaRnJ7XfbPdseLmuLZeaBqb8t1qGSK4Mn1z/quP8XfCCUQbPKEmguM+
         SPx0HGQBOFZlOlHqyNwY+/GvkHv9G9CiRs+Rkd9j/4URGfBLVO4x8/0O8VEA+QHZWN+O
         HEykXtLO+DMYdnFT4AE1ETzt+yKvBXm/VlKxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683141848; x=1685733848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnk0azjKtvGmutcc0sPTCISsVHec16NyojRU9ojJrvg=;
        b=WBS9S08i1CP214HwtgSGVxAmQxF745g2J2pyye5u3dr4DrVLU4QSL6fAfZFIsLOCoZ
         jgKVM5AgDEpB0eS8Juiyn37CbJRbHpkhf22Fn1cCNaTxAlcWIJcJqizKXRSaH4CBWqDz
         +LPbWFav+mtEfxhnIqRgfqAGqH6ZXZ6/u0jXv+p0msUrCakvnFya1mbh2psy1iQljtsz
         zX08LT9LWgcaWmf9N76Z60Y09RerrOFJY0gYHUPAuNiu7ivtCF8pZWnc1zriO30YiTUQ
         vaJuV8wY1Rob/FbRXPu7atwknmPbNIIbG2YvQ8XzxrqlY1+oAK3hhBEbRCSh9SRcw2RQ
         i/2w==
X-Gm-Message-State: AC+VfDz/koPyV8APYqdiaHbGHWaIjJO2G/tz9f1ChmHJbLqomDV7CDYX
        w2ihlplhAxizjCKJDOVJ7Q9Hz8OzPIBPEa71Wy9xXQ==
X-Google-Smtp-Source: ACHHUZ626npmqq3Ke12y9sEtTUaTnBVIdke+mc0DgvA6fyTg+85Aq2tOfz/TR2MM+ESahXnKp0mu3A==
X-Received: by 2002:a05:6402:1d4a:b0:506:b94f:3d8f with SMTP id dz10-20020a0564021d4a00b00506b94f3d8fmr1715227edb.5.1683141848103;
        Wed, 03 May 2023 12:24:08 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id o10-20020aa7c50a000000b0050bce352dc5sm1017758edq.85.2023.05.03.12.24.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 12:24:07 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so10028126a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 May 2023 12:24:07 -0700 (PDT)
X-Received: by 2002:a17:907:98c:b0:95f:969e:dc5a with SMTP id
 bf12-20020a170907098c00b0095f969edc5amr2502183ejc.30.1683141846992; Wed, 03
 May 2023 12:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230503023329.752123-1-mcgrof@kernel.org> <ZFKKpQdx4nO8gWUT@bombadil.infradead.org>
 <CAHk-=whGT-jpLRH_W+k-WP=VghAVa7wRfULg=KWhpxiVofsn0Q@mail.gmail.com> <ZFKxl2d+kqYN0ohG@bombadil.infradead.org>
In-Reply-To: <ZFKxl2d+kqYN0ohG@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 May 2023 12:23:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgUizDLEhvHdM=7yUmdGMB--CGV1ynMSQrd0r7C06ALUA@mail.gmail.com>
Message-ID: <CAHk-=wgUizDLEhvHdM=7yUmdGMB--CGV1ynMSQrd0r7C06ALUA@mail.gmail.com>
Subject: Re: [PATCH 0/2] sysctl: death to register_sysctl_paths()
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        ebiggers@kernel.org, jeffxu@google.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 3, 2023 at 12:10=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> Sorry thought you don't mind a few patches, so ditched the formalities
> for the pull.

So I don't mind patches per se, and when there's a reason for them I
have no problem at all taking them.

The reason is typically something like "let's short-circuit the normal
channels just to get this trivial thing sorted out and we can forget
about it", but it can also be just a practical thing like "I'm
traveling so it would be easier if you'd just pick up this patch
directly from the mailing list".

Or it could be "I don't have a git tree since I'm not a main
developer, so I just send patches".

All of those are situations where I'll happily take patches directly.

But on the whole, when there isn't any real reason to avoid a pull
request, I'd much rather have the full thing with signature and
everything...

               Linus
