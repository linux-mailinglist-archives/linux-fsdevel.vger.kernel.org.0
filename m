Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A912CD960
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 15:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbgLCOiP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 09:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbgLCOiO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:38:14 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380C1C061A51
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Dec 2020 06:37:28 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id u4so2190484qkk.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Dec 2020 06:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tRaksBdiJ9O3u8mQ5z+bBUCn8VpNBVTbpG+ZUh7pbQQ=;
        b=kpYJ8mb/ShcMAiNzLiEB+p/aBtblThc0DZJd9ro0DuU3BjVw5Q7mHxKpEm5Z35eOPq
         6vZxEiSgr46CaICHgD8sMy7QVVEzU4NVWDCRxehtTN8UbR9YMBuHXCFQ7uIUEzzHM9yT
         e2OhCAcHyCUsgYCKiWS0kXuUaY3BhGOpR/s0p6hbpqbt3AJUT9Xhe0rBsRJ7ZV9bc46Y
         TDp/1GUTIOvK3bJ1cNX3p8zNq9t0X/bWDnjnn45ZdG3E48pVEAz6ET+C+Ranm39plFdB
         ygxPw4NbcMOei5EZksnKbx4ryJ2DkC7LGeplGWEcJbC7zTrfd8p9jZEzhDW6KHE55ata
         K/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tRaksBdiJ9O3u8mQ5z+bBUCn8VpNBVTbpG+ZUh7pbQQ=;
        b=Xyrzda5rih09ttVvgGQETid2LbBLm9GRocTMQ4gvRnUWbV1ioXOv+QZf7XXvl2/n37
         ZF6ju6ToR8FJg2Lg0BHyP+MfQEl+HI3FqHx/RjRFl/qwa6IGICJpIjZT4Z1FuNLFiY7C
         f/++Zyop7ltNSrNe18SmOh+/lfXSDrjyW9XRSko8G8K2mBbgk1lFn+qRfySxE658BQmB
         dRpOHdzYZ4qHJLFk8VTUpoXgSGXLM2qK4DFiyNPFBJj6y5eDB5ax8MYzEqHu1XIjGWnU
         PysyTwXkArHNkGT5QLmvyV3RzY5D7KYHOJCFb5sC6XpDqk8Ydg6RS35dmOSdIdNjUAQf
         CIlw==
X-Gm-Message-State: AOAM53318vf7ruOppcBJUNxYZZIs5iEg2kM8WcIlHT9aMSgD1YeNQNRq
        dYLFXMybpMeLio0jlidP2Hv3aA==
X-Google-Smtp-Source: ABdhPJzMX8HmCsVHfR0OmrZIiDkY3k1n+yjarn0l1aQitgNLcxdJGX8+i5hzVL952EH6qox7kOkGYA==
X-Received: by 2002:a05:620a:790:: with SMTP id 16mr3154252qka.169.1607006247296;
        Thu, 03 Dec 2020 06:37:27 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v9sm1394976qkv.34.2020.12.03.06.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 06:37:26 -0800 (PST)
Subject: Re: [PATCH v6 11/11] btrfs: implement RWF_ENCODED writes
To:     Omar Sandoval <osandov@osandov.com>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1605723568.git.osandov@fb.com>
 <fe58a0fe2c1455567fe1e9e62232e8b711797a93.1605723568.git.osandov@fb.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ffca5825-27f1-63c2-1195-d0c338cd067d@toxicpanda.com>
Date:   Thu, 3 Dec 2020 09:37:24 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <fe58a0fe2c1455567fe1e9e62232e8b711797a93.1605723568.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/18/20 2:18 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> The implementation resembles direct I/O: we have to flush any ordered
> extents, invalidate the page cache, and do the io tree/delalloc/extent
> map/ordered extent dance. From there, we can reuse the compression code
> with a minor modification to distinguish the write from writeback. This
> also creates inline extents when possible.
> 
> Now that read and write are implemented, this also sets the
> FMODE_ENCODED_IO flag in btrfs_file_open().
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Fix up the spacing thing and then you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
