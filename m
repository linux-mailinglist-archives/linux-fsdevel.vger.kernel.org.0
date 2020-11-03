Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466652A4ABD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 17:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgKCQFW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 11:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgKCQFV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 11:05:21 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE91EC0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 08:05:19 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id a64so11727940qkc.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 08:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RRaeRyma+rFExA7OcsLY5lJGO7CxG8L3qmNLqxc/usg=;
        b=eQmTRqfJziGAqLnUabsrNFicBL9PQ9qViEA879pfnchc0pB6t7lru3bNcmBHn66wIC
         7njnkF8CiSm0eIgGH2u5R2OGjdKnpYzbD/lMV0XRqZBkJQlfU4vzQI9pjA83DwkIj4E2
         l4cq9erVPXE9EVSYDutK2dN0U99on4mEQJaue3BMMIoYIMdRvzv43kwLe7K/4rr5Dyr3
         FlJZ0LwXBV5d1gA1R69CqdOsh5c4G0A4NXJ608+D63mcx8KSbGBP/GFxkkiKaQUQeZzb
         AgAx/97uc4SmPgJ1+WpQAk353R6kKj3K6ZwNUeVPJ0zMM+DWeoHRDhIDr4BZabuz/aXS
         ck8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RRaeRyma+rFExA7OcsLY5lJGO7CxG8L3qmNLqxc/usg=;
        b=Gnn4SWhoUgCuvugAEz46+0b/rfvtXjMDKrXMwny8eKtQrDj7bgfSz7pT6RtSgF618F
         2WxJV1pKCO9H2L6w/zA7Howk+2XxFpsfahegP1LG6mNWUPh9HxCcb130tJPpdTLpCHRV
         CNgYRtN7Jjlm83qB7kXPOFHiK3qiYmOIorDN4b96aCpJZt4G/GV8k/ZGBhCIVnpaibA3
         tF6EtefjX3qabT9AuC+kMpsgj8SgoRv1gn87AaUxHYNxek+Q9y7igcJbiODKoJPDM8B+
         Ed86Aw6feY6zJ0X5ZR3298pVoXfJubWbtANoshUzizzhb95gmyP0p9Cjfj4jDqaH+JV3
         iKMA==
X-Gm-Message-State: AOAM531E0jUX4OXgMKW4b6wW4MmsVb+v066oHXTr+l/tAu2GaAJpgHNl
        Ty3rrP7Lvly7ZtkJhDObewMfVxiYr0kFbUNr
X-Google-Smtp-Source: ABdhPJxL/pLj1hrYMzq78X/mm+TIGu300Em3sbbFnTDdgvra/9nwVci4yT9hHvH+6gWeXoCefuMnfg==
X-Received: by 2002:a05:620a:856:: with SMTP id u22mr20430384qku.84.1604419518716;
        Tue, 03 Nov 2020 08:05:18 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k11sm4118646qtu.45.2020.11.03.08.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 08:05:18 -0800 (PST)
Subject: Re: [PATCH v9 30/41] btrfs: avoid async metadata checksum on ZONED
 mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <3434830b6fadf644c5a47eaaea6759c375b39ad7.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a8ce8d2a-bcf5-1d0f-dd60-5ac4905049f0@toxicpanda.com>
Date:   Tue, 3 Nov 2020 11:05:17 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <3434830b6fadf644c5a47eaaea6759c375b39ad7.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> In ZONED, btrfs uses per-FS zoned_meta_io_lock to serialize the metadata
> write IOs.
> 
> Even with these serialization, write bios sent from btree_write_cache_pages
> can be reordered by async checksum workers as these workers are per CPU and
> not per zone.
> 
> To preserve write BIO ordering, we can disable async metadata checksum on
> ZONED.  This does not result in lower performance with HDDs as a single CPU
> core is fast enough to do checksum for a single zone write stream with the
> maximum possible bandwidth of the device. If multiple zones are being
> written simultaneously, HDD seek overhead lowers the achievable maximum
> bandwidth, resulting again in a per zone checksum serialization not
> affecting performance.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
