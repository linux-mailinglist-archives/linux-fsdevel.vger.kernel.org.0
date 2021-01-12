Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944F72F3AAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 20:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404607AbhALThR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 14:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732584AbhALThQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:37:16 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD3FC061575
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 11:36:36 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id w79so2981158qkb.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 11:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AF8nZxMphvu+aZn1k4BUicUQlLLJxkqYyK9NALRcH7I=;
        b=HYtoZDlwABYpMfcqzLmfYIfIxgWWnLc9GcaqKYPL4tRnX8esZ1L4KpcwAj9YYlHLOn
         TVs97gmYKPS2hUWECVlXHWmA0GzpyIOxZjgmeKA8mqDWeYzIvetHA4Kh4rCi//gaBBEP
         W7Mdp1XS6Oc5mql1eKR4FgxKzjO+9eO/N0R+0NQMuZtnZlYjOnpvFRs9UZWrX6mSThan
         UTZCdcXjqY8b7edBouIpgw1HKrWihXwoP9IWi216nUtQyo/fp3X1CCpXFaG9ILZVXamQ
         uCbRESILnro0ng3bndChjsJ9tx6KiiblswMpFkBm50hQ96YJGZ6aIblZeB5PEdM904s7
         6pRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AF8nZxMphvu+aZn1k4BUicUQlLLJxkqYyK9NALRcH7I=;
        b=uEdZB9Z3Fj1HX9JKdQe+7KvllAJBYNj3LZd56aGcrxAkE4Ja/FYx3mzWWT7igGPqGY
         m2FEt82mofEl0NnbQKgPvuBWI9U7UFmSsTU5Pr4rTzR8CtmnVFfZ7YvoMLVtl5f10vAO
         4vtDvGTtkAw9elzNnJJybvNPfCX6lXlgNu46e4SWH01DCLFlcxS65iusWvU4lkHcO5j8
         wo3SEKzrDch9aNjbor3zuxQowqm+OBQKdbnZCJ9rpZlIZgCIEw14D/OoH+fdBD0X9hQk
         NPcUYhXzWQ1V7zBdKEgix0fF14rSv64a/6WxaJcFF5HyRGsamQlx3JH5/n2+E4ZBj/7p
         zDAA==
X-Gm-Message-State: AOAM533OUeE/Mgx9Ww1XFNp9pvcB7/I9heSvcmqU6iys6xmroI+avJbm
        uglaJoSMlwz4+xsliul4X0V+EQ==
X-Google-Smtp-Source: ABdhPJz+RFd2guYp6BnmSWX+tS9Om+VRscRHW9+XtFJG1mqIawlHp4tmUZHDALdoib/Ji0mvd8dOUw==
X-Received: by 2002:a37:a095:: with SMTP id j143mr1007962qke.25.1610480195687;
        Tue, 12 Jan 2021 11:36:35 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d3sm1894855qka.36.2021.01.12.11.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 11:36:35 -0800 (PST)
Subject: Re: [PATCH v11 32/40] btrfs: implement cloning for ZONED
 device-replace
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <25d52cf3e1e1fcc53625d1a6d925dfa46aedc547.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c2247edd-7afc-3606-f8d2-22663c162621@toxicpanda.com>
Date:   Tue, 12 Jan 2021 14:36:34 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <25d52cf3e1e1fcc53625d1a6d925dfa46aedc547.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/21/20 10:49 PM, Naohiro Aota wrote:
> This is 2/4 patch to implement device-replace for ZONED mode.
> 
> On zoned mode, a block group must be either copied (from the source device
> to the destination device) or cloned (to the both device).
> 
> This commit implements the cloning part. If a block group targeted by an IO
> is marked to copy, we should not clone the IO to the destination device,
> because the block group is eventually copied by the replace process.
> 
> This commit also handles cloning of device reset.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
