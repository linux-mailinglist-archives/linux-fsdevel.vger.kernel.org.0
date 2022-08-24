Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF7159F26D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 06:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbiHXELj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 00:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiHXELi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 00:11:38 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FA87D1F4;
        Tue, 23 Aug 2022 21:11:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bj12so14132121ejb.13;
        Tue, 23 Aug 2022 21:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1SWmPxwQyH5LYZrwY6U9XBorttydo0GXweh3dw5/QKE=;
        b=aB5Gk0PGmxav71TxeXANmr1pPDPghLTSfQ29XJ8LQy6WvkEb8HPfBSqN5qkhPDpuUS
         7RXfKn4IOpvkyiAGIGpUlc8/7FaY0Z2NXa1XkOs9/zXwUfvDusGj+ct52/rKAulJ6Chf
         lONMykmHKfe4ukqG1F/WMOfl3oqYGykOX1fErzqYsP/7D5TU7VkHGULWyaiGY8oKLumW
         mliTpyuj5LrIBwrR10LcRQMn2zqdmDjcqi2PVcDmmBgJghBAwztDCODbjgnpxCS4XT19
         GW9hWN6b5BneomBEXiE7nAjgVSOuT8gq6lIVEeutl71hFIevTTlSS1BwjFdshjZtW/+L
         dL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1SWmPxwQyH5LYZrwY6U9XBorttydo0GXweh3dw5/QKE=;
        b=ytJFg0LMCuvH+8J+Jm28kk/LGmDtJsscm/icAvWBSuIV8sv00XhwWFy2663dF2YzdK
         7Pz7Hm4+OuuPaSF577dZ2/fJBQ9QwClrgcM70nCQFHT6CGHcNx3FNRa3owFV1gBEmULt
         FpoV9vAqO262np839v6clNnU3DXXi3ZWlqXOGppqCXjvMEnqpCugMg9iUI5JDHMPzhoe
         WLkZrYkJPE6+0jTt8vRDz8F7otjU41TwyUkuKvrK2oDfrT0AD51209kAFA9EkR6Eha1r
         fBcGIGnMlxkezoUBe+C9TZ1YWGPWeDRTTsMAje6Pf5mGpulfMx06IrwfCSyZ2ON5Kkhi
         FFPg==
X-Gm-Message-State: ACgBeo17VNELAPiuBV4tlVhtWJdbkog7E4OsGXntP7TiC5J2fPvxmtPK
        BL3/GWZWrFY55nUfex1emv8fK9Qha5EXtrhHLhOhwSMBbd2Hdw==
X-Google-Smtp-Source: AA6agR4cufQC1ybMe0UuAZb3MJf2BHeBD6bTNPsU6naKJlaYsRTjLVGNlcd3crGT1O5HhTLM9yRM3D1aUHgdUSPVjaE=
X-Received: by 2002:a17:907:e9e:b0:73d:69fa:9b1c with SMTP id
 ho30-20020a1709070e9e00b0073d69fa9b1cmr1551540ejc.681.1661314294805; Tue, 23
 Aug 2022 21:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220824004023.77310-1-vishal.moola@gmail.com> <20220824004023.77310-6-vishal.moola@gmail.com>
In-Reply-To: <20220824004023.77310-6-vishal.moola@gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Wed, 24 Aug 2022 13:11:17 +0900
Message-ID: <CAKFNMomaxii8r_B3XA4KdkvcD+9Crm=S=0KE-nDa4+qs78E4dQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] nilfs2: Convert nilfs_find_uncommited_extent() to
 use filemap_get_folios_contig()
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Wed, Aug 24, 2022 at 9:43 AM Vishal Moola (Oracle)  wrote:
>
> Converted function to use folios throughout. This is in preparation for
> the removal of find_get_pages_contig(). Now also supports large folios.
>
> Also cleaned up an unnecessary if statement - pvec.pages[0]->index > index
> will always evaluate to false, and filemap_get_folios_contig() returns 0 if
> there is no folio found at index.
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  fs/nilfs2/page.c | 45 ++++++++++++++++++---------------------------
>  1 file changed, 18 insertions(+), 27 deletions(-)

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Looks good, thank you!


Ryusuke Konishi
