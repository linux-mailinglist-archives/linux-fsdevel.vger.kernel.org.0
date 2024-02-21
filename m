Return-Path: <linux-fsdevel+bounces-12270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8894285DF56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 15:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4178F2854E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 14:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552D27CF08;
	Wed, 21 Feb 2024 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KuM6aCiH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD71469962
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525617; cv=none; b=KJt+HKeV9UVdoMRC7XTImo+luXCoPXKm9vNJpka1GtXF/568AZ0XKov6daAky5T/cYs/uijhDF8QqZOxOxXdZnVrIU7HNGBWhit3JEZzji5uG5QzuNOLc3MvQSeiJZjYAkGP78lO2pIEma5eXhRvGh89Y03hy2UJpSiRvPu5GFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525617; c=relaxed/simple;
	bh=5oWkD2FaqkD0kYMxDZ3B3sb6F6lGwW+CZXsdNRCDKWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BcnwdcRK7E9bCiMviyj49ngLUaLzw67K9sZGBfwXyCYvZ94Ve1XTbBCXgpvSFNSY5a2YFGdH9k224NhSF6DiZzyyrkVG+FTgnQ6RZH6zLDm46/7TAgQfuZfTsQTzLtMRTdLzPX4fWSZ0wTu024TcLdrkIEy0b2JHyTMHH5sk1OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KuM6aCiH; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e33db9118cso1015248b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 06:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1708525615; x=1709130415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SVGUs8JFv1/V93TlaR+90LP3Y6ZwxPBuwr1HDt3LFuw=;
        b=KuM6aCiHvR8PUxA968/qSHOnfTh6waVcXLVnHkF2NEmYq1eI0qmKWDfdhynDa5MxiL
         1KSfIJOsmSlixHwXWQ+53LN/U3cL5kTLk9aUep0FFezASMrLUI/sPkxFDzwVBCcy56T5
         ZfNht8yW/ZfUAk/vzm2f0jG5cf9RkrmFtKH//SasFmpDLZJy3Y8rV7OzybpmEOJ0uBfI
         O2Tzi9VtRXgvknyGEMFMJbWeNPZlxSxmkhtWjPvNcQlLTOUdIR41wak0SDoVoB2Cl20q
         PWoYm4nLwnNQVvEl1ZXN4sStFzXCitX0HqKtDLq+gkUjfksrZI5a4LsOjXnPqIvw2GnR
         ak4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708525615; x=1709130415;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SVGUs8JFv1/V93TlaR+90LP3Y6ZwxPBuwr1HDt3LFuw=;
        b=sVCcdUuTItQUC7alXY6OcrrCiPCwtt4AlhC0vJB8GJ2pDvEVUmU4hrRoCq7sBXV49Z
         kvyJDxAdU9OkKR3YFYVE/5MCg6tHaJ9OVwheeI8zdYmLru//U/m/mjIeKrMfuiRwigWG
         2c2awDQHGlwV9YIm9esDeKKoBn7gE3V7VT4eYfvVPJOTM6JX1xjgNJTH22wpoK5qR16v
         GvQnDZgj1aG6CyH0hTnXtZI15Fri64Xh1/9oD7xQmee5lz3/fZKEx65OeeDpxULpqOKs
         Enmu6kkUcS32Ldm6l2j346mQUiP18Mv1p1QToiu4ysGADctm+UnM4EfJmpSbnPY/1Ekq
         /v8g==
X-Gm-Message-State: AOJu0YzCCMP4Q3OC93Qh2USIf61U+XxUASaTmv4AqBvW0Sj8s0ceLylt
	44rvsvsFjvUWcrLrajMDs54JVOBz02NAFKB6ut1y3VkqBQ/SKoUlUZPcQC0PuGQ=
X-Google-Smtp-Source: AGHT+IGWtrBI3YcMOy3hERvUjq7oUiTByRTeZL9iWcm9qeoPtIw2BqLDWLvNmt+3oej+p28dGt1SMA==
X-Received: by 2002:a05:6a20:6a22:b0:1a0:c207:808c with SMTP id p34-20020a056a206a2200b001a0c207808cmr1763297pzk.0.1708525614866;
        Wed, 21 Feb 2024 06:26:54 -0800 (PST)
Received: from ?IPV6:2600:380:7677:4d94:4513:899f:6e45:a331? ([2600:380:7677:4d94:4513:899f:6e45:a331])
        by smtp.gmail.com with ESMTPSA id h5-20020aa786c5000000b006e4452bd4c6sm6949123pfo.157.2024.02.21.06.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 06:26:54 -0800 (PST)
Message-ID: <b70345f6-f371-48b0-ad15-ca6d09d1365e@kernel.dk>
Date: Wed, 21 Feb 2024 07:26:52 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] fs/aio: Restrict kiocb_set_cancel_fn() to I/O
 submitted via libaio
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Avi Kivity <avi@scylladb.com>, Sandeep Dhavale <dhavale@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, stable@vger.kernel.org
References: <20240215204739.2677806-1-bvanassche@acm.org>
 <20240215204739.2677806-2-bvanassche@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240215204739.2677806-2-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/15/24 1:47 PM, Bart Van Assche wrote:
> If kiocb_set_cancel_fn() is called for I/O submitted via io_uring, the
> following kernel warning appears:
> 
> WARNING: CPU: 3 PID: 368 at fs/aio.c:598 kiocb_set_cancel_fn+0x9c/0xa8
> Call trace:
>  kiocb_set_cancel_fn+0x9c/0xa8
>  ffs_epfile_read_iter+0x144/0x1d0
>  io_read+0x19c/0x498
>  io_issue_sqe+0x118/0x27c
>  io_submit_sqes+0x25c/0x5fc
>  __arm64_sys_io_uring_enter+0x104/0xab0
>  invoke_syscall+0x58/0x11c
>  el0_svc_common+0xb4/0xf4
>  do_el0_svc+0x2c/0xb0
>  el0_svc+0x2c/0xa4
>  el0t_64_sync_handler+0x68/0xb4
>  el0t_64_sync+0x1a4/0x1a8
> 
> Fix this by setting the IOCB_AIO_RW flag for read and write I/O that is
> submitted by libaio.

Like I said weeks ago, let's please get this fix in NOW and we can
debate what to do about cancelations in general for aio separately. This
patch 1 is a real fix, and it'd be silly to keep this stalled while
the other stuff is ongoing.

This isn't a critique at at you Bart, really just wanted to reply to teh
cover letter but there isn't one.

Christian, can you queue this up for 6.8 and mark it for stable?

-- 
Jens Axboe


