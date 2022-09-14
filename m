Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837775B8AC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 16:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiINOh1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 10:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiINOhQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:37:16 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1172610FE0;
        Wed, 14 Sep 2022 07:37:14 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1278624b7c4so41530357fac.5;
        Wed, 14 Sep 2022 07:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=LVKzlmP/G0PqWNO0u32O0oQ6Jt6/5xnFA05eO88+5ww=;
        b=IODi9yixigDEJYjVdRQovl05Uf/txqrG+I5FQgUJ3TaOT++NZ4GbWlT4wjArCK9osI
         2pyS+C11gnYhftlFitPtmpj3iUQsQbVakh1J7hcmq4ccEAuju/D5oj7nEfWzW/4QZAET
         3AqjyUGIsy7hMSbfc5eR7uh2BNFaqHRZxulDAzql9PnQtv++8dkp8uvfOefbzxP9N7az
         jnYH26AAsstkI5I0UvfQvOveNmgV7tribbLqeeVI56wSnasZ1wvUs0TXkPo3l+ajTXLm
         9oc/abf8MVdiU9w/uw/F1ONAq7uZYBfxdEVSZ4V3BBELBZhVDOm6oWIL9q2M5Pr0Y/Ua
         2EHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LVKzlmP/G0PqWNO0u32O0oQ6Jt6/5xnFA05eO88+5ww=;
        b=uzHSurKvP4WGGPY4C1zV4ynrB1FTV/H7csNl3Db7iPH0yN9dpCJ0ORMDCywa8C06+3
         NWMb8VnUI4BJi+TiucxWPwOXwBbRGykPo7VaFgbtQTVVumQuEgnyVAKmxe2nc3vx6wj0
         toUVUH1fgyyecjvZmFakyXe1BDgdDM2IkAfjNtVCUTGUKk/IRt7tbSORnoVmtNUUxN9S
         beWVjngdAsZ0TyWCnHIBKVFtTzf3+aIQqjjN8oRkvTogRCS8hdZO0QmXZlh2xxnmhDFR
         WIFzdRjvA69gogMq2uHT1TiBhtl5h6foTsa5G8O8mdzws+JYi5SLELETvZxe89MUb2oe
         m/AA==
X-Gm-Message-State: ACgBeo0i9Y79tIPgrSYMqqRvnqGikYg3rByj42w9ahuSCvTA89CUjBdt
        aEPh2oE6hDkvMiyPfmG38QTAm+4dB0P1AOTc2yXILIyA8bw=
X-Google-Smtp-Source: AA6agR7l6g2d3kTOdIT2TZkfgBpJLU1P6Cx6S5aS+ouejkp31RIFhj0iLLOVZQcoklzYf9Q1cHhKq/E5/ax901LN2s8=
X-Received: by 2002:a05:6870:d1c5:b0:127:4089:929d with SMTP id
 b5-20020a056870d1c500b001274089929dmr2551809oac.203.1663166234235; Wed, 14
 Sep 2022 07:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220815071134.74551-1-yang.yang29@zte.com.cn>
In-Reply-To: <20220815071134.74551-1-yang.yang29@zte.com.cn>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Wed, 14 Sep 2022 23:37:02 +0900
Message-ID: <CAAmzW4O53eW9n=N0F31tG4im=+uiA_gGq5RA0u8UGos12hRvvA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] delayacct: support re-entrance detection of
 thrashing accounting
To:     cgel.zte@gmail.com
Cc:     bsingharora@gmail.com, akpm@linux-foundation.org,
        iamjoonsoo.kim@lge.com, mingo@redhat.com, bristot@redhat.com,
        vschneid@redhat.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022=EB=85=84 8=EC=9B=94 15=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 4:14, <=
cgel.zte@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: Yang Yang <yang.yang29@zte.com.cn>
>
> Once upon a time, we only support accounting thrashing of page cache.
> Then Joonsoo introduced workingset detection for anonymous pages and
> we gained the ability to account thrashing of them[1].
>
> For page cache thrashing accounting, there is no suitable place to do
> it in fs level likes swap_readpage(). So we have to do it in
> folio_wait_bit_common().
>
> Then for anonymous pages thrashing accounting, we have to do it in
> both swap_readpage() and folio_wait_bit_common(). This likes PSI,
> so we should let thrashing accounting supports re-entrance detection.
>
> This patch is to prepare complete thrashing accounting, and is based
> on patch "filemap: make the accounting of thrashing more consistent".
>
> [1] commit aae466b0052e ("mm/swap: implement workingset detection for ano=
nymous LRU")
>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> Reviewed-by: wangyong <wang.yong12@zte.com.cn>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
