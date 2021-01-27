Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F223062FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 19:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343786AbhA0SFA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 13:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344338AbhA0SEe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 13:04:34 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A37C061756
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 10:03:53 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id a19so2638375qka.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 10:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4rPnUBxqM9G//9qOahLs/sqsjnaOAWtvt4RahjK16Io=;
        b=Hs2ULQi2fn7qbjMoL3CTXn8N9CbwumqD/j3rTIruytU+XgHRSrQyw1uGg1YbAWX/H0
         3bBcGEugqz16dCJ+jaOMj3t+Eni2UpwQnHI4WahoCfYgHJyn1MbxzVN4JZ1tXtToNEr5
         iB2ucn93nR/PnFhIzXXugzRmj9TIZyPWDdKtDzKUUrrsE1Zx298sSPTTfD5G2ZGnIw3T
         XOKZfOa//mjhr8RNppX7yh1KHppABdYziF4cC8DIM3Oy84s/BPHya5vcwsNvmB3fa9aN
         wq4oboFRHcqdE1F29v5DUMtQMvNsEKynI0yOgMGIeHUz5jh5X51tgthYW0MZjI5USDW3
         YSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4rPnUBxqM9G//9qOahLs/sqsjnaOAWtvt4RahjK16Io=;
        b=PWgAMYgCzo5DCUDD6mmVIMGGk783DalpnmlFtD2pyy5IMWvHUSpPyQ7ObTDLtcf6BK
         E1fqq9GCLawxGW1ubKEmrYYdu/sy12DBpyC+yggnZkv2u3XVCdBNytccsdRZC2T8xP2Z
         ygOvayPSKE6MDG2GegNkcXdL6kbQzXclOPFJV/NkYf0B2tJwIKgHCgkChUAr7cAw2ICL
         5d/7aosKoQ8j4IiJj5JFI4Xz+QTCzjlrfSusYYZSKxVSAvXvoiCCCs8h0XKFhGwBYMvW
         LrxXSVAzKyKniS0tk0V38PiOvPVsBaN9fsZ6542hDYqWdYK+wjq4G1D7B3nqYldhwVbu
         lNJA==
X-Gm-Message-State: AOAM531E6glY9PRxfYKgcqxRGtPNWdPE93uT1ZyEiLys/QjElqSu4O1l
        oGkWyrVcW9ZMidTSYjKDlY3U/g==
X-Google-Smtp-Source: ABdhPJzId3KvIqJDJtpQpeAHUX93XlW64tCFrI4jvwLDR8RCIYAMydCiNsdnFq9+7dRo2Jt9VNDn7w==
X-Received: by 2002:a05:620a:b04:: with SMTP id t4mr2672162qkg.392.1611770632039;
        Wed, 27 Jan 2021 10:03:52 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g128sm1579216qkd.91.2021.01.27.10.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 10:03:51 -0800 (PST)
Subject: Re: [PATCH v14 12/42] btrfs: calculate allocation offset for
 conventional zones
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <583b2d2e286c482f9bcd53c71043a1be1a1c3cec.1611627788.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6b8a86e8-b0cf-a188-a92c-b38be2146ccf@toxicpanda.com>
Date:   Wed, 27 Jan 2021 13:03:47 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <583b2d2e286c482f9bcd53c71043a1be1a1c3cec.1611627788.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/25/21 9:24 PM, Naohiro Aota wrote:
> Conventional zones do not have a write pointer, so we cannot use it to
> determine the allocation offset if a block group contains a conventional
> zone.
> 
> But instead, we can consider the end of the last allocated extent in the
> block group as an allocation offset.
> 
> For new block group, we cannot calculate the allocation offset by
> consulting the extent tree, because it can cause deadlock by taking extent
> buffer lock after chunk mutex (which is already taken in
> btrfs_make_block_group()). Since it is a new block group, we can simply set
> the allocation offset to 0, anyway.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
