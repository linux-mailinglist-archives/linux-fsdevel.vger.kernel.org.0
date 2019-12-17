Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1FA123908
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 23:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfLQWEL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 17:04:11 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46432 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfLQWEL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:04:11 -0500
Received: by mail-qk1-f195.google.com with SMTP id r14so9201626qke.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 14:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6mDGpaAqC9Qen570rGE9CrSvvqdlOzeL58pU399uFGs=;
        b=Hha9uzXMCOGCIgTkjsS9wzgphstDoNhdzcwMotyKjUkiXQv20UGU9rG/u74a2cObr2
         0M4BRGELMF/s2GxunzxmCyf26jCVNCHa362JGP8zGb+UU3Nkyad13jMqfUVJtftyW9jh
         AoLvTseT2+A2GZlx0oX31eiKIgjICK7ULA6rJwTI4yLrWiqnJq7fEGah6otzlkR56wln
         lqcmZFicMgmq6NNf2Xg8678OFQ5v4t24ZblnKftHA5OtvWO57/7pqXhnG+fIYe1KVwlF
         5d8+BdNOJvCFAAFDW1s/pFDuxMdr8K5udm28Gu/dXHxjYWQw+RgT4H+k+ZNt8m4nQ5ow
         8zCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6mDGpaAqC9Qen570rGE9CrSvvqdlOzeL58pU399uFGs=;
        b=nQfHS45GcbfLEur/DVTOpBe84HPLRB3kL2Lj33Ms3Cb4w5CQ+B4Dpu00wPHapcQZkw
         rqS/+SuukGwHSWNdzKeVvpx74DZ+8FGftVEa53irdkh/OkV4oR+SXx5h9Qbf7QCBtwpj
         OTXmNf6WXpHXXJjs80QOK809QbvMCmvMLCeLmqRmb0uKv4VytUzTQvPGgvddJhyelC/g
         6s6BG3S7Qy3AYQ3Th80I9BpVJmLFCozSonrlIkFhWUdDi436vHxe7WzCvb94hsixQcyh
         5rSUokyD/wm3ih0fPuMId/5+YObLDvveHAi7V329fGBQsE9QXSFou7S4APtz2uSy7oqp
         2CZQ==
X-Gm-Message-State: APjAAAU+6//mwuZmofeOvO54nRDUuW85VYG85OJx0RDwGD8m7UfrcjHH
        liGmJwsMm0JhVn2dkhYxJFd89eD30P2u1A==
X-Google-Smtp-Source: APXvYqyXOl2vmdhy2v5eBW2BKS/cLw8fUEpi4/Uqdd3iWCZ193LM2QQiF6ZnUu99LQNWlsFqywRdkA==
X-Received: by 2002:a37:8ec7:: with SMTP id q190mr215061qkd.412.1576620249532;
        Tue, 17 Dec 2019 14:04:09 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l31sm72119qte.30.2019.12.17.14.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 14:04:08 -0800 (PST)
Subject: Re: [PATCH v6 25/28] btrfs: relocate block group to repair IO failure
 in HMZONED
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
 <20191213040915.3502922-26-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <58bd77d2-13ca-0fa4-1373-c7d099ef152c@toxicpanda.com>
Date:   Tue, 17 Dec 2019 17:04:07 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213040915.3502922-26-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 11:09 PM, Naohiro Aota wrote:
> When btrfs find a checksum error and if the file system has a mirror of the
> damaged data, btrfs read the correct data from the mirror and write the
> data to damaged blocks. This repairing, however, is against the sequential
> write required rule.
> 
> We can consider three methods to repair an IO failure in HMZONED mode:
> (1) Reset and rewrite the damaged zone
> (2) Allocate new device extent and replace the damaged device extent to the
>      new extent
> (3) Relocate the corresponding block group
> 
> Method (1) is most similar to a behavior done with regular devices.
> However, it also wipes non-damaged data in the same device extent, and so
> it unnecessary degrades non-damaged data.
> 
> Method (2) is much like device replacing but done in the same device. It is
> safe because it keeps the device extent until the replacing finish.
> However, extending device replacing is non-trivial. It assumes
> "src_dev>physical == dst_dev->physical". Also, the extent mapping replacing
> function should be extended to support replacing device extent position in
> one device.
> 
> Method (3) invokes relocation of the damaged block group, so it is
> straightforward to implement. It relocates all the mirrored device extents,
> so it is, potentially, a more costly operation than method (1) or (2). But
> it relocates only using extents which reduce the total IO size.
> 
> Let's apply method (3) for now. In the future, we can extend device-replace
> and apply method (2).
> 
> For protecting a block group gets relocated multiple time with multiple IO
> errors, this commit introduces "relocating_repair" bit to show it's now
> relocating to repair IO failures. Also it uses a new kthread
> "btrfs-relocating-repair", not to block IO path with relocating process.
> 
> This commit also supports repairing in the scrub process.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
