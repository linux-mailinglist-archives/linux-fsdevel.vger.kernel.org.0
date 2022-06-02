Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E619353B1C3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jun 2022 04:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiFBCtP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 22:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbiFBCtO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 22:49:14 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975B021E301
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jun 2022 19:49:12 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id u12-20020a17090a1d4c00b001df78c7c209so8101417pju.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jun 2022 19:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oBX4Zh/klMP01LwWdPV7qG4KZ68HFcbXLrqsyrjieJQ=;
        b=OehZV7TQerpFAXbu8YkENmpK7xZcTcdg8PQt1xWLn/zK9mDkk1ZQSZ9TUVgpJ/c/NK
         5aWUpP7VGyl5MUtUwRNNRWvOg6i7BtGxX9bflCh0UuNtMc4/N/Yr+A6/gKm1pTkFT4EV
         IzmZKMjvmIB5sdRAM4/favBs8rV8LJGLUskjrv3P2nsn8ftbIrghInQvyqMzNVu6EBs+
         OFXHw+mC59HE1jObpYd7HiGlZ0EaBsUFtS7O+FieVvtSGmyC95HOqSRS2TebNywE6Gam
         m9F6Q1C3xq61ogXEk0ZjZihY1iaUKJPUlOpq2gEh+8695dEt4LRnJPcg9GLIl+Cf68FX
         vnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oBX4Zh/klMP01LwWdPV7qG4KZ68HFcbXLrqsyrjieJQ=;
        b=0AyfqTwCSW1lSC75AD4/z35zNc4tvJf0+is3PnIohywTlFaur69RnuyoiVAOwbTKxj
         EkCQHmJOQ/TGxzy7oiaT+n90REWqtJNR9kTkqCve3HYzBFtx10qPtN30q/KWcqr4IN4p
         MUMDMH/RL/tkTrgBI8iLt5BH9GazgkeS1NTgp245k8ssZgIRJKRBQzQ0DBGHl8F4ykJH
         QPLBqBFvdhVY57caz3ov51MLDMZMYyj3oSJ5p98HjcA2kEN6+opHyh57tKEG9HX61e1P
         Fd7we7s6p2CoVFdFYYZyaJa0rAVUkELvI3WmNpSLY2ksT1pmuze5ZFI7w9C7WrYhESC0
         bu1w==
X-Gm-Message-State: AOAM532o7S0lCmYTHNcD3Nv7E4IBoDJ7ru+JBlN4rMYsM2gbBPDF5gex
        AZlf8yIea7PbDPYElHwcYiM4UMkCtKg72w==
X-Google-Smtp-Source: ABdhPJwLV2dsEMl7iKEmBA5KURdcXeP3cisCGxxui2oEtqe9ffc1/1Ofr9MwpIFZ3peN6zFTWKzxMA==
X-Received: by 2002:a17:903:40ce:b0:164:248:1464 with SMTP id t14-20020a17090340ce00b0016402481464mr2600139pld.16.1654138151842;
        Wed, 01 Jun 2022 19:49:11 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:2468:2a68:7bbe:680c])
        by smtp.gmail.com with ESMTPSA id fv9-20020a17090b0e8900b001e30a16c609sm1811030pjb.21.2022.06.01.19.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 19:49:11 -0700 (PDT)
Date:   Thu, 2 Jun 2022 10:49:05 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 1/2] hugetlb: Convert huge_add_to_page_cache() to use a
 folio
Message-ID: <YpglIRJ43zdDhzYb@FVFYT0MHHV2J.googleapis.com>
References: <20220601192333.1560777-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601192333.1560777-1-willy@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 01, 2022 at 08:23:32PM +0100, Matthew Wilcox (Oracle) wrote:
> Remove the last caller of add_to_page_cache()
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
