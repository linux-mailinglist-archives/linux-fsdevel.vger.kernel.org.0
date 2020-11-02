Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7354D2A30D0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 18:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgKBRFE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 12:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgKBRFD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:05:03 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E92C0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 09:05:03 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id b18so12079571qkc.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 09:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y38b4I8F8TzbnCJnqVcBeFa6DkdFk2BpIFLm4lvKtuQ=;
        b=kGv6qQfTyQ811LuGIIGqHI+tXnWLezncZhRnfepg3EyTd/XVYEUG6v/scvXNSkGWBG
         nz07ukkvu6uorOW8w/Qmf2RD1Ao7b2TOvGq6M205ibw4ugEipfNp55IPcTHJ9UUEkonZ
         7vumjtOYXoIFVnUnfYAeWIrNpuqFiSELotOIua7AS0AL8PHaK3sedQvRCOowEgf6NUr/
         UlwHf5GRQI5wfsm+UBNhtVDMx/Aw9sY1mjgEYrDjDjZ4bsJB/2/HY3W1iEKdhrx0p22M
         Qj9KPoBqn/dU6n/JYF+BKuNDYbXAkxqBnXrFYbGburXYR4o/MDSe6e4MOfIsiJ9WHBpJ
         EGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y38b4I8F8TzbnCJnqVcBeFa6DkdFk2BpIFLm4lvKtuQ=;
        b=UDSthC00TAuYrC8rhbpDn7efkLDNdzbHOYn8L2tfuSd1Sdbzxj82FR3rSao0I9/8Rn
         x/8SCdqwlo+O+2UwJmu5dGznBvcinoHVkFZouv6I6D/vSt0QkhozuN96TKL6ciVQ4LG2
         0Vi2yVg8jl8caeuq2aLCdw5b06JWTLtAn51cZYP9BUf+hGBhHZPg7WB47ZHOQ/hveDRY
         Ga0zJDoY4mfZWWTFkoKQvtErHO/mCb5qik74r3NBKbj3tH0AE35FGtPLf2Mnf9d9DqQW
         eE0sJPheyTyKKYo/pRltqVgnnJxzNQZ7UeBDWP/x78sb/8yeyVHwRe0gWwbEmk96diB+
         +4dQ==
X-Gm-Message-State: AOAM533B8ddexVM+pURV//0E55XCHZ45oCTIEI0vnA4YGP+WyJExad1G
        WLZZFnWRo9iUtck40H8ANRVYTA==
X-Google-Smtp-Source: ABdhPJzAHrmcW4bpGc+WqnnRZtd1fbVeh5ma2CvPxT2OpHWIJlO0hr+BVcKVSk0QYjPdGKmBpYST2Q==
X-Received: by 2002:a37:90c3:: with SMTP id s186mr15944818qkd.130.1604336702740;
        Mon, 02 Nov 2020 09:05:02 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:11d9::116a? ([2620:10d:c091:480::1:f39e])
        by smtp.gmail.com with ESMTPSA id f21sm4677080qkl.131.2020.11.02.09.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 09:05:01 -0800 (PST)
Subject: Re: [PATCH v9 08/41] btrfs: disallow NODATACOW in ZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <4129ba21e887cff5dc707b34920fb825ca1c61a4.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d61bedfe-9288-940c-e410-60c835591fe0@toxicpanda.com>
Date:   Mon, 2 Nov 2020 12:05:00 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <4129ba21e887cff5dc707b34920fb825ca1c61a4.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> NODATACOW implies overwriting the file data on a device, which is
> impossible in sequential required zones. Disable NODATACOW globally with
> mount option and per-file NODATACOW attribute by masking FS_NOCOW_FL.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
