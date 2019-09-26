Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA95BF147
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 13:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbfIZL2D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 07:28:03 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35058 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfIZL2D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 07:28:03 -0400
Received: by mail-ed1-f65.google.com with SMTP id v8so1652868eds.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2019 04:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g4JC5OZZ5TgrhoN9BDJo5r3Bzy53xCrCDfOjVmIq/o8=;
        b=pBlZn7Tv2mTdToFk+gEas7iX7VxmY/vaZO+zvvW3OlfB7SYH6IojSeKcyaeCI36qSp
         el1dQ+9zfzd97S/Si5vhrq8OJS0DiEuYKLck7OUfmxwo7HNBeR9O4emQEliiRWG7XR5y
         LpLylloh/X74uklN7X3PG4lUZTAN1A5x+iWA7c+X4tJdbcfROQMT2plJX/A2pA/uNgtK
         qaSEURH9TLk3/6tMZhNMFGfPPrTcPoQcomCiH/zph4Ec8EK6gNcSVQFbSeoul5B74rz1
         eDm0/kdOM7X0eYXUPvYtqumep/PmV0kr69CC6S01LSoUd6yFgCruyFAdj/tcWKEAZbJm
         nX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g4JC5OZZ5TgrhoN9BDJo5r3Bzy53xCrCDfOjVmIq/o8=;
        b=CGqlUBJNUFXZcKOhkZNHeymlXacbI2nFDWgXwoCGdMRz6CHuNO5OBSoDvtUUDvKp22
         HBtt9fno5L1SgAudsMH1hUlspAMMbSETHuuzI+NlHL4J8M8edX6I8koCgj+bkF/d8bVQ
         hKMDToVfFkzUtBSK/kaPjKnqp9GY0JpNdGa2QYaMpo5yKyxoKgY19J7hYgiigR3wlz7S
         PQyw+E0CLJhpCepxDd+qnZPkdSjcPu/vfWHmbXwMWrmPWBUMD2Bd8x4W+H3Qw/M1VDw2
         tWqFrxbpBfl+rrtZD80QW4k9BcgI5FXFj6wsT+cm52RVrZR6uVyzyoMAp1KK02MajLLx
         wrFQ==
X-Gm-Message-State: APjAAAVyBqPwk3sRk1YEcLUnXRP0A5cTqrVtHLIDtxh0kRWmQM4KuvPo
        5hy/FMXxCZfGJMLpeNNGx7Q=
X-Google-Smtp-Source: APXvYqwwAQigawVhDBoq/olev89itfHOpH5b6Wi18lpd5ksUA+ciLzntMb8s4a3O3lyV1i/Y3ukdNg==
X-Received: by 2002:a05:6402:651:: with SMTP id u17mr3050002edx.104.1569497281552;
        Thu, 26 Sep 2019 04:28:01 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.210.43])
        by smtp.gmail.com with ESMTPSA id r18sm424692edl.6.2019.09.26.04.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 04:28:00 -0700 (PDT)
Subject: Re: [PATCHSET v02 00/16] zuf: ZUFS Zero-copy User-mode FileSystem
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Boaz Harrosh <boaz@plexistor.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matt Benjamin <mbenjami@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Sagi Manole <sagim@netapp.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20190926020725.19601-1-boazh@netapp.com>
 <CAJfpeguWh5HYcYsgjZ0J2UWUnw88jCURWSpxEjCT2ayubB9Z3A@mail.gmail.com>
From:   Boaz Harrosh <openosd@gmail.com>
Message-ID: <0bb90477-e0b5-650b-d8c0-fb44723691a4@gmail.com>
Date:   Thu, 26 Sep 2019 14:27:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAJfpeguWh5HYcYsgjZ0J2UWUnw88jCURWSpxEjCT2ayubB9Z3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26/09/2019 10:11, Miklos Szeredi wrote:
> On Thu, Sep 26, 2019 at 4:08 AM Boaz Harrosh <boaz@plexistor.com> wrote:
> 
<>
>> [xfs-dax]
>> threads wr_iops wr_bw           wr_lat
> 
> Data missing.
> 

Ooops sorry will send today

>> [Maxdata-1.5-zufs]
>> threads wr_iops wr_bw           wr_lat
>> 1       1041802 260,450         3.623
>> 2       1983997 495,999         3.808
>> 4       3829456 957,364         3.959
>> 7       4501154 1,125,288       5.895330
>> 8       4400698 1,100,174       6.922174
> 
> Just a heads up, that I have achieved similar results with a prototype
> using the unmodified fuse protocol.  This prototype was built with
> ideas taken from zufs (percpu/lockless, mmaped dev, single syscall per
> op).  I found a big scheduler scalability bottleneck that is caused by
> update of mm->cpu_bitmap at context switch.   This can be worked
> around by using shared memory instead of shared page tables, which is
> a bit of a pain, but it does prove the point.  Thought about fixing
> the cpu_bitmap cacheline pingpong, but didn't really get anywhere.
> 
> Are you interested in comparing zufs with the scalable fuse prototype?
>  If so, I'll push the code into a public repo with some instructions,
> 

Yes please do send it. I will give it a good run.
What fuseFS do you use in usermode?

> Thanks,
> Miklos
> 

Thank you Miklos for looking
Boaz
