Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F81F55E05F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242184AbiF1H2P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 03:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243314AbiF1H2A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:28:00 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6205B2CE23
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 00:27:57 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c4so10289713plc.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 00:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O7AN7zCw88CnfnIChdPaHJO6t2qn6tmZuT2O8QWFHSI=;
        b=eNTlJF/BtQg9WVGF2y+8VuOy3vNS4fH+PnrG0Z6DKkZ+UFAPgV+jkAhGiBF5nO25Up
         dbapw4GCwyfUcnVH+wabukYa7lPzjHx7ORUycC9B2VY5XMZAPTHZfcITdQprInKX9J63
         TI1amqXY++6Gf+hHHvo5ZxgwqnM4pVy037p9uL0OsJ8VvKMh+xy4E43kY2/fbLqcyNAh
         M1oS3NsF+M80FXbrcfHCzhRhrubZ4M50rxjQK7m7TVQ6aUXZe845vKDw26ZXsrHtbWrq
         7sE33wSRptssjVtZoIn67OBUeLtO4e5tVLU3TwhmeYcvB63hCTM+24H74Ie5nCGEs44l
         5KlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O7AN7zCw88CnfnIChdPaHJO6t2qn6tmZuT2O8QWFHSI=;
        b=EvGjYLDBPF40W5kRqRt5Lk5ey+BBZyQDgd57gDbN5YjuYUlkK0Pfui0NZDVDMbc2MQ
         hOn50V29hOvQFrvnCYnQrUGx7D/3MbAlCwNthEIvUB7MKnzU9d2LMzIc4qX0dKtD5/HY
         9A+6nEUoMykPWxz+LW6er8/RwgbvWzrc3VSNiFESM9p3iBAbMctJxSzbA5OYDqguVvhD
         kkwcAN8Xsie5WwuJdnxtsyu3J+605tLPpeAxU5vQCYQfAElo3EBtqnwLPtRDZl/kJlef
         GiVJ6su8FiU7CT+c3LjQmnHKQyqud9G2jFN3mFoVVRR5qYebVwvNXyee04wpTyorbSUj
         MLgQ==
X-Gm-Message-State: AJIora/YGyFlYDrHGCZDBbw9UAoXMITwdWBoJJzgV92kDagnHVKkR5Nv
        gZItbAy09pIo/YyuhxMKM8/w/w==
X-Google-Smtp-Source: AGRyM1vpRDk7C83YVdMc/cvyHuJucN0u+xGlkuoAOyEGfFxBjGZ5LFrV8J1bUv78B4U4X0rQdIi+mw==
X-Received: by 2002:a17:90b:38c2:b0:1ed:474a:a668 with SMTP id nn2-20020a17090b38c200b001ed474aa668mr17414680pjb.201.1656401276991;
        Tue, 28 Jun 2022 00:27:56 -0700 (PDT)
Received: from localhost ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id n24-20020a170902969800b0016a034ae481sm8467854plp.176.2022.06.28.00.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 00:27:56 -0700 (PDT)
Date:   Tue, 28 Jun 2022 15:27:51 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] filemap: minor cleanup for filemap_write_and_wait_range
Message-ID: <Yrqtd/dv7qJlB8ca@FVFYT0MHHV2J.usts.net>
References: <20220627132351.55680-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627132351.55680-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 27, 2022 at 09:23:51PM +0800, Miaohe Lin wrote:
> Restructure the logic in filemap_write_and_wait_range to simplify the code
> and make it more consistent with file_write_and_wait_range. No functional
> change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
