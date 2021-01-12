Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615412F34F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 17:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405515AbhALQCX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 11:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405499AbhALQCX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:02:23 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE7CC061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 08:01:43 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 22so2228994qkf.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 08:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0L9jT0ymm+dII/abfSrf2Na0VP9LxfGIQiZmMeSzjkw=;
        b=BADWoTWvTfExEiqzb6cCqRMp2Okf3vocLXZYF10wXNS5Rcr56E8P7bchV4KVQfVbvp
         l8XekXnpSymARkY3UNOr9VrAT2SjTmMpmp7f+LwRgWlq8OrE/D1P0kQzR2CGIIVbe+k5
         ktpf0bdnfuYdJEvnFc8wadhYxmqGGIKZ/ztGRLw18jLnEm+jc6MR3bzUjhdR26CXcQUs
         3KwF72GLqAyqc2wfg4+QNB7kLEWpNubwbUiJCyQ7oibpswlkfuxfYS3I63K+Z95cditJ
         icFuv6h0f2Fkc1oxDbIhf/1+lVyDF8jFbrf+oG1Jluq3N3F85HzzSkalHHA0dAEgKbCY
         vYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0L9jT0ymm+dII/abfSrf2Na0VP9LxfGIQiZmMeSzjkw=;
        b=HhdLVa/PqmGB278ixXwahmMFaeh4e5c/xrwcbPvYUb/EXVxD+rL1R3Y2SX+Dpqj0qJ
         S7xYiAdSRrAWSQfxpSIrZGfGXYz2nvKuIPo7g7XCbG1nzXBJwF6kBSsHXJXFmcEXPos6
         suBtq917u8CrJfDKu8wXZ1AZXEOjhUJd9/cVjHN8P87FzqNEXXkPDoido2OvENQn0Njw
         x1DbAeNbhpKeWqrqA2KLYVZ7rgtdzfWtO43pn4K9pS165LmlTUlVEtPwlFr/D6M319OV
         3yMXpglsZOXFG4MU1YM6ERY0IksZA6PLUvV3dCtCVt+9/K240byTRLdX9odxeG2r+qtr
         4Gjw==
X-Gm-Message-State: AOAM530k3U/kZKZK01AEYdp10EoIMWryx9q+k9Th0PcFkNaq1ti8qHlL
        iInNtjVa1pNXYwDBiX9rcrSgrg==
X-Google-Smtp-Source: ABdhPJw/mc8V9i6x/AU4+wocb54KtzZQ0AI343r2LT0BadnoOVrzSAY+kwuhC8/4z4Gk3r2/Spf7DQ==
X-Received: by 2002:a37:4bc1:: with SMTP id y184mr5324042qka.278.1610467302241;
        Tue, 12 Jan 2021 08:01:42 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r190sm1525356qka.54.2021.01.12.08.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 08:01:41 -0800 (PST)
Subject: Re: [PATCH v11 24/40] btrfs: cache if block-group is on a sequential
 zone
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <8fe22c91f24d5e79c8dbc349538908d7ba0bb2a4.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <11b7f357-f31e-2243-062d-fc40611fcfb6@toxicpanda.com>
Date:   Tue, 12 Jan 2021 11:01:40 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <8fe22c91f24d5e79c8dbc349538908d7ba0bb2a4.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/21/20 10:49 PM, Naohiro Aota wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> In zoned mode, cache if a block-group is on a sequential write only zone.
> On sequential write only zones, we can use REQ_OP_ZONE_APPEND for writing
> of data, therefore provide btrfs_use_zone_append() to figure out if I/O is
> targeting a sequential write only zone and we can use said
> REQ_OP_ZONE_APPEND for data writing.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
