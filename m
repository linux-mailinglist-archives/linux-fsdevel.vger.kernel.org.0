Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB4B7519BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 09:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbjGMHXI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 03:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbjGMHW5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:22:57 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8F01BEC;
        Thu, 13 Jul 2023 00:22:55 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso710743e87.0;
        Thu, 13 Jul 2023 00:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689232974; x=1689837774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDO68jZT0ZTH+b3zqYQI1EKldxdKdxhzMhCjT6ca8vE=;
        b=Ly/a27qbWm3qnzDRfYBv4iH4P6cijdUjadNRwoKPK/KhYArh0x6LsU/QDC05GBtclw
         nESgKh9tkDdvPova6963LvehGtmrTTHXwBjx/K1/YNQnxCd1mG+2XiKXHmFnA5w8As7t
         OJapWE0i1xt1GlMWVZd4aIcKEdFofW21+tSVOuypoO95mH/YJ/7MZSqTJLsbwrJZEXgp
         LsCaEy8mJnnx2eLgLYw0YfLVC2MKdVQB/DsF/32i/Ez76hv2LhJSK4RYBaX+eTiUKhp3
         hYkIJf+iXHSP4z9G0xlwztAJOa+fFFYMHSHVfxim3hT/HRJS2qGU1eUxz7d24YII0ZxI
         Yy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689232974; x=1689837774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDO68jZT0ZTH+b3zqYQI1EKldxdKdxhzMhCjT6ca8vE=;
        b=d9svM6NHUje7o/cPcVNiAqxCIEfydGMaaeDJOJEcLKV+dzMn8VYn6AIm27ekhyBCCs
         DK9JSMCO2aTXlJUh5e+pt6JmDYkYB0N94IxQ2tlxVTklYMkSa1WovxAyZN1CdZKAP5mm
         h6C2TUe+7z/lVOCm1HBbbg5bSp99t5MieaBkzWueqaJnuQZwufr12iR8mQr4JHecnPGB
         f9J+4gQMuZUvbpgeZLCytr4y0QG0ReQg31x+l+HhjfhyvJUsqKv5x1DqPjskkwJfTX65
         ut5OkHh2cFZsT7TkdKbd4SbPr1hJ0sMyKKkq7Uy5xs/PAhlZIAta7ia+6jXNKn1KS71q
         yVQQ==
X-Gm-Message-State: ABy/qLazFQBx22PuBW7oOrBLX5dEOedM2p2PJ52cfPrV9YYcJuU819mG
        gdxjzJ041Fkwici7Cs1oZkcgayA08Rzfz53JawjKWi/mwCk=
X-Google-Smtp-Source: APBJJlEOOBWszTkJd6+V6um9Yfz8YUq3x98+y1I0ERzQRWEfxvaAa8YyMhs9UsBI55YAuP+TdqkwF0jZ3JKJEYm97Ko=
X-Received: by 2002:ac2:5506:0:b0:4f8:586a:8af6 with SMTP id
 j6-20020ac25506000000b004f8586a8af6mr498554lfk.4.1689232973781; Thu, 13 Jul
 2023 00:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_4D921A8D1F69E70C85C28875DC829E28EC09@qq.com> <ZKqc5Uj14C7ST21K@casper.infradead.org>
In-Reply-To: <ZKqc5Uj14C7ST21K@casper.infradead.org>
From:   linke li <lilinke99@gmail.com>
Date:   Thu, 13 Jul 2023 15:22:42 +0800
Message-ID: <CAKdjhyD8Nn+h77xGRcaHvDNA+Xw_UBzr7TBAoSs-=geUs+f0eQ@mail.gmail.com>
Subject: Re: [PATCH] isofs: fix undefined behavior in iso_date()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linke Li <lilinke99@foxmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for your reply.
> This certainly fixes the problem, but wouldn't it be easier to get the
> compiler to do the work for us?
 I don't know which solution is better, but it does avoid this problem.
Like
    tz = (int)(signed char)p[6];
