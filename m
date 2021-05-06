Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72E7375CCF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 23:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhEFVYR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 May 2021 17:24:17 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:36805 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhEFVYR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 May 2021 17:24:17 -0400
Received: by mail-wr1-f43.google.com with SMTP id m9so7075717wrx.3;
        Thu, 06 May 2021 14:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7/YXsCClb5ycW3XuLhsSzwdxpiiYUxJ6Ez9bqElY5I4=;
        b=He88hGf/Sa23yoZkhTFNohtu4dlShvPVRtyzVIF+gM8UCuB2SPzzaXNDJmJBmhjRTT
         zigXJsVB5pVtnNwm1f3X+SjEpANstUPG064b4W6gSC0kqsw69GLrF8ajHoReEpQf/91Z
         zkwV6eofWOyGTEAVFol2+IK5qpnm0k0OyBgbwtHKFprdaA+EZoHbx71FoU7pnQi+SkUm
         SS2pBlvhUPSfeZj+XY8R4B+qGXDbRLZaxuPCF2PCkDPgJ9EM6lzM4JQU4jE2o8hymbVB
         /E26EXmqjbs2oC05zULR1dBCjm6HYjwm40ZzOYDkyEnRmQg8GsndkN62Jtr7jWRsQW0p
         jepQ==
X-Gm-Message-State: AOAM5324LAiAJ2Zr2JoCCyz8tFacEV8/zvSyVjwP7cXgjtXUoKg+rkOC
        JCYXt/EDQ2JymPJln4/dxU38Wzx4S1c=
X-Google-Smtp-Source: ABdhPJygHlArd7HD4oGDRBN4RdTogoQwIfD4aiWm3a/1zmSJ8bAgFbO7pFL9Qz1fU9PBd9jyq22kGA==
X-Received: by 2002:a5d:6daa:: with SMTP id u10mr7644966wrs.119.1620336196795;
        Thu, 06 May 2021 14:23:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:7945:4a4a:9424:5a3f? ([2601:647:4802:9070:7945:4a4a:9424:5a3f])
        by smtp.gmail.com with ESMTPSA id n124sm11815031wmn.40.2021.05.06.14.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 14:23:16 -0700 (PDT)
Subject: Re: [PATCH 14/15] nvme-multipath: set QUEUE_FLAG_NOWAIT
To:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20210427161619.1294399-1-hch@lst.de>
 <20210427161619.1294399-15-hch@lst.de> <YIjJRiyA26gELV+d@T590>
 <20210429072737.GA3873@lst.de> <YIpiS0d1NeoX6p0H@T590>
 <20210429094618.GA15311@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4742e817-6733-dab3-3c4b-71f1694e713c@grimberg.me>
Date:   Thu, 6 May 2021 14:23:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210429094618.GA15311@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>>> BLK_MQ_F_BLOCKING is set for nvme-tcp, and the blocking may be done inside
>>>> nvme_ns_head_submit_bio(), is that one problem?
>>>
>>> The point of BLK_MQ_F_BLOCKING is that ->queue_rq can block, and
>>> because of that it is not called from the submitting context but in
>>> a work queue.  nvme-tcp also sets QUEUE_FLAG_NOWAIT, just like all blk-mq
>>> drivers.
>>
>> BLK_MQ_F_BLOCKING can be called from submitting context, see
>> blk_mq_try_issue_directly().
> 
> The all drivers setting it have a problem, as the blk-mq core sets
> BLK_MQ_F_BLOCKING for all of them.  The right fix would be to not make
> it block for REQ_NOWAIT I/O..

Hey Christoph and Ming,

I think that we can remove BLK_MQ_F_BLOCKING setting from nvme-tcp,
the reason that it was set it because lock_sock taken in sendpage is
taking the sk_lock mutex, however given that nvme_tcp_try_send is
protected with the queue send_mutex (which is taken with a
mutex_trylock) we can probably convert it to sendpage_locked...

Let me run it through some tests and get back to you...
