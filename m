Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47E4275DBB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 18:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgIWQoA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 12:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgIWQn7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:43:59 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4177C0613CE
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2020 09:43:59 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id l126so19535pfd.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2020 09:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9kKVBm2QDcEhoI7VNH0u9uwqsgFbX84K7to4q+EvAF8=;
        b=wo1HxCm5bKIVa9so0OH72jUPeuxpy0gBmSztrnAMX5SSm8gqDsd/uDbJD7n0nTY7Hv
         CKJoObg/EBB1JCvStmCq+2DKeNopjuTxhY6T7yv5TlzOVOSgvtBEy4neG07it4ARoA4J
         WHOi+7obrEMIUDmzT3kBBEHLDf0ZbrbNxMoUwtAnQnNZ4qwV/A1Mq5PJhKVbgpJ/Rod5
         V4wdCnvNPJU0KSWHIs05KbU5DxoLhNDG93YaWxwBm6g7XccmnyHw+ixRtSpxeaSGMhwd
         mx1/GOsS6pG7kDo6kprXjUbJ/6H+1rzHGTrQ7trw2dp1Uk7jyzCH8F6put7clvS8xmh3
         DueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9kKVBm2QDcEhoI7VNH0u9uwqsgFbX84K7to4q+EvAF8=;
        b=SPoPcO+aw71b+U1Ow/16ebZc8CJlnHRnNdXr8QzkoSwcvnrbNuakpIa7Mqn9pMRlkG
         T9G0ZM8ov089KeEMwS/G+OXLB1kwp4iZtfkMPIxXYctGAx3onFT7316mjAZ7wLaDQ3Wv
         3HNYQswvFeDUyTyQx9BQQ6nmFPUYpTSS1Fh43hj/I6ptTboFsQ7JkBFDuhCCfg1NtVqC
         B4E3tIWcZufyU/BvVIK+mcv6/fHGpI79Xxz+2syuJuuB98srhkouFz4xOId2MUcuy+nh
         OzPaBziOpqjrapkwPKJO5cosszDZDLKo2S8c7pUvqfvCpS5LkA5YKDEzr8oP9xlb5FIg
         Bolg==
X-Gm-Message-State: AOAM531WayU1gfMeWPDJVUU/NqK9KDk3kui+op8zt/2IPrgAOXcCFAi6
        tPWtd5bAVFMIrOjHCbITg4m5/w==
X-Google-Smtp-Source: ABdhPJzQnxjNRw3M1n4lJU3pDIkemY3ZCQKnOQ7VywhFrMYRm0itMgYfj3gWdktm3tes58COiW8SXA==
X-Received: by 2002:a62:2b52:0:b029:142:2501:39e9 with SMTP id r79-20020a622b520000b0290142250139e9mr746426pfr.56.1600879439083;
        Wed, 23 Sep 2020 09:43:59 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q190sm241046pfq.99.2020.09.23.09.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 09:43:58 -0700 (PDT)
Subject: Re: remove blkdev_get as a public API v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        linux-ide@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
References: <20200921071958.307589-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d23e5bd4-4d69-f909-eb8b-10c489b67f8b@kernel.dk>
Date:   Wed, 23 Sep 2020 10:43:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200921071958.307589-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/21/20 1:19 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series removes blkdev_get as a public API, leaving it as just an
> implementation detail of blkdev_get_by_path and blkdev_get_by_dev.  The
> reason for that is that blkdev_get is a very confusing API that requires
> a struct block_device to be fed in, but then actually consumes the
> reference.  And it turns out just using the two above mentioned APIs
> actually significantly simplifies the code as well.
> 
> Changes since v1:
>  - fix a mismerged that left a stray bdget_disk around
>  - factour the partition scan at registration time code into a new
>    helper.

Applied for 5.10, thanks.

-- 
Jens Axboe

