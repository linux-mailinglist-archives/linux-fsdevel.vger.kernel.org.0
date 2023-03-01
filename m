Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611386A7331
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 19:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjCASOG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 13:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjCASOF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:14:05 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7B442BD5
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Mar 2023 10:13:59 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id o15so54988079edr.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Mar 2023 10:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677694437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/asb3PYi302CsLXOXWpBQTKIfyQX2PG5Qj/oLUdH5k=;
        b=VcEiiaTfxPmiqwXoecvpahehdctu63BLGW4saFO/UrTcs1beWBHcWiztIw4qeMLbtN
         UDhVjdTYZ+U8fsUpZKjsT4dWBeA5xIObDM5vZ0oqdg6xFxGAE/ONB29DGc4bgwj08Yi/
         pe4O9bVEPFq8625OTiGntkymQ9EyiAsiFSpUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677694437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/asb3PYi302CsLXOXWpBQTKIfyQX2PG5Qj/oLUdH5k=;
        b=Rgm4LpzJb9GhfcBba6l62jx6K4u3ej8uOtfXWsYaMPKVC8IThpW46PFo1EpXf6U6Hm
         iQEKvCezJY0iwMCwnTQChRvGzASLYLvkfpHNjvRJO7EeATgJlK72HzSPulyorDWiVCm9
         ezu0Rk0AC6w8eNPIPE4gRjfxE6GEmD8ET/S9MjMlu3w/hGu46wdvBk6GPb0x6rYHTR1Y
         69FkS6RtrYhdf/alyrJcCNofhfx5zSYzS0MaDpjuNqdmny+p/uHoDWYe6Mxw4lzPKVrr
         yIwQL4hHqz+aMfeX7A+npnP6kGdVZzT4HzkBiJr35LzjjENJlN70SaDNBU7y74x6T78M
         2Owg==
X-Gm-Message-State: AO0yUKXu9UmmlXyZjkVbKAFkQEvwqwITyA0RUwgiRLZ+z2bKq3HQlvqW
        t032VbKhVFT1V6t9+wiwii1wJ4ELBoOJfGV8c7NiZg==
X-Google-Smtp-Source: AK7set8qze8W8r2FkuMrEXCQeR+B4towBGfA7FC+d0zKMpVvu5VDrLjIZ29YodGG9bTx4i0DhYHMVA==
X-Received: by 2002:aa7:c9d9:0:b0:4ab:1625:908d with SMTP id i25-20020aa7c9d9000000b004ab1625908dmr8249956edt.16.1677694437606;
        Wed, 01 Mar 2023 10:13:57 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id u7-20020a50d507000000b004af759bc79asm5964358edi.7.2023.03.01.10.13.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 10:13:57 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id ck15so57715882edb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Mar 2023 10:13:56 -0800 (PST)
X-Received: by 2002:a17:906:2ec8:b0:877:747e:f076 with SMTP id
 s8-20020a1709062ec800b00877747ef076mr3586877eji.0.1677694436076; Wed, 01 Mar
 2023 10:13:56 -0800 (PST)
MIME-Version: 1.0
References: <20230125155557.37816-1-mjguzik@gmail.com> <CAHk-=wjz8O4XX=Mg6cv5Rq9w9877Xd4DCz5jk0onVKLnzzaPTA@mail.gmail.com>
 <97465c08-7b6e-7fd7-488d-0f677ac22f81@schaufler-ca.com> <CAGudoHEV_aNymUq6v9Trn_ZRU45TL12AVXqQeV2kA90FuawxiQ@mail.gmail.com>
 <CAHk-=wgCMTUV=5aE-V8WjxuCME8LTBh-8k5XTPKz6oRXJ_sgTg@mail.gmail.com>
 <CAHk-=whwBb5Ws8x6aDV9u6CzMBQmsAtzF+UjWRnoe9xZxuW=qQ@mail.gmail.com>
 <CAGudoHH-u3KkwSsrSQPGKmhL9uke4HEL8U1Z+aU9etk9-PmdQQ@mail.gmail.com> <CAHk-=wgsVFvGrmbedVgpUjUJaRTMVxvGkr-dcR7s30S_MyDZfA@mail.gmail.com>
In-Reply-To: <CAHk-=wgsVFvGrmbedVgpUjUJaRTMVxvGkr-dcR7s30S_MyDZfA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Mar 2023 10:13:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=whmk3EnmFU6XbLjMZW_ZBU8UJGDEyua7m5Aa3pmgtVQRg@mail.gmail.com>
Message-ID: <CAHk-=whmk3EnmFU6XbLjMZW_ZBU8UJGDEyua7m5Aa3pmgtVQRg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] capability: add cap_isidentical
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Serge Hallyn <serge@hallyn.com>, viro@zeniv.linux.org.uk,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 28, 2023 at 1:29=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That said, the old code was worse. The only redeeming feature of the
> old code was that "nobody has touched it in ages", so it was at least
> stable.

Bah. I've walked through that patch something like ten times now, and
decided that there's no way it breaks anything. Famous last words.

It also means that I don't want to look at that ugly old code when I
have the fix for it all, so I just moved it over from my experimental
tree to the main tree, since it's still the merge window.

Quod licet Iovi, non licet bovi, or something.

                 Linus
