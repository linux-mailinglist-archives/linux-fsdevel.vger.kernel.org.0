Return-Path: <linux-fsdevel+bounces-46991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E9EA972D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 18:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3C617B08E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BF12918FF;
	Tue, 22 Apr 2025 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JJ+ErcEa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2F219F471
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339558; cv=none; b=LB/W6GKtXcdVoF95DSES9oHpydLOUkJcdvpkZrmQK3xry60Iy2LOCXkHOyU/32X6upFQBCMnKtODwoit8fVFak7uoEeUVssS5XUcY8XIV5O8r12Pmij933y2oKh1iIP3XDcmX97QW14zk50784pDpWf9GPDJhD82v53vHviDBG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339558; c=relaxed/simple;
	bh=Hc/a/N/czd1QJv27rjO3dbrnoqAvSzODqlF6TDvG0Ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YtDJZub0RPrnzaZsvRO/qD6Dt5CO5VNPByLUJ3X7BtPrIr1ZlJ75ZtXzo5fGmVyl6A3nn/XVbJQXMZ7DQfXeacvXZqshpAvnzbvXbSKIFHKTVs7ae+OzIgWzsBjUGWBDwy8txMNg8+GD320YPXTKJxFlsq8vlSTZxz6OdzPKNPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JJ+ErcEa; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85dac9728cdso105829239f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 09:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745339556; x=1745944356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BI9KG26m9xjN9k6dbGw+O0NB/svh8sdwPuBKvebFKKY=;
        b=JJ+ErcEacJcnmCKKdBqYjTgPYOlb3oEIuQYoXzfTrgWjxvznzuKQcZUY89gbNVAV0X
         UStMCUWyEW3CEgXcAkoqxSmOpCO+7JeaSdxMSGFsQpYZwov2gzFuKcBN/IL1yDQQ02ve
         IZSOE+/ssGWpFUhAXojMGNsNpQJUSt8Nlnh2uWOP8fpMFG393SnFoT6N4RmTMPqCJohJ
         oVyIwc7LB1DBrmKXcVY9LR4YJhiNDTkbYBiVwCUaSTXlQ4gqZAdABvedekgKpx5D3PgX
         bWyBKrXzloQQ6379aFoDGBNoDkAaKDRKyVYR+Zm3mSPOlfMaKyBghGOGS3SZoCFGfHzs
         TRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745339556; x=1745944356;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BI9KG26m9xjN9k6dbGw+O0NB/svh8sdwPuBKvebFKKY=;
        b=BeU2IaECDJK5lWqty3/+E4eiDddEakGZBGuPMXRf4LHnRiT+zK/gGfhGa5aXk7JfWB
         1YX8W6GJQ3xKj0G+HQ0Q5HmNce4MHR2pLbsf5sB/CVuP+qyIqppsU6CiHcsTFWgqwvsI
         6q8ywArdlY0mmhJFit95MFDqg0Rm5APf9PU2z4wdu12JpgGb1wENZlNk31kIZ/EYhTsA
         9n9jttYg+mjwqZd53gyZnLswJK2B2Q4WvCVkr2Aw189HPV/5aUZq4cwH0Q7asnIWA22p
         BGXyz57c1pT9gySCNK+ofa0S4XhnWxQC22302GFZ+EhZ8XohhPB/rRIPLRO1wzEOVTag
         7i5A==
X-Forwarded-Encrypted: i=1; AJvYcCUSqBd/AWiM3RBOoTkWeL32yoZjZenn+A9UaEQiOq5DLECU5hAtTGgWALR7Tg9Ct/CSrovuwnviRA5D1QdL@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ+M85RXD0HJyxK/H/l6qdYme77M3eQuSEYlQBrJSPOh3gUpY7
	eDnJ6wopYtfdXd2zmMItY5Jzt5jn2wB05Lq9FrURb+iYe3EUw3XfHz9lSQ8JekU=
