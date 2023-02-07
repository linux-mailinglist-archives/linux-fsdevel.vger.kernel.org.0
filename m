Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589A268E0A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 19:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjBGS5b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Feb 2023 13:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBGS5a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:57:30 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68E72331E
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Feb 2023 10:57:28 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id u22so528017ejj.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Feb 2023 10:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UBj6mQus6ryOdHxfJUZE61s4ML7ZKSWKaLSWveVYJ8E=;
        b=DtNvCWwPk8FH+RYNhBkyQ+Ieu1H5KuuVGuFo/51V0G4ysuENTf6Oy9VDbDfVyTQhgM
         e1rJDpJuuqvXg24gmansVexLblPeFPM51zzzfIfCzAx3iUalOso3rSSzQ4z3UYIFJQCo
         FPSVrTcgjVEGTlcAJYhZkiTl+nCb1pTyZxpOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UBj6mQus6ryOdHxfJUZE61s4ML7ZKSWKaLSWveVYJ8E=;
        b=LsBo1s+gUe7nK/lb+045K8/veXgMUfVmCngfyyfu0K+1fjB1B5Ldc7aridF3uMk1GA
         1HcpQ+OW3U6sIEVAMzgyKczRcqagLy5G5LJ2qYvhJszS/QglCqb0s8/fpudDxod1K9qA
         MlYIu6uOnMVFMD+S5ZoDJQaIFMpH1H4tCQzQ/HpC7KQFY+dxxVpgjDMbqt7mtXH22yf5
         KFP54xTbSZZOWORiTL08+Ke23Vm4gHdwcW39fPwl/bfJQXLQz7Ez7mbxe6ImBCiWn12D
         Yq5a+5kG1XHARZquNcRjZggsJe43k/Tvxg/d2qgR+W9DkrFqXs9vv/C/GxPA39STwOs8
         EOsw==
X-Gm-Message-State: AO0yUKVrDOkt1QhipzqCWBdi8tqGvmTYBb9kiSfjJifuSIOGijxfPDcv
        8gYKd/cHiGuiFxnedZIv8+DGxkQhGsc77giM/QJs+A==
X-Google-Smtp-Source: AK7set9jxiA8nm1NVkfthCiKz7/I0lz+mf7vEm3aXaZb5cBN86kciOkhdUrh6K1gGGUpw+nlBbpoFg==
X-Received: by 2002:a17:906:32cc:b0:8a4:7f5d:c000 with SMTP id k12-20020a17090632cc00b008a47f5dc000mr4819982ejk.64.1675796247169;
        Tue, 07 Feb 2023 10:57:27 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id y14-20020a170906448e00b008787becf3a8sm7244102ejo.79.2023.02.07.10.57.26
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 10:57:26 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id q19so17392661edd.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Feb 2023 10:57:26 -0800 (PST)
X-Received: by 2002:a50:9fa8:0:b0:49d:ec5d:28af with SMTP id
 c37-20020a509fa8000000b0049dec5d28afmr946530edf.5.1675796246043; Tue, 07 Feb
 2023 10:57:26 -0800 (PST)
MIME-Version: 1.0
References: <20230129060452.7380-1-zhanghongchen@loongson.cn>
 <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com>
 <Y+EjmnRqpLuBFPX1@bombadil.infradead.org> <4ffbb0c8-c5d0-73b3-7a4e-2da9a7b03669@inria.fr>
 <Y+Ja5SRs886CEz7a@kadam> <CAHk-=wg6ohuyrmLJYTfEpDbp2Jwnef54gkcpZ3-BYgy4C6UxRQ@mail.gmail.com>
 <Y+KP/fAQjawSofL1@gmail.com> <CAHk-=wgmZDqCOynfiH4NFoL50f4+yUjxjp0sCaWS=xUmy731CQ@mail.gmail.com>
 <Y+KaGenaX0lwSy9G@gmail.com>
In-Reply-To: <Y+KaGenaX0lwSy9G@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Feb 2023 10:57:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=whL+9An7TP-4vCyZUKP_2bZSLe-ZFR1pGA1DbkrTRLyeQ@mail.gmail.com>
Message-ID: <CAHk-=whL+9An7TP-4vCyZUKP_2bZSLe-ZFR1pGA1DbkrTRLyeQ@mail.gmail.com>
Subject: Re: block: sleeping in atomic warnings
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Dan Carpenter <error27@gmail.com>, linux-block@vger.kernel.org,
        Julia Lawall <julia.lawall@inria.fr>,
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

On Tue, Feb 7, 2023 at 10:36 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Also note that keys are normally added using an ioctl, which can only be
> executed after the filesystem was mounted.  The only exception is the key
> associated with the "test_dummy_encryption" mount option.

Could we perhaps then replace the

                fscrypt_destroy_keyring(s);

with a more specific

                fscrypt_destroy_dummy_keyring(s);

thing, that would only handle the dummy encryption case?

Ot could we just *fix* the dummy encryption test to actually work like
real encryption cases, so that it doesn't have this bogus case?


> By the way, the following code is in generic_shutdown_super(), and not in
> __put_super(), for a very similar reason:

Well, but that isn't a problem, exactly because that code isn't in
__put_super().

Put another way: the problem with the dummy encryption appears to be
exactly that it doesn't actually act like any real encryption would,
and then triggers that "this whole sequence gets called even under the
spinlock, even though it's documented to not be valid for that case,
because we added a bogus test-case that doesn't actually match
reality".

Looking at Jens' reply to the other cases, Dan's tool seems to be on
the money here except for this self-inflicted bogus crypto key thing.

                     Linus
