Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD012F1EC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 20:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387445AbhAKTRV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 14:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387724AbhAKTRV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:17:21 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5A7C061794
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jan 2021 11:16:41 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id e15so65864qte.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jan 2021 11:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EOIAHZy7Alr8j0pKyIV99mgIDJFNi3YsWZPV/tFxciI=;
        b=Rv0JtkE3sNJWZpvrJPQTHpAG6CzUTdY4fYgqMvTNVg+8Zpuc52jkJ2q1qb0jj1I8nN
         4Hlhzx+x0yRbv4yrFXrBRI/sd+Gsf2PEJUGvquMY6V73JNug6wlzc/vsRQpG3Q0B3AC3
         j8sX8eJiHOfnktBqo+eDB5FzD4otaF8o/OqWm583fAIQnCRQT0+Dx59198BppCDpomq/
         AsV/Tc55Nj8EYfz0AczTAtr8eWnCN3LSj3FzNOME1wtRKBe/C2liJAhY2cqM2xmipFvr
         e9dgL5+R0Gqe4Qcm9JHfZpqJQSOWmdo3CnKqFzpUqF6xRx4Y7D6c8CUD3rVB/duBQpje
         X/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EOIAHZy7Alr8j0pKyIV99mgIDJFNi3YsWZPV/tFxciI=;
        b=IxLNxcxSRweHJsJ63yzgENShghb65F9rD+ziPYeEZryr3SlhL7ehXv5CHC9S46CjyN
         ZOpaoKOyp5vll8ShymY6NxvVJHHgi8nFQBtGANxJXVEVFCiRo1+o/VqHMzBzBWicOuzw
         nNvvGaiQuigGu+SxjIqUfHlEFyBLLo3QZ/oF741+KHqV985otL18TzFtFPaUg+7L01NO
         UGnXlu6nLgj7gtl3VKPgKc7HbZOIAYi1SftMNHN8HCmPA47pplgOahxbbXYAn+/DNSL+
         L7uDRrbF5qAE/z3u8+j/D9KrKQFcW53bG6zLHZfILxXcYJtiMoziXnUD6yw5qtbJd5RX
         MFKw==
X-Gm-Message-State: AOAM531BKC4f9KS9P++l14bb5M00cTfjl/F6d8qH+AQHXx3tYB8OsONh
        1SoCKPXoxVm2eNzXlo8g6+m7uA==
X-Google-Smtp-Source: ABdhPJxm4i5VdPQb/eP5QpGwRg3sntj8WZF0Msn9gz42PlqLZvCHhmdxl9uij6E89ihSRlw99Ix1nQ==
X-Received: by 2002:ac8:6b59:: with SMTP id x25mr1061609qts.301.1610392600388;
        Mon, 11 Jan 2021 11:16:40 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x185sm415721qkb.87.2021.01.11.11.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 11:16:39 -0800 (PST)
Subject: Re: [PATCH v11 03/40] btrfs: defer loading zone info after opening
 trees
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <ba41ebbfe3a47b0088a50d7d6eddb28d99cc9d83.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <fa8c5079-d681-f2a5-bdb5-175ad0ebb59d@toxicpanda.com>
Date:   Mon, 11 Jan 2021 14:16:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ba41ebbfe3a47b0088a50d7d6eddb28d99cc9d83.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/21/20 10:48 PM, Naohiro Aota wrote:
> This is preparation patch to implement zone emulation on a regular device.
> 
> To emulate zoned mode on a regular (non-zoned) device, we need to decide an
> emulating zone size. Instead of making it compile-time static value, we'll
> make it configurable at mkfs time. Since we have one zone == one device
> extent restriction, we can determine the emulated zone size from the size
> of a device extent. We can extend btrfs_get_dev_zone_info() to show a
> regular device filled with conventional zones once the zone size is
> decided.
> 
> The current call site of btrfs_get_dev_zone_info() during the mount process
> is earlier than reading the trees, so we can't slice a regular device to
> conventional zones. This patch defers the loading of zone info to
> open_ctree() to load the emulated zone size from a device extent.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
