Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91894E5584
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 16:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238252AbiCWPoP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 11:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbiCWPoN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:44:13 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85015642D
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 08:42:43 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e18so1279222ilr.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 08:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Q+QWIODRunL1kZDxkGcjubr7xZYCTkjXBoQ6GHBjdng=;
        b=rKJPBrT/fwB5RPRTSrN7oyA4l4lLXNdlw8m1cbxtLtf/aCb6lmXP8ecNKCnz5QvAzG
         6yTZ8Bo/YzAFHSjxWer0zagiDNtTWGTMTX+idSWuwknAEoSzUj8u2byB+1gGo7TNCYlz
         IAuM0KmU/X+jYN1uLNNhaJJCuIizwT5ZvWFPraeHsWW4PBy+iJaaRKA7pjdjm4l315II
         AOqidbWncNwJby8i51Y2uYKAC16/Rl8Phw4gEnMqf7wOlgJmzpO8eXdnAL9FfJ4Z9PPZ
         PbGgP1JQyZbuaLHRYYS9G7urf6o/8Ehts8d4jLY9UVkrNLpxAWRaCJ4hfyox2NkPvmkS
         bm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Q+QWIODRunL1kZDxkGcjubr7xZYCTkjXBoQ6GHBjdng=;
        b=btpu8/enLs+nd9QW+q9yIs0h7SlUpaKG0zYQcynuJD6QTB8ixZcAPnn5HCkrS25PBO
         WpU+KiHaWq823PlQVdj6Puiz+mffcrt9vu1gHCa5rF39T4gjivs91igKzV7Pb2+Vg01G
         YF2tFT3/WmM48rf46F0UTRk5DuhD+ysfmv5zJFghNJU66NhW52VzF/nRGf0F7gPh6UDR
         vFz9R1ScAcBMGiD2o9GbOa045XDohujBHxeeE2+YTRt8COFZ6R35YM+j6bEgFKeWSWg0
         bQIouyt2Bnw9ocvSR6SZn+Fqz4L4QPu7VWIwMXvNmjoF/vKzytQjG4AxeZcstke/Wf6H
         s0Bg==
X-Gm-Message-State: AOAM530d6rSNTnaOr6h4dq+ukpYWAVMiW6y1HyG6fC0bky28wu3Q9E/e
        abOTgWw9r1rjM4+LWJKidKspGg==
X-Google-Smtp-Source: ABdhPJw1zXcF2NHArvdixZyJ6ySe9N67vs6A+LOFqBlJhkit10ZNhV9WGnkHqlxliaasGuo/R8ooyw==
X-Received: by 2002:a05:6e02:1c0a:b0:2c7:75de:d84 with SMTP id l10-20020a056e021c0a00b002c775de0d84mr337284ilh.186.1648050163113;
        Wed, 23 Mar 2022 08:42:43 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c15-20020a056e020ccf00b002c865ea7babsm192178ilj.51.2022.03.23.08.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 08:42:42 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220323153952.1418560-1-hch@lst.de>
References: <20220323153952.1418560-1-hch@lst.de>
Subject: Re: [PATCH] fs: do not pass __GFP_HIGHMEM to bio_alloc in do_mpage_readpage
Message-Id: <164805016256.144972.11275037637375213496.b4-ty@kernel.dk>
Date:   Wed, 23 Mar 2022 09:42:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 23 Mar 2022 16:39:52 +0100, Christoph Hellwig wrote:
> The mpage bio alloc cleanup accidentally removed clearing ~GFP_KERNEL
> bits from the mask passed to bio_alloc.  Fix this up in a slightly
> less obsfucated way that mirrors what iomap does in its readpage code.
> 
> 

Applied, thanks!

[1/1] fs: do not pass __GFP_HIGHMEM to bio_alloc in do_mpage_readpage
      commit: 61285ff72ae59e1603f908b13363e99883d67e09

Best regards,
-- 
Jens Axboe


