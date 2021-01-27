Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92DB306300
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 19:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbhA0SHU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 13:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbhA0SHS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 13:07:18 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79727C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 10:06:38 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id u20so2622932qku.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 10:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ytbpICBwwAswu0lM5h+6T7WQmz+iQOy5Eel5alHGS4s=;
        b=pRqogWMj87ZbOiM5Dn6nOJ0T+TBIT7flIY14jFyRT9lkjvSmgbxB+c/axnR7BWQ7LX
         Xy5Byz/pEV5+QgiHlGZXj7d2QXUlLFuvTYQgoO6mmJjmALb+Spx3XQU4ZQmL03EWULHv
         dCnkJ2ze8BodbgwDvtHrVvp7CaYYC+N3DF8j8pp4KNWwbWE9r7MO9syPkXwpM7nbYvDP
         pqIGCmffrVvSYbtZvtyrDahFE834EDCWR3h2sOLdMfF2rXESnFfer6IC12Sx0a0krBPk
         7cF/BCMXJrxI3vEFEkn2PxFqF5OuptYhEMX3EWBZHQGZvzYgs5ISQf1TAsuPiauuLURb
         R/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ytbpICBwwAswu0lM5h+6T7WQmz+iQOy5Eel5alHGS4s=;
        b=qvRY7ooExsV3oICH78Jv+sP/lv4BoLefclRVXA1dKB9WAv/IuEft2Rdhl4Qkz8rQhI
         ZZpmY37FScPr6S7WCYQNBZybJIf7jnUroDqRh5a83M9MJT836VZGaPBmHMPIK0tpo1b2
         RG3AE/iJ5r5Y6lXgDKDYH210H/O25Fn1cpfR7WDUnUxszFqvclWk6psj89S8MxIHP6QJ
         ypNDyzQbElf+BV4v/Xj7CSBoknXUG0QeOOdOzCkpJM91dsxhVBTBT3w0jJ0eHFsJY9jk
         tVi6P4xJuPMV+nJYnkJyVZabZ0sI8Rbb13vMocdnLhgBHS/ZyYpB0JzrasR5F6PKElqc
         7iKg==
X-Gm-Message-State: AOAM531Bujyy5e6gd6s/LcHOPyKz/gM5TenoB6L6T2cHLTXIwBNYFatO
        STMQyWng2y4bA43KBh8OfG/JgQ==
X-Google-Smtp-Source: ABdhPJzrhg1ZW29vb1Qi0qOdClCC1NOTw+/bu5hVd+uWE0Jo9GYf91CnbDLG1Ox3e8UsNnt6SnWtUg==
X-Received: by 2002:ae9:f511:: with SMTP id o17mr11361112qkg.215.1611770797656;
        Wed, 27 Jan 2021 10:06:37 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p12sm1740303qtw.27.2021.01.27.10.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 10:06:37 -0800 (PST)
Subject: Re: [PATCH v14 13/42] btrfs: track unusable bytes for zones
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <a46c503f1419e9a7ec13ab227159e0391d1e6868.1611627788.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <75b2b514-f735-048f-ece0-c5e6976b0a4c@toxicpanda.com>
Date:   Wed, 27 Jan 2021 13:06:34 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <a46c503f1419e9a7ec13ab227159e0391d1e6868.1611627788.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/25/21 9:24 PM, Naohiro Aota wrote:
> In zoned btrfs a region that was once written then freed is not usable
> until we reset the underlying zone. So we need to distinguish such
> unusable space from usable free space.
> 
> Therefore we need to introduce the "zone_unusable" field  to the block
> group structure, and "bytes_zone_unusable" to the space_info structure to
> track the unusable space.
> 
> Pinned bytes are always reclaimed to the unusable space. But, when an
> allocated region is returned before using e.g., the block group becomes
> read-only between allocation time and reservation time, we can safely
> return the region to the block group. For the situation, this commit
> introduces "btrfs_add_free_space_unused". This behaves the same as
> btrfs_add_free_space() on regular btrfs. On zoned btrfs, it rewinds the
> allocation offset.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
