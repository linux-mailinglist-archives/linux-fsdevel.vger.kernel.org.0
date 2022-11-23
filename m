Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA08636995
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 20:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239688AbiKWTJJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 14:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239669AbiKWTJI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:09:08 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8A4A9
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 11:09:06 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id k2so13113578qkk.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 11:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yPgzuaoqHuz3hc6GKBXrRYZsP8U7EhvDm+I1zVt6Kyc=;
        b=EFNC4tQlvCILCh89xvIkqHD2HaIjFKosUdVGMRAv1CFQL71EGGppxAhkFklcwgTSBC
         DHCoZhz3mvQ7jOPniFnrjTEdj3Ju25j/2/tkns12FsXfLuvllqmlGAwtDPqcAFeaDJST
         IkO304Om2ISQ4EzhQM5kzUC5yFRh1EPVo8X9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yPgzuaoqHuz3hc6GKBXrRYZsP8U7EhvDm+I1zVt6Kyc=;
        b=K74JeBgObIE+FkCQBM3RwXQGiExyPgYvlKXCaoU74YQoFGgAVlnENLpUBJiHoAfliD
         3AhzpAdLBEMVgWaaHU1dVeSVWbNA0IHK1GbnsLdD4pLra1IX9We1fEs0N55qaV2ZHHK3
         tw/gB0pQ7Bv+aXRnJJ7q2w7GBhn+qtf0Xaw7K0VNRxrl+f24MHlcgWXNHAdcl7cLlgs0
         VX3VMkK8HLbI7oGje6S6mSwo3Bi9M6/luja2WWKLwIfAaJSpIVqfl4TjvkN9FkzXoqdi
         veGX2WU2LmtfhZfDBP/BcShhzXvzsBQ8Qgr2PO9559sgH5NDjjnDMk5oyP8/+ZMe2/mh
         rpWA==
X-Gm-Message-State: ANoB5plb6tOKhhFiC0Fu7PO9aULIB44Zvh1kNq4d56jgoWt17jfFFr2J
        cpwQYI6s6GELgu8n+sqKhTKVquwViOTTEg==
X-Google-Smtp-Source: AA0mqf54B7YXHhBqRExRBXGy2nEPeXwkP7MBl8m1FGly58DPlp+iXd1MnRnGO9bpBXzkOhpH5aOc6g==
X-Received: by 2002:a05:620a:208d:b0:6ed:682a:4235 with SMTP id e13-20020a05620a208d00b006ed682a4235mr25305107qka.681.1669230545692;
        Wed, 23 Nov 2022 11:09:05 -0800 (PST)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com. [209.85.219.53])
        by smtp.gmail.com with ESMTPSA id bx15-20020a05622a090f00b003a4f22c6507sm10319104qtb.48.2022.11.23.11.09.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 11:09:05 -0800 (PST)
Received: by mail-qv1-f53.google.com with SMTP id d18so9253541qvs.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 11:09:04 -0800 (PST)
X-Received: by 2002:ad4:4101:0:b0:4b1:856b:4277 with SMTP id
 i1-20020ad44101000000b004b1856b4277mr9787467qvp.129.1669230544666; Wed, 23
 Nov 2022 11:09:04 -0800 (PST)
MIME-Version: 1.0
References: <Y32sfX54JJbldBIt@codewreck.org>
In-Reply-To: <Y32sfX54JJbldBIt@codewreck.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Nov 2022 11:08:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=winPSOAoRAc3vUSy9UZ-kLpjehVkEsncbiyqZ4cZfV0xg@mail.gmail.com>
Message-ID: <CAHk-=winPSOAoRAc3vUSy9UZ-kLpjehVkEsncbiyqZ4cZfV0xg@mail.gmail.com>
Subject: Re: [GIT PULL] 9p fixes for 6.1-rc7
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 22, 2022 at 9:16 PM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
>  net/9p/trans_fd.c  | 24 +++++++++++++-----------
>  net/9p/trans_xen.c |  9 +++++++++
>  2 files changed, 22 insertions(+), 11 deletions(-)
>  9 files changed, 254 insertions(+), 28 deletions(-)

Strange bogus second line of statistics.

But the first line looks right, and I've pulled it. I'm assuming this
is some odd cut-and-paste error on your part where you had some stale
data from before.

               Linus
