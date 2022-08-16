Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E685962C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 20:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbiHPS65 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 14:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbiHPS64 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:58:56 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7AA7FE76
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 11:58:55 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id fy5so20635683ejc.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 11:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=myA6wGDIgByJk1WYJ7NbWkC9vBZKSXiJuc2HqFuxdRE=;
        b=A5hVAKOtmHXBMBIDVslcAS87f3kEif7RuLLmp3N5fguUMF0U8vBDP9lq/lxQvrQZnv
         ORjnsA7QqoE3Ha66JyTNstl3HsdkiwohluW0VNTDtrsXuBotG2TZFKBZgwqIUUdKO5j3
         qHMvKBBDmaqmVeEZljqJ2zZw2TEF++qUyxnp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=myA6wGDIgByJk1WYJ7NbWkC9vBZKSXiJuc2HqFuxdRE=;
        b=ITK0hbJPAelAHBltg8iGrT8+4j5MsI+6fDV5LjCO5MjlU9d5Tz90aYJZrZJPk6ROGr
         ARAsBj6kD8jR9rs2hzVCovewoaxb8ZOJv9yHzsmfhmSHGTG5Azz6nRV99YcPdgIMrD+E
         10Pcdm0DdzUVBXG5avyMBWhTRWrR4OGQMCx4ky9Ez7DcHnhs2/7szsAzDqMGUd7tVcj3
         O2YVFz8PG3M5hrdVj9V91n7wKTPIirNmUwzCQhlvyVY/YoezcFD2Zm/iNJdA2TuzsT/5
         3d4kwJXl08RDLoPAl1bzTZMlWVpGxoQRLtosvKPQQEg7Ka/GYbfoALSEGIQ+gl7wg7Kc
         NHhg==
X-Gm-Message-State: ACgBeo36T6gGm7fdkcFk09Ptg7/iNPobwmMh1oeMPGNQAhCtU1LTCExj
        Q9eLV7M1Yw9mV5gYp0OVvBs16frPpHaMQJoPMY8=
X-Google-Smtp-Source: AA6agR4mZUxINUAXRtI5FhycPfyKlfn97THL6DXO25U7XXum8+AuG9x3ClhsQMUrdNRn6DBDdmAq9Q==
X-Received: by 2002:a17:907:6e14:b0:730:a229:f747 with SMTP id sd20-20020a1709076e1400b00730a229f747mr15040331ejc.202.1660676333863;
        Tue, 16 Aug 2022 11:58:53 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id f16-20020a50ee90000000b0043cf2e0ce1csm8976175edr.48.2022.08.16.11.58.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 11:58:53 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id r16so4476516wrm.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 11:58:53 -0700 (PDT)
X-Received: by 2002:a5d:6248:0:b0:222:cd3b:94c8 with SMTP id
 m8-20020a5d6248000000b00222cd3b94c8mr12740312wrv.97.1660676333096; Tue, 16
 Aug 2022 11:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <YvvBs+7YUcrzwV1a@ZenIV>
In-Reply-To: <YvvBs+7YUcrzwV1a@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 Aug 2022 11:58:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgkNwDikLfEkqLxCWR=pLi1rbPZ5eyE8FbfmXP2=r3qcw@mail.gmail.com>
Message-ID: <CAHk-=wgkNwDikLfEkqLxCWR=pLi1rbPZ5eyE8FbfmXP2=r3qcw@mail.gmail.com>
Subject: Re: [RFC][PATCH] Change calling conventions for filldir_t
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 9:11 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> filldir_t instances (directory iterators callbacks) used to return 0 for
> "OK, keep going" or -E... for "stop".

Yeah, and it was really confusing wrt what the reported user space error was.

> So let's just return bool ("should we keep going?") - it's less confusing
> that way.

Ack. And the "true means keep going" that you picked is, I think, the
more natural model with the conceptual model being

  while (dir_emit()) ..

and this makes the filldir return value match that dir_emit() one.

That said, our filldir code is still confusing as hell. And I would
really like to see that "shared vs non-shared" iterator thing go away,
with everybody using the shared one - and filesystems that can't deal
with it using their own lock.

But that's a completely independent wart in our complicated filldir saga.

But if somebody were to look at that iterate-vs-iterate_shared, that
would be lovely. A quick grep shows that we don't have *that* many of
the non-shared cases left:

      git grep '\.iterate\>.*='

seems to imply that converting them to a "use my own load" wouldn't be
_too_ bad.

And some of them might actually be perfectly ok with the shared
semantics (ie inode->i_rwsem held just for reading) and they just were
never converted originally.

Anybody?

              Linus
