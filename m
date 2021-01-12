Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3E22F3A64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 20:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436691AbhALT2Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 14:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436685AbhALT2Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:28:24 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF9EC061795
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 11:28:04 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id bd6so1438201qvb.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 11:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zLQy1IUOCHDg15kQZt2C3FHFO0LwngRYm0O+AhN6YVc=;
        b=uHj3X0mODo1G57l45ybobb+L+GFwBk3NrtLlTV9N6rbqX5NMRY2Vn3wCaJDhDO0YUi
         wqArcCBSBLvKLV5fGMGWlTDvN+b72V2rJFkWkNWO8bcQbjAeuNA5rBfJNpRpK7UHz3fR
         BEZugo7Nbn3MyndKDq6I1/htzE8Y/IcFCsZMODoOd5VkGryCObnto8h6+cFKTff/GIOd
         BuOSn+MxRdAPNi6K24TvPWEFsMvBxTcdswv6Mfv6IAsnnHh8PNIxKUUgmfaNgfSfPmr9
         CDMMRJe+vFblSMJhpJmgJsv2sRrunk2B44lM0VSePIgvhiqFHiAuWknJWwoI5tbXbjSR
         +Lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zLQy1IUOCHDg15kQZt2C3FHFO0LwngRYm0O+AhN6YVc=;
        b=OzOywHkF1OZ5VwtR6glErWIJlAjvufK+373Uq+F+cfg+gH4qa4zZZ/QKz5JE7KDe/R
         n2WuR3GHlOHAQI4rnFEPhjIrpkQMFlFTFA+rxTMrvArCd8ya7ftbeMv6EMkWidKdLcI+
         jw5gkzLf4p13bWKlsLeiv5mC1odEgFZvEUU+sALp/ZZ+9oa7Q9cTruGx9TbyhP99e1Ep
         PbwrUUIIcTw/qvBvnajTsJff+SEJTr2bDnorbmmBGHvIQvk/PtNafpXsIgdLvstn9FHh
         Av5dL64CHBAG6/XAXHwvkzFsbGS1hwcqgVEE8UpTDRKEcoAMXJ26UoIapHZ/Xtt4WEPO
         xp9Q==
X-Gm-Message-State: AOAM531ZB40dBMotS2Wu2aThZY53VJk0odUvBpqAv1JvezTzIaOK0BWN
        LvpLHH/L4mi2S+NWGeWnKusb2Q==
X-Google-Smtp-Source: ABdhPJwyrSANMfdDOH90si78FzE6fCPqWk/ZdNmTx/KAM6IfrpKfdmErj7B6rRod3/il3eluV1oM7Q==
X-Received: by 2002:ad4:4870:: with SMTP id u16mr1026023qvy.44.1610479683274;
        Tue, 12 Jan 2021 11:28:03 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z78sm1907837qkb.0.2021.01.12.11.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 11:28:02 -0800 (PST)
Subject: Re: [PATCH v11 27/40] btrfs: introduce dedicated data write path for
 ZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <2b4271752514c9f376b1fc6a988336ed9238aa0d.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <bfd898ed-25ad-11f7-2998-15868bf80695@toxicpanda.com>
Date:   Tue, 12 Jan 2021 14:28:01 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <2b4271752514c9f376b1fc6a988336ed9238aa0d.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/21/20 10:49 PM, Naohiro Aota wrote:
> If more than one IO is issued for one file extent, these IO can be written
> to separate regions on a device. Since we cannot map one file extent to
> such a separate area, we need to follow the "one IO == one ordered extent"
> rule.
> 
> The Normal buffered, uncompressed, not pre-allocated write path (used by
> cow_file_range()) sometimes does not follow this rule. It can write a part
> of an ordered extent when specified a region to write e.g., when its
> called from fdatasync().
> 
> Introduces a dedicated (uncompressed buffered) data write path for ZONED
> mode. This write path will CoW the region and write it at once.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
