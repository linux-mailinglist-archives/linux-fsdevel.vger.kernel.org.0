Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8610F6EDA46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 04:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjDYCm3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 22:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjDYCm1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 22:42:27 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EE149F8
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 19:42:26 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5066ce4f490so7781699a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 19:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682390545; x=1684982545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nopTUbVZ7u3O1SJHx/a+pOrc1wtXatQ+0xOyurfkVU=;
        b=WScUZfIMUBoko7QJwGLA7Ux4PSQJ1+BROaaB42J2oCtngVRuuFUrT8uzzpa5DbD519
         1rSU2XeED0BHTL68KfmxWX1FGzooZi3DU39RyKLw4v+HGtjEI5FQZ5IcIQByHKTm27Vw
         fwF3N1HID2EzHEm8w7FchBI5Z9UhgL+mnjupA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682390545; x=1684982545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nopTUbVZ7u3O1SJHx/a+pOrc1wtXatQ+0xOyurfkVU=;
        b=cNklv5cWkJ8I8QG8vtiMBYEKXFgGpoxZ0J7oRoFxFNN2qpTzR/ruj0zm/Cuj4OLbuR
         PlmVVEDRtSOZCeM5pFuWIp6z/rI2aREevpkKpenDPFYSh4N2tY9fB6wNhUhjd+5WV2sI
         PGWPtng9In4UVWCz6BdL/yuouG9DadLyvpEmhFdiaNC94uPEyjekeIn2CRRNWGgfWbMF
         aSYpOWMiHf2rQMFlokPT2jhBupNGbt6JCKgRCpx48hf3/b0+66jf/EarN5I/YWt8xcth
         T5soNpppcneiB4Ecx+EYDWWxHdt/BXLlJjeg+iALa2vM6MFV1nkhWaQdSTLzujCYDTHx
         5xeQ==
X-Gm-Message-State: AAQBX9c5vUfCG5UouwlyeaJJn/3td+5SOE9Qlqd0e943d6Pnkb9jsecQ
        wmoP8U5kd2XjR2Vp5wVJG6Jw0bkB9Cfu+H8Riu/xwA5e
X-Google-Smtp-Source: AKy350bP1v6IUgUuHBVjdTjbe0gKy6akeq/sdXlFZ2oa7rjf7TPcZvjOS509Hls8HmJYkfO2G0pw1A==
X-Received: by 2002:aa7:d7c5:0:b0:504:7d53:2148 with SMTP id e5-20020aa7d7c5000000b005047d532148mr12553127eds.30.1682390544705;
        Mon, 24 Apr 2023 19:42:24 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id s22-20020aa7cb16000000b00509e3053b66sm1572061edt.90.2023.04.24.19.42.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 19:42:24 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5066ce4f490so7781679a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 19:42:23 -0700 (PDT)
X-Received: by 2002:a05:6402:7c2:b0:508:4954:e30c with SMTP id
 u2-20020a05640207c200b005084954e30cmr14782354edy.11.1682390543388; Mon, 24
 Apr 2023 19:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230424042638.GJ3390869@ZenIV> <CAHk-=wibAWqh3JqWaWfi=JWNAz3v_qb7LZ+76qF+PKEJciHbGA@mail.gmail.com>
 <20230425023511.GO3390869@ZenIV>
In-Reply-To: <20230425023511.GO3390869@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Apr 2023 19:42:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=whTKF81MosfR2Y4fiR=WvKTRw-AODYzstkXD=TiizETdQ@mail.gmail.com>
Message-ID: <CAHk-=whTKF81MosfR2Y4fiR=WvKTRw-AODYzstkXD=TiizETdQ@mail.gmail.com>
Subject: Re: [git pull] the rest of write_one_page() series
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

On Mon, Apr 24, 2023 at 7:35=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> Point...  With this one it would be along the lines of "the parts of
> Christoph's write_one_page() elimination series that missed the previous
> merge window".

That would have been nice, but I've pulled then now (ok, nios one
still pending), and it all was small enough that I decided that the
"one-liner description" was barely ok.

Your suggested ones do sound much better, and I'm hoping to see
descriptions more like that in the future, ok?

             Linus
