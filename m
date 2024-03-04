Return-Path: <linux-fsdevel+bounces-13548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C37870AD9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 20:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A13C81C21506
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7098379B6A;
	Mon,  4 Mar 2024 19:43:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC55E4653A;
	Mon,  4 Mar 2024 19:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709581393; cv=none; b=klvcMObzAuu0H/RCJLTwHegnsClStLQ3LvRWyu6mslb/9P8fGQYVb0Eg0sbF5hDb2L6oKuZw+E2Yo2hmazTO5k9XPkHyZjWzp4sOFNWa/1NUK8YmfHThZwGUOIg+XJRBKB1eeqCfMsSR/w5SNkuux9BEKNphMhm8j86yandpY8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709581393; c=relaxed/simple;
	bh=g4BE9SgKCtefxG89FH1WH3YUWls3hEfAM41n89RBJ9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pCvN5WZlfXxhO1Bevp+N6z+RU4L705Bt5o/t/soFCk4wARL8W/Px/Adai/iy1fL8UGFtA3ZlqOzrnLPZeTPW6aQ4awlNml875mYBKChGSykvax3KQR/eCpNTpTDTmL9TaWBuKyZ1/LYdkmenXRmZ3FL7xUVjUTzAYnjdZXNkS8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so4304549a12.1;
        Mon, 04 Mar 2024 11:43:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709581391; x=1710186191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lOJxNPPzSVXqD3aagskQD2Ydr+bCaePzg4Tv2ZpuDdI=;
        b=a6dRe+O2iO/xo0I4zZftI8VSoSQwvAAIm6cGqFpz3Uqsazyqr4szsDGwdHxtfMrOMB
         vkKjoZC3QEkdrOAX9vDNvaWnn2OepigTR62bxfRpl1kFqqlXGeUXtD6YGnBJaz306iff
         gy2yH7AUaFj3MHpzk7IvruJd3ADZr1IxtrOsCrlHu9dm83F+MGS7S8k5DOcV4cLMMdXC
         iaCh2TrwkGLlXgTfdpEuO4LN/zFQLqhDdmS0Bf7YsuqXVTbr4NiWbzyOeqo6GCXc33H/
         5NR9Geb06HCSGnbRDFGhdUj6S0bbmUiHfYj8aKhAB4725QnyVd8NyXjlAB7TRU/GA6ue
         NYjw==
X-Forwarded-Encrypted: i=1; AJvYcCV6/xO1eeFQQWDjMSsKw66l+GOyrDLV5rY2+9awfAVnrWbZRq/JcSNgjW7wTCGvqky/imtayW1Pdom1puiPJmts+hRRUMiisEzwsT8u+pGlSOzCmmMEtRWn4IevoDzX6Txh2I8F+Q==
X-Gm-Message-State: AOJu0YzrgzwIibl/k4xTWifk05agWMtEegnk6AhC9V1qgeed70Jl0J0b
	7ZCHWXKZtHHHmsj5I80BoGJkH3Lk+0x9xucRdK+IH2PhfLmqxqFB
X-Google-Smtp-Source: AGHT+IGGtb3+zcEUDFEGBym9/lHtcgKiWmjGgpb4yuKXaoo3nJv91szPGYzRL8fLTXFcrSHtJ1OziA==
X-Received: by 2002:a17:90a:b107:b0:29a:f199:1647 with SMTP id z7-20020a17090ab10700b0029af1991647mr555668pjq.1.1709581390965;
        Mon, 04 Mar 2024 11:43:10 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:9ba8:35e8:4ec5:44d1? ([2620:0:1000:8411:9ba8:35e8:4ec5:44d1])
        by smtp.gmail.com with ESMTPSA id kn11-20020a17090b480b00b00299101c1341sm8326806pjb.18.2024.03.04.11.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 11:43:10 -0800 (PST)
Message-ID: <90c96981-cd7a-4a4c-aade-7a5cfc3fd617@acm.org>
Date: Mon, 4 Mar 2024 11:43:08 -0800
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
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Avi Kivity <avi@scylladb.com>, Sandeep Dhavale <dhavale@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, stable@vger.kernel.org
References: <20240215204739.2677806-1-bvanassche@acm.org>
 <20240215204739.2677806-2-bvanassche@acm.org>
 <20240304191047.GB1195@sol.localdomain>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240304191047.GB1195@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 11:10, Eric Biggers wrote:
> If I understand correctly, this patch is supposed to fix a memory safety bug
> when kiocb_set_cancel_fn() is called on a kiocb that is owned by io_uring
> instead of legacy AIO.  However, the kiocb still gets accessed as an aio_kiocb
> at the very beginning of the function, so it's still broken:
> 
> 	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, rw);
> 	struct kioctx *ctx = req->ki_ctx;

Hi Eric,

Thanks for having reported this. I agree that this needs to be fixed.

> I'm also wondering why "ignore" is the right fix.  The USB gadget driver sees
> that it has asynchronous I/O (kiocb::ki_complete != NULL) and then tries to set
> a cancellation function.  What is the expected behavior when the I/O is owned by
> io_uring?  Should it perhaps call into io_uring to set a cancellation function
> with io_uring?  Or is the concept of cancellation functions indeed specific to
> legacy AIO, and nothing should be done with io_uring I/O?

As far as I know no Linux user space interface for submitting I/O 
supports cancellation of read or write requests other than the AIO
io_cancel() system call.

It would make it easier to maintain the kernel if I/O cancellation
support would be removed. However, there is existing user space code
that depends on USB I/O cancellation so I'm not sure how to proceed to 
remove AIO io_cancel() support from the kernel.

Thanks,

Bart.

