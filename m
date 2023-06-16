Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E0873356B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 18:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjFPQI2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 12:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjFPQI1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:08:27 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435C5269E
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 09:08:26 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-760dff4b701so10233139f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 09:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686931705; x=1689523705;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YfEH8qoqKE2ArVjSGCyI8u91V3DIju5xdxwJAakLmE=;
        b=YNP5kETLrm8T/RRnZdDcLyOkiDJYyJwp+cTeIfg89bpejVpm5crpLiTODsa/EZ0ezn
         6YXH317Iv6PZIxOKTERy616a808YLQdjGUUYZ1VlR2HTSBY9OkIgCM5MvasgUQIKA8oQ
         UgZq+eWLAnSJdy7Tl0KEAgf0KAd8AcjBcrvwU/Xz8SkNHsbyipJONhw5SEzQkyPzDW5n
         ihAQC53imOPIHBM1vZu5/7ZQPlEALgmTT0GtGbLzablAxMbtO1S+GvbHzbcQNRRpqy7X
         1wRlYfNqOx566BtD3Xg2LUXoftbybpIgMSO/RWyAG5MbyxJdFb5mbfZfYCfwduqTCMSU
         EZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686931705; x=1689523705;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YfEH8qoqKE2ArVjSGCyI8u91V3DIju5xdxwJAakLmE=;
        b=R/7xHMn3pF7ozUtQ/BI9OoHFCAMuZ/65bKPRx4dhlG6Mvr8tzIWuNhY2FNF12YGjJP
         SlhP/ut3rS5HCBPknoKxvrLM2ba7jvJjgMgJHiqTYzGZTOTLIsF4wZAWrIwr4W5QAeyQ
         rNiQLKYo/9pTq13W4KqpkDy+39YyBjBig+N3IU/DHtEYICR8gCltADFJQf86o3xkB39g
         bWQMvXhSqQbdbPLlQxnwmyHZMdzPuraz+txFNwbMu3o0OjZZUaCXdC6dfYLAfhDcfouC
         qwRWK5uy3k+h/kiPfAd/IkFB/ZHaR4yD7fp2Ug0k4ggDPNCv9v0u/oLtaT4LmuReHHSF
         YyQw==
X-Gm-Message-State: AC+VfDyD/c/CVV8lWWZAkRNUk7gXTDmPj8sBz88gkinhQCR8k2d5OYCq
        eLbS0wZcoLgxwO/u9xnJdGWpHw==
X-Google-Smtp-Source: ACHHUZ4cKsFlo8t58r1Lk9uE5JPxsZHPspWy3gYS2SrJmhQPp5WRVCbqt5753z2TzwDBlED4W3bJsw==
X-Received: by 2002:a05:6602:1a87:b0:774:9337:2d4c with SMTP id bn7-20020a0566021a8700b0077493372d4cmr2784811iob.1.1686931705526;
        Fri, 16 Jun 2023 09:08:25 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g6-20020a05663811c600b00420c29f7938sm3687115jas.100.2023.06.16.09.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 09:08:24 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20230614140341.521331-1-hch@lst.de>
References: <20230614140341.521331-1-hch@lst.de>
Subject: Re: dio / splice fixups
Message-Id: <168693170439.2452694.2683453223561840064.b4-ty@kernel.dk>
Date:   Fri, 16 Jun 2023 10:08:24 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Wed, 14 Jun 2023 16:03:37 +0200, Christoph Hellwig wrote:
> this series has a small fix and a bunch of cleanups on top of the
> splice and direct I/O rework in the block tree.
> 
> block/blk.h               |    2 --
>  fs/splice.c               |   15 +++++++--------
>  include/linux/bio.h       |    3 +--
>  include/linux/blk_types.h |    1 -
>  include/linux/uio.h       |    6 ------
>  lib/iov_iter.c            |   35 +++++++----------------------------
>  6 files changed, 15 insertions(+), 47 deletions(-)
> 
> [...]

Applied, thanks!

[1/4] splice: don't call file_accessed in copy_splice_read
      commit: 0b24be4691c9e6ea13ca70050d42a9f9032fa788
[2/4] splice: simplify a conditional in copy_splice_read
      commit: 2e82f6c3bfd1acde2610dd9feb4f2b264c4ef742
[3/4] block: remove BIO_PAGE_REFFED
      commit: e4cc64657becbd073c3ecc9d5938a1fe0d59913f
[4/4] iov_iter: remove iov_iter_get_pages and iov_iter_get_pages_alloc
      commit: 84bd06c632c6d5279849f5f8ab47d9517d259422

Best regards,
-- 
Jens Axboe



