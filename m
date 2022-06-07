Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0F8540372
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 18:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344869AbiFGQLJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 12:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344854AbiFGQLH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:11:07 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEE3100503;
        Tue,  7 Jun 2022 09:11:05 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id g201so4104318ybf.12;
        Tue, 07 Jun 2022 09:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Gf/LMdzQibmA3CQFIu++5apIgfZQUBK5B+qLCJdcj4=;
        b=UlIOhhRMP5WcJQ/zc/OiuB+lJTkLdYOOC2sp32tUMTA/O3i/rkc1ZAr+Jnb1VYWskV
         u05p+kDGel0dChhHcNMQJ3nWK9QM/AusSmrLoilAGAMq8P1Cg/bOJoeexeiBsy2GTk2F
         xVz0A6K871QbrFfNY0huAGfUWcdkRyXdofetnbhEzKFP4IxOMyQ0BEUlVV/2c2qB5QcA
         555PBTn0EZRhixi/yvufl6vbsxbyCY9hXpoiDGn8etsqPoI/JAhbz7JMw04rLSzr9ZHj
         Urd+yKShZEUZEf3WOAkzCDqqZ597u7goZccNJETiU8vkNdpHhHzGB9Qr5r5SMSwm00qh
         DfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Gf/LMdzQibmA3CQFIu++5apIgfZQUBK5B+qLCJdcj4=;
        b=qFZ2ooXcW2n6+jnCHMRHnI4GKZii9HlvGI15t+YyS3hy0+1HHkb+dmgXyae6MFwzJt
         dbV1BN/GGMKkjhVs0YMXLLmwk5TVD9tUaYb36t8kelZv+rsl8WVh8TjYrAStoNCBqMdo
         iYnLOaVItWzIZ5LbMcrPe4zVZ0P87T7zZY8MwK5hPpAU8gpptzc9VSBCl4U/PgjNLfD0
         5rRktsv5KxN5/d/jbk3oTSNNJpVkv4uSkTo4sS6yKGt06ukbhcWxRRIPp9Wh2akd0CiT
         iIovyckpqZY5bhLFeTXZ86bqCEbjsl5WwI5Y4E4wS5dCJWNykCP/QNFPahMcatIsG56h
         mCHg==
X-Gm-Message-State: AOAM532n/nDyGvu5VWlhWZOgkn6iFpR0JiNlsj6q1XOWYqai+cQw50qM
        RrmbQ71L/SpNAZKCq8NGxU6RBc6zpCACQt1d8bAo7LT0
X-Google-Smtp-Source: ABdhPJynkdTX/fp35vm2swA2RdeGUwkUNt87eYdVaLp+FtHRWgq9QR33twmE++ce1Xf4CBz4Rw1N2NcwHcYZ321gzr0=
X-Received: by 2002:a05:6902:1509:b0:663:3a8b:4fac with SMTP id
 q9-20020a056902150900b006633a8b4facmr18522009ybu.545.1654618264815; Tue, 07
 Jun 2022 09:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220605193854.2371230-1-willy@infradead.org> <20220605193854.2371230-8-willy@infradead.org>
In-Reply-To: <20220605193854.2371230-8-willy@infradead.org>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Wed, 8 Jun 2022 01:10:53 +0900
Message-ID: <CAKFNMonLF+nEs7xi0t=Wy4tf7fttLZCL4v+AZGjDWvSYqmZiaw@mail.gmail.com>
Subject: Re: [PATCH 07/10] nilfs2: Convert nilfs_copy_back_pages() to use filemap_get_folios()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Linux MM <linux-mm@kvack.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 6, 2022 at 1:00 PM Matthew Wilcox (Oracle) wrote:
>
> Use folios throughout.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/nilfs2/page.c | 60 ++++++++++++++++++++++++------------------------
>  1 file changed, 30 insertions(+), 30 deletions(-)

Throughout, looks good to me.   Thank you so much for your great work.

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Ryusuke Konishi
