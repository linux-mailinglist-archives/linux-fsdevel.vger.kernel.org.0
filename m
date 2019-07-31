Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F07A97C457
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 16:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfGaOGr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 10:06:47 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42242 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfGaOGq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:06:46 -0400
Received: by mail-io1-f65.google.com with SMTP id e20so3579945iob.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2019 07:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fZNwrkMVKiuAg2/EbekwczHzfWS9d7cPF07lILiSr04=;
        b=cm81+0ttyogzbawDNgloBP2d+3Ip1gbgDJvVFj/sKn9t+r2Vk1GFxwDPjDujxMP5Yl
         8D7ZG1PPbYCm2JTT9vPtkZWC8lWOBjQ3nPDeDQ5Oz2vMVTT1RU+bN8cDTddH7MYxu7W3
         RSrMb6/7HNe4GGgBQG5PK+VEgYJ5A01o7MsRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fZNwrkMVKiuAg2/EbekwczHzfWS9d7cPF07lILiSr04=;
        b=h3JL3agNgADAyaCuSIm9snTdSV+e9G7pzPcdmekA5zSRkbKKIismkPmiDaGVtQxJRn
         oa6F09YOIcyyEpBxuRX4Sw6pzEkTHXAhNUxNPgn9tCeNH0xs5XFvS2K5JIaVz/EOHzpw
         G8rWiQMFgV/rC6WHuSSx4ygrUZC0bGn/FZeyF9/PivWPN0UmhYH3QOl5mNSbKOG1hO77
         xOgxQwLLnFBdcbpNFtBSMe34sAzaKkqnMBDxIDLZReuExhBYo/Ihz5FQCWtHTiyxJP7Z
         v/bKH/PrVSeeRzNT/T1gOBQzx3cm3Gx/YtaKkUGAzuOheuelpXkL6obn4vY7EmQFM2Tn
         I73Q==
X-Gm-Message-State: APjAAAUZhDfSvkQUnbCIZF8YRj/N1cXret2509i4XdXolX7vyMXDnCLL
        FT2nWhGsy41Wm0fXu7yS4Q8KNALJ5Ew=
X-Google-Smtp-Source: APXvYqyKwTlHuovQ0FZC7YuS6LfPdubC/e5rhbCUEhGTHGwA6ez3AfRilCCRoa1fa+SPff50Myrvfg==
X-Received: by 2002:a6b:da1a:: with SMTP id x26mr87307549iob.285.1564582005619;
        Wed, 31 Jul 2019 07:06:45 -0700 (PDT)
Received: from [10.10.6.48] ([50.73.98.161])
        by smtp.googlemail.com with ESMTPSA id v3sm12305025ioh.58.2019.07.31.07.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 07:06:44 -0700 (PDT)
Subject: Re: [PATCH] udf: prevent allocation beyond UDF partition
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>, Steve Magnani <steve@digidescorp.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
References: <1564341552-129750-1-git-send-email-steve@digidescorp.com>
 <20190731095901.GC15806@quack2.suse.cz>
From:   Steve Magnani <steve.magnani@digidescorp.com>
Message-ID: <0449d177-28f3-2da8-b893-940e9e0511ed@digidescorp.com>
Date:   Wed, 31 Jul 2019 09:06:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190731095901.GC15806@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/31/19 4:59 AM, Jan Kara wrote:
> On Sun 28-07-19 14:19:12, Steve Magnani wrote:
>> The UDF bitmap allocation code assumes that a recorded
>> Unallocated Space Bitmap is compliant with ECMA-167 4/13,
>> which requires that pad bytes between the end of the bitmap
>> and the end of a logical block are all zero.
>>
>> When a recorded bitmap does not comply with this requirement,
>> for example one padded with FF to the block boundary instead
>> of 00, the allocator may "allocate" blocks that are outside
>> the UDF partition extent. This can result in UDF volume descriptors
>> being overwritten by file data or by partition-level descriptors,
>> and in extreme cases, even in scribbling on a subsequent disk partition.
>>
>> Add a check that the block selected by the allocator actually
>> resides within the UDF partition extent.
>>
>> Signed-off-by: Steven J. Magnani <steve@digidescorp.com>
> Thanks for the patch! Added to my tree. I've just slightly modified the
> patch to also output error message about filesystem corruption.
>
> 								Honza


Thanks Jan. Ror the record, it appears that Windows chkdsk has a bug in its
analysis of a space bitmaps. If the last block of a UDF partition falls
in the middle of a bitmap byte, chkdsk reports spurious errors if the bits
in that byte that _don't_ correspond to UDF partition blocks are zero.

To maximize interoperability it would appear that it's best to format such
that UDF partition sizes are always a multiple of 8 blocks.

Note to non-UDF wonks reading this, a UDF partition is a sub-extent of a
disk partition. So achieving the multiple-of-8-blocks involves a change to
mkudffs code.

------------------------------------------------------------------------
  Steven J. Magnani               "I claim this network for MARS!
  www.digidescorp.com              Earthling, return my space modulator!"

  #include <standard.disclaimer>

