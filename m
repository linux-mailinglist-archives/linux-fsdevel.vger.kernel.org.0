Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C5F6ED6D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 23:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjDXViC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 17:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjDXVh6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:37:58 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27864ED5
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 14:37:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5050491cb04so7508964a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 14:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1682372276; x=1684964276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrwnaZWjXEThBGNt6dinryO7jmM1jZWEW+zc57nY1i0=;
        b=hJEf8qnZAJH0YavQOr1k+4TatBQtemLQQ/JVE9u3UeRJTULjmmv8a8WCEdnHUZLApC
         79o7t4xKlBb0vMdew4ZQd6dDyrezu1IfscSbi8y8Gx5Y/wl5LZ0HLzZtw/Ur74hpISCe
         1aCyV+9aym0ZkVQ8DljKg/dYl3V2UXAK8Azp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682372276; x=1684964276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrwnaZWjXEThBGNt6dinryO7jmM1jZWEW+zc57nY1i0=;
        b=Dwrzyy4fsh6DiYawEZf9M1jWhnqZc1yniOASydtZbQbThbw2q8AKZ1t3LjUS5eTpTh
         1zNFcMO+evq1v0bBBUzO94D5XctQ5znKidpDi2Z5QyO4kKwPV5Vpvb+POTbgprrffWOB
         Om1EEXij8oywzYVJ7J6ENE/84MpYTN6k9qQiontePjLHwQSxFvaeMg9Iq2P3z/zpem0Q
         VJ1idIi6D9FM/57COkj8rM0B9BnKO6gepC+INw+RIt+FeHwIQiOZnYnAY4vTbhwxs6NV
         czxMNLRFyUmkHfcRVoCScNNtzZXbv0NRqv3rkMszPpGQkjgXveVlYlSoKpejKDQF9rTs
         DIdQ==
X-Gm-Message-State: AAQBX9d2AS2I44FIurcoeTnQoe65UYF+xXSBtK7wi1tTpuWffuz2hkqw
        4DBHwd7WH65knb6QjxEuqydll0JYATsVk2q5h1mlv6xE
X-Google-Smtp-Source: AKy350aVyJevhPauXEgrC7ixySoDos827k9PO6UlXgbj9/U0B/aq1yy5zlbb1XSFtLr0SPMMOLoJag==
X-Received: by 2002:a50:fa8e:0:b0:506:85d1:35c1 with SMTP id w14-20020a50fa8e000000b0050685d135c1mr13084905edr.29.1682372275818;
        Mon, 24 Apr 2023 14:37:55 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id w14-20020a50fa8e000000b004aeeb476c5bsm5006912edr.24.2023.04.24.14.37.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 14:37:55 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-94f910ea993so731754666b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 14:37:54 -0700 (PDT)
X-Received: by 2002:a17:906:dc8b:b0:953:8322:a99f with SMTP id
 cs11-20020a170906dc8b00b009538322a99fmr15462944ejc.0.1682372274606; Mon, 24
 Apr 2023 14:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230421-seilbahn-vorpreschen-bd73ac3c88d7@brauner>
 <CAHk-=wgyL9OujQ72er7oXt_VsMeno4bMKCTydBT1WSaagZ_5CA@mail.gmail.com> <6882b74e-874a-c116-62ac-564104c5ad34@kernel.dk>
In-Reply-To: <6882b74e-874a-c116-62ac-564104c5ad34@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Apr 2023 14:37:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQ8g+B0bCPJ9fxZ+Oa0LPAUAyryw9i+-fBUe72LoA+QQ@mail.gmail.com>
Message-ID: <CAHk-=wiQ8g+B0bCPJ9fxZ+Oa0LPAUAyryw9i+-fBUe72LoA+QQ@mail.gmail.com>
Subject: Re: [GIT PULL] pipe: nonblocking rw for io_uring
To:     Jens Axboe <axboe@kernel.dk>
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

On Mon, Apr 24, 2023 at 2:22=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> If we don't ever wait for IO with the pipe lock held, then we can skip
> the conditional locking. But with splice, that's not at all the case! We
> most certainly wait for IO there with the pipe lock held.

I think that then needs to just be fixed.

I really think that trylock due to "nonblocking" IO is fundamentally
wrong. Thinking that you need it is just a sign of something else
being very wrong.

That "very wrong" thing might well be splice then not honoring
non-blocking IO on a non-blocking pipe.

And I completely refuse to add that trylock hack to paper that over.
The pipe lock is *not* meant for IO.

             Linus
