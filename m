Return-Path: <linux-fsdevel+bounces-7011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513BA81FB9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 23:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D61D2856F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 22:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5883110A1C;
	Thu, 28 Dec 2023 22:42:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF9D10974;
	Thu, 28 Dec 2023 22:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cd68a0de49so4671063a12.2;
        Thu, 28 Dec 2023 14:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703803322; x=1704408122;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DTy5fC2IJhp+ci9FkJAD+jYq4iQn7KSbHoZ8YlA2wvQ=;
        b=kMj7KgH8FEjcTaT3OezB+WoHMYviKSLWg6Ijs6Xh16aWAwpW6uqRmDR+U4AzvVZxSY
         l3s1tuYn8WnagZxbsbGdUYw4B2T0GUP7tscrK33DDsNgq07/k94JUAO9XCf9J+vfNw+R
         XjC8SMaNTHW9NkniPW2vHtLClZxmJhbzCgD2bpQoyclDuOrSlY7m04Pak/MZcwTpjghU
         3lrMzCMKUVNSBYvI9yxe3tQpTXbbnCJ71U4+Yk5B6VlzQixIxpusDaDULIpw2dUhvdlf
         LfQyRbOMlRLDUXXPAk5pNi7ygMcK/y2hdYlQ8euxez3zUAFN2OIrwV5MmibdTdUHC0K3
         b1LA==
X-Gm-Message-State: AOJu0YwmDd9P+JeM6KY6wNsm3vJZQAsSeCdafG56ST0lbkDvhzE8VsV+
	ob4u/mFCtWwPGSOevjAt8Vc=
X-Google-Smtp-Source: AGHT+IGfNnlAW2Ujv1FURsshAv4bfKuLSP9tIJr+PW8/iihOLm7kQ5HX5H8gMCYPmNM9u0qyCs+CVg==
X-Received: by 2002:a05:6a20:2445:b0:196:3265:e806 with SMTP id t5-20020a056a20244500b001963265e806mr2631958pzc.86.1703803321864;
        Thu, 28 Dec 2023 14:42:01 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id sr5-20020a17090b4e8500b0028afd8b1e0bsm14482044pjb.57.2023.12.28.14.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Dec 2023 14:42:01 -0800 (PST)
Message-ID: <00cf8ffa-8ad5-45e4-bf7c-28b07ab4de21@acm.org>
Date: Thu, 28 Dec 2023 14:41:59 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/19] block, fs: Propagate write hints to the block
 device inode
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Daejun Park <daejun7.park@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>
References: <20231219000815.2739120-1-bvanassche@acm.org>
 <20231219000815.2739120-7-bvanassche@acm.org> <20231228071206.GA13770@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231228071206.GA13770@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/27/23 23:12, Christoph Hellwig wrote:
> On Mon, Dec 18, 2023 at 04:07:39PM -0800, Bart Van Assche wrote:
>> Write hints applied with F_SET_RW_HINT on a block device affect the
>> shmem inode only. Propagate these hints to the block device inode
>> because that is the inode used when writing back dirty pages.
> 
> What shmem inode?

The inode associated with the /dev file, e.g. /dev/sda. That is another
inode than the inode associated with the struct block_device instance.
Without this patch, when opening /dev/sda and calling fcntl(), the shmem
inode is modified but the struct block_device inode not. I think that
the code path for allocation of the shmem inode is as follows:

shmem_mknod()
   shmem_get_inode()
     __shmem_get_inode()
         new_inode(sb)
           alloc_inode(sb)
             ops->alloc_inode(sb) = shmem_alloc_inode(sb)
             inode_init_always(sb, inode)
               inode->i_mapping = &inode->i_data;

>> @@ -317,6 +318,9 @@ static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
>>   
>>   	inode_lock(inode);
>>   	inode->i_write_hint = hint;
>> +	apply_whint = inode->i_fop->apply_whint;
>> +	if (apply_whint)
>> +		apply_whint(file, hint);
> 
> Setting the hint in file->f_mapping->inode is the right thing here,
> not adding a method.

Is my understanding correct that the only way to reach the struct
block_device instance from the shmem code is by dereferencing
file->private_data? Shouldn't all dereferences of that pointer happen
in source file block/fops.c since the file->private_data pointer is
assigned in that file?

Please note that suggestions to improve this patch are definitely
welcome. As you probably know I'm not that familiar with the filesystem
code.

Thanks,

Bart.

