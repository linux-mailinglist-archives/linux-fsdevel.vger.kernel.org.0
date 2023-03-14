Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932AE6BA3C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 00:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCNXsS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 19:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCNXsR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 19:48:17 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B824F3D93D
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 16:47:52 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x13so21537765edd.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 16:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678837670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNuC5vuLHUrjsLAEtJntp1DYmMh0ryjDseFJIAEyVKE=;
        b=Txq6X4zSQo7xYO5tDpfbu6iD6NbbI+/DQjvAgDqamrWJVkbwoLurx8Kgxqek+PQ+3x
         I3ou2+/h46Ob3EB7gP/IqbVT2urd/aPmzzjID0s/3N64fzQpm7ljtad+mxBF2+NFONgR
         wYb3QPVyp9FvnRTalr+D+2K6ttJWWgGbKnehs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678837670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNuC5vuLHUrjsLAEtJntp1DYmMh0ryjDseFJIAEyVKE=;
        b=s32qH2nxFvPLCOLmvHypeTT4+0n6agOnNZvebfGKJp0EZHJCSXH9sDHHpu179WwtxG
         DF8v7Mbc7rFUqa/0cm72TqPG4C4EVsdXVMG9CjGi0B1vf4c0tqAoi5KcTsRXX7anoUYJ
         DdaheIwkIly4dP17io6m1tzLs7rgDzF0Tvhnjt+sj0WvVdclIXaDh/bfyULV9xK3ErPS
         vXBzMbFa4sONCzsbe8l1bGPpqBy0WNwyvPZxL9vrkgfP4aTppgj5DW7qeip9ysbfD1R4
         Ia5Tyr7p6rmUD8+q/9Sb109xC5fB6Epess8zDPGkWC3vzO8KGcJdnKw9YORWLUEIowTL
         liIg==
X-Gm-Message-State: AO0yUKUqZ3iOGeAapP7cGpJR7wfudsgRVHRZIBLwqDaRMUAExQuBr03U
        d6HbCl6swKwIcLaOAXPeJMp07h4KYO6Me4OEFC72Fw==
X-Google-Smtp-Source: AK7set8exa9ERiEOWPs50r6uFnDXdr8Au8aP5Rn5bCSd9hOTM09uNqad8zJi53qBh0xywyP2x13Xfg==
X-Received: by 2002:a17:907:7631:b0:900:a150:cea4 with SMTP id jy17-20020a170907763100b00900a150cea4mr3933589ejc.37.1678837670071;
        Tue, 14 Mar 2023 16:47:50 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id n18-20020a170906701200b00927f6c799e6sm1719252ejj.132.2023.03.14.16.47.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 16:47:49 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id fd5so34986806edb.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 16:47:49 -0700 (PDT)
X-Received: by 2002:a50:d506:0:b0:4fb:482b:f93d with SMTP id
 u6-20020a50d506000000b004fb482bf93dmr435862edi.2.1678837212326; Tue, 14 Mar
 2023 16:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230314220757.3827941-1-dhowells@redhat.com> <20230314220757.3827941-4-dhowells@redhat.com>
In-Reply-To: <20230314220757.3827941-4-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Mar 2023 16:39:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=whKPK=Bn_je2A19rSptpDo589DWxBJi8UQYS7sPjDPurw@mail.gmail.com>
Message-ID: <CAHk-=whKPK=Bn_je2A19rSptpDo589DWxBJi8UQYS7sPjDPurw@mail.gmail.com>
Subject: Re: [PATCH v18 03/15] shmem: Implement splice-read
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Daniel Golle <daniel@makrotopia.org>,
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

On Tue, Mar 14, 2023 at 3:08=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
\> +static size_t splice_zeropage_into_pipe(...
>   ...
> +               *buf =3D (struct pipe_buffer) {
> +                       .ops    =3D &zero_pipe_buf_ops,
> +                       .page   =3D ZERO_PAGE(0),
> +                       .offset =3D offset,
> +                       .len    =3D size,
> +               };
> +               get_page(buf->page);

That

+               get_page(buf->page);

is still there, and now it's doubly wrong because it's never dropped
and will eventually overflow that count that shouldn't even be there.

             Linus
