Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FDE774610
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 20:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjHHSwi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 14:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbjHHSwU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:52:20 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E735EA3B
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 10:05:42 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so9724753e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 10:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691514339; x=1692119139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1uNjCc9Bzcn7Dor1sdhjCXOwNWmVk+6MaO4ncMW1tgM=;
        b=gifu3hI3Y2Y1Hqj/X0HI3y5JgWHgfs81ZFYzlTJgFMo66Ka4YBt+qKw1/kWUd7NaT5
         3892R2r454SKdtdIaycq6gbtSmTvMl5F6NOC83SNvQglwYfBBPyXYF0GBCgmmXJyVSpl
         qEg0gZuD3KItQIaj5YpOiVxRj65+qkuXsDpsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514339; x=1692119139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1uNjCc9Bzcn7Dor1sdhjCXOwNWmVk+6MaO4ncMW1tgM=;
        b=jX3petHefmsYv1mTtF+PowFU6/rerLuz4WurQZfrSCoQbha813ZMIKWz973COTJyXq
         qWYztS5bAYtkouF+Pe++R3gsUqTtuKNbp8MGfyx01VMkUJTw0ENlx7jYVW8wHjUn2fOX
         9DguUy9RG16hKFf+rvyKppIiCZn7uFOC8FfBCBpDWvSbG+qrfenfG+NFh+9n60GpNizu
         Z8Lh556lnU8mowKe3n45QjrepoJB/S7EhC8HCnjI8QgSdb38k3xE2wRt41Utkv7JIiC3
         LjxNNhgcQKo/UwXsKquXPwoLJTi57zOxPGZa2AVWeXP0ss7eyj89ughZkUhKVyM2Ka/q
         quQg==
X-Gm-Message-State: AOJu0Yw7lAvNPoT19GftN+HBwde7Xo9rFdb9eGxj7Ub/VvxkxS4E7rNF
        iH+wJsPe7ghXUY/u1La8zxOTK5LugN1VPwquveLIWUCt
X-Google-Smtp-Source: AGHT+IFjwOZrlHtSaTNOWqXY514Njeb37ySxWor8XCzSXpISgxe3CrHFAq1mYtlWQv9wL1c0yNfgxQ==
X-Received: by 2002:a05:6512:4002:b0:4fe:2f8a:457e with SMTP id br2-20020a056512400200b004fe2f8a457emr79786lfb.43.1691514339090;
        Tue, 08 Aug 2023 10:05:39 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id e14-20020ac2546e000000b004fe4811d382sm1934764lfn.85.2023.08.08.10.05.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 10:05:38 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4fe1489ced6so9778668e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 10:05:38 -0700 (PDT)
X-Received: by 2002:ac2:54ba:0:b0:4fe:f24:cbf3 with SMTP id
 w26-20020ac254ba000000b004fe0f24cbf3mr47081lfk.63.1691514337785; Tue, 08 Aug
 2023 10:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230806230627.1394689-1-mjguzik@gmail.com> <87o7jidqlg.fsf@email.froward.int.ebiederm.org>
 <20230808-eingaben-lumpen-e3d227386e23@brauner> <CAGudoHF=cEvXy3v96dN_ruXHnPv33BA6fA+dCWCm-9L3xgMPNQ@mail.gmail.com>
 <20230808-unsensibel-scham-c61a71622ae7@brauner> <CAGudoHEQ6Tq=88VKqurypjHqOzfU2eBmPts4+H8C7iNu96MRKQ@mail.gmail.com>
 <CAGudoHGqRr_WNz86pmgK9Kmnwsox+_XXqqbp+rLW53e5t8higg@mail.gmail.com> <20230808-lebst-vorgibt-75c3010b4e54@brauner>
In-Reply-To: <20230808-lebst-vorgibt-75c3010b4e54@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Aug 2023 10:05:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiyeMKrvU5GdjekSF65KS=i3hKzfJ1qe2Xja42K+qOd2w@mail.gmail.com>
Message-ID: <CAHk-=wiyeMKrvU5GdjekSF65KS=i3hKzfJ1qe2Xja42K+qOd2w@mail.gmail.com>
Subject: Re: [PATCH v2 (kindof)] fs: use __fput_sync in close(2)
To:     Christian Brauner <brauner@kernel.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 8 Aug 2023 at 09:30, Christian Brauner <brauner@kernel.org> wrote:
>
> At least make this really dumb and obvious and keep the ugliness to
> internal.h and open.c

See the patch I just sent out.

I hate yours too, for that nasty "bool may_delay".

I hate those "bool flag" things that change behavior of a function. It
may be obvious when you look at the function itself, and know the
code, but then it causes things like this:

        return __filp_close(filp, id, true);

and there is zero clue about what the heck 'true' means.

At least then the "behavior flags" are named bitmasks, things make
*sense*. But we have too many of these boolean arguments.

And yes, I realize that we have tons of extant ones, and this would be
only one more in a sea of others. That doesn't make it ok. So please
keep it to when it *has* to be done to avoid major problems.

             Linus
