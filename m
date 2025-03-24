Return-Path: <linux-fsdevel+bounces-44886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E43F7A6E1A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 18:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85AE87A78CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 17:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24723264A69;
	Mon, 24 Mar 2025 17:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jr0poIr3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28E526462D;
	Mon, 24 Mar 2025 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742838535; cv=none; b=g2ffq6FLHqQ/nHv04bNQv23C7oa2ZB/qMZybvDTw8qM2hS5Qg55Zks1bxQK6+sZ6EtgaW7sx12axdeu6JpKYZRv+8/hFsV1bkMhNoP38WoXVRrFQUlsUCcd/GlkOaR0E2Bjk9F4yCWEIe7RROSXZYiKU1PEWzWeVg8C4D0xuP+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742838535; c=relaxed/simple;
	bh=RZQuZtXy5wnvBruRoNcdKcd8icEsXemLdvH5AT5pFrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZv6A/d4scdeopYgqn6PTl+FW3kQSANgjNsLEK05mYS7DvltcSVbeK4tOaNZQn+5rzdOHYjEuOLxGSkev+ekMjkaofutQTWImw2IPEPg8EpFvN1fWU15ax401gY4XoVAEmIbnSefhAU9qMvoO3xK0cAay9L6CR+G5Ntx91v0Rk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jr0poIr3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so38074985e9.2;
        Mon, 24 Mar 2025 10:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742838532; x=1743443332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=azBOCOMxXyiXiEpeV9ZgsajMxLsGMhPfMHOInLxtg9k=;
        b=Jr0poIr35ntYsFH2uIoIqcxCG0BlKcAy4MvzJEWOjskbVI3DoJiqEnkI+fpvCCBxa3
         zqq0fFaG7uV/UL0+dekpeuhRjqO8Je1YmRpmiCZg8O3pzdFe7jlOfKxJH7WHFHdiG11s
         ovvU7UoX00O0UGYjonqnpcfHR17O/WAYH/v4FRFrY1ldQ9BXlz7n0hkC6qMyr4jlS/e/
         PC0Ht8OKCl9li2LlJXD4Pwo1T3nMNX2a0ZWGprpDcPu9flS+jDb1W7JdM7TqGx9Xf9lE
         6tbg8QewlSd6bHaq2dW88ON9nkqAIjr5qO0a8DNZ+J/vxl1RmAh+uyWXKRKzvpMfaCu5
         CA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742838532; x=1743443332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azBOCOMxXyiXiEpeV9ZgsajMxLsGMhPfMHOInLxtg9k=;
        b=SmjrObkmfncJqOhei/wfR/oNmtgojw/zjfGFjnspVo7n8HT0rsx7wU7RGw/wvS8T2v
         NRWNBGConZGfApFeyVnvrzS69ZZ8GDQu2R5AB7JXrNe+RflrKDieWtvugB2A6EjSKPhI
         8HEFrK6nE4ZzNntU+fhmQsIheTAZjhAAX1psFdB9nw/Ll7C2QnOV7q029RMabtW3r2u3
         eX0DwG81JJlUZqkvITf33Ox7/+nRtov45QQURiT4hTBIKNkPIFz6BPDZJYHIkos6s54E
         jGbRrupfkxeQ3GqftplahIjTcQRW5w5YDOyowrrp5+YxDq5fg/H8XY6j57bBI4baVCVr
         ypZA==
X-Forwarded-Encrypted: i=1; AJvYcCVDFgK7G17bSd6P2k+Gh/711puctXBjxg/JvqoV9ElVmw7AIJOT8Pu6BxTnCRt5JvT1tWl2qzZ1FxxkN846@vger.kernel.org, AJvYcCXLWFVnVRiuHApxBQ62pZfbstsKnTz7N2ri0ws03cdvYJ7EoQ6v4Pa6JCdxKKomSO0512QXvZQs1kD1i+ap@vger.kernel.org
X-Gm-Message-State: AOJu0Yybt77SHgOVNs+rcVaQKnu5Viimc2U+SrD4t2RKD14/TITxgHcZ
	pWTGIjpk3hdE0ZsRTaRnYOEcV1LnGM3vHkXdTfrgiWrxOcX655Qn
