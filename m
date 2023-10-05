Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98DD7B9F26
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 16:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbjJEOS2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Thu, 5 Oct 2023 10:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244339AbjJENxC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:53:02 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C19886A8;
        Thu,  5 Oct 2023 01:12:54 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-579de633419so7444727b3.3;
        Thu, 05 Oct 2023 01:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696493571; x=1697098371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4BxR8WaEars+PKA9cftvTpz4ekcZ4zNs/xIqkYQhA0=;
        b=qqG6JP8oNhq2epEH2PKLA5kvLVJf5DSyvOh7Mf2ldaI3hTcO8eHPJxuO++nZd8Smr/
         OfCmzFGgxwetdexnTXKiVUutshDJZc0iJEt4pIUxpkX0iuTtSl9E1JqAHxFZTGtFxF8U
         OrpW3YQRgcb3OOYVp2qLeOeZ+KDUZfoLBQl4GNbHus978BTPq6NFEolPGv+NQMJSIkHs
         dPnO7XjKeAorQgVVCtyiPf9ieBjtAAWgH9eIdmQAA/B59Pjgl3aSDqtmbxTsfCeo4xeV
         W4+P29jGXNnEUlmfXQnfvrcDv9AzWt65OgAuEypQ/OdRvgmahFL7VQpeUI+9w49Mvjo3
         cEzw==
X-Gm-Message-State: AOJu0YzRZ+tEzjLENtn5OEXa832PHYNZbiwvpz59pFnXGbOI5dIYn2nv
        jBD7X3Vz+4SXVmwWWpjBAU4AHHTdImyBWA==
X-Google-Smtp-Source: AGHT+IFqfQSmPCLL9q3dJmqXGvGKh0yiuBHHWU0dWxGcB4CF5ZCwuI4wvJ8/HTqlEVW+3KyEKyx+7A==
X-Received: by 2002:a0d:cccc:0:b0:592:97c3:18d2 with SMTP id o195-20020a0dcccc000000b0059297c318d2mr4954447ywd.15.1696493571546;
        Thu, 05 Oct 2023 01:12:51 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id b126-20020a0dc084000000b0059935151fa1sm340844ywd.126.2023.10.05.01.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 01:12:51 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5a50756542cso7722917b3.0;
        Thu, 05 Oct 2023 01:12:51 -0700 (PDT)
X-Received: by 2002:a81:6d46:0:b0:59b:d7d9:266a with SMTP id
 i67-20020a816d46000000b0059bd7d9266amr4247083ywc.5.1696493571014; Thu, 05 Oct
 2023 01:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231004165317.1061855-1-willy@infradead.org> <20231004165317.1061855-15-willy@infradead.org>
In-Reply-To: <20231004165317.1061855-15-willy@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 5 Oct 2023 10:12:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVP+wZBMr0vzeKqaiW1yxi-RT5qpRRzF9R3fphmWi-2JQ@mail.gmail.com>
Message-ID: <CAMuHMdVP+wZBMr0vzeKqaiW1yxi-RT5qpRRzF9R3fphmWi-2JQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/17] mm: Delete checks for xor_unlock_is_negative_byte()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        torvalds@linux-foundation.org, npiggin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 4, 2023 at 6:53 PM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> Architectures which don't define their own use the one in
> asm-generic/bitops/lock.h.  Get rid of all the ifdefs around "maybe we
> don't have it".
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

>  arch/m68k/include/asm/bitops.h                |  1 -

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
