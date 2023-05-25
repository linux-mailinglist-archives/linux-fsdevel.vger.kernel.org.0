Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27E67111C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 19:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240673AbjEYROB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 13:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240503AbjEYROA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 13:14:00 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1121194
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 10:13:59 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-96f818c48fbso162419166b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 10:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685034838; x=1687626838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zMzRygPKkdKlo23QW/uYg+LGfB6C3Hjzj0Tw04tNig=;
        b=KZ5RlKgWhUG1MQQqgMFTMcqAf8xBrnemZ3pTYeAdV59cQMutizSYab9Mixp1CbTHQ1
         g8fLNpRk5Tt56dZPEDcJqBAbGYB/dHVjIPCfLDRLPdZCINAyerRVn0sqdBdf5kyv5mlp
         ptXyUnRdpveENYl84Wp8uXDUH50aJTeFd2LVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685034838; x=1687626838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zMzRygPKkdKlo23QW/uYg+LGfB6C3Hjzj0Tw04tNig=;
        b=B/RdLgK27pZlxf6erMiO7QbjWXQ03meta8VnuqGseoNXjD8RRTRwbsZ5hz+RuIeFMc
         ZRtWsfvFtxz+Aj3hawk9wDmloOGz0p2iPZDqlPZ7e62PbeU75Qr99pgqvk6p2mVaTI11
         vVlBcIPeyY8ET5w/iysdYa3I+RtzmndDza/63Dz9cFBomNcMs7Vwp14WJhPYv8CzMnej
         kXyZHaIML7/6gC5cNtaYL/2dO91ZFj1U+O4snzbscZ6MnO8S/mVQPJIoRv1xLYRuapc7
         deRt3ETmdOYhnPP7MiRwpmLgqHoTLqprcPGownl1+fFFAZCATtpZRCWc7Yb/7E2hvG3F
         uPiA==
X-Gm-Message-State: AC+VfDyRir4YpS/BS0VPdt63JKufZQI75MvU///qKVobJCpuD7c0Vob0
        g5942UG+2ZnaUo0jCgPlBBGHu+C9Oy+dywQ2l5YO6rvv
X-Google-Smtp-Source: ACHHUZ6iCpgoDi36Owwsj29sox4FX3IB4qAMS23Mpq2rJR/l/reHmQSQ4XUN9us6Y5QvnkQE0qmNAg==
X-Received: by 2002:a17:907:c23:b0:96f:e7cf:501b with SMTP id ga35-20020a1709070c2300b0096fe7cf501bmr2671836ejc.33.1685034838034;
        Thu, 25 May 2023 10:13:58 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id z9-20020a1709060f0900b0094e1344ddfdsm1087263eji.34.2023.05.25.10.13.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 10:13:57 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-9700219be87so160912366b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 10:13:56 -0700 (PDT)
X-Received: by 2002:a17:907:a49:b0:96a:498a:bd4b with SMTP id
 be9-20020a1709070a4900b0096a498abd4bmr2248713ejc.64.1685034836175; Thu, 25
 May 2023 10:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <ZGxfrOLZ4aN9/MvE@infradead.org> <20230522205744.2825689-1-dhowells@redhat.com>
 <3068545.1684872971@warthog.procyon.org.uk> <ZG2m0PGztI2BZEn9@infradead.org>
 <3215177.1684918030@warthog.procyon.org.uk> <CAHk-=wjaqHgd4u63XdZoTPs1YCJnDZ7-GQHKKdFrT32y2-__tw@mail.gmail.com>
 <88983.1685034059@warthog.procyon.org.uk>
In-Reply-To: <88983.1685034059@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 10:13:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wguy6bcoUznDCU3mr-wbi-8NigkTw5GvwiF8R76J=vGUQ@mail.gmail.com>
Message-ID: <CAHk-=wguy6bcoUznDCU3mr-wbi-8NigkTw5GvwiF8R76J=vGUQ@mail.gmail.com>
Subject: Re: Extending page pinning into fs/direct-io.c
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 10:01=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> What do we gain from it?  Presumably since nothing is supposed to write t=
o
> that page, it can be shared in all the caches.

I don't remember the details, but they went something like "broken
purely virtually indexed cache avoids physical aliases by cacheline
exclusion at fill time".

Which then meant that if you walk a zero mapping, you'll invalidate
the caches of the previous page when you walk the next one.  Causing
horrendously bad performance.

Unless it's colored.

Something like that. I probably got all the details wrong.

                Linus
