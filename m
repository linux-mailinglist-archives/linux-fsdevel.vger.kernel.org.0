Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54E9F15C821
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 17:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgBMQUW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 11:20:22 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44038 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbgBMQUV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:20:21 -0500
Received: by mail-qt1-f193.google.com with SMTP id k7so4767814qth.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 08:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uo7vejI/lsIvurQbZI0WXKj5IX0URkCLu86Ld4Lvlf8=;
        b=KfMUo1AbfXNHH9jNSXtygbufhjygNrWsmz21oAZASLFWNFQ048l5k7FwChy7o6jbi9
         j3EypP45rZCLDOVkAVliSRZ2ksdneLJjz/mWpzC2A6gxfgaP+bMzxOFpTWhce0Pw9lkO
         HlystR7Ze/IiJnSRUHyxCUWGDT62g0E0BO/cgxfEuvbiYY7NpsGbx16bHmIXW2AbG1MS
         TSJhJAzoaN22ez/l5BTOxUI9in2tO+0W4shTdFKXkapRGKtIG/6LYNtd7ztTVTPbTYm8
         /zSU71SR0EX6OvZSJeYeimkrtILJPgo/TWtpvQwvrw7uQdLTCfLz8Cs1K/uC2ICytUWP
         XSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uo7vejI/lsIvurQbZI0WXKj5IX0URkCLu86Ld4Lvlf8=;
        b=XyBFvyBNImkm5mEKAoZZBb2Hy3n6bsyKq2GeCqsBxD8s9Y0Dw94qfKn4aMOktxOPBI
         ib06nrDcf5fw2reqKEJY+hScLdoGEdrBotPuQYYIYlh1wRv68+7+iWZYOg18Nfwcl2nN
         dxShRVf71/IOrlqiV1/QDhgjdEV/Y9LlYrnTPkmqf3ZsXb/KeKMjrF0u7DmJRGW2CyyP
         qUvGOWkSmFbteG9RU/QJTYipYu597wt6MCWO8vHavezOzej6EVYDHeihB8gpN3/8btR0
         DZWUJ9jQLCSUfwmbczO/SO9QyrV9ndsixsjF0RWcygYkpx9ZTVVuL8eVib8rwpNKNTsp
         svtQ==
X-Gm-Message-State: APjAAAXXLPVqk6J6xcSumA00AwNOC24GKZknBj/q70leYd9Rx9Wi9GdA
        5umPqTLIQuHsvOIygGPnGWE5gX0mel0=
X-Google-Smtp-Source: APXvYqxYxvRtF4CDIFErl2EmPOvPCVsRVD3GHR3YL0sO6L3Xf2557Kl2c4joh4LFcrtLHy0NlfCSTw==
X-Received: by 2002:ac8:f63:: with SMTP id l32mr7868109qtk.327.1581610820589;
        Thu, 13 Feb 2020 08:20:20 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::edcc])
        by smtp.gmail.com with ESMTPSA id j17sm1553846qke.69.2020.02.13.08.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 08:20:19 -0800 (PST)
Subject: Re: [PATCH v2 06/21] btrfs: factor out init_alloc_chunk_ctl
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-7-naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1d328222-7934-013b-0474-71cc2fca9123@toxicpanda.com>
Date:   Thu, 13 Feb 2020 11:20:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212072048.629856-7-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/12/20 2:20 AM, Naohiro Aota wrote:
> Factor out init_alloc_chunk_ctl() from __btrfs_alloc_chunk(). This function
> initialises parameters of "struct alloc_chunk_ctl" for allocation.
> init_alloc_chunk_ctl() handles a common part of the initialisation to load
> the RAID parameters from btrfs_raid_array.
> init_alloc_chunk_ctl_policy_regular() decides some parameters for its
> allocation.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
