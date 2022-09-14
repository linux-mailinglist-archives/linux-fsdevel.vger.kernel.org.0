Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BAD5B8ABD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 16:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiINOgx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 10:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiINOgh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:36:37 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA9C4BA6A;
        Wed, 14 Sep 2022 07:36:36 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1278624b7c4so41525130fac.5;
        Wed, 14 Sep 2022 07:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=kFgFNMVDRvCC/nP/lPORN2htqPQLp6KV5JvuAgA93QY=;
        b=VczWFULHqHoMqMKDSp7OE8Ntcn6YdvZ+uzgeUyKY+MaARpoa1fkJsylo+QEI0ej0xV
         BQXK6G+qelaHL6OaDfw2i0KueNMcaHDp8jF/cCQ5X3lX2Gzy58ICYnYot3u1DaROke2F
         x62wBEm+wXgrMzdx0+XWasiG8FqSRnkKk5m8XGNYfcTDbOUP86pDkHWxYRhN3MwszuR4
         l/k1vzu8Bn8MBgL7LK6k3o8PSNy3I207pRTgb9AovmXX640D2wLZOcIffNpI4cBGY5r9
         3VuDM0THQijUL3Dg6iQqXNqYY7PKtTMxBWniivpwQjNIq9CNbzxXbOPXmiiOpWmjbEGv
         FVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kFgFNMVDRvCC/nP/lPORN2htqPQLp6KV5JvuAgA93QY=;
        b=giZJ5LM7yI88C6gEcilKx3++zqVsL36pKA5298fFSRS57Y0d8kbG+2ix96xM0mvu48
         Gl/Wk9h7xKnmjPaZqNIONKfHL35cqb/TkTyScMIxXufJasJo6C/k+/xpyzMB/vNCkCrA
         WFDkNbbHjSxkteYzAxGJTiUVgTIU7TIe4v9Gv/a1rWX3PedkoK5rzWAdmnrdwLiThkvB
         YgsgoIXh3SMuzA5vDbv2qGQR4xeXyKLjc9YhOM3Luv7Fv0EiFOtSyjcFGwA8piuKHg3L
         e6oSHHfs4jCl8vjEcMXXktt3Ip1iD0uxNWhLMYrgD5gX/9W2aaDexmMgaXwJnoW5RonC
         nNLQ==
X-Gm-Message-State: ACgBeo2BV9buIywH0C86WwcGBWaSAj4Cw2BhYUgVyT41meg2HOfT3glS
        DthUhAgdGMsZpQhrF1TH97M+JEKBbmJwte62FSw=
X-Google-Smtp-Source: AA6agR68fG7ReaARw1T683i+0dbbcVItIA0tOejmfRQpCIgjiblCs09OGM0ihVhlQs2YgvzB/IVA0NYKBaLgBG0piUs=
X-Received: by 2002:a05:6870:d1c5:b0:127:4089:929d with SMTP id
 b5-20020a056870d1c500b001274089929dmr2550325oac.203.1663166195962; Wed, 14
 Sep 2022 07:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220805033838.1714674-1-yang.yang29@zte.com.cn>
In-Reply-To: <20220805033838.1714674-1-yang.yang29@zte.com.cn>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Wed, 14 Sep 2022 23:36:24 +0900
Message-ID: <CAAmzW4NvQ+hsSoXFgXAsbp+mKHaxPA2PmjK4Hu-5Z+pB6RuwnA@mail.gmail.com>
Subject: Re: [PATCH] filemap: Make the accounting of thrashing more consistent
To:     cgel.zte@gmail.com
Cc:     akpm@linux-foundation.org, bsingharora@gmail.com, corbet@lwn.net,
        willy@infradead.org, yang.yang29@zte.com.cn, david@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
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

2022=EB=85=84 8=EC=9B=94 5=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 12:39, <=
cgel.zte@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: Yang Yang <yang.yang29@zte.com.cn>
>
> Once upon a time, we only support accounting thrashing of page cache.
> Then Joonsoo introduced workingset detection for anonymous pages and
> we gained the ability to account thrashing of them[1].
>
> So let delayacct account both the thrashing of page cache and anonymous
> pages, this could make the codes more consistent and simpler.
>
> [1] commit aae466b0052e ("mm/swap: implement workingset detection for ano=
nymous LRU")
>
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>

Acked-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
