Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F598E282F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 04:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437081AbfJXCbU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 22:31:20 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42412 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437073AbfJXCbT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 22:31:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id s20so11353567edq.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 19:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gnpimtDmP0lqthi2a9dQUIzsbuDYbXbk8lwy1rA6ZU4=;
        b=rWfKpJmH4ifuIAc04embim+n/JBDGLFT0Hj+ihXkCmiMhnOlUJ7dovXsW/rUmYCG6F
         NxvohT6iNXBI6t174vtu7YcDkT26RFlgZNkwGZix5mNkPhEVfaQJud2KWOstCgH42cLL
         C6TMjBSQEmYIn9WfT37PSeJ/iFVaR6bQjE0zyQcvJKF2mvrqFmnCmfG0685/oCLWd2D/
         kj3C67iakdIgJwUCaU7RXbrXgjL50UBwhAsUqAr4lASSx5NA4IH+9zeFS8WnF3708s4S
         VD43nmX5iXHmxRFB4FSaXMMTYJZZ+KuoOiJB3j+OaIRifCMquB5u1LE663zK8s24CJAE
         4+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gnpimtDmP0lqthi2a9dQUIzsbuDYbXbk8lwy1rA6ZU4=;
        b=LToDoE7RCzylTzTtyGBif1ymGHuN41uX02Jut7pa3r4JkHeMbuhnSexbMxEIHD7FcZ
         T9RsSwSP+ZRhjarAaCgyjHFvP2GCb3ThqkPDrL868NwQuTDINniE8fPw9zMhJZqM1PML
         f8UApOvua84CXGzA2/mAZCTgNxMmuDGMcYnQcjHqfOYB3239ZYd7kQBQ9oUR1AZn+3bZ
         tvSzv6wEQhjgGg0IR6BKY85DIk208wNoh+5XgJSeXvdBGj8JiznUQHn89ozHRNiM2jqy
         Bm/RMNl/yViWsHYDMD6UDvYvqoHmaNeqmXTpfEkXOf6b0GrjsFc/deXjnLVMVrj1vULX
         NsSA==
X-Gm-Message-State: APjAAAVWfsuuaCaLuzytUlhMbBaEV7VihMK380ZnxmXjnPggSnsBYeVJ
        /wbACNmpqogeUGcO5QDAbg6+bC9Fg+I=
X-Google-Smtp-Source: APXvYqy84bemiVw55n7fco+FbX1+KuwznFlI0XsqhDfwNJccDH40WXATcHh+QUP1GE+pY3XO2S2c9A==
X-Received: by 2002:a17:906:780e:: with SMTP id u14mr26591750ejm.97.1571884275784;
        Wed, 23 Oct 2019 19:31:15 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.210.43])
        by smtp.googlemail.com with ESMTPSA id x23sm430555eda.83.2019.10.23.19.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 19:31:15 -0700 (PDT)
Subject: Re: [PATCH 0/5] Enable per-file/directory DAX operations
To:     Dave Chinner <david@fromorbit.com>
Cc:     ira.weiny@intel.com, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20191020155935.12297-1-ira.weiny@intel.com>
 <b7849297-e4a4-aaec-9a64-2b481663588b@plexistor.com>
 <b883142c-ecfe-3c5b-bcd9-ebe4ff28d852@plexistor.com>
 <20191023221332.GE2044@dread.disaster.area>
From:   Boaz Harrosh <boaz@plexistor.com>
Message-ID: <efffc9e7-8948-a117-dc7f-e394e50606ab@plexistor.com>
Date:   Thu, 24 Oct 2019 05:31:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191023221332.GE2044@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 24/10/2019 01:13, Dave Chinner wrote:
> On Wed, Oct 23, 2019 at 04:09:50PM +0300, Boaz Harrosh wrote:
>> On 22/10/2019 14:21, Boaz Harrosh wrote:
>>> On 20/10/2019 18:59, ira.weiny@intel.com wrote:
>> Please explain the use case behind your model?
> 
> No application changes needed to control whether they use DAX or
> not. It allows the admin to control the application behaviour
> completely, so they can turn off DAX if necessary. Applications are
> unaware of constraints that may prevent DAX from being used, and so
> admins need a mechanism to prevent DAX aware application from
> actually using DAX if the capability is present.
> 
> e.g. given how slow some PMEM devices are when it comes to writing
> data, especially under extremely high concurrency, DAX is not
> necessarily a performance win for every application. Admins need a
> guaranteed method of turning off DAX in these situations - apps may
> not provide such a knob, or even be aware of a thing called DAX...
> 

Thank you Dave for explaining. Forgive my slowness. I now understand
your intention.

But if so please address my first concern. That in the submitted implementation
you must set the flag-bit after the create of the file but before the write.
So exactly the above slow writes must always be DAX if I ever want the file
to be DAX accessed in the future.

In fact I do not see how you do this without changing the application because
most applications create thier own files, so you do not have a chance to set
the DAX-flag before the write happens. So the only effective fixture is the
inheritance from the parent directory.
But then again how do you separate from the slow writes that we would like
none-DAX to the DAX reads that are fast and save so much resources and latency.

What if, say in XFS when setting the DAX-bit we take all the three write-locks
same as a truncate. Then we check that there are no active page-cache mappings
ie. a single opener. Then allow to set the bit. Else return EBUISY. (file is in use)

> e.g. the data set being accessed by the application is mapped and
> modified by RDMA applications, so those files must not be accessed
> using DAX by any application because DAX+RDMA are currently
> incompatible. Hence you can have RDMA on pmem devices co-exist
> within the same filesystem as other applications using DAX to access
> the pmem...
> 

I actually like the lastest patchset that takes a lease on the file.
But yes an outside admin tool to set different needs.

> Cheers,
> Dave.
> 

Yes, thanks
Boaz
