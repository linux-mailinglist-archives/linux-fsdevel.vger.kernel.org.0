Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D8F305D41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 14:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313345AbhAZWf2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 17:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387886AbhAZRXj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:23:39 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA548C06178B
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jan 2021 09:22:58 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id v19so11845481pgj.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jan 2021 09:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eYJnZZFypTKv1MYlJhQR66lAKTujf0kvok9gjJ0kfEw=;
        b=bXbFi3Y4glTktlCccZ1cGdk6FA2EMGkng3P3s+/qO4vIjAK7oWfxYn18X1rB/Fkz+t
         /fuK9RoSf8L2EVfHn+yB/Wrhnoj55RFJGdJdxgNFgAkcgtnq4QeK+1pHZ6BBIQ3Kqb2K
         UcjBoGANXHoELqbgA46fchB4XUjBqs9NRJod4W7Y/tWvfSWeMTbSkiMs1gc2YAu65aLq
         J12Wsu4dw9ymmRdrdgmWMFg+ZLu11sG911XyYnn8aG+pM7jGe+m07veZshWS89L5nlYo
         cXlQKnI3oP8AzkH3p7sUgn5Lw9XA27ZnV5+vaESosIEsbV9WUOz1UbG/F78dmzjvJw8d
         tMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eYJnZZFypTKv1MYlJhQR66lAKTujf0kvok9gjJ0kfEw=;
        b=gVG//7EndWRyyQzye02joKjW2vy6mvk4ujQT+y2MmwCW7mfyl087UYWjOUZHi7kwrY
         kfCJcB6isrPrGRw5BZClVycI7ofWKNDjLzKZuAWXfr+L2rtgFwScP4S0Th/JsNvKLw2N
         tZpO1FaUSlkdj8jv5gzSYPTM2cXpM8iFd8O2gCKCpCoCDDF6bHlDU9DEis4WVdEi7Nh9
         LGrZRuIJICNf6MmXpbQtwlo1VNmNU3GkxuZgk5RQj5q7JBRi/cX/0iex30T48u3DEpym
         NgShOM2OVwzaE3xiPKTgWPP8QTaT+zN3xEF5Xa3NbHGQjf7AHxQxju8/Zh6jgMzBfoNV
         HyyQ==
X-Gm-Message-State: AOAM532t1X4B/X4qaIAc/BZXgYJJw/kGCTQc9F+Tz1LiCmFoXUXbrs4B
        iXzjNC8QraI8uygoIJAzOyIbGw==
X-Google-Smtp-Source: ABdhPJwFHubLGL7MNxyMyQwa8cAR3T5Y4uKtvZBMyWw1LQCQdDzZBqTnplG+qDebm95sf6MOBFoXBg==
X-Received: by 2002:a63:1f1d:: with SMTP id f29mr6637724pgf.47.1611681778414;
        Tue, 26 Jan 2021 09:22:58 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id b203sm19739492pfb.11.2021.01.26.09.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 09:22:57 -0800 (PST)
Subject: Re: [PATCH] bdev: Do not return EBUSY if bdev discard races with
 write
To:     Jan Kara <jack@suse.cz>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <20210107154034.1490-1-jack@suse.cz>
 <20210126100215.GA10966@quack2.suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <29be3d51-43b4-b4eb-66e0-669c517ed830@kernel.dk>
Date:   Tue, 26 Jan 2021 10:22:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126100215.GA10966@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/26/21 3:02 AM, Jan Kara wrote:
> On Thu 07-01-21 16:40:34, Jan Kara wrote:
>> blkdev_fallocate() tries to detect whether a discard raced with an
>> overlapping write by calling invalidate_inode_pages2_range(). However
>> this check can give both false negatives (when writing using direct IO
>> or when writeback already writes out the written pagecache range) and
>> false positives (when write is not actually overlapping but ends in the
>> same page when blocksize < pagesize). This actually causes issues for
>> qemu which is getting confused by EBUSY errors.
>>
>> Fix the problem by removing this conflicting write detection since it is
>> inherently racy and thus of little use anyway.
>>
>> Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
>> CC: "Darrick J. Wong" <darrick.wong@oracle.com>
>> Link: https://lore.kernel.org/qemu-devel/20201111153913.41840-1-mlevitsk@redhat.com
>> Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Jens, can you please pick up this patch? Thanks!

Picked it up for 5.12, hope that works. It looks simple enough but not
really meeting criteria for 5.11 at this point.

-- 
Jens Axboe

