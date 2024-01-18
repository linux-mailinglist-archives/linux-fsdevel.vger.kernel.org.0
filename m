Return-Path: <linux-fsdevel+bounces-8272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5C7831F60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 19:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 232AF2819BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 18:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475EB2E403;
	Thu, 18 Jan 2024 18:54:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D122DF9F;
	Thu, 18 Jan 2024 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705604063; cv=none; b=S+322/jMiMuTyQd8qeLXNn8Y+gida5gMZyx8vMuNOw2+mmV9D90kxOR7NPs5LqOPH1kVgjPPB/LwwIX6Cye6zVSJJ+Hd7H11D1vlct6mCyowpjWq2NeJ1nYl/KSaqrQIxXqgo40hJa2Hws9aWCINFfdzcA0e7nalkWGxZvX6phc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705604063; c=relaxed/simple;
	bh=SW61X9iPT5HGpvAFWYKZrBk7bt+69tgTJLf5vM7rc+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ad0LtJ4GzqBPJecnDv55loSQtGMGnScrr5Q+rfZ6svdNUlAYaqQZ3Queb7KL6H3VKJ130ywB3CDs1Nhy+AlnTc5W4NWtVjDldjplnrm6tkrZ563v8Yp+FN4IDpawCYtFNwe+hqwrSzLllXs3zFCGjlWNpp6DjiaCjTQ0p4vpGW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d5f5a2e828so20915715ad.3;
        Thu, 18 Jan 2024 10:54:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705604062; x=1706208862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NLiyP8JdjAEXsd0zQe8BGblZ6FI95yViZfYspX8Q9/o=;
        b=e+8dE7FNS44NldSHN/+UE9rZJvY6b/PTQeoBYxB29RPQp/Ui+HpXUzCKtkfsgm0AkZ
         J0fDZOa0SU3YuS0cM62xJOCSMlxzmzI5y/R3E1nhTyZzwoVMVc+eUiMCe9r0viepTzuF
         qGatDiSouOhXXpZCoARRl8qB3GXWzax8J3iMuxdsc9dIuQu11yteO1ZE9XWPJMrKKHpA
         MoUQieR91hze2MsMNK9IiJoYuaWuzf/MR011HW1nPXDPw9Eu7w7TDDWx++xOXtOOhMnP
         v693M0WTSROPQbv9qAiu/XOck8leV/Gu5awZUJvL6q81FJC9qWV9yv5G9nQ5SF14Q8j+
         0kVw==
X-Gm-Message-State: AOJu0YyVMINxeH6DAfgZ8ySIU6xP2zl5SCatSVx54kEXl5bBEJ6gv8XO
	mjzvNDixB9kkTjkz42q8aiIv4ir6iWz/upb6bojJIaAssJTCAFMl
X-Google-Smtp-Source: AGHT+IFua4xS8c4R16Z+P0rkFE6/w1mNKJq9+y5u5VqHvTtYpShphwLlwxVeMZP8fdrfZRim0syktw==
X-Received: by 2002:a17:903:1109:b0:1d7:4d7:a64b with SMTP id n9-20020a170903110900b001d704d7a64bmr1472959plh.121.1705604061921;
        Thu, 18 Jan 2024 10:54:21 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:718b:ab80:1dc2:cbee? ([2620:0:1000:8411:718b:ab80:1dc2:cbee])
        by smtp.gmail.com with ESMTPSA id mf12-20020a170902fc8c00b001d39af62b1fsm1704172plb.232.2024.01.18.10.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 10:54:21 -0800 (PST)
Message-ID: <9b854847-d29e-4df2-8d5d-253b6e6afc33@acm.org>
Date: Thu, 18 Jan 2024 10:54:20 -0800
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
To: Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Daejun Park <daejun7.park@samsung.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>
References: <20231219000815.2739120-1-bvanassche@acm.org>
 <20231219000815.2739120-7-bvanassche@acm.org> <20231228071206.GA13770@lst.de>
 <00cf8ffa-8ad5-45e4-bf7c-28b07ab4de21@acm.org> <20240103090204.GA1851@lst.de>
 <CGME20240103230906epcas5p468e1779bf14eeaa6f70f045be85afffc@epcas5p4.samsung.com>
 <23753320-63e5-4d76-88e2-8f2c9a90505c@acm.org>
 <b294a619-c37e-cb05-79a8-8a62aec88c7f@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <b294a619-c37e-cb05-79a8-8a62aec88c7f@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/18/24 10:51, Kanchan Joshi wrote:
> Are you considering to change this so that hint is set only on one inode
> (and not on two)?
> IOW, should not this fragment be like below:
> 
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -306,7 +306,6 @@ static long fcntl_get_rw_hint(struct file *file,
> unsigned int cmd,
>    static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
>                                 unsigned long arg)
>    {
> -       void (*apply_whint)(struct file *, enum rw_hint);
>           struct inode *inode = file_inode(file);
>           u64 __user *argp = (u64 __user *)arg;
>           u64 hint;
> @@ -316,11 +315,15 @@ static long fcntl_set_rw_hint(struct file *file,
> unsigned int cmd,
>           if (!rw_hint_valid(hint))
>                   return -EINVAL;
> 
> +       /*
> +        * file->f_mapping->host may differ from inode. As an example
> +        * blkdev_open() modifies file->f_mapping
> +        */
> +       if (file->f_mapping->host != inode)
> +               inode = file->f_mapping->host;
> +
>           inode_lock(inode);
>           inode->i_write_hint = hint;
> -       apply_whint = inode->i_fop->apply_whint;
> -       if (apply_whint)
> -               apply_whint(file, hint);
>           inode_unlock(inode);

I think the above proposal would introduce a bug: it would break the
F_GET_RW_HINT implementation.

Thanks,

Bart.

