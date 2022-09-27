Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DDA5EC8F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 18:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbiI0QD4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 12:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbiI0QDS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:03:18 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C691C4320;
        Tue, 27 Sep 2022 09:02:07 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id b23so8120504iof.2;
        Tue, 27 Sep 2022 09:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ct18v3QfbaOt7CsF6ErcYqFs3nH5VotKpLqZ78HARmQ=;
        b=no1GeN48oclNXpvXOcJ3XM42s7G74QAfuxJUP2w9C5cuLEt1LA2InXaLu4/g7vE3Ah
         S/Mc2c6zxeOHl3MQFolYrdx35TehZqB+m2XkqpnZHNqrwi5umGImsOgRLLDhEMmJ6ix5
         qeuIUdoylQJ7AptS4+1rEN42XUXKncRc/qyo1TFhi6Q0KDwdAtuC5XFm02IRz9f+iAcx
         sEw/LaTx83SSMgttZk7rB8ivAe4XALo445n5UqTrJu3tSHxpkqdJOl5W6Zc+DO1pRwIo
         j2fZEMqxdCfiMO3AUliNZDWlSVzAxmAB9lJ4s9GqYvY0EH8pYHJ1JJ0Idmtjb+MQEjmv
         /mhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ct18v3QfbaOt7CsF6ErcYqFs3nH5VotKpLqZ78HARmQ=;
        b=z2UIMpPaueuEiTLuA1Ar10i85x2jLdjeMgTFceEvPQ3npAZB8XP3pL97HU9KJEy+yt
         Xh8OVj72N+wCM46RnJ2whBWPuNdK3uKhMbe3CULbbvP4doP/j4Fmnoa+kKBmGXyf+XEl
         p0+uiH387tDbLI2t6Sck1pZJvl60ngygq0dn6SLXujt8mNdwutj+d0SYOFjaYSLJgB0G
         Vs483npUUhwhxjJ78J9L9H4LeiaLvJeKk/KEnSxTELv8NZrm29iGresOlo7J6JBbxXT3
         TJk1blhFr6JKJFlG+hUWROF+gjwvd+HvINscI0bXxSas/JgwPMiRd12VGolvcG7g2qsA
         6OLA==
X-Gm-Message-State: ACrzQf1HUMDV6LMYmReMr0RiDHbPt48RKPAf16dH1NNYcyNB9T/8Z/FW
        roG8bIMQ4VHYUaBopiXqYxPYSAhRmfLFyQ9iJAo=
X-Google-Smtp-Source: AMsMyM5odjm/1/sK9Q4u52UeI71zmJgkTDOy0C5e+aZtCOyOTsfGQ3g+oQ5ZaDNDjzLaBsPSyP2gSi2I+7blmm5gF9c=
X-Received: by 2002:a05:6638:218f:b0:35a:7f20:6a57 with SMTP id
 s15-20020a056638218f00b0035a7f206a57mr14587401jaj.186.1664294526531; Tue, 27
 Sep 2022 09:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220927131518.30000-1-ojeda@kernel.org> <20220927131518.30000-9-ojeda@kernel.org>
 <YzL/9mlOHemaey2n@yadro.com> <CANiq72kDPMKd0qLAMVrd2A3n9aAWhh2ps5DvKos58L=_V2-XwQ@mail.gmail.com>
 <YzMTH1v9yZQcujLa@yadro.com>
In-Reply-To: <YzMTH1v9yZQcujLa@yadro.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 27 Sep 2022 18:01:55 +0200
Message-ID: <CANiq72nkiOsAkr4oeBi-ohf12-JjvkQmb67s-G1L87pBS+FEWA@mail.gmail.com>
Subject: Re: [PATCH v10 08/27] rust: adapt `alloc` crate to the kernel
To:     Konstantin Shelekhin <k.shelekhin@yadro.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Matthew Bakhtiari <dev@mtbk.me>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 5:13 PM Konstantin Shelekhin
<k.shelekhin@yadro.com> wrote:
>
> Sorry, my bad.

No apologies needed! Thanks for taking a look like in v8 and v9 :)

Cheers,
Miguel
