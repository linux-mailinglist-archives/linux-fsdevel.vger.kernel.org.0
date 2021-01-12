Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB4A2F3B1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 20:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393168AbhALTtB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 14:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393150AbhALTtA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:49:00 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572B1C061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 11:48:20 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id b9so2445797qtr.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 11:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RQu649TCaHDomH3kJ9pQ/RlBs5AkiynTs8OoFIdtDkg=;
        b=R4poAMTo0NxjaFebhk2GZJAhM9Unpc0R1IdmZZhfJslc6DizWOOYRMonQd5IGAh4ym
         a7YqyanVTeXJp0vI0zZcsIaCCe6yXFG0/iMZ9aJz4YKyNCpe2KOiIZ/KGk4+QqRsuDHF
         2NqkACvQy+K7f5YqOH2Q8TPwxrw5jKIozipWrkUEr7XsRfokako/kUL3bzyvvUkhHsod
         QwVyOdyK56zohlx/lA9HQCz3HNLm9dKUyyIehd9ER5NKR5HA1df2jIlHk6xnSLme8phc
         GO5jBzrPS4SWIHuk2qJE/sIpfzzV2BADAK0qTbWiXaYCw/bcUbiXP1tdHMVQPBSqMC+J
         0Y6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RQu649TCaHDomH3kJ9pQ/RlBs5AkiynTs8OoFIdtDkg=;
        b=ne+G6E/9983JTOH7/b/WMQOlA4u5IpSEvTkPCLJ8uIbM8gQ6cNlf6fW3sKD37PObw4
         MRvGg/ZjLHJQavFdHMUD8oi8MV3f6N/9wtAK6wHQRWvLPAckXvZmKIlMcc+QOMQFfpIV
         3/Vr3qJ4RhJuQ0By7qUG9r/6Ph69P2GmVGOCAusJZ60pSlK7ZcDI/P0ghUOJWNUErHCI
         a4fbwGXqswWebBDSBcbIj3Z95MEftAba0Byes3v4HRu7DDzJ6vQUBCViC06XmyGZV1R/
         5F2ejAu1ImNlbA8Z1wwMHXTB5iLp2QjovNzphA2cKcxQK02wLEDDZPjt5PDFfmSPUKCg
         CbHg==
X-Gm-Message-State: AOAM530DX04LJVXnZew2dfp78LDmhxSFT87IuJbUvK/qCKFRA7Cq/Kj4
        6TBfzgKTl5pfsUGcDqyGQH6HMQ==
X-Google-Smtp-Source: ABdhPJzTdoWIagOiLEsA0cW3o4JkxiK0suExusLCynYO7U1yahdA+mmhUfJqqpCOmP1TDLfxDsWunQ==
X-Received: by 2002:ac8:4f45:: with SMTP id i5mr652046qtw.349.1610480899510;
        Tue, 12 Jan 2021 11:48:19 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v5sm1915088qkv.64.2021.01.12.11.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 11:48:18 -0800 (PST)
Subject: Re: [PATCH v11 38/40] btrfs: extend zoned allocator to use dedicated
 tree-log block group
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <920bc20e9b4b1bed3802c3dca6f9fa3c72850804.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <824b1581-973c-42aa-7ff6-0d36cb4e5249@toxicpanda.com>
Date:   Tue, 12 Jan 2021 14:48:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <920bc20e9b4b1bed3802c3dca6f9fa3c72850804.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/21/20 10:49 PM, Naohiro Aota wrote:
> This is the 1/3 patch to enable tree log on ZONED mode.
> 
> The tree-log feature does not work on ZONED mode as is. Blocks for a
> tree-log tree are allocated mixed with other metadata blocks, and btrfs
> writes and syncs the tree-log blocks to devices at the time of fsync(),
> which is different timing from a global transaction commit. As a result,
> both writing tree-log blocks and writing other metadata blocks become
> non-sequential writes that ZONED mode must avoid.
> 
> We can introduce a dedicated block group for tree-log blocks so that
> tree-log blocks and other metadata blocks can be separated write streams.
> As a result, each write stream can now be written to devices separately.
> "fs_info->treelog_bg" tracks the dedicated block group and btrfs assign
> "treelog_bg" on-demand on tree-log block allocation time.
> 
> This commit extends the zoned block allocator to use the block group.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Tho if you have to touch this thing again I'd like to see a helper for clearing 
the fs_info->treelog_bg, since that code snippet is duplicated, but it's not a 
big deal.  Thanks,

Josef
