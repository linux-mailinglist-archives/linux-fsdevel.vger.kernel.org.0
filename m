Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701AD711DEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 04:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbjEZC3p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 22:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbjEZC3o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 22:29:44 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C037BC
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 19:29:42 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-510eb980ce2so238395a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 19:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685068180; x=1687660180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFUluCk6Yg3CJh7zCYAWn34AyV3ksw1s+RmFmqdT4VM=;
        b=Ieid42mOXUdzZxbIYNgLrrStagH1yaiUL7RqhGGSGjoaOffdI4Bu3y4Jfpd6Kvjam+
         k/1nt52NIiItCsyE8kAKdpy33LEz7/+zVLLtipntGfqUOUAy7D9POjHN1WUf0D3nnwhC
         IRaJSV57B3gxXp5hxEwcUEqwi3M+0nVRjAaQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685068180; x=1687660180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFUluCk6Yg3CJh7zCYAWn34AyV3ksw1s+RmFmqdT4VM=;
        b=RiMIZwvzx0yhFd9fnZZD5nCxHJbdOBphn3DqO941Y3msJMA78t9NaMbJKEs2CZRzWu
         OOJPwCj4mXGeXw1EFUEiHYSuNmFBzqJ315sfcevL+JiTINztC2pGU4wgGSZttiKLRqij
         tGUpoRPWs+nhlMD+D2hGlJL1QmlQAsv+p83YsW9bv5H6nwZewzq9a9LLI9cxHbomKHNz
         Qe0IlRGRfw6KboYkjAaVgm3YyQ16WtdwrRXcMpXJYIPA3Z/MtFTH7jpi7c6A3ciDKlMv
         eHjR+SxEjRt6ERRcN0IsRgdDW4x+Scf83/MZddzSK7c3BCepAZljnwHD8JtJN+JLwkPs
         8Bog==
X-Gm-Message-State: AC+VfDwnJDv+suJD1517iYrOPzlx16xC6DeFaCJEytuvnUENkH72jfyf
        ZAZBgaR4NzgV4NCaPNEqEQYbJmGefnBG0ZE0Rr9Z1odu
X-Google-Smtp-Source: ACHHUZ7PqoIlcPg0wkcJ5EpD0RxvdPiqcqcajEKNvNM4OXosmYW1TgANdyf5LJOrpX0Mm9IyjrcQQg==
X-Received: by 2002:aa7:d489:0:b0:509:c669:6839 with SMTP id b9-20020aa7d489000000b00509c6696839mr243835edr.27.1685068180790;
        Thu, 25 May 2023 19:29:40 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id w24-20020aa7da58000000b0050dab547fc6sm1072318eds.74.2023.05.25.19.29.39
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 19:29:40 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-51440706e59so234312a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 19:29:39 -0700 (PDT)
X-Received: by 2002:a17:907:d10:b0:96f:d345:d100 with SMTP id
 gn16-20020a1709070d1000b0096fd345d100mr533983ejc.59.1685068179297; Thu, 25
 May 2023 19:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230525223953.225496-1-dhowells@redhat.com> <20230525223953.225496-3-dhowells@redhat.com>
In-Reply-To: <20230525223953.225496-3-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 19:29:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=win3ttfr2xb1JcGroPSOoqGs0GooZq0DLsRtZzXUH5YeQ@mail.gmail.com>
Message-ID: <CAHk-=win3ttfr2xb1JcGroPSOoqGs0GooZq0DLsRtZzXUH5YeQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/3] mm: Provide a function to get an additional
 pin on a page
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
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

On Thu, May 25, 2023 at 3:40=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> +void page_get_additional_pin(struct page *page)
> +{
> +       struct folio *folio =3D page_folio(page);
> +
> +       if (page =3D=3D ZERO_PAGE(0))
> +               return;

You added that nice "is_zero_folio()", and then you did the above anyway..

               Linus