X-Gm-Gg: ASbGnctH8qw7T4e9t5FNxkybHWBXH/DIGyDOVzebX5BpU3mLo+kSlrBkiagIia6kJtl
	VPpfjtS9Ie/HTTbDf7/VRCYrB7I3Y3B7SXTjrrdexl/jmbYgGUxqgiPFxPL1oCjFoIf0wIBGvik
	EVv0FaiSfRXhk9b0Db28W4k0pOxcVkYIcKKjWEmvGgniRwWy6brRSSSJXSCK0XQGVM8Kxn3TjcF
	/ddpTEH/kP0odinHLehCdvuxKmBODhOWAy2A+37Wv3k5xJGV79PcJy/QMF7+GbNGx3KoiuYobHB
	JU+eXtFyxQO/626S6C8GcezqFhFzmHkvaQ2p6g==
X-Google-Smtp-Source: AGHT+IGFUtqoZyoWSfs3yKraYI/uOz+4B4kDE1UUkceCkMGC1DfmqmAIi/faS6XWXrDcN0tXD6ot6Q==
X-Received: by 2002:a92:cda5:0:b0:3d8:1d7c:e190 with SMTP id e9e14a558f8ab-3d88ed79da8mr170240475ab.7.1745339556060;
        Tue, 22 Apr 2025 09:32:36 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d821d1d7casm23248195ab.10.2025.04.22.09.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 09:32:35 -0700 (PDT)
Message-ID: <14195206-47b1-4483-996d-3315aa7c33aa@kernel.dk>
Date: Tue, 22 Apr 2025 10:32:34 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] io_uring: Add new functions to handle user fault
 scenarios
To: Zhiwei Jiang <qq282012236@gmail.com>, viro@zeniv.linux.org.uk
Cc: brauner@kernel.org, jack@suse.cz, akpm@linux-foundation.org,
 peterx@redhat.com, asml.silence@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
References: <20250422162913.1242057-1-qq282012236@gmail.com>
 <20250422162913.1242057-2-qq282012236@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250422162913.1242057-2-qq282012236@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 10:29 AM, Zhiwei Jiang wrote:
> diff --git a/io_uring/io-wq.h b/io_uring/io-wq.h
> index d4fb2940e435..8567a9c819db 100644
> --- a/io_uring/io-wq.h
> +++ b/io_uring/io-wq.h
> @@ -70,8 +70,10 @@ enum io_wq_cancel io_wq_cancel_cb(struct io_wq *wq, work_cancel_fn *cancel,
>  					void *data, bool cancel_all);
>  
>  #if defined(CONFIG_IO_WQ)
> -extern void io_wq_worker_sleeping(struct task_struct *);
> -extern void io_wq_worker_running(struct task_struct *);
> +extern void io_wq_worker_sleeping(struct task_struct *tsk);
> +extern void io_wq_worker_running(struct task_struct *tsk);
> +extern void set_userfault_flag_for_ioworker(void);
> +extern void clear_userfault_flag_for_ioworker(void);
>  #else
>  static inline void io_wq_worker_sleeping(struct task_struct *tsk)
>  {
> @@ -79,6 +81,12 @@ static inline void io_wq_worker_sleeping(struct task_struct *tsk)
>  static inline void io_wq_worker_running(struct task_struct *tsk)
>  {
>  }
> +static inline void set_userfault_flag_for_ioworker(void)
> +{
> +}
> +static inline void clear_userfault_flag_for_ioworker(void)
> +{
> +}
>  #endif
>  
>  static inline bool io_wq_current_is_worker(void)

This should go in include/linux/io_uring.h and then userfaultfd would
not have to include io_uring private headers.

But that's beside the point, like I said we still need to get to the
bottom of what is going on here first, rather than try and paper around
it. So please don't post more versions of this before we have that
understanding.

See previous emails on 6.8 and other kernel versions.

-- 
Jens Axboe

