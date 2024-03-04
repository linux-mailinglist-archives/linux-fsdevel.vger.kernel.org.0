Return-Path: <linux-fsdevel+bounces-13550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1652870B72
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 21:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3D7281C25
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 20:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117CB7B3F3;
	Mon,  4 Mar 2024 20:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="f8XCakn3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E14F7B3F4
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583693; cv=none; b=VTFwaEIeqXLcsl06Vt5fmQpM08RRb4xYFnYPbmowgvCphDDet1vP3RIh6/zKkENnZhhtMGlMCKAGLUlrSt5xrN6uijnPI4CUY+1P5a91jX3y1T8DPJJ6QYSdbO0RDCrefXYBz8TgHYVfFO5bqM1CYXHr+e12kSKiaP7lT1LquXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583693; c=relaxed/simple;
	bh=ixv/3e099K5oAkmm/TE8nxObti56XmIKB0Vva3OJIcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dmty9vCQjUiUZLPVCRPluV0apyb8j94fX0xViIrs/c/t+mLq81GsMqo5RCoFF4u4rU21sIAzKvs1mzsBckEbmAu1Z9V5luPtHiO4q3KmP6q4e7q6XJuQQW3/8XJ5PYFJ9C845+IkjZehqtkx6gBL2Ne8gOI+pgQkXLH5mhCO/eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=f8XCakn3; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5fc05784c60so5327847b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 12:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709583691; x=1710188491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C4ofA+r/J1VWu+/TU1IW0qQNdlLB2vA5UomhfHP0BSE=;
        b=f8XCakn3Rbd8iXmorNbUEmmh28ZhkNXTgGjfdiaFeSiTcfck61Csqt0sGeSUupjK/A
         0z1HJuApFKZNuEhP5cSiMp7PyyzYwUHmTwlz/iy66w7SvuV/uwjUPISW3MI94d39Jpmf
         Xi/91hR988eoGClxi0v15SD/7r/r5koaLms30AFf3GR34zV/vKn14Ts0rQ7j8/8Yk7UU
         kqo9zJJIyG4IRAYuoZSorHd6i/nCJVnzMty8x/GFkemIe6KXvCJ+HmNLfAggPepfgInK
         SpXdehUA25ZQe71WsmHLyfrVEvftvhd30deun2337Tpqur6wwiF38tPsBzI82lU3xxB0
         d2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709583691; x=1710188491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4ofA+r/J1VWu+/TU1IW0qQNdlLB2vA5UomhfHP0BSE=;
        b=HM2nEjfoGYRV0pNmc0uZVzX0v1YeTyTinaav+xPRRA4P1iVk7GlrGwV/AtzARHmCXn
         aHxjp1qXgCuQJUlVehEhyqMheMNYiyUOdGgMmzJkJnIZQu65QR8LUGppAksx0MitDJj9
         F/KRUL/O9T5msrrEs/pDdo/3p1gVLNl6YbP+vPDmWZxl/739aqsoRFodbLTqQtBH83au
         t7Fgr40QXm52nIW3BCo1+iHwMo/uYYw40ajLYrjmUYVHtkjMXZUgp8EnxbSumNSQFtIK
         OexpD4zNrgtanmiyG/hf8fV4GK/jZ3+qYTKmqxKeF9svBRrUU158mhYSPkgC8tRdwnmm
         n/Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXhy3hREPNH3rRIH6hQ+0aF9XDv6nXhuOBXhIVucAGrSfSgLlnljGbEn8MOlTj10cstMEx1mHdT6QMt17YuJ073mqFSLBHQ1puXohv3wQ==
X-Gm-Message-State: AOJu0Yzi+1yzhb438pZZHFFE1XbsICB279XeL98mbkbA19sn1pxGgU1B
	DQDUwDM8orUusiHE0pDHsmtvC6YmRBcsYzlqsIszqk8WIYBpD2KL8WbrtqIz3BM=
X-Google-Smtp-Source: AGHT+IHwg9aIAW314BBFsP4hayoCOjkU/morxEs5OwYsv0BRjPcUDKtNYzKqFvSVuB7YrmWVtGBEMQ==
X-Received: by 2002:a0d:eb0a:0:b0:609:8d70:d6f1 with SMTP id u10-20020a0deb0a000000b006098d70d6f1mr5817137ywe.2.1709583691063;
        Mon, 04 Mar 2024 12:21:31 -0800 (PST)
Received: from ?IPV6:2600:380:9e7e:686a:98c8:d673:48af:2e19? ([2600:380:9e7e:686a:98c8:d673:48af:2e19])
        by smtp.gmail.com with ESMTPSA id l8-20020a81ad48000000b005ffff40c58csm2808519ywk.125.2024.03.04.12.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 12:21:30 -0800 (PST)
Message-ID: <b36536cd-c62b-4b86-aef7-fddd3eb282a1@kernel.dk>
Date: Mon, 4 Mar 2024 13:21:29 -0700
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
To: Bart Van Assche <bvanassche@acm.org>, Eric Biggers <ebiggers@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
 Sandeep Dhavale <dhavale@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, stable@vger.kernel.org
References: <20240215204739.2677806-1-bvanassche@acm.org>
 <20240215204739.2677806-2-bvanassche@acm.org>
 <20240304191047.GB1195@sol.localdomain>
 <90c96981-cd7a-4a4c-aade-7a5cfc3fd617@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <90c96981-cd7a-4a4c-aade-7a5cfc3fd617@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/24 12:43 PM, Bart Van Assche wrote:
>> I'm also wondering why "ignore" is the right fix.  The USB gadget driver sees
>> that it has asynchronous I/O (kiocb::ki_complete != NULL) and then tries to set
>> a cancellation function.  What is the expected behavior when the I/O is owned by
>> io_uring?  Should it perhaps call into io_uring to set a cancellation function
>> with io_uring?  Or is the concept of cancellation functions indeed specific to
>> legacy AIO, and nothing should be done with io_uring I/O?
> 
> As far as I know no Linux user space interface for submitting I/O
> supports cancellation of read or write requests other than the AIO
> io_cancel() system call.

Not true, see previous reply (on both points in this email). The kernel
in general does not support cancelation of regular file/storage IO that
has submitted. That includes aio. There are many reasons for this.

For anything but that, you can most certainly cancel inflight IO with
io_uring, be it to a socket, pipe, whatever.

The problem here isn't that only aio supports cancelations, it's that
the code to do so is a bad hack.

-- 
Jens Axboe


