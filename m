Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562706CF3F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 22:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjC2UAQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 16:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjC2UAH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:00:07 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8D47A8F
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 12:59:54 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eh3so67881320edb.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 12:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680119992; x=1682711992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GG5OJsG+n1Kii6yB3SnHTXIj/fg26fKlfTqQKHiFOLM=;
        b=A3lY5BakbIv/bVVP/64Qf/I20vC18EH4PjcieMeRcSDtg9NeRDa3KypaeSGYG/5dXa
         hFNb0yedYcSEUzyzsGVL3hrOb1H/JD/YR9txdSGfUU0A1phP3aD0o3JkvhmlGfwfK1rS
         5Ky/dlvKba4qkXjEl0ATp3N3YIjq0sfiKeJ9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680119992; x=1682711992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GG5OJsG+n1Kii6yB3SnHTXIj/fg26fKlfTqQKHiFOLM=;
        b=kOzyUWa/aZiQHEEv+dLrASWzK5gsKmhunuCER/2I1zjAxt0exSvRP5DX0E9eOgpbuU
         aLzwCG+BkxXdTMVIK7CVfNQRVWxKvO6EAcW4Zz3RZa95E8r6oqn6uESn2D6/4G6t1dUS
         1ChB9rW/VnQmo87JIt11JMrm85+uRtF9zJpqLV0jxSNbtfvQRjJGK8OnmsYu7VrnkILx
         W8y2JZCPlPBY67G1NMplCJH5ab7uGx0dxB7eSGYEPUAf3o4nxtu4kaQgAm1cbAl3Oeom
         Pur/dbITRLY/KziSq7c9hM5bVjDsPU777Tl6k0Q5foEEu+4HDjtPn+8o25zf/jkTpbDJ
         fgKQ==
X-Gm-Message-State: AAQBX9eQ+peKyJALI2BligeA/tyri8G3r/z4BhFtE/5bppTqrmUy/m4d
        zmI/sfXy05OdDp9q14TE7dMNQYgxdT14PYYO8dzoK3sB
X-Google-Smtp-Source: AKy350a3dLYUgZIUu/2yQ21hF5TrYCVsEDeTfYAS3Fjyi+VC8UfZGepzNHpk1muW3q58pScH0dr78Q==
X-Received: by 2002:a17:906:4786:b0:946:a1c8:e000 with SMTP id cw6-20020a170906478600b00946a1c8e000mr9976829ejc.44.1680119992403;
        Wed, 29 Mar 2023 12:59:52 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id v12-20020a17090610cc00b008f767c69421sm16714595ejv.44.2023.03.29.12.59.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 12:59:51 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id t10so67810071edd.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 12:59:51 -0700 (PDT)
X-Received: by 2002:a17:907:9870:b0:8b1:28f6:8ab3 with SMTP id
 ko16-20020a170907987000b008b128f68ab3mr10940316ejc.15.1680119991316; Wed, 29
 Mar 2023 12:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230329184055.1307648-1-axboe@kernel.dk> <20230329184055.1307648-7-axboe@kernel.dk>
 <CAHk-=wg2q64+WLKE+0+UNeZav=LjXJZx2gHJ5NR3_5LxvQC8Mg@mail.gmail.com>
 <554cd099-aa7f-361a-2397-515f7a9f7191@kernel.dk> <a0911019-9eb9-bf2a-783d-fe5b5d8a9ec0@kernel.dk>
 <f12452c7-0bab-3b5d-024c-6ab76672068f@kernel.dk> <CAHk-=wg4J1+Ses2rY0xBhWxyfTDNW+H_ujpcwngKG5tp0y_Fxw@mail.gmail.com>
 <3274c95f-b102-139d-0688-be688d799c20@kernel.dk>
In-Reply-To: <3274c95f-b102-139d-0688-be688d799c20@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Mar 2023 12:59:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjMWpR6y34Rk92O31NFEOaZPuMb9DxwKThvFF-CE+vA8Q@mail.gmail.com>
Message-ID: <CAHk-=wjMWpR6y34Rk92O31NFEOaZPuMb9DxwKThvFF-CE+vA8Q@mail.gmail.com>
Subject: Re: [PATCH 06/11] iov_iter: overlay struct iovec and ubuf/len
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 29, 2023 at 12:56=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> Nope, still fails with it moved below.

Ouch. I guess the 'const' cast may be the only way then.  It sounds
like gcc may warn whenever it sees an assignment to any structure that
has a const member, rather than when it sees an assignment to that
particular member.

Sad.

           Linus
