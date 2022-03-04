Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C524CDE13
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 21:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiCDUU7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 15:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiCDUU7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:20:59 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2BE12D227
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Mar 2022 12:20:10 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id mg21-20020a17090b371500b001bef9e4657cso8126962pjb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Mar 2022 12:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=MzIVLFYgbIHKi0WfmGy/b7PPLkLPtlBjK1VwtmfcCaA=;
        b=2xgKttVdE+/3e73yVrW7xAHaDB3kKqtj49qJHIQnLCF0m/Opwy1KSuE9in16hG+ho5
         4pncR48ceZqaBfGLvTX53Sn2ScC1bZ6IsUHeELUi3rPOasHA0Xq8YIAJ4WOEq7PMYR5x
         OZcZaSdaQeFi70GWxawnI2Qy0xZE4Ltqs0zEZeMIBBIFT31oDwKMNHfE7Hfd4iFuqtU1
         QIlBlYTLi0Q++xOVL4tXESTdjUyZPOUAvjuufrwIQ6DKdOVG9Q6xK7pOCnZmRPvD5ifH
         /KkHUjNb5CadrWEaCLx4pT8+ljYKkchUVh3UvokT/F0ByHWSmvTVXZ3rLMg5LGBADHpa
         dk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=MzIVLFYgbIHKi0WfmGy/b7PPLkLPtlBjK1VwtmfcCaA=;
        b=pKAWN/SlAtB3NVQrWAOqvfRq0TI6OKzmtFELuO1G+vmVWtjQZqE9UzXmI2anLI+0jc
         4o6kVK2u8PPMLQsATdNSyd/XCqLdocZQXT3V4HXlwFlyy9FbHvRtbgDpoV/keT5R6iHM
         G8++Gr5G/aehFi3FNusA83QBUpjvTKjA4+NeY96qX2XJvj1OPn/KqD8Qn/Q/DAFZo5eP
         7oysFNH058ZImoWlapyvuM7UYvBRIfyUvlkY/fNgktdCZSQIKDHmJYnCLtrTJkr0SOJU
         5ZLt0s2gDebuSps0b8BMXsy8i7WIIXc3mIuotcNXHaOkhUmWcD8Z/2hcmzIAaOro5qoP
         GelA==
X-Gm-Message-State: AOAM530Xya+aZn+zDMH1rpNeN8SvxwfU1/iBZ7lgNOdFj/brICyzc0Hr
        rc8x1mq9qMi5fRHmpgI0LFBioUONrGVmgnFm
X-Google-Smtp-Source: ABdhPJxzNrjaHLQHQLD/BhExavFf9aVSlD7kGy6+cUzSlMmSh60/B/1lked5Soafp5AjkDLXFnEiCg==
X-Received: by 2002:a17:902:7404:b0:151:c3f9:e43a with SMTP id g4-20020a170902740400b00151c3f9e43amr105492pll.12.1646425210378;
        Fri, 04 Mar 2022 12:20:10 -0800 (PST)
Received: from [127.0.1.1] ([2600:380:777a:c32a:5fa9:a654:f35:71f6])
        by smtp.gmail.com with ESMTPSA id mu9-20020a17090b388900b001bef86b7d92sm8488608pjb.24.2022.03.04.12.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 12:20:09 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org, sagi@grimberg.me,
        kbusch@kernel.org, linux-raid@vger.kernel.org, song@kernel.org
In-Reply-To: <20220304175556.407719-1-hch@lst.de>
References: <20220304175556.407719-1-hch@lst.de>
Subject: Re: [PATCH 1/2] nvme: remove support or stream based temperature hint
Message-Id: <164642520857.251407.3488369238595834309.b4-ty@kernel.dk>
Date:   Fri, 04 Mar 2022 13:20:08 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 4 Mar 2022 18:55:55 +0100, Christoph Hellwig wrote:
> This support was added for RocksDB, but RocksDB ended up not using it.
> At the same time drives on the open marked (vs those build for OEMs
> for non-Linux support) that actually support streams are extremly
> rare.  Don't bloat the nvme driver for it.
> 
> 

Applied, thanks!

[1/2] nvme: remove support or stream based temperature hint
      commit: 86cc47f6c199a71fdb28fe781174d9974ee14304
[2/2] block: remove the per-bio/request write hint
      commit: 6928b8f7eafaec1f0ea318fec71b537a165e552b

Best regards,
-- 
Jens Axboe


