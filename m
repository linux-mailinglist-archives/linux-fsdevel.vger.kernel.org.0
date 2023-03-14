Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B7F6B9FC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 20:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjCNTa0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 15:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjCNTaG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:30:06 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0163212BF
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 12:29:57 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eg48so7244157edb.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 12:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678822196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XXQN4LaizH2j4eXVSdO1xOJU1STk3wgvGGHOknlOD8=;
        b=J8J6+IIeTib/o8tn1o3Tm4wf8QCx+CFWcDHRTZMOrLKl9q7F3WPeySOkbmQMgpba/2
         D+hPq6grcETAnRYaWv/VDaKVx7dSI1wO/e5kPbhofxfK9VlpMq9SmDmR3OnZ21f7nBHJ
         PNl6Zef7fJUIHqj8/q41bFBFo6p/46nHOjs7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678822196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XXQN4LaizH2j4eXVSdO1xOJU1STk3wgvGGHOknlOD8=;
        b=HYL0OgLT65+6RXiu4YCuffRT5BGhLCCJwXs4ilrjsJcQ9N+xJXRCE4TKPC0GnR1TUC
         /wCeoUvTtPI8B+3vZr3ICRyJL3uj4b/nXr0MiaYPWGP8m78pEIraNm2lquGlAgdpzJoo
         iO3UITi311OV3IfdvhryOgy+tmr9Tus3/n7lpZTpvdSGZBARGphCxgG3tzJKS+2Bi9RG
         Cp0DkOxIBv+H+7HTdxMDD2AdyTMM9Hy/d7w2nQMoG0HhXh5rGqcMDmqV39XbiNUgthn9
         g1B24vwsIRzgCn5sPuSKUOUGwa6JmEn17aPvp+E/mWXm8NSDmf5KjXK8jEudlJTUUplK
         bzhA==
X-Gm-Message-State: AO0yUKWBq+d0iDHpja0j9lOwL+XaE69o5BSLzPRh3xmf/8cgvc8w+yi7
        KpV/+Gv+AVpvrLB/+xPO+MHgrod0xA3qF/KDiKRpeQ==
X-Google-Smtp-Source: AK7set+pH/cCYGEkSbtNvRfonxkKcRqDSJfnY9JxW/67BH/4m2Vn7dah+fd2PDRPJnzSaNMv3oLQ3w==
X-Received: by 2002:aa7:c7cc:0:b0:4fd:298d:2f95 with SMTP id o12-20020aa7c7cc000000b004fd298d2f95mr189989eds.26.1678822196048;
        Tue, 14 Mar 2023 12:29:56 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id b4-20020a50b404000000b004fcd78d1215sm1477590edh.36.2023.03.14.12.29.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 12:29:55 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id o12so66465214edb.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 12:29:55 -0700 (PDT)
X-Received: by 2002:a50:d506:0:b0:4fb:482b:f93d with SMTP id
 u6-20020a50d506000000b004fb482bf93dmr106272edi.2.1678820874229; Tue, 14 Mar
 2023 12:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230308165251.2078898-1-dhowells@redhat.com> <20230308165251.2078898-4-dhowells@redhat.com>
 <CAHk-=wjYR3h5Q-_i3Q2Et=P8WsrjwNA20fYpEQf9nafHwBNALA@mail.gmail.com>
 <ZBCkDvveAIJENA0G@casper.infradead.org> <CAHk-=wiO-Z7QdKnA+yeLCROiVVE6dBK=TaE7wz4hMc0gE2SPRw@mail.gmail.com>
 <3761465.1678818404@warthog.procyon.org.uk>
In-Reply-To: <3761465.1678818404@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Mar 2023 12:07:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-OKQdK2AE+CD_Y5bimnoSH=_4+F5EOZoGUf3SGJdxGA@mail.gmail.com>
Message-ID: <CAHk-=wh-OKQdK2AE+CD_Y5bimnoSH=_4+F5EOZoGUf3SGJdxGA@mail.gmail.com>
Subject: Re: [PATCH v17 03/14] shmem: Implement splice-read
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Daniel Golle <daniel@makrotopia.org>,
        Guenter Roeck <groeck7@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 14, 2023 at 11:26=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> Are you okay if we go with my current patch for the moment?

I  guess.

But please at least stop doing the

     get_page(buf->page);

on the zero-page (which includes using no-op .get and .put functions
in  zero_pipe_buf_ops().

Maybe we can do /dev/null some day and actually have a common case for thos=
e.

             Linus
