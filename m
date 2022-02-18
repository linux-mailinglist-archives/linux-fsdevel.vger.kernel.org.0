Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA61B4BBFC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 19:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbiBRSns (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 13:43:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239337AbiBRSnh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:43:37 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351182A0D61
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Feb 2022 10:43:14 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c192so5770600wma.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Feb 2022 10:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=algolia.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=orCCOR7r9pXl+8mlMsq8CUD1TrMdL21O1JGEwb9J58g=;
        b=iz6bhBjfeDWwOmTAZHyHLm86k6kjSIW1lWvtFTLe/zV9DQXcTFIkffdjVVOIcKsZL7
         PrxzWQIr0Xv4gJOov9fFbTA1R6tqf3BpFOl7tBUywa2aFov81EYAX1satx5UK44P3uAt
         qhOEaU2Ym78P5bS4wdiojn5yX52ZhcdgPVKI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=orCCOR7r9pXl+8mlMsq8CUD1TrMdL21O1JGEwb9J58g=;
        b=761L51i7ztek0Dz1+usMoSeIrRjifwPEwice60SlJ41og0dQAzNXFBlg8uhZEvgZhH
         yD22vPLk5BDlwbCbTsq+FDt//HC9yd8uwG9ZavViwaoKCd4weGvEDx2UubB5bbc288Hd
         /HINKwhQxWp8ekURVcjHD1eT/FKt33j8FIEaesm1i3fv7+zGyrvsljumU+xACUHNXF5h
         HX/M7tWP/liQiLob/zGmNo3pRRvR1OFlJ7g9ESHe9Mz+R7NvK7hNDOamHBmscIesdf5X
         2+NVNWSrL7dLytMUjMP7EFpZb8HYnmm8bbQu15dqOU+tAwtdmmMwUs6NSoCsNavJDPZY
         9NwA==
X-Gm-Message-State: AOAM530iw4AyPOkSyQKQ1cOUkKB1do6hOrh6PvQIM/k6KPaN4xHsJemT
        N4CmVtoOF+Ty0NeqKu9mg0E2jA==
X-Google-Smtp-Source: ABdhPJyevz9tSC8A0Z+WJdqdwhZwuWTwV20iT8VlBV5uYkA0vOkgJf/NiwOFtPx2C1IlZCA6ajOc9g==
X-Received: by 2002:a05:600c:220b:b0:37b:ec02:32c4 with SMTP id z11-20020a05600c220b00b0037bec0232c4mr11938531wml.11.1645209792687;
        Fri, 18 Feb 2022 10:43:12 -0800 (PST)
Received: from xavier-xps ([2a01:e0a:830:d971:a8a3:7a18:7fc0:8070])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c338600b0037c322d1425sm187852wmp.8.2022.02.18.10.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:43:12 -0800 (PST)
Date:   Fri, 18 Feb 2022 19:43:10 +0100
From:   Xavier Roche <xavier.roche@algolia.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: fix link vs. rename race
Message-ID: <20220218184310.GA242779@xavier-xps>
References: <20220218153249.406028-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218153249.406028-1-mszeredi@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 18, 2022 at 04:32:49PM +0100, Miklos Szeredi wrote:
> Reported-by: Xavier Roche <xavier.roche@algolia.com>

Just one minor detail for the records: this was tested by me but reported by
another Xavier. But that's not a big deal.

Reported-by: Xavier Grand <xavier.grand@algolia.com>
Tested-by: Xavier Roche <xavier.roche@algolia.com>
