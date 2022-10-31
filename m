Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87326613D9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 19:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJaSqN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 14:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiJaSqM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:46:12 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D9313D75
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 11:46:11 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id s20so1762351qkg.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 11:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wbqXepqBr/d+nZhEtmIQjbOd1ibdPmbwm+prkMG2b7c=;
        b=Jz8Ca0enSFe+lKvvMsvmPfLX3BuPDuiZYUhK6rGyjOoNtKx4TsFn5pBucUpsWlRlPv
         Tl77uj0agyiPA6Si89dXmpdFFbXsvj2QHwMSMvIsDWLRDizVEsZwjuiGQpGuyU5XPhmA
         Xu5z5a4RW69o6+/cYgBo5949XF+YCTw1ZCUR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbqXepqBr/d+nZhEtmIQjbOd1ibdPmbwm+prkMG2b7c=;
        b=7amjrXetwUf7V+8DYD2phBQw4jDmiXdsh068TSPbrlN8A2FTUkGEvRplGY6GY7up9B
         i7is25tS07Wej+RoFAOY1ze16ZYhZ7GdVXJzQVVXP6vWwuINCTz9l1f+8aKujhkN45a7
         1u8RlS6f19Xyq95L7kUPm9vhHUFJgHwnkgEfwt/bsBKz46BSGmNvWRluPjGQvZsVIe1Y
         M8hRISQoLosB/ld6sRaARxoQNH/B70XQjeYsJcsTVtk1oqa/xTtucS9qlXcm4ruuxXrT
         YNdlcKelwuWg1ZRdM78Ebif0VQtHF+JE5dFBzvnPauTdpsKzM1qhOoiwImYHRfN4f5lQ
         sEpA==
X-Gm-Message-State: ACrzQf36kLsEe3tU3BrsXFKgwHIlcHx+fjjJngKi6SJQOaxkCXfAAyhT
        STBQVLenaV04ZHmvXNIm+ZLxhtZE4/sozg==
X-Google-Smtp-Source: AMsMyM54QvLSrYgC7iVjTYNhm1KZy8h4KaowUyT64XOdClACcTQg3GiPW1IvFsfHeeOQZzsC4a4FLA==
X-Received: by 2002:a05:620a:489c:b0:6ef:14a1:4b90 with SMTP id ea28-20020a05620a489c00b006ef14a14b90mr10284817qkb.192.1667241970391;
        Mon, 31 Oct 2022 11:46:10 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id s16-20020a05620a255000b006ee7923c187sm5214394qko.42.2022.10.31.11.46.09
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 11:46:09 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3701a0681daso81554907b3.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 11:46:09 -0700 (PDT)
X-Received: by 2002:a81:555:0:b0:36b:2d71:5861 with SMTP id
 82-20020a810555000000b0036b2d715861mr14455647ywf.340.1667241969081; Mon, 31
 Oct 2022 11:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221031175256.2813280-1-jannh@google.com> <Y2APCmYNjYOYLf8G@ZenIV>
In-Reply-To: <Y2APCmYNjYOYLf8G@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Oct 2022 11:45:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=eaYiBf5JMQRS53=y17N7gvZNhn+kYGZj=2R=8Pc_4Q@mail.gmail.com>
Message-ID: <CAHk-=wi=eaYiBf5JMQRS53=y17N7gvZNhn+kYGZj=2R=8Pc_4Q@mail.gmail.com>
Subject: Re: [PATCH v2] fs: use acquire ordering in __fget_light()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jann Horn <jannh@google.com>, Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 31, 2022 at 11:08 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Looks sane, but looking at the definition of atomic_read_acquire...  ouch.

The compiler should sort all that out and the mess shouldn't affect
any code generation.

But I also wouldn't mind somebody fixing things up, because I do agree
that checking whether 'atomic_t' is a native word size is kind of
pointless and probably just makes our build times unnecessarily
longer.

                Linus
