Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231636BBA5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 18:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjCORBL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 13:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjCORBK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:01:10 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F5552F64
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 10:00:47 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id cy23so78043682edb.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 10:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1678899645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNcufV/o6gXGVvEybdJYpsgEKHaP677A9vzHvZRO1S4=;
        b=hmklnvS8zFNaTwg4I6AQ8EgxC3rDC55Fy1yfRRBp55jWHPiflyBzeHx2PDt50zg8GT
         D8dve4rM25zjPPSNbTl+uptvWB3CXXHZbGRLv00MJOeGP99iz9VvwSrP1tZCPGdmqxt5
         UYJQJr2DMflIuMNL31dLUytSBT/8YJpsXrhPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678899645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNcufV/o6gXGVvEybdJYpsgEKHaP677A9vzHvZRO1S4=;
        b=rlaLk3xs2fFoPaelwYgeQK66fxx0bo4Nd3GUwntSrxaNIArdc0UqLapfsF6JXFKAWj
         JAzsNJRgsdFKMKsQE7iU+6J6NTSDezIfEoChZM4y9pPm4x7nV/oqbPapTB2PnfEMaztQ
         5HkZiue/mtpki2oSEkGgHOf6jutLuI2Wx/y8RbKcUUodZ6vPZWAepkIJ1QXeSDkaJn/d
         rVdjUpfXEBjzPCQ/tWirP0ooq2jmr7Sn4DaO80y3oi0MmQinC5/AElgC5lrEIth1Tyke
         UMJ7jXUufCKpgAyHwjHS4twqgNU7gS9sxzgd9Via7B1vDW51xD9Y8E2OHmAt5oZbpQfQ
         +Obw==
X-Gm-Message-State: AO0yUKVjzjc232MtQFY+VAZCYdrTR7Dll2QHZD+TUUKLG1E/kQ+bK1tw
        /EZMraPUBQ+FUDmTRLkOJAS7ruQmih0f3+j9+rxOrA==
X-Google-Smtp-Source: AK7set+/ULcUdMl9s8UEJT7VuihiDMKiAIt+Bpz7Bnl8S7569zx9x/AC6wCAP2fmVvGw4JcyGubmjQ==
X-Received: by 2002:a17:906:830c:b0:7ad:aed7:a5da with SMTP id j12-20020a170906830c00b007adaed7a5damr7034280ejx.28.1678899645453;
        Wed, 15 Mar 2023 10:00:45 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id ha11-20020a170906a88b00b0092043ae1a8asm2770186ejb.92.2023.03.15.10.00.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 10:00:44 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id h8so34374318ede.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 10:00:44 -0700 (PDT)
X-Received: by 2002:a17:907:72c1:b0:8e5:1a7b:8ab2 with SMTP id
 du1-20020a17090772c100b008e51a7b8ab2mr4223971ejc.4.1678899643988; Wed, 15 Mar
 2023 10:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230315163549.295454-1-dhowells@redhat.com>
In-Reply-To: <20230315163549.295454-1-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Mar 2023 10:00:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiSfbFAVvXpbRJ0NkNJbpo93d5ObdoHcNMvX4CYGrafAQ@mail.gmail.com>
Message-ID: <CAHk-=wiSfbFAVvXpbRJ0NkNJbpo93d5ObdoHcNMvX4CYGrafAQ@mail.gmail.com>
Subject: Re: [PATCH v19 00/15] splice, block: Use page pinning and kill ITER_PIPE
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
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Wed, Mar 15, 2023 at 9:35=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> ver #19)
>  - Remove a missed get_page() on the zeropage in shmem_splice_read().

Ack. I see nothing alarming in this series.

              Linus
