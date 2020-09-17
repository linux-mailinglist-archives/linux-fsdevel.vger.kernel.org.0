Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F8626DE8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 16:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgIQOWe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 10:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgIQNym (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:54:42 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F040BC061220
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2020 06:46:42 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id i22so3389585eja.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2020 06:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vn8Ib8aYTFIxxqTycEHlG/ghKTkhckew2Lqu7O8X6Rs=;
        b=2I8GLAggHCEfndqwRmqt6x9A4uf6YSTFBgDaUxJ98/fF1Of0hW1Hn3Y0XgE5bbIH2X
         wSsUcP8tLlvbw98s2+9sd5rV1UQKg1UQ9ANndPUHHAZ9WcYBfkYFwfTJwY3yiBFSMVxX
         B46Cjm13oovsckeJ47Cv3IjeGdJz1+OzXVso6+sng5gjggxC0id2th69lYQ22dICwm/a
         +HWTYQRWEcAlCjSY5/gsyh0biMRT6SdYy+t/Rin2dcgW4q95wHZqZFeXKWB7E6C3+nb5
         Xz1FnwnJ97bXkJVYF2r6iQhqX8YSGywxolWfg4I0ol86+Vwh/NMVeKKvqK6kyFaEG3uK
         h32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vn8Ib8aYTFIxxqTycEHlG/ghKTkhckew2Lqu7O8X6Rs=;
        b=bJAepMR6aH6mgx4cp6pFhuiG221q1tC7mbpNUdPNUYVUe4HVH3PB/D7uwBauQlf/jK
         3Io5Was6XG1es76FSYbb3eZ1h/87/p+HXstDLsFKm365AHxG9WrKRfNDZuj73JQcWn9s
         eaK3EH7v4z7FPtY0xjrEZLqZVeMfpNsAAcUJF+yJUFIo0LPxfCjsc6i7dBtE21ez+eCh
         fDIxxvKPHxECB30b/eJhHNQRpzj5XcAuG3tEu98l8MRk7vG1AJRBmgiiOhXv9lAPParO
         mikI9PKII7v8fdDMxMOgJ+WizhKx6qLKbxsymbp2xAhIUvvkimmFVypUKBRk9GZaj2Uc
         y9fw==
X-Gm-Message-State: AOAM530QX+83qFIVWptsq1CaZO3Cw+1Yf+ZK/HFlFSQEJNYRZs7RF9UH
        wwyUYv8Kne/QZTfaMCjoc+9cmQ==
X-Google-Smtp-Source: ABdhPJxMRbmTCEPByc8ZLp+OCATWxVGB3JQ0YY8lhNTPhEkHaHhbeMfMV0xWWNKI0J6LYeuZwbug7Q==
X-Received: by 2002:a17:906:9346:: with SMTP id p6mr29979581ejw.305.1600350401578;
        Thu, 17 Sep 2020 06:46:41 -0700 (PDT)
Received: from [192.168.88.231] ([45.139.212.114])
        by smtp.gmail.com with ESMTPSA id f13sm15496884ejb.81.2020.09.17.06.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 06:46:40 -0700 (PDT)
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for
 read_count
To:     Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Hou Tao <houtao1@huawei.com>, peterz@infradead.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
References: <20200915140750.137881-1-houtao1@huawei.com>
 <20200915150610.GC2674@hirez.programming.kicks-ass.net>
 <20200915153113.GA6881@redhat.com>
 <20200915155150.GD2674@hirez.programming.kicks-ass.net>
 <20200915160344.GH35926@hirez.programming.kicks-ass.net>
 <b885ce8e-4b0b-8321-c2cc-ee8f42de52d4@huawei.com>
 <ddd5d732-06da-f8f2-ba4a-686c58297e47@plexistor.com>
 <20200917120132.GA5602@redhat.com>
 <20200917124838.GT5449@casper.infradead.org>
From:   Boaz Harrosh <boaz@plexistor.com>
Message-ID: <e25a3354-04e4-54e9-a45f-7305bfd1f2bb@plexistor.com>
Date:   Thu, 17 Sep 2020 16:46:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200917124838.GT5449@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17/09/2020 15:48, Matthew Wilcox wrote:
> On Thu, Sep 17, 2020 at 02:01:33PM +0200, Oleg Nesterov wrote:
<>
> 
> If we change bio_endio to invoke the ->bi_end_io callbacks in softirq
> context instead of hardirq context, we can change the pagecache to take
> BH-safe locks instead of IRQ-safe locks.  I believe the only reason the
> lock needs to be IRQ-safe is for the benefit of paths like:
> 

 From my totally subjective experience on the filesystem side (user of 
bio_endio) all HW block drivers I used including Nvme isci, sata... etc. 
end up calling bio_endio in softirq. The big exception to that is the 
vdX drivers under KVM. Which is very Ironic to me.
I wish we could make all drivers be uniform in this regard.

But maybe I'm just speaking crap. Its only from my limited debuging 
expirience.

Thanks
Boaz
