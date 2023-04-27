Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798D26F0826
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 17:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244052AbjD0PWK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 11:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243741AbjD0PWI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:22:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BD84EF4
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Apr 2023 08:21:54 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-959a3e2dd27so1007572066b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Apr 2023 08:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682608912; x=1685200912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwewOZK7JBxGabnXdHhR1rBDIN8G0aMcI1DZlXZ+li0=;
        b=g2A6QM0BDUoUqE0IeGiIMb66AZcDuDEzbh8NnUSrTk9Y4Jqq2BZ4N2rqALEc9qWHkc
         UO4dT6+2nZLmN0BpS5GOp0cQf1DwuKFIyY8US3/JZG5N3sIcGzXqXDTAO9GYPqZP2n0e
         QHKKaRSyBJoMUgMstqZnPa5+w6oUXLX4GsjpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682608912; x=1685200912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwewOZK7JBxGabnXdHhR1rBDIN8G0aMcI1DZlXZ+li0=;
        b=EnsPpao8JU3Lax1aDfbfSnNQ4NzaIynLYzYjF4SrWr8vKKZe1PHw4ppp+tjk2npCKl
         QJhN/BsZcFlT7JpvcveaR7VYHWffUmHjOV5ytuhviyPc9jIOIV2TRe9LeBgcSMMiJBxs
         MEKyRMLj5aEE0Og54rsN5dsLobzCX9Uv9Q1nEZQycTB5IEM7qO+Nj1UCEaZXOIr/xIfC
         uUz03V7jhmFeij3kUcjQ0X03kyVLn5OI98wUTDtpHcy8Tnn/w4ZIG3VCzgfNIEOEtWhB
         eTYVLJff3e9b0OgGRSLM6sUhElDszTy6ZF1llxYqpaVdLAtwwGIBoslYJ+mms3k+lNys
         AcPQ==
X-Gm-Message-State: AC+VfDyX5J8phMdvgyEuFfKyjsD2P37Gz7YlGgdaQO7Wfcwk2Oa3MIhP
        6E//ZaWcOV5O+hJb8igmS0p6eJ3IV0jwNK7jt/qRSw==
X-Google-Smtp-Source: ACHHUZ54LMtm7ppDPuQtQPaYpU0nkHSVwqaf1hq0SibDoNASRD+c0VOapJ4OFXvZZ2JUyxckx1/C1Q==
X-Received: by 2002:a17:906:dac8:b0:94f:123:fb83 with SMTP id xi8-20020a170906dac800b0094f0123fb83mr1864241ejb.73.1682608912558;
        Thu, 27 Apr 2023 08:21:52 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id z15-20020aa7cf8f000000b005067d6b06efsm7954480edx.17.2023.04.27.08.21.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 08:21:52 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-506b2a08877so14982523a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Apr 2023 08:21:51 -0700 (PDT)
X-Received: by 2002:aa7:d407:0:b0:506:c2b2:72fc with SMTP id
 z7-20020aa7d407000000b00506c2b272fcmr1606707edq.7.1682608911570; Thu, 27 Apr
 2023 08:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
 <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
 <20230425060427.GP3390869@ZenIV> <20230425-sturheit-jungautor-97d92d7861e2@brauner>
 <20230427010715.GX3390869@ZenIV> <20230427073908.GA3390869@ZenIV>
In-Reply-To: <20230427073908.GA3390869@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Apr 2023 08:21:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=whHbXMF142EGVu4=8bi8=JdexBL--d5FK4gx=x+SUgyaQ@mail.gmail.com>
Message-ID: <CAHk-=whHbXMF142EGVu4=8bi8=JdexBL--d5FK4gx=x+SUgyaQ@mail.gmail.com>
Subject: Re: [GIT PULL] pidfd updates
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 27, 2023 at 12:39=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> int delayed_dup(struct file *file, unsigned flags)

Ok, this is strange. Let me think about it.

But even without thinking about it, this part I hate:

>         struct delayed_dup *p =3D kmalloc(sizeof(struct delayed_dup), GFP=
_KERNEL);

Sure, if this is only used in unimportant code where performance
doesn't matter, doing a kmalloc is fine.

But if that is the only use, I think this is too subtle an interface.

Could we instead limit it to "we only have one pending delayed dup",
and make this all be more like the restart-block thing, and be part of
struct task_struct?

I think it's conceptually quite similar to restart_block, ie a "some
pending system call state" thing.

(Obviously it's entirely different in details).

          Linus
