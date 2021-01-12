Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78712F3A3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 20:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393048AbhALTYx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 14:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393042AbhALTYw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:24:52 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE919C061795
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 11:24:11 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id h4so2948541qkk.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 11:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KFKKnSZi5yUUQjE1MWzIUZ8OCrYewvjXKnguQMhvjNs=;
        b=psEEy9vD4d5dIvu95MY6SiIBhDJyE9UwJbvsUiq7tCkFQkA7pAMGlYTqt7q0LUqjB1
         BH5JZR6/iSCN+p5I/fpIWz2Mcm7y6uy9oYEzgPC+eKVy3wQ/phUN85ZtdZ/n9VN+L6lR
         Xh/zyEJrgP6uPZEz4J64RfdZq7SiiScaT1/gDFWVBDYkLmHJ6gcJHrqdV6LBI/356n9C
         d2wCpxzSGVSue7OeLe6TkOGKBA/GyqdftrW+axf0YNjx7hwW66zTjEOUnOvwlv6wY5Zt
         XIwWeC8bGU3RfYolHYhlmPGaV8aSUpYoGwKgZcSbeUAeL/fCJVzWdWuJuRHBnwvFOlKV
         0Gjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KFKKnSZi5yUUQjE1MWzIUZ8OCrYewvjXKnguQMhvjNs=;
        b=YglZLIsr45xdU0GyNV7sfB061Rh3doDNc9QIXauPfjsMggLRVZNAf2pDPR9fQB396q
         5sm8bTi7pEFt42TBMVhv3RCOlKJ1hz+zsfIC6g6UQaDPwJvE2pPuEswZyVxTONqifTut
         Ma2VgnCZ4IgzaAya47sOx0o/6pAd/j6K5A9dgJRzWojRDOhj7FEUyj66yq4j5coFEyM3
         UwkA7SN9PO8583wzIYMUBPxxTpOqsZYUwl71NA2RSnxaH16sDYQygCa9xJQCLlYmrLpf
         7ESGgu3lHHqH69wSi6KOBYb+gp2vINYkOvv+38qEXQ8A/nR8pwSCDPw2Yqyy8QX0AFym
         Xg5w==
X-Gm-Message-State: AOAM532JgBmYCGANYyM8Nbsi0vvq74gPw3tG+IZvHVXyK9HbJRGivzoM
        vVhlkFuzTx1GYXVPVuMoNddLFA==
X-Google-Smtp-Source: ABdhPJy4PX7Te1E+CdEv0YMpBSoW7d40fEUnjChPHInGmMUSSjD3Na0Li5sy7QYJx/uWYoByrXUfpA==
X-Received: by 2002:a37:a1d6:: with SMTP id k205mr939074qke.384.1610479450794;
        Tue, 12 Jan 2021 11:24:10 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t68sm1920529qkd.35.2021.01.12.11.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 11:24:10 -0800 (PST)
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
Message-ID: <5c4596ba-06b5-e972-bf85-5a6401a4dd16@toxicpanda.com>
Date:   Tue, 12 Jan 2021 14:24:09 -0500
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

This means we'll write one page at a time, no coalescing of data pages.  I'm not 
the one with zoned devices in production, but it might be worth fixing this in 
the future so you're not generating a billion bio's for large sequential data areas.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