X-Gm-Gg: ASbGncvfymFYl3Ev+1mEaU+YUSi0L78pFQ762XX+g3+etLKGLhkzznYQXm11zA85FZs
	c0R59mY/vDbsrm/HXBwwROuu17Fov1dS1Z5nOnlW9NzMxMeRfD++HAPZ0Xn+reK2INO7fEC1ckr
	9fKIXIsIW6WtwvxoKBdyfg6jNMk8hrBSLQmGS2snRh4q+L/ELFvYLtHJs6kZy0pisyaRty/Xiwo
	8QvU4HsB49146DYkJg3flX6dqJrIeYek7SKPFcMX7ZmaqQiOuFiogGTCZhn7zmg/RzKpo0B7WY/
	arIf8jGcT0xM9hLv68dbUALivkTVclVhvLDx8c/aOi+/mzmEc4KKpbwn8CqP
X-Google-Smtp-Source: AGHT+IHaFr+YpetoOYJ7K0s7wosWi4wwpC9N5K/MZhGWvBurJT1aEYdrzxI323k/7WkiGDFh0tQ5zg==
X-Received: by 2002:a05:600c:3489:b0:43c:efae:a73 with SMTP id 5b1f17b1804b1-43d509ea0f8mr150880905e9.10.1742838531829;
        Mon, 24 Mar 2025 10:48:51 -0700 (PDT)
Received: from f (cst-prg-80-192.cust.vodafone.cz. [46.135.80.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43fdaca8sm180961875e9.28.2025.03.24.10.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:48:51 -0700 (PDT)
Date: Mon, 24 Mar 2025 18:48:35 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Penglei Jiang <superman.xpt@gmail.com>
Cc: brauner@kernel.org, akpm@linux-foundation.org, 
	lorenzo.stoakes@oracle.com, tglx@linutronix.de, jlayton@kernel.org, viro@zeniv.linux.org.uk, 
	felix.moessbauer@siemens.com, adrian.ratiu@collabora.com, xu.xin16@zte.com.cn, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	syzbot+f9238a0a31f9b5603fef@syzkaller.appspotmail.com, syzbot+02e64be5307d72e9c309@syzkaller.appspotmail.com
Subject: Re: [PATCH] proc: Fix the issue of proc_mem_open returning NULL
Message-ID: <ajipijba74lvxh2qqyxbxtbmlqil2smsuxayym5ipbmjdysxq2@stvu4kt62yzu>
References: <20250324162353.72271-1-superman.xpt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250324162353.72271-1-superman.xpt@gmail.com>

On Mon, Mar 24, 2025 at 09:23:53AM -0700, Penglei Jiang wrote:
> The following functions call proc_mem_open but do not handle the case
> where it returns NULL:
> 
>   __mem_open in fs/proc/base.c
>   proc_maps_open in fs/proc/task_mmu.c
>   smaps_rollup_open in fs/proc/task_mmu.c
>   pagemap_open in fs/proc/task_mmu.c
>   maps_open in fs/proc/task_nommu.c
> 
> The following reported bugs may be related to this issue:
> 
>   https://lore.kernel.org/all/000000000000f52642060d4e3750@google.com
>   https://lore.kernel.org/all/0000000000001bc4a00612d9a7f4@google.com
> 
> Fix:
> 
> Modify proc_mem_open to return an error code in case of errors, instead
> of returning NULL.
> 

The rw routines associated with these consumers explictly NULL check
mm, which becomes redundant with the patch.

While I find it fishy that returning NULL was ever a thing to begin
with, it is unclear to me if it can be easily changed now from
userspace-visible behavior standpoint.

I think the best way forward for the time being is to add the missing
NULL checks instead.

> Signed-off-by: Penglei Jiang <superman.xpt@gmail.com>
> ---
>  fs/proc/base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index cd89e956c322..b5e7317cf0dc 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -840,7 +840,7 @@ struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode)
>  	put_task_struct(task);
>  
>  	if (IS_ERR(mm))
> -		return mm == ERR_PTR(-ESRCH) ? NULL : mm;
> +		return mm;
>  
>  	/* ensure this mm_struct can't be freed */
>  	mmgrab(mm);
> -- 
> 2.17.1
> 

