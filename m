Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FB62F3AB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 20:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392907AbhALTht (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 14:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392791AbhALTht (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:37:49 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10290C061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 11:37:09 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id b9so2419056qtr.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 11:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OvdQirYZyqp+uo66ZvPAvwcefUbcRGNX5FjNoF+XJko=;
        b=kMxohQmqi7GM2zs0T7kzfVf7BcHTGhTE836tcLo0Q0B83ZLUiP/MGgXYFu3AK9QYhl
         ZkS3Gt6OP47HPOFAylYSnBALpSWSKq8Ep6OWAMvC4COPyLht33YBVig2z6IDWLtnVr7n
         UiU9yANVNwTeYcF1Aq9DVoHuSrWxY/5tG4AQPdhwThk7oK/AVSJ3HFcNoIim+5H9e8fp
         HwW7zA73OK1xUaH8eQvSU8+n0T5KqzdSfoXlQCsKgreqOg3XYxemnPvqbuE3Rqm5kWUS
         lYEt/xH1/KG16Q7SN22tZnoTy4kLKcHsE6JkBzWezgWzmqOIr6TfjcozcKenG3SZSIDY
         H7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OvdQirYZyqp+uo66ZvPAvwcefUbcRGNX5FjNoF+XJko=;
        b=dDD1eNPbPOhAz0sGb+Jv7gtaaODsPu3BOaOqV2THSPs47H6035XINeF5nn383TJmar
         ZVWmdp3B94KlANYiEFLcRzw3xZg9cKMFLB1D8gW+DmBma2KEJT17ZpET5v9c0c9TIBGf
         C74s9vMEzBmS48dh9Jwwl9wioxkQqxAqyA4agReRCv4rKcsMuy4jEtx61xY8HTbdpOy6
         aPe3IY+kshYVRJMRHF+GdZqqJOKQAPRZod3WHqMCbnxNzYlgo4p9Rohh14bDYi2xe2vL
         73rtzWbg76zfRU8f+snp7f9T13UbuPb7Z2h93RnoxWLhKhJu6SO6ccSQD0rKVz0iPxAN
         KrUQ==
X-Gm-Message-State: AOAM531Jp5uKXVdYoGNQwGboPClTCJ1TJoEzGBJcINzLRxlzb2KVFIh5
        eTMRGumsClw/h+rR564ilxrdNw==
X-Google-Smtp-Source: ABdhPJzJx425tLHmQVdmebQ62orUa9opzERPf/GuTTHuAT2jmmodumK5ULWjo7Md9zkywDAU4WDXOw==
X-Received: by 2002:aed:2ec6:: with SMTP id k64mr594148qtd.171.1610480228185;
        Tue, 12 Jan 2021 11:37:08 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i129sm1742386qkd.114.2021.01.12.11.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 11:37:07 -0800 (PST)
Subject: Re: [PATCH v11 33/40] btrfs: implement copying for ZONED
 device-replace
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <a197cf28a857c308327753c8b7ac1e3f50679320.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c6594df8-15b0-b302-8ce1-33e69a0495fe@toxicpanda.com>
Date:   Tue, 12 Jan 2021 14:37:06 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <a197cf28a857c308327753c8b7ac1e3f50679320.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/21/20 10:49 PM, Naohiro Aota wrote:
> This is 3/4 patch to implement device-replace on ZONED mode.
> 
> This commit implement copying. So, it track the write pointer during device
> replace process. Device-replace's copying is smart to copy only used
> extents on source device, we have to fill the gap to honor the sequential
> write rule in the target device.
> 
> Device-replace process in ZONED mode must copy or clone all the extents in
> the source device exactly once.  So, we need to use to ensure allocations
> started just before the dev-replace process to have their corresponding
> extent information in the B-trees. finish_extent_writes_for_zoned()
> implements that functionality, which basically is the removed code in the
> commit 042528f8d840 ("Btrfs: fix block group remaining RO forever after
> error during device replace").
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
