Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A9379446A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 22:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244382AbjIFUVa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 16:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244380AbjIFUV2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:21:28 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E8C1BD1
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 13:21:20 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5298e43bb67so336814a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Sep 2023 13:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694031678; x=1694636478; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=juvIBN8bH5nfyemIbaYqy2hi6dz3IfTdEON4xkDZyZg=;
        b=LmO/AEN05xILKYsMLaoZsLbQGdc/6PcgAb5OerutYzUfm49tWSoRfaGS3YrE5+hmW2
         o4HvizGFnU4GnuycWAduXHmqNQrAY39kDjLmQ4SKC2uqwdk8OpALf5UKxHqXRwPkkU+Z
         4YnKK5dT2R4E1KsW8GHvtVBQ6plmYXY9r1Zns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694031678; x=1694636478;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=juvIBN8bH5nfyemIbaYqy2hi6dz3IfTdEON4xkDZyZg=;
        b=GWQpXoDlzr2gy1CP/Sb3y1/Ud7VziNbmAYid8iwUlQTm4xefmkMjwhWT/IvGu1HbJb
         DRaL3NIEPev82jz9E/NIbggEtTWe8MNHPGWEc+1SzGs0VqndflLqrhunDDWFKd9cw6w7
         /+7CaQ3SbXaHX07f46gAok7pLpbDHbAGKQlvWRme5C6QdOsQwuxyolFtAL0NVpw2jAWa
         V2q2s3fkJmZH2RpmMoaXg5Vxzx65rs+tMMP1+4JGsu5lJsf6YBpQ63GbiBeQdWmYIc63
         oYVU24QbEtf1qnyuMyHUHMXxRpjdkWj6fzjXmCEnHuoaD3spn+gNzmYjAesli9+CceGN
         phUA==
X-Gm-Message-State: AOJu0YzpeZ0y25TwKSod2njp1KX6jcziQ3cl0jfth6arKG6l/2ADfr+K
        I022h4QGopGYsu4C57FtZRy9k9dMyPxCL/6hJ84zAw==
X-Google-Smtp-Source: AGHT+IFmaOyrc+WBhHiEQhI8KPNI4TWTNjLK2FfMLGWSAYwT3W0tkOuEmsxnbye5lUvr56BX9w2gmg==
X-Received: by 2002:aa7:df81:0:b0:523:c36e:ec8b with SMTP id b1-20020aa7df81000000b00523c36eec8bmr984846edy.9.1694031678315;
        Wed, 06 Sep 2023 13:21:18 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id u20-20020a056402065400b00529fb5fd3b9sm8792677edx.80.2023.09.06.13.21.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 13:21:17 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so2925851a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Sep 2023 13:21:17 -0700 (PDT)
X-Received: by 2002:a05:6402:50ce:b0:521:ef0f:8ef9 with SMTP id
 h14-20020a05640250ce00b00521ef0f8ef9mr908145edb.19.1694031677181; Wed, 06 Sep
 2023 13:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
 <CAHk-=wjUX287gJCKDXUY02Wpot1n0VkjQk-PmDOmrsrEfwPfPg@mail.gmail.com> <CAHk-=whaiVhuO7W1tb8Yb-CuUHWn7bBnJ3bM7bvcQiEQwv_WrQ@mail.gmail.com>
In-Reply-To: <CAHk-=whaiVhuO7W1tb8Yb-CuUHWn7bBnJ3bM7bvcQiEQwv_WrQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 Sep 2023 13:20:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi6EAPRzYttb+qnZJuzinUnH9xXy-a1Y5kvx5Qs=6xDew@mail.gmail.com>
Message-ID: <CAHk-=wi6EAPRzYttb+qnZJuzinUnH9xXy-a1Y5kvx5Qs=6xDew@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 6 Sept 2023 at 13:02, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And guess what happens when you have (unsigned char)-1? It does *not*
> cast back to -1.

Side note: again, this may be one of those "it works in practice",
because if we have -fshort-enums, I think 'enum
btree_node_locked_type' in turn ends up being represented as a 'signed
char', because that's the smallest simple type that can fit all those
values.

I don't think gcc ever uses less than that (ie while a six_lock_type
could fit in two bits, it's still going to be considered at least a
8-bit value in practice).

So we may have 'enum six_lock_type' essentially being 'unsigned char',
and when the code does

    mark_btree_node_locked(trans, path, 0, BTREE_NODE_UNLOCKED);

that BTREE_NODE_UNLOCKED value might actually be 255.

And then when it's cast to 'enum btree_node_locked_type' in the inline
function, the 255 will be cast to 'signed char', and we'll end up
compatible with '(enum btree_node_locked_type)-1' again.

So it's one of those things that are seriously wrong to do, but might
generate the expected code anyway.

Unless the compiler adds any other sanity checks, like UBSAN or
something, that actually uses the exact range of the enums.

It could happen even without UBSAN, if the compiler ends up going "I
can see that the original value came from a 'enum six_lock_type', so I
know the original value can't be signed, so any comparison with
BTREE_NODE_UNLOCKED can never be true.

But again, I suspect that in practice this all just happens to work.
That doesn't make it right.

               Linus
