Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2E368E17A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 20:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjBGTt7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Feb 2023 14:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjBGTt4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:49:56 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838823E619
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Feb 2023 11:49:35 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j25so11152398wrc.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Feb 2023 11:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uEXUUXABVU5CpTmI5+WPS3SAiFl2iysjHXRNiSK+RSc=;
        b=NAsrX48xgJfvmnA63/xN8z3ZNZj9KxhAXx9sVPZSipkeGUbQZK47jEZLSxQAZsoKtm
         uQ+0JBwWNuQtqirsFeDAtYVMB9CkREBLzlQqNmAHL0HRnjhjNe2yZnNWhsT7bMRWJVeU
         +5n5j4hE+CqIu6Y+15dkIxcIqIZBV5aROnWdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEXUUXABVU5CpTmI5+WPS3SAiFl2iysjHXRNiSK+RSc=;
        b=2/EXBlYwBzH5YKBbY68xKLXeuND4XDd5kr+nOVxRfTKiGWC11VOtXznK7iZjy2lfe2
         +XyuaEwJesB/90hLxd+nIdwFWCbRRzFDnCXbnCfrDA4IAQwR7AeGKR+dPtBbX5sCijWr
         2RfY7Shc63NghUi9GvemGCsJwhzN/c7f2o9EOYfl59w4Y4LiSvbcBDJIhRAttyvq+Pmm
         VwiJMXoswZgvXSQENulI4s3+Q7yyhM3LZ8HdfZT7b2vLA9X2+sVlfg7u/tHdnx4tnOox
         nXBTTB9ki+qBfpu/R/QXj+7xrNQi4t9oSAhC0Edgp042uhh7lsmn4zAvSkVMl/WkEPGl
         NkHQ==
X-Gm-Message-State: AO0yUKU058Ac8bpnhv2iNoLfMJOzgtahheINMNrSAUbB+mfGoW7qzlJH
        iXmVipHurW1UZ+GL95k1LS5bVzMvd2raQWJFpmOj3w==
X-Google-Smtp-Source: AK7set/PgaVsfoxoSgOtuSbVPgVwdm3nKgKOK9c/ABEZSwRjJVGvoJAtWG229XfJGFxGTQSXT412Aw==
X-Received: by 2002:a5d:595f:0:b0:2c3:ddd2:f74c with SMTP id e31-20020a5d595f000000b002c3ddd2f74cmr3850121wri.49.1675799373684;
        Tue, 07 Feb 2023 11:49:33 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id r17-20020adfce91000000b002c3f210e8c0sm2760676wrn.19.2023.02.07.11.49.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 11:49:32 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id gr7so45474214ejb.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Feb 2023 11:49:32 -0800 (PST)
X-Received: by 2002:a17:906:4e46:b0:87a:7098:ca09 with SMTP id
 g6-20020a1709064e4600b0087a7098ca09mr1026268ejw.78.1675799372087; Tue, 07 Feb
 2023 11:49:32 -0800 (PST)
MIME-Version: 1.0
References: <20230129060452.7380-1-zhanghongchen@loongson.cn>
 <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com>
 <Y+EjmnRqpLuBFPX1@bombadil.infradead.org> <4ffbb0c8-c5d0-73b3-7a4e-2da9a7b03669@inria.fr>
 <Y+Ja5SRs886CEz7a@kadam> <CAHk-=wg6ohuyrmLJYTfEpDbp2Jwnef54gkcpZ3-BYgy4C6UxRQ@mail.gmail.com>
 <Y+KP/fAQjawSofL1@gmail.com> <CAHk-=wgmZDqCOynfiH4NFoL50f4+yUjxjp0sCaWS=xUmy731CQ@mail.gmail.com>
 <Y+KaGenaX0lwSy9G@gmail.com> <CAHk-=whL+9An7TP-4vCyZUKP_2bZSLe-ZFR1pGA1DbkrTRLyeQ@mail.gmail.com>
 <Y+KoGikLhfhDoMWv@gmail.com>
In-Reply-To: <Y+KoGikLhfhDoMWv@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Feb 2023 11:49:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=whdCBPH0WYK-D5q60u1hvwTabKETWTsEKYXNRgx4tGOPA@mail.gmail.com>
Message-ID: <CAHk-=whdCBPH0WYK-D5q60u1hvwTabKETWTsEKYXNRgx4tGOPA@mail.gmail.com>
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

On Tue, Feb 7, 2023 at 11:35 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> The point of the "test_dummy_encryption" mount option is that you can just add
> it to the mount options and run existing tests, such as a full run of xfstests,
> and test all the encrypted I/O paths that way.  Which is extremely useful; it
> wouldn't really be possible to properly test the encryption feature without it.

Yes, I see how useful that is, but:

> Now, it's possible that "the kernel automatically adds the key for
> test_dummy_encryption" could be implemented a bit differently.  It maybe could
> be done at the last minute, when the key is being looked for due to a user
> filesystem operation, instead of during the mount itself.

Yeah, that sounds like it would be the right solution, and get rid of
the fscrypt_destroy_keyring() case in __put_super().

Hmm.

I guess the filesystem only ever sees the '->get_tree()' call, and
then never gets any "this mount succeeded" callback.

And we do have at least that

        error = security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
        if (unlikely(error)) {
                fc_drop_locked(fc);
                return error;
        }

error case that does fc_drop_locked() -> deactivate_locked_super() ->
put_super().

Hmm. It does get "kill_sb()", if that happens, so if

 (a) the filesystem registers the keys late only in the success case

and

 (b) ->kill_sb() does the fscrypt_destroy_keyring(s)

then I *think* everything would be fine, and put_super() doesn't need to do it.

Or am I missing some case?

                Linus
