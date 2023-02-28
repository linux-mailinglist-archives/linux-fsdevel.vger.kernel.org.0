Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843746A5FFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 20:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjB1TwH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 14:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjB1TwG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:52:06 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50D833441
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 11:51:57 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id f13so44803412edz.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 11:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677613915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CI4tO9SBnVHbpP1UFj/aIsZLnQqSb0KukHtZDEVF+9Q=;
        b=EGqXWGb6FO9oqjBg/RjdN/86icRC1mPJ3oftK9FFQmtW1fgTuj/zmUleWUKUiXp25b
         c6AlQmcV0atsC/y67K5zu2wXxvzhbGCaOD7syFHQ9VXJzRYz6NH2pn9up0dOx+dWjEbu
         VnxtlH/hlKeQ5BYQrPpt5FLATZFI06UDFf424=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677613915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CI4tO9SBnVHbpP1UFj/aIsZLnQqSb0KukHtZDEVF+9Q=;
        b=E3T840scMm4UIaBM3D3dfcbqMKFWlhR9ro/UqmYbrXNJPdKuXq9AX6hfXVuimcTYDM
         GYcMCWF9gVrBoUGwcE8yhcg5Mz9Cxt7DUpNFaszwil4duqDHSun99TxVGa0rPmth5V8Y
         iEZLMW6Yr9ohkPZ53SlQePSdoPDZ1RtYnt7cHAbYtRkfC2dbVHcHnv6O4xuRM673slRu
         eLl868b3MFJ9ryz1L6r+Rfs+IwujmQG95a0qKSsYmHy3ltXV0H+AZ1BPBCrHYlHsPXTf
         MLH6uTfXCz4rEYLjvDyNGk5UvdX51voZqRxTLsI9AIXrYnyS2yxxN8xY43ydEpMm/PnP
         aPJA==
X-Gm-Message-State: AO0yUKXSkt5o+eMHftVU9L/bhOPK9OTDST6RNuZTM7neCQ4YSgGmWFjE
        g3q8uVrDgqCNWifnP9qozx8iyWDoJUq6oPo9tFg=
X-Google-Smtp-Source: AK7set/515ghHpksBJw4SxMZjLOLJnxH9+AoIBYGoQ614M5W4/q5nW5zS0Pf0xkpKx0gNT0U2F4iJA==
X-Received: by 2002:a17:907:c207:b0:8f6:dc49:337f with SMTP id ti7-20020a170907c20700b008f6dc49337fmr5523166ejc.43.1677613915661;
        Tue, 28 Feb 2023 11:51:55 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id w23-20020a17090649d700b008b17fe9ac6csm4864664ejv.178.2023.02.28.11.51.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 11:51:54 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id o15so42297105edr.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 11:51:54 -0800 (PST)
X-Received: by 2002:a17:906:c08c:b0:8f1:4cc5:f14c with SMTP id
 f12-20020a170906c08c00b008f14cc5f14cmr1947231ejz.0.1677613914258; Tue, 28 Feb
 2023 11:51:54 -0800 (PST)
MIME-Version: 1.0
References: <20230125155557.37816-1-mjguzik@gmail.com> <CAHk-=wjz8O4XX=Mg6cv5Rq9w9877Xd4DCz5jk0onVKLnzzaPTA@mail.gmail.com>
 <97465c08-7b6e-7fd7-488d-0f677ac22f81@schaufler-ca.com> <CAGudoHEV_aNymUq6v9Trn_ZRU45TL12AVXqQeV2kA90FuawxiQ@mail.gmail.com>
 <CAHk-=wgCMTUV=5aE-V8WjxuCME8LTBh-8k5XTPKz6oRXJ_sgTg@mail.gmail.com>
In-Reply-To: <CAHk-=wgCMTUV=5aE-V8WjxuCME8LTBh-8k5XTPKz6oRXJ_sgTg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Feb 2023 11:51:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjrQ_+PCrdNRWKsmf=SZP45_N7r51NbbB55DUdGb5f76A@mail.gmail.com>
Message-ID: <CAHk-=wjrQ_+PCrdNRWKsmf=SZP45_N7r51NbbB55DUdGb5f76A@mail.gmail.com>
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

On Tue, Feb 28, 2023 at 11:39=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This actually looks sane enough that I might even boot it. Call me crazy.

Oh, and while I haven't actually booted it or tested it in any way, I
did verify that it changes

-       movq    48(%rbx), %rax
-       movq    56(%rbx), %rcx
-       cmpl    %eax, %ecx
-       jne     .LBB58_13
-       shrq    $32, %rax
-       shrq    $32, %rcx
-       cmpl    %eax, %ecx
-       jne     .LBB58_13

into

+       movq    56(%rbx), %rax
+       cmpq    48(%rbx), %rax
+       jne     .LBB58_12

because it looks like clang was smart enough to unroll the silly
fixed-size loop and do the two adjacent 32-bit loads of the old cap[]
array as one 64-bit load, but then was _not_ smart enough to combine
the two 32-bit compares into one 64-bit one.

And gcc didn't do the load optimization (which is questionable since
it then just results in extra shifts and extra registers), so it just
kept it as two 32-bit loads and compares. Again, with the patch, gcc
obviously does the sane "one 64-bit load, one 64-bit compare" too.

There's a lot to be said for compiler optimizations fixing up silly
source code, but I personally would just prefer to make the source
code DTRT.

Could the compiler have been even smarter and generated the same code?
Yes it could. We shouldn't expect that, though. Particularly when the
sane code is much more legible to humans too.

                 Linus
