Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EB871119F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 19:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239986AbjEYRFQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 13:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238954AbjEYRFO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 13:05:14 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02631C0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 10:05:13 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-96f818c48fbso160778166b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 10:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685034311; x=1687626311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSr58RBXCv1EwUMOYtICqFDX8H+m5pyEj79JnZvBvqM=;
        b=FUBX4bX4Rtu2T0f2hT26650q+dMnkZkzNX0I0hBfyLgOH2Ax4epbIripcg6b1UDFpM
         o3prOgLKFbhWUaC45DzFa9SPMncTSsRCM3jaIgaKdONEpkKIUcalhdfLJHBraYaiCHV8
         h8i1H4qHYaOI0fXj3tt41b8ArUeOIe7GFAM0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685034311; x=1687626311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSr58RBXCv1EwUMOYtICqFDX8H+m5pyEj79JnZvBvqM=;
        b=UR3lkg2vA2G/F1fvAjitmcvxjwTn2RUSlzmYhXIzYGc57w/S5WXcB9XQnDmj6Z6wiN
         rop1fM9axoo9Ig9EIBsXEOVQcVrJQ7nMafv/lBkw1zDK27ywsG4PPcpAl4uAHD5a3IMW
         DTcZqLmU6jo/DCME0mTofyWU1APIJqOeq6Lr5udRELnHt+9vS2R3kOB/a+ihhMhccPkk
         t18c7XVJb8mPGBEhZIHrvBXwu/r07+RqrCTzQpe+2ltlYLUZt/HtxrDZwGXkvirkBvxJ
         f/rr06PGL1t5lr94VjW7gyRev/lmfj1N8sECm7Y6YOC9EHjlrT8GCD5Ux2BZJSs4N6CI
         skTg==
X-Gm-Message-State: AC+VfDy5aeVYtROXbp3NiUKtLvHAE7d0YS47vVIdBAROhhEvaqX3Cv2v
        8Sfv/mN63fvaWM/5jV1YLSXgrxyCBN3nUDKQdaHMfmHV
X-Google-Smtp-Source: ACHHUZ7XtcGgMgV7dB8R23mvVlrd5dYw8efSfsgoUJmGfY0YyCwRyQMdzcBUxW3FdGdfYYEVsgzcgQ==
X-Received: by 2002:a17:907:8a09:b0:947:335f:5a0d with SMTP id sc9-20020a1709078a0900b00947335f5a0dmr2321478ejc.62.1685034311329;
        Thu, 25 May 2023 10:05:11 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id j23-20020a17090643d700b0095850aef138sm1083552ejn.6.2023.05.25.10.05.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 10:05:11 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-96fbe7fbdd4so158466966b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 10:05:10 -0700 (PDT)
X-Received: by 2002:a17:907:3185:b0:970:925:6563 with SMTP id
 xe5-20020a170907318500b0097009256563mr2076202ejb.8.1685034310240; Thu, 25 May
 2023 10:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <ZGxfrOLZ4aN9/MvE@infradead.org> <20230522205744.2825689-1-dhowells@redhat.com>
 <3068545.1684872971@warthog.procyon.org.uk> <ZG2m0PGztI2BZEn9@infradead.org>
 <3215177.1684918030@warthog.procyon.org.uk> <CAHk-=wjaqHgd4u63XdZoTPs1YCJnDZ7-GQHKKdFrT32y2-__tw@mail.gmail.com>
 <e00ee9f5-0f02-6463-bc84-b94c17f488bc@redhat.com>
In-Reply-To: <e00ee9f5-0f02-6463-bc84-b94c17f488bc@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 10:04:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPWUCyhiM+=S3nmh4JK8qtBQteYvtiXpoYpDjfKHnEhQ@mail.gmail.com>
Message-ID: <CAHk-=wgPWUCyhiM+=S3nmh4JK8qtBQteYvtiXpoYpDjfKHnEhQ@mail.gmail.com>
Subject: Re: Extending page pinning into fs/direct-io.c
To:     David Hildenbrand <david@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
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

On Thu, May 25, 2023 at 9:45=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> I think the correct way to test for a zero page is
> is_zero_pfn(page_to_pfn(page).

Yeah. Except it's really ugly and strange, and we should probably add
a helper for that pattern.

The reason it has that odd "look at pfn" is just because I think the
first users were in the page table code, which had the pfn already,
and the test is basically based on the zero_page_mask thing that the
affected architectures have.

So I suspect we should add that

    is_zero_pfn(page_to_pfn(page))

as a helper inline function rather than write it out even more times
(that "is this 'struct page' a zero page" pattern already exists in
/proc and a few other places.

is_longterm_pinnable_page() already has it, so adding it as a helper
there in <linux/mm.h> is probably a good idea.

                Linus
