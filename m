Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC35300721
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 16:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbhAVPYn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 10:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728821AbhAVPY3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:24:29 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C31CC0613D6
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 07:23:48 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id n15so749089qkh.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 07:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vjBhquyHjvS0CTkIizBcxUjpPUd/gpXlah2dnfq4vFQ=;
        b=qO2PmzO6I6FAjS4HjTFMQYUT8mhYTtwiS1jja2ayqehzSRBGssovHGK+WDiU3+52Fx
         xq0V8441ThGBtuRdfs0D8RodVch7uYSPR07k3spvx9KNOVKYC9I7KZAVmvDwKRRUftZb
         kb3kgoHIh5SglSl4DuovRt9lNS7ed9NK8fpSdXALI14l54TKM8iwpc9VV3Rsj0zQQKrQ
         FO/M3MprCqt2bEDgJkrY1UVuAkat8SqSiXQpb5SfgPn8obBS2jpoDcH5Cy4HlZaefisH
         Cbe51W23oTyFn0/Fa6N8pwOTTIvXiyXQ9p0eG335ex6CldCGlM1DGIg0To5I5c/+n4Xb
         P9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vjBhquyHjvS0CTkIizBcxUjpPUd/gpXlah2dnfq4vFQ=;
        b=Jyn0wSnuNqlBC5+7jNnjCMI433Dfi7d9R0IVZlFjAfkhJ1ykTcYJYYwL56noTqC0x+
         Q5JevQVQDGnIZG/+z8lpDXbBHaWqWtzQnljEmii6LjPE8eM3FvkpywtMDLzoIhYLAo+2
         kjvv2ZNHyoMveteBtLCSa+4c/HwBmmx3iVSJvfead/NWxrSgxDbRheg+BJZJWu+bjn43
         jNfmfBpiR/ZQYqYEhWIZT7h8YlUphHkMs1p7tdo+ryjwtvN0hHFZt7akJBIR+gbdN8Uf
         levBawOhgj5fKGl3Zp+3lZhj2aS8IbZNFDM/17TtGSCFXJvWm7fWecvy4KUUKd6yBDcu
         VhiA==
X-Gm-Message-State: AOAM530zlfJsA/8TqkR80Qh0vnABNTf7kL/wc8KcHIiEQhCKq6jxpJAh
        /9Z5UEb5FKG+OXIQTyknXdOlQQ==
X-Google-Smtp-Source: ABdhPJyIowoTrLV+9FVo43Bn4OQY6BdIfHAk0ibgHlzeVNc6g/po1DdT63FodrDxm0dLO5LB8kuzrQ==
X-Received: by 2002:a37:4d8e:: with SMTP id a136mr5065891qkb.317.1611329027389;
        Fri, 22 Jan 2021 07:23:47 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u1sm6204719qth.19.2021.01.22.07.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 07:23:46 -0800 (PST)
Subject: Re: [PATCH v13 23/42] btrfs: check if bio spans across an ordered
 extent
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
 <b82f4a6510eea4dd567251d52311add6dcb8e4b9.1611295439.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1f07b000-32c3-9844-0b3b-65a265718baf@toxicpanda.com>
Date:   Fri, 22 Jan 2021 10:23:45 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <b82f4a6510eea4dd567251d52311add6dcb8e4b9.1611295439.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/22/21 1:21 AM, Naohiro Aota wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> To ensure that an ordered extent maps to a contiguous region on disk, we
> need to maintain a "one bio == one ordered extent" rule.
> 
> This commit ensures that constructing bio does not span across an ordered
> extent.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
