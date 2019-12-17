Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 184151235F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 20:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfLQTts (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 14:49:48 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41203 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbfLQTtr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:49:47 -0500
Received: by mail-qt1-f193.google.com with SMTP id k40so3760937qtk.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 11:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NKnDMkwSwk7/ycnDKkFU/CDHozyI27AAHGCjjPIydi0=;
        b=h5qIyGDqZUYeVRu3LwvM7/NOS/k7+2+GlJdlDKtBioIcMmcRgZVphenQC/oNqERE8a
         H0LIce1e1M6F3w2j18uVckvfUuTa8dc/EIMyaIUQDnP29r/Qp/Grze02Vz8OTcsx4Dg2
         l6vNkuRPBpphD50PXna03rkut5hVA1+qgYwgkczXy2t1MOmnnjLW1JmA4Ef7csK1dkbi
         xgPiJQ+yx3bZA562UhLBjzwy5jd+Tr/H44X1jVSJu7L8U1QIbxnBmkpaP8CHbRYSW70T
         gkR8NBExzuEpoENIISJgO0IzkU4G8u+Y2j6tftoQmH7d70Q4EIfrFcqO6tIHhQBYuJsL
         yhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NKnDMkwSwk7/ycnDKkFU/CDHozyI27AAHGCjjPIydi0=;
        b=qA+vgNZWhxuTIIjcXT0Esj9WehubWug0cFX+1v0Ph4JiNRF3QcSJ6Ua9EbWqUaN15u
         /hyh6vok+r0By26fDc0GqA1bWt9uUqSZILLbslwUlRj1qDrYv7qPtVhccyoFU7AqYt6Z
         yRIX+UHPICe7R0zcK/QS1zhijBBm/p5VGA9BFymGdV+osZy1/HO7MnVSzmHRhU9JVCpC
         KVIs00leIY/mGft67IxHeuF22fRFAt9e9y/F49j1UeHPMTof7ZycBuA1tMaCMIHw5Jvo
         2IHCwfg3q8oCJPC+GyXJzVApzjXY4b8MSZDjquNFUbcTYYR27l4E72HfgX21JdItQQK2
         qpxg==
X-Gm-Message-State: APjAAAWIc8m+8/fwja2dDrOiIXCs3Xf9pWlNFmNBXCY10NlNicibyILd
        73Ds7/+SSnOqXUDPk4j2zWi8GMHOA0N/oQ==
X-Google-Smtp-Source: APXvYqyuUQqim1sOQiqzIkdgOBiD8yJgWMBzZEjmk1aQDkTnuS9WF8GOA8ehSDIMQndQFKlZ5y8SNw==
X-Received: by 2002:ac8:7b9a:: with SMTP id p26mr6176737qtu.281.1576612186375;
        Tue, 17 Dec 2019 11:49:46 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::4217])
        by smtp.gmail.com with ESMTPSA id t2sm2280487qtn.22.2019.12.17.11.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 11:49:45 -0800 (PST)
Subject: Re: [PATCH v6 15/28] btrfs: serialize data allocation and submit IOs
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-16-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b11ca55e-adb6-6aa7-4494-cffafedb487f@toxicpanda.com>
Date:   Tue, 17 Dec 2019 14:49:44 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213040915.3502922-16-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 11:09 PM, Naohiro Aota wrote:
> To preserve sequential write pattern on the drives, we must serialize
> allocation and submit_bio. This commit add per-block group mutex
> "zone_io_lock" and find_free_extent_zoned() hold the lock. The lock is kept
> even after returning from find_free_extent(). It is released when submiting
> IOs corresponding to the allocation is completed.
> 
> Implementing such behavior under __extent_writepage_io() is almost
> impossible because once pages are unlocked we are not sure when submiting
> IOs for an allocated region is finished or not. Instead, this commit add
> run_delalloc_hmzoned() to write out non-compressed data IOs at once using
> extent_write_locked_rage(). After the write, we can call
> btrfs_hmzoned_data_io_unlock() to unlock the block group for new
> allocation.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Have you actually tested these patches with lock debugging on?  The 
submit_compressed_extents stuff is async, so the unlocker owner will not be the 
lock owner, and that'll make all sorts of things blow up.  This is just straight 
up broken.

I would really rather see a hmzoned block scheduler that just doesn't submit the 
bio's until they are aligned with the WP, that way this intellligence doesn't 
have to be dealt with at the file system layer.  I get allocating in line with 
the WP, but this whole forcing us to allocate and submit the bio in lock step is 
just nuts, and broken in your subsequent patches.  This whole approach needs to 
be reworked.  Thanks,

Josef
