Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167FB709C7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 18:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjESQcP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 12:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjESQcD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 12:32:03 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD399E47
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 09:31:36 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-965b5f3b9ffso213416466b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 09:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684513895; x=1687105895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afFaOwVkDQVoLtMd5ERUW5Y+E5Lld4ra+zl50KIIzto=;
        b=YzrWcDld4RTJchGelZsjKIflSPDXxiN983phPQf+kkueJ++VbeVCYYGAIi9K+eB62u
         pvnn8G2ZHozyAGv0C9JWxXUEJFs028oh1ByD36OWtKKdm/xJ3b1kImHNWzYbpdVNtFHS
         IVwUNWaLdUfhR5yMO2njMd1b8YV9G1S0wfjeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684513895; x=1687105895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afFaOwVkDQVoLtMd5ERUW5Y+E5Lld4ra+zl50KIIzto=;
        b=WHKDkE9KpWTKGfy4IZ9TBTJzVDz5EV8FSajkrDdDpCCbRagt+kjQKavZPCaSLvcmlz
         /Ws2LWZApZi2dkNUS5n3VBMbWLNTANYLXGAvS5EObgRIA1vFpydOsF/WojyStYdUyHAQ
         7roCHGB8Y1PXbQo27RDP1G1MU6CFrHRTvbzA1f5ZCarqCAivpf4gsXCb21+MtSGGi5Wq
         IkSyJShdQmR38CjGMk/WzkVBwQO+IpsaoIwskzHnT081B/qRxwOabD2CR9DlG0pfBT1G
         ReTPJHCpRumf5xJIa1+q2kyyHAM43DV0V4q7MTRK3MLHLmYN/XzPxhe7p0zbB3Is2qIR
         shFQ==
X-Gm-Message-State: AC+VfDy1gvHgTEQlYR/vNlHK+OVOB6Cg3KSPWCqL9wj1dtdH578kJ82a
        mixAqmQRryHRHUqS5ok3JDMO8gDJsN6Bp1TxyndUL5MN
X-Google-Smtp-Source: ACHHUZ4J0ON5woH+9P/mk6tunGMgb+hHnRnoo21njPy8NYukJSRT80HeR6SemTeUiQm/jAXpkuiYZg==
X-Received: by 2002:a17:907:72d1:b0:96f:5511:8803 with SMTP id du17-20020a17090772d100b0096f55118803mr2276275ejc.22.1684513895286;
        Fri, 19 May 2023 09:31:35 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id k21-20020a17090646d500b00965f98eefc1sm2492513ejs.116.2023.05.19.09.31.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 09:31:35 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-510c734fa2dso2135275a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 09:31:34 -0700 (PDT)
X-Received: by 2002:aa7:d7cd:0:b0:512:698d:34ac with SMTP id
 e13-20020aa7d7cd000000b00512698d34acmr65349eds.12.1684513894474; Fri, 19 May
 2023 09:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230519074047.1739879-1-dhowells@redhat.com> <20230519074047.1739879-4-dhowells@redhat.com>
In-Reply-To: <20230519074047.1739879-4-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 May 2023 09:31:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whX+mAESz01NJZssoLMsgEpFjx7LDLO1_uW1qaDY2Jidw@mail.gmail.com>
Message-ID: <CAHk-=whX+mAESz01NJZssoLMsgEpFjx7LDLO1_uW1qaDY2Jidw@mail.gmail.com>
Subject: Re: [PATCH v20 03/32] splice: Make direct_read_splice() limit to eof
 where appropriate
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
        Christoph Hellwig <hch@lst.de>
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

On Fri, May 19, 2023 at 12:41=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> +
> +       if (S_ISREG(file_inode(in)->i_mode) ||
> +           S_ISBLK(file_inode(in)->i_mode)) {

This really feels fundamentally wrong to me.

If block and regular files have this limit, they should have their own
splice_read() function that implements that limit.

Not make everybody else check it.

IOW, this should be a separate function ("block_splice_read()" or
whatever), not inside a generic function that other users use.

The zero size checking looks fine, although I wondered about that too.
Some special files do traditionally have special meanings for
zero-sized reads (as in "packet boundary"). But I suspect that isn't
an issue for splice, and perhaps more importantly, I think the same
rule should be in place: special files that want special rules
shouldn't be using this generic function directly then.

                 Linus
