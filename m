Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577C768DDD7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 17:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjBGQXf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Feb 2023 11:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjBGQXe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:23:34 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C10A618A
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Feb 2023 08:23:33 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bp15so22987750lfb.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Feb 2023 08:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4RM6pXDqOiFHeAx0WMmnhom/Qz888Ih/TPZU+Y9eyTk=;
        b=NsNlyZdX9FntXMmjVZZquGBbjRgyatHH8Ma3nbcSD5cdovFSmwk5DDBQ2fWraFPrwc
         yEbD3pAldW0OWp9nFmXL3+41yWEaP4WAJsgLpL/66YPcHbCxz4tea6LTrE8ieMPZUjLt
         m4B76mBx3QUIutr78aW0ASxIjNPwfvFPpHMSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RM6pXDqOiFHeAx0WMmnhom/Qz888Ih/TPZU+Y9eyTk=;
        b=ippoGiQSCcqPX5dinHWnmMRHcfu8vzgS7DbFSHDhlczqY7J8Rd2TvQRA6mJAqJ9j7P
         PzfKQQXis1Pwp3Y6qiO04F0/+PMtCa/EivBedNjCBM0w3BqAle1slF8WzNjmgAFV3TE4
         q00H8laVLhMebWRPTc/4BzhrqeRn2srWl6WVA5s1QFzwGdNy1MnnXlF6+rjAbJcKcBY4
         F90PJcOMAZKFMysTwc2ZcWwjpaXLUyX+copt1yVWy7XuWQp+w9aDtoSu37CoSt6Y3/jv
         u2OWRZWdVm+LUQAGa/+qzihEz+IE4hEcs1nOIqCGRnCqsWfKP4WUIXpsGILafGIhr1Ci
         aYqg==
X-Gm-Message-State: AO0yUKUUZaAXSXx7rYxAoIif84SDzeYVHLeY0Ea7iwMR1EARrzAHsrrW
        88NkW6hCtb3Iu/rCM7gYAvwe5uuOD+chDamxd8ibHw==
X-Google-Smtp-Source: AK7set/ov5lzH6F5a/dtiNqT5AdOQgWEvTaVji0NVqdUuolxZ7TYz77kIh7KeIvFlxrcl/knXfxEoQ==
X-Received: by 2002:a05:6512:3886:b0:4b5:4606:7ae3 with SMTP id n6-20020a056512388600b004b546067ae3mr823766lft.46.1675787011705;
        Tue, 07 Feb 2023 08:23:31 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id cf38-20020a056512282600b004a9b9ccfbe6sm1045112lfb.51.2023.02.07.08.23.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 08:23:31 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id b16so8389885ljr.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Feb 2023 08:23:31 -0800 (PST)
X-Received: by 2002:a17:906:4e46:b0:87a:7098:ca09 with SMTP id
 g6-20020a1709064e4600b0087a7098ca09mr874420ejw.78.1675786520751; Tue, 07 Feb
 2023 08:15:20 -0800 (PST)
MIME-Version: 1.0
References: <20230129060452.7380-1-zhanghongchen@loongson.cn>
 <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com>
 <Y+EjmnRqpLuBFPX1@bombadil.infradead.org> <4ffbb0c8-c5d0-73b3-7a4e-2da9a7b03669@inria.fr>
 <Y+Ja5SRs886CEz7a@kadam>
In-Reply-To: <Y+Ja5SRs886CEz7a@kadam>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Feb 2023 08:15:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg6ohuyrmLJYTfEpDbp2Jwnef54gkcpZ3-BYgy4C6UxRQ@mail.gmail.com>
Message-ID: <CAHk-=wg6ohuyrmLJYTfEpDbp2Jwnef54gkcpZ3-BYgy4C6UxRQ@mail.gmail.com>
Subject: Re: block: sleeping in atomic warnings
To:     Dan Carpenter <error27@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, Julia Lawall <julia.lawall@inria.fr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maobibo <maobibo@loongson.cn>,
        Matthew Wilcox <willy@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
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

On Tue, Feb 7, 2023 at 6:06 AM Dan Carpenter <error27@gmail.com> wrote:
>
> block/blk-crypto-profile.c:382 __blk_crypto_evict_key() warn: sleeping in atomic context
> block/blk-crypto-profile.c:390 __blk_crypto_evict_key() warn: sleeping in atomic context

Yeah, that looks very real, but doesn't really seem to be a block bug.

__put_super() has a big comment that it's called under the sb_lock
spinlock, so it's all in atomic context, but then:

> -> __put_super()
>    -> fscrypt_destroy_keyring()
>       -> fscrypt_put_master_key_activeref()
>          -> fscrypt_destroy_prepared_key()
>             -> fscrypt_destroy_inline_crypt_key()
>                -> blk_crypto_evict_key()

and we have a comment in __blk_crypto_evict_key() that it must be
called in "process context".

However, the *normal* unmount sequence does all the cleanup *before*
it gets sb_lock, and calls fscrypt_destroy_keyring() in process
context, which is probably why it never triggers in practice, because
the "last put" is normally there, not in __put_super.

Eric? Al?

It smells like __put_super() may need to do some parts delayed, not
under sb_lock.

              Linus
