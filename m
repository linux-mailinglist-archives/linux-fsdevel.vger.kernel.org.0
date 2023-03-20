Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FB86C24C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 23:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjCTWbl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 18:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjCTWbj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:31:39 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8F128E68
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 15:31:32 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id cn12so7168203edb.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 15:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679351491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAGlFJqYmzMpi4y5YSD63yoKu9/i/gsYoJLo98dDpYM=;
        b=H5TVtg/3LzAcq64snwXsy7VefCIII3gMvSBifldyIZdNKh2asrD7t6Nt4Qh9RAAIN4
         sM3WpgH6gUTn/4BK2w/IufDFw9EME4pIEE0VcJfLYvAv0MlBXAZzb0TB3MF9MQeTjmY0
         nRlFGAjPfsE0h0PANnuVAn9iu+9cVAhzryiuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679351491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAGlFJqYmzMpi4y5YSD63yoKu9/i/gsYoJLo98dDpYM=;
        b=tttI3mWyvzXclZWayYHhjwL4oYt6aMyTNj0aoTC5envQPMWukZ8RiJ47SXiVvbiiSw
         8pQxsDHuFmslBa6RSilwI18ivTEvhJPzAqbByGG/+xhs8xAJrkS6TscTi+XuGwDMCsH9
         kJm05vhz2DwXNejCJLoFQ88GOJ55eaaPSbvoAEy8wu2fw/A61YGG+2YK/CV2fi1HJmsB
         S5q4kixd2HnZUIc3hynFshWRguhW5lB+pdEsK3qublm9SB7jS1In8SO0iiXHJ2PiPx2w
         r6rQmxd5WIdlzvnp0nLWa+wVrZjdhQKUh16NxMsG1gCrxxSy5qbzcNOlIt9EnFv7MJtV
         lP3w==
X-Gm-Message-State: AO0yUKV+Xgo7FifdJLRRwvnDt1eUyxAds5E/2NbiLi+WMP7u33Eq6ZmG
        xop1bGjjmx1OeO20Z00dGJU3CsZkXx9aq7xCO3g6zMHI
X-Google-Smtp-Source: AK7set/1Uq9Rio60MPK5Sxglut85veiII1Fhh3DVX24H7N4BsX/tuPvH/00kAvai0ANQoPFnx/vJdA==
X-Received: by 2002:aa7:c142:0:b0:4fc:535c:3aa1 with SMTP id r2-20020aa7c142000000b004fc535c3aa1mr1283047edp.10.1679351490957;
        Mon, 20 Mar 2023 15:31:30 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id u3-20020a50d503000000b004fcd78d1215sm5526157edi.36.2023.03.20.15.31.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 15:31:30 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id eh3so52752794edb.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 15:31:30 -0700 (PDT)
X-Received: by 2002:a17:906:34cd:b0:8e5:411d:4d09 with SMTP id
 h13-20020a17090634cd00b008e5411d4d09mr293646ejb.15.1679351489808; Mon, 20 Mar
 2023 15:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230320210724.GB1434@sol.localdomain>
In-Reply-To: <20230320210724.GB1434@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Mar 2023 15:31:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgE9kORADrDJ4nEsHHLirqPCZ1tGaEPAZejHdZ03qCOGg@mail.gmail.com>
Message-ID: <CAHk-=wgE9kORADrDJ4nEsHHLirqPCZ1tGaEPAZejHdZ03qCOGg@mail.gmail.com>
Subject: Re: [GIT PULL] fsverity fixes for v6.3-rc4
To:     Eric Biggers <ebiggers@kernel.org>, Tejun Heo <tj@kernel.org>
Cc:     fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Nathan Huckleberry <nhuck@google.com>,
        Victor Hsieh <victorhsieh@google.com>
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

On Mon, Mar 20, 2023 at 2:07=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> Nathan Huckleberry (1):
>       fsverity: Remove WQ_UNBOUND from fsverity read workqueue

There's a *lot* of other WQ_UNBOUND users. If it performs that badly,
maybe there is something wrong with the workqueue code.

Should people be warned to not use WQ_UNBOUND - or is there something
very special about fsverity?

Added Tejun to the cc. With one of the main documented reasons for
WQ_UNBOUND being performance (both implicit "try to start execution of
work items as soon as possible") and explicit ("CPU intensive
workloads which can be better managed by the system scheduler"), maybe
it's time to reconsider?

WQ_UNBOUND adds a fair amount of complexity and special cases to the
workqueues, and this is now the second "let's remove it because it's
hurting things in a big way".

              Linus
