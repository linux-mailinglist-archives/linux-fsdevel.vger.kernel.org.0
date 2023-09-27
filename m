Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FB77AFC36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 09:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjI0Hka (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 03:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjI0Hk3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:40:29 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5606D1A8
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 00:40:27 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4060b623e64so25440125e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 00:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695800426; x=1696405226; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xr/6DFmMOi1WsZ3Vb3f6bHjlDxv1PMn2U1/j6DS9Q5s=;
        b=sJb/FJlp3hMZs2TcCQFyBdCEKbs72EI+A8aXvree37DQ7/6YW4vC6+sFWAYTiEBO41
         dT2laXjh1yQPDc6PED19WaYSU1/PBulGEJvGBNOxMTrczl8IWEtepC/z451pr2LA4Z/+
         bWD3a81E+q/lqZrXJakwbDcNywg/wHYZ/GFlL099gVSg7mxIEHknLXJBgsnaZLRzXyTd
         /MCJ3/iSBEy8+gycTYIErMbxz6U9Dq9fLc+ErM4yNcv+31a3+PBQzqcoAfCh3+kdaAIx
         rm0BkxTw3um4RgS1TgxTW8Fc4QilNf43eXa1ILPMrC0JwaxL1Q/Zjd385MUHkulW7xCC
         Pyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695800426; x=1696405226;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xr/6DFmMOi1WsZ3Vb3f6bHjlDxv1PMn2U1/j6DS9Q5s=;
        b=lr7zB/T1qgg7mttoVpXWuFC/srYgEkHelmPMWxFwSAbBgomnjL6v3vhh5ShC9kJZSf
         Cyqalyvd5gfauEt7SjkylQvJ/Vprt+GEy4DerOF7yTQu8PSW6DPBGl7kQrKZb+vD24oB
         etoSd4xwZiWOTf3G8iX6Q2/Hwap/WYdsO6VN0tdl3dtu2TNJokYLz6ewXR5Mt1PPj6X7
         YMxkuAzOZTzTrxiUBZJEG6ogLUA4QaFGYEnD+VHqa60ecafesq1XCyWCA4Luiy2pAjAQ
         BDv04hjBG+COZ7B02u40JlBL5YZaVnCNbv4hCUQBCWAxaNTwQ2KT+1SCxdQsTQkjPkrW
         LIUQ==
X-Gm-Message-State: AOJu0Yx+acwhTEk+Sp6IDiI4h+0mdsagK6tIpVw6m5nnF2RqbE5/lE3a
        BORE20JADmL5fQDOKEXnG+e9+Q==
X-Google-Smtp-Source: AGHT+IFYiNfcNyNVQK8HsUFQFEDg2agzZsROcPcXZfVp0tgaozVs8p1RwhsBo+CpcT9SSJqosh0uFQ==
X-Received: by 2002:a05:600c:84ce:b0:400:5962:6aa9 with SMTP id er14-20020a05600c84ce00b0040059626aa9mr3828430wmb.11.1695800425557;
        Wed, 27 Sep 2023 00:40:25 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k12-20020a7bc40c000000b00403038d7652sm16991629wmi.39.2023.09.27.00.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 00:40:25 -0700 (PDT)
Date:   Wed, 27 Sep 2023 10:40:21 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [bug report] buffer: hoist GFP flags from grow_dev_page() to
 __getblk_gfp()
Message-ID: <592d088a-12c7-40e6-9726-65433e2e5a2d@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Matthew Wilcox (Oracle),

The patch a3c38500d469: "buffer: hoist GFP flags from grow_dev_page()
to __getblk_gfp()" from Sep 14, 2023 (linux-next), leads to the
following Smatch static checker warning:

	fs/buffer.c:1065 grow_dev_page()
	warn: NEW missing error code 'ret'

fs/buffer.c
    1037 static int
    1038 grow_dev_page(struct block_device *bdev, sector_t block,
    1039               pgoff_t index, int size, int sizebits, gfp_t gfp)
    1040 {
    1041         struct inode *inode = bdev->bd_inode;
    1042         struct folio *folio;
    1043         struct buffer_head *bh;
    1044         sector_t end_block;
    1045         int ret = 0;
    1046 
    1047         folio = __filemap_get_folio(inode->i_mapping, index,
    1048                         FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
    1049         if (IS_ERR(folio))
    1050                 return PTR_ERR(folio);
    1051 
    1052         bh = folio_buffers(folio);
    1053         if (bh) {
    1054                 if (bh->b_size == size) {
    1055                         end_block = folio_init_buffers(folio, bdev,
    1056                                         (sector_t)index << sizebits, size);
    1057                         goto done;
    1058                 }
    1059                 if (!try_to_free_buffers(folio))
    1060                         goto failed;
    1061         }
    1062 
    1063         bh = folio_alloc_buffers(folio, size, gfp | __GFP_ACCOUNT);
    1064         if (!bh)
--> 1065                 goto failed;

Should this be an error code?  It's kind of complicated because I think
the other goto failed path deliberately returns zero?

    1066 
    1067         /*
    1068          * Link the folio to the buffers and initialise them.  Take the
    1069          * lock to be atomic wrt __find_get_block(), which does not
    1070          * run under the folio lock.
    1071          */
    1072         spin_lock(&inode->i_mapping->private_lock);
    1073         link_dev_buffers(folio, bh);
    1074         end_block = folio_init_buffers(folio, bdev,
    1075                         (sector_t)index << sizebits, size);
    1076         spin_unlock(&inode->i_mapping->private_lock);
    1077 done:
    1078         ret = (block < end_block) ? 1 : -ENXIO;
    1079 failed:
    1080         folio_unlock(folio);
    1081         folio_put(folio);
    1082         return ret;
    1083 }

regards,
dan carpenter
