Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7D8774882
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 21:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbjHHTeV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 15:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236434AbjHHTeJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:34:09 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96058744AC
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 10:19:13 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bf9252eddso881729566b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 10:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691515148; x=1692119948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+LPhKJdQTcwFoDItceYL3qjZJlSnPxbCU8xvPi+Vd8A=;
        b=a7Y7Uja51LpOnsbvN2jw/j0zaBQumTDCa3kDQPJebVDIhi71lEgwqgRZg2v1lUeAov
         GjAQpU1TASBkwKved/eg0zQ3Fts5ESw//r2XleDJ91OfhWRiLeI8bEdvbI1JduXN33Nw
         6qBxd8Febunk14JGeFM93LdBvrXvf6iR88sqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515148; x=1692119948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+LPhKJdQTcwFoDItceYL3qjZJlSnPxbCU8xvPi+Vd8A=;
        b=Lf/LE30/+w/u8omRR+RL/mAj3odbCb5jV45KP7xJGcs4YnxqAxn6S6W/bsy/t1cpYO
         6ZEB/bHI+fzpBtvtotIXYV1diMavJhkPFtcCNu6Nf0c6VxS19wuD3ljL8g5c7Cqf8fxj
         J61cN54Fpzo5JBbKEllX4yJNeCR0OJU0n5vIOS7LOg0gMos8NEl+uhzgeyKdnclFef8D
         yb9R6m3jKCEEI03q5eYmMIQOP8tTSATkWfzdRTnklGWkGWNES21pXGgKJPJZl+Mo5Iwq
         gwEPS5EzJh9Cm/5V3tBvhSCvXnK2JGUBZPKjhR5C8IDlHucVwVRlhtOfRxMDrDf/0QH9
         WaDA==
X-Gm-Message-State: AOJu0YzPaMEnONbpkpcbSFLXi6uckHs0Pxx3h5Fk8CfEWLIA9tNC14GR
        SYxRwriMSo8/mP7Rl1c/2KmwmKe9aQMcdpBNy0EWGUU2
X-Google-Smtp-Source: AGHT+IHgq/8Ferzpc2HvobZG2Lkvuu7b9x0Un3WmswCXd2dH2c2kFDVxONP3HisTy2R3w5ERGcVD2Q==
X-Received: by 2002:a17:906:8465:b0:98d:fc51:b3dd with SMTP id hx5-20020a170906846500b0098dfc51b3ddmr204115ejc.41.1691515147783;
        Tue, 08 Aug 2023 10:19:07 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id o17-20020a17090608d100b00988dbbd1f7esm6914508eje.213.2023.08.08.10.19.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 10:19:07 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-523476e868dso1305181a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 10:19:07 -0700 (PDT)
X-Received: by 2002:aa7:d6c6:0:b0:523:1ce9:1f41 with SMTP id
 x6-20020aa7d6c6000000b005231ce91f41mr435083edr.18.1691515146925; Tue, 08 Aug
 2023 10:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230806230627.1394689-1-mjguzik@gmail.com> <87o7jidqlg.fsf@email.froward.int.ebiederm.org>
 <CAHk-=whk-8Pv5YXH4jNfyAf2xiQCGCUVyBWw71qJEafn4mT6vw@mail.gmail.com> <CAGudoHE5UDj0Y7fY=gicOq8Je=e1MX+5VWo04qoDRpHRG03fFg@mail.gmail.com>
In-Reply-To: <CAGudoHE5UDj0Y7fY=gicOq8Je=e1MX+5VWo04qoDRpHRG03fFg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Aug 2023 10:18:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+Uu+=iUZLc+MfOBKgRoyM56c0z0ustZKru0We9os63A@mail.gmail.com>
Message-ID: <CAHk-=wj+Uu+=iUZLc+MfOBKgRoyM56c0z0ustZKru0We9os63A@mail.gmail.com>
Subject: Re: [PATCH] fs: use __fput_sync in close(2)
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>
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

On Tue, 8 Aug 2023 at 10:10, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> Few hours ago I sent another version which very closely resembles what
> you did :)
> 2 main differences:
> - i somehow missed close_fd_get_file so I hacked my own based on close_fd
> - you need to whack the kthread assert in __fput_sync

Good call on teh __fput_sync() test.

That BUG_ON() made sense ten years ago when this was all re-organized,
not so much now.

> I'm offended you ask, it's all in my opening e-mail.

Heh. I wasn't actually cc'd on that, so I'm going by context and then
peeking at web links..

             Linus
