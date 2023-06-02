Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36E37207B4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 18:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbjFBQhU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 12:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbjFBQhS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:37:18 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88789197
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 09:37:14 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-97460240863so142469566b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Jun 2023 09:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685723833; x=1688315833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzJT3HyKG2J4xiGoewlppsTGaruPJowM8pRCfo3JmUA=;
        b=YSWipyxtRYE4aRsDx5kpWeNsJaCCphIsrGhQvjZ+/BMhyCSkf4uEQLXkrVhWP7CDlu
         qN17+0sbc3gtoOv5SZ2CUZ68i8hS72K0bHyO0AqBAYkzVnsWGpQbFZqdLfe0L7n1Ewf6
         WSGhzHTQoSTj8eo9ruZ5OJukGtLsMqqkI5OJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685723833; x=1688315833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzJT3HyKG2J4xiGoewlppsTGaruPJowM8pRCfo3JmUA=;
        b=d79FiX87Wff5D4ZJkBSANmk07V/wdQDfQbPfCTo+ud9PYfHik0s/jJF2yDNt3RICHk
         ocRiBnEKkfP+jNqSNpTZy+t3a+i0hA3Y4D4TzT5tm1EgYBxSMc7xSsAmo55VIa6rR4i6
         h9i71WlmI6YkiiaHoPHUCi8T3dAkFjBuzgqGm7X7xxBuQMqVqHArr538uVccOxPamI0+
         urGGHEsGsYKdEaK57Ckwv0j7midZkvSDYnORERlaJx9Q4QsXwruF7qYlRm03IiGrXsWB
         c7p/WorSICU36FdOEiZUnSE8XQNchVh9cdp0q6xYkRQus9v0ZUu+j1GnmwpAlBwG6bBk
         IeeA==
X-Gm-Message-State: AC+VfDwZqcm2TR6ePJhMn5f8YrB/UCLHJcYGOU8jOU3Er4vxkbX0GxoZ
        Ad+1d+/IPa5ftcyRF/nj4B+hc5ATX3FbeUU9FwWwT03B
X-Google-Smtp-Source: ACHHUZ5rd1P6c/phLmtpaybI8uqIHsVE6NMc10Pp7gJsxx5meNzxkmP51psnren/v9cxAsP54gI2+w==
X-Received: by 2002:a17:906:9747:b0:976:6863:a737 with SMTP id o7-20020a170906974700b009766863a737mr418755ejy.50.1685723832954;
        Fri, 02 Jun 2023 09:37:12 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id t11-20020a170906948b00b0096739e10659sm934111ejx.163.2023.06.02.09.37.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 09:37:12 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-51494659d49so3266381a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Jun 2023 09:37:12 -0700 (PDT)
X-Received: by 2002:a2e:7302:0:b0:2af:1681:2993 with SMTP id
 o2-20020a2e7302000000b002af16812993mr311009ljc.49.1685723811492; Fri, 02 Jun
 2023 09:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230602150752.1306532-1-dhowells@redhat.com> <20230602150752.1306532-6-dhowells@redhat.com>
In-Reply-To: <20230602150752.1306532-6-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jun 2023 12:36:34 -0400
X-Gmail-Original-Message-ID: <CAHk-=wg-9vyvbQPy_Aa=BQmkdX7b=ANinNUU+22tMELuxmH99g@mail.gmail.com>
Message-ID: <CAHk-=wg-9vyvbQPy_Aa=BQmkdX7b=ANinNUU+22tMELuxmH99g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 05/11] splice, net: Fix SPLICE_F_MORE
 signalling in splice_direct_to_actor()
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
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

On Fri, Jun 2, 2023 at 11:08=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Fix this by making splice_direct_to_actor() always signal SPLICE_F_MORE i=
f
> we haven't yet hit the requested operation size.

Well, I certainly like this patch better than the previous versions,
just because it doesn't add random fd-specific code.

That said, I think it might be worth really documenting the behavior,
particularly for files where the kernel *could* know "the file is at
EOF, no more data".

I hope that if user space wants to splice() a file to a socket, said
user space would have done an 'fstat()' and actually pass in the file
size as the length to splice(). Because if they do, I think this
simplified patch does the right thing automatically.

But if user space instead passes in a "maximally big len", and just
depends on the kernel then doing tha

                ret =3D do_splice_to(in, &pos, pipe, len, flags);
                if (unlikely(ret <=3D 0))
                        goto out_release;

to stop splicing at EOF, then the last splice_write() will have had
SPLICE_F_MORE set, even though no more data is coming from the file,
of course.

And I think that's fine. But wasn't that effectively what the old code
was already doing because 'read_len' was smaller than 'len'? I thought
that was what you wanted to fix?

IOW, I thought you wanted to clear SPLICE_F_MORE when we hit EOF. This
still doesn't do that.

So now I'm confused about what your "fix" is. Your patch doesn't
actually seem to change existing behavior in splice_direct_to_actor().

I was expecting you to actually pass the 'sd' down to do_splice_to()
and then to ->splice_read(), so that the splice_read() function could
say "I have no more", and clear it.

But you didn't do that.

Am I misreading something, or did I miss another patch?

               Linus
