Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFD872FF48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 15:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244410AbjFNNBV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 09:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbjFNNBU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:01:20 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B2C10DA
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 06:01:18 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30aea656e36so4813046f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 06:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686747677; x=1689339677;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zKcyeIjuX8sywa2E7FEsKNjVnYGon92ntPAS7tyVkXM=;
        b=EehtkPGgvmAZy9ncu5cJ/tjuIUL+5kv2TYpVVeOgS5yYfW01RhE1AbZFzX1BPtHMhH
         jwpOcxFcdkMekmW0vx7OQJc2guSSpYCsIdBRseOb0u8oQcDFp3XuXNbO/dHFfb1G0l4U
         TbMo8/JOpVqQVdgrV7IghpZF6wRtY6YRmbWczds9lNv1ib4fngCbL1JRdegb182zbFxc
         AlG5xAe1U9c5DDxmkTwQfQT+l2UzPn0e3r66ua1zICC0bN99ReuAo9fM3GCTAIRE12iI
         QScKwJ5hOg91y2Y4TbQNNv2OkT+Y584Pdcwhh+vM2hK5pNbyohk/fO8w9rylvqbPALxK
         GfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686747677; x=1689339677;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zKcyeIjuX8sywa2E7FEsKNjVnYGon92ntPAS7tyVkXM=;
        b=MezCGrbTRiO0p+bWMydbFAdE+PYNQ+6Tk576mn47I569nWYowRFa4VfmcS35DggPO4
         x778A+aoV6okNsINN4fqhkUGPLbcX0f834gvKgTQXS+6OcukbvHe7VDd2+6OPE/PDesQ
         1VK212g7ofinU01GKtUOE+mNqNthlqXm5jPftcgZRXA3pAjYGb69tQ27ntyj6bGTcyui
         LAO1CQ9m0NNbIdWJHsbU0M4Ebti7KcaP4SDgwCrRUMByCvCCrz1dUYZwZLNBpdyHjQRZ
         GlkZ6ZcxhLMKT5C1yiDeLkvxVqlCEaYK3mqUXLy7yEDgGrQVlya+1b1zbeGXWKmb74Qw
         uzBA==
X-Gm-Message-State: AC+VfDyqMNFgBkATz5h3HGejyfTBrSgv/YttK2CbeeHe13Y0pLd10yQh
        mMScNETY/KE6FDqO65sWhEC+Bw==
X-Google-Smtp-Source: ACHHUZ4S4zDpcojMrLWg6NB9lAmjFVlgJQhnDxUOlAr2LszHmuOOmelC06aLOdjxrq8uLunltO44Vg==
X-Received: by 2002:adf:e945:0:b0:30f:ce60:a3a with SMTP id m5-20020adfe945000000b0030fce600a3amr3320301wrn.10.1686747677415;
        Wed, 14 Jun 2023 06:01:17 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a10-20020a5d4d4a000000b0030fc079b7f3sm9334796wru.73.2023.06.14.06.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:01:16 -0700 (PDT)
Date:   Wed, 14 Jun 2023 16:01:12 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [bug report] buffer: convert block_truncate_page() to use a folio
Message-ID: <330ceb44-8cd7-41ee-8750-648e90cb165e@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Matthew Wilcox (Oracle),

The patch dd69ce3382a2: "buffer: convert block_truncate_page() to use
a folio" from Jun 12, 2023, leads to the following Smatch static
checker warning:

fs/buffer.c:1066 grow_dev_page() error: 'folio' dereferencing possible ERR_PTR()

This one seems like a false positive,  If you call __filemap_get_folio()
with __GFP_NOFAIL then it only returns valid pointers, right?

fs/buffer.c:2689 block_truncate_page() warn: 'folio' is an error pointer or valid
fs/buffer.c:2692 block_truncate_page() error: 'folio' dereferencing possible ERR_PTR()

fs/buffer.c
    2679         length = from & (blocksize - 1);
    2680 
    2681         /* Block boundary? Nothing to do */
    2682         if (!length)
    2683                 return 0;
    2684 
    2685         length = blocksize - length;
    2686         iblock = (sector_t)index << (PAGE_SHIFT - inode->i_blkbits);
    2687         
    2688         folio = filemap_grab_folio(mapping, index);
--> 2689         if (!folio)

This should be IS_ERR(). 

    2690                 return -ENOMEM;
    2691 
    2692         bh = folio_buffers(folio);
                                    ^^^^^
Dereferenced.

    2693         if (!bh) {
    2694                 folio_create_empty_buffers(folio, blocksize, 0);
    2695                 bh = folio_buffers(folio);
    2696         }
    2697 
    2698         /* Find the buffer that contains "offset" */

regards,
dan carpenter
