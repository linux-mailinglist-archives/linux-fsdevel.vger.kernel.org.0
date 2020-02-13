Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC4715CB71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 20:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgBMTzh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 14:55:37 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45699 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgBMTzh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 14:55:37 -0500
Received: by mail-pg1-f195.google.com with SMTP id b9so3538037pgk.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 11:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bvqjxh0Y4A+ickJ+bQqbRnG5FKHFyHZRGKgpAFYkeC8=;
        b=gUykxT54sJ5oSGfJ0ngqMPVHWQ1tn8jF6Z4infvgBIrT6UQC9rGo5bv9yKh3uCKBga
         0wi4YeEdDgNxaTvwNvcFRltQNcMq3LNfRVegwjRvw7LTXZ8JDng77e8XNGVFH7utGA7I
         xJ3zkBjXk/yX4SrW54OpSQqex8qb13FC84DN8oDRkkj9Mnx0zob9yXb7IB1O8LCWeSpc
         ibeqPkuS3AP4UY9UM4Nf99SUBR0w8kbsjKu0PzDakDdDLdsKRnpm1y7CUy7XFRAI8h97
         2sW0z3JlpJmNOFKeykEx/j3fNVaxxZsDg92HJQzo3SBiEJLI+JMezfaxZr2IHuAzq91O
         V/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bvqjxh0Y4A+ickJ+bQqbRnG5FKHFyHZRGKgpAFYkeC8=;
        b=a4XI1upvQo97l1L6y6YGMbdmqIad5H22FqyG/7Fi2ww86hGEBp4ALoyjeAU2dBgpPO
         NiHgrQEitq7BKJE5I5N90USqhkqCVh1Tgzw4F8ezOPyc0HPm0cj4smRpibpQ/YJah2I/
         bEzNIvgXzVf1lDi80ctxbZZJstcsEw9nPsWEjA/jI3qHwcBOIZPM6BRy7dUHVRfPTUFC
         vAcrtC7Dg2V7e6HiPr1ywWGESQELhWgTCKhACRORXfaFHFW647sWRQMF8m9xNJ9dF/tn
         qzeVNKSCQUku8AV0VEHzqS5e92T+WFuJ8L8WtVIC4gIy52epGGTKoU6ykmdcbOzdvzTl
         IyWg==
X-Gm-Message-State: APjAAAWp9wYmW9p75cabDQnoat8U+Ru6+PcB6s9a88DtgRFaQZ/JD243
        BnvHbnQ4K2yf4Qb/sAY5IPCFgCOjONg=
X-Google-Smtp-Source: APXvYqzKojIVGOUV7xDbp3PawzvA8cAc8+QEAl3ZiljaRMoMPEig/TXjIN+vJUTiNe1Kh76H7wrJGg==
X-Received: by 2002:aa7:8193:: with SMTP id g19mr15579432pfi.172.1581623734587;
        Thu, 13 Feb 2020 11:55:34 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21cf::1150? ([2620:10d:c090:400::5:249c])
        by smtp.gmail.com with ESMTPSA id v25sm3992254pfe.147.2020.02.13.11.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 11:55:33 -0800 (PST)
Subject: Re: [PATCH v2 20/21] btrfs: skip LOOP_NO_EMPTY_SIZE if not clustered
 allocation
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-21-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b8908ae0-9e4d-5086-0d4c-768d45215695@toxicpanda.com>
Date:   Thu, 13 Feb 2020 14:55:30 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212072048.629856-21-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/12/20 2:20 AM, Naohiro Aota wrote:
> LOOP_NO_EMPTY_SIZE is solely dedicated for clustered allocation. So,
> we can skip this stage and go to LOOP_GIVEUP stage to indicate we gave
> up the allocation. This commit also moves the scope of the "clustered"
> variable.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/extent-tree.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 8f0d489f76fa..3ab0d2f5d718 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -3373,6 +3373,7 @@ enum btrfs_loop_type {
>   	LOOP_CACHING_WAIT,
>   	LOOP_ALLOC_CHUNK,
>   	LOOP_NO_EMPTY_SIZE,
> +	LOOP_GIVEUP,

Why do we need a new loop definition here?  Can we just return ENOSPC and be 
done?  You don't appear to use it anywhere, so it doesn't seem like it's needed. 
  Thanks,

Josef
