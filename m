Return-Path: <linux-fsdevel+bounces-11003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2FC84FBAC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 19:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32BB28397A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 18:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1837EF01;
	Fri,  9 Feb 2024 18:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zClRmySY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2AF7F48A
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 18:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502384; cv=none; b=om3QsGfV47jZE9x4TsV7fL2aO4IaAZfp196A/iNUYB7bJDpUQxunmq0Kpnut/GFMmNd1JRv96fJyNlOA1oPUvXz9UnC5I6C1/4mnGdbwt/Q6WxQ980mx6ocdUphjvD8Zj9a6VEnsGzhGGBDjlIXaKDcxpDWv8jGcoNYxzcZqanE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502384; c=relaxed/simple;
	bh=aauKJJj9TU85XOv1eBB6c9GF/CDXW241tDNbIsbTAl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kx0SmubSjxWlBDQuJNvy2E4PPJcwKqTggzCXg9VZsuqYSiD3SA/AVvgs6DYiuqpp8rfS2D/pvSS5aFmTY8k8lwRxaaF33zLvQOn8U/oCnuE6SUodXQTKUXhWFvBCZT8BOxoTXxq4Pc+1fNR5Wyc0PvNFSEQJT9nKP7mK6v5q5DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zClRmySY; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-363f0a9cf87so1343525ab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 10:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707502381; x=1708107181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FapmDDtx1ab5pMc+0Vo68lEXcL/wuQcJAlemfNfLS20=;
        b=zClRmySY03sKiUF7DrWHgKQk44bj2LzADVrB0T/16q/CyT2SZzICeecQkF4TCTMAof
         jX4j9eGTaVcxSGSdJepJXjHZ/rbNWVP0xibmeqYwBX3VCHIJCajc/2SQl/a4E6W3o/eH
         vPblxk5ytzpOladOjmD32Hdo55FRhBniPWBgxxYaAljncTYYFWRxAsZF3+c48VjkSZIY
         yd1gFBfMuwwyDZ1uQ+39bcvtu9m4/zlHiI5BGM0r2LO83TJ2ThxRHiNwICM/vBvkJILd
         DEfUFRBbhzj5JKOvE7qf1WnN3T0RWAt+XsZsFef6bGhBHgAOhyNu6rKvMSCl8cRZq5+I
         FYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707502381; x=1708107181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FapmDDtx1ab5pMc+0Vo68lEXcL/wuQcJAlemfNfLS20=;
        b=mFqZGksJkPCS/uXdgLnI6ODX0a6gv4jKof3lB62sp/D8hAXD8MTps+X7tl/x1ISwXi
         OvxeaV8sZNZrGbskpHe/mga3aGgqtPd5/8rvyeSCJpXu1bwWBtWGh468jL73tt4h0Nwp
         eVlrgTwGM0+lBJCnQrDUtwe11f/L6yNsEEgcaTWOBPVSISQjqcdMhnLIb7TAZ2GIZ+BM
         Y/z2Pg1SKCFuAAGldXC9uc6KyYuq39I439tjp+J9HlM3BZLcIh5IkFCu8dZrouaZ+JbN
         TvJfqF3/DDalmzKPNgwItGikp1KOPI9K2w3eOKSiyL8k+KvjqKCdgEDI0JF+V379ZB2/
         0MjA==
X-Forwarded-Encrypted: i=1; AJvYcCUnqP1Tw7X7ucE6yUbDp218MqKSNFgqOeXcbRRpH8fl7TO4X4bLzfQxYCkBoLUf7F1PMv/z27EVBnP6Dpv29qMf4OnVdWdWYkG0u18fQA==
X-Gm-Message-State: AOJu0YxhzkmHjnnff/l2lfNNkO60AanoLdJb21vfLo/mjOX2oi7NFpG1
	VQaY+t3TbMCRKlWopQrISQTZrLRVmzGAVuI7BB8cr5ICjkVwQJxAV2zDC0/sMQU=
X-Google-Smtp-Source: AGHT+IG/V88bpIyU8MOKlWCUKNcfIklsMyf56DRgdFVH3lW39zsw1OZpNq415AOZXL5kGbPXMGoo8g==
X-Received: by 2002:a6b:6716:0:b0:7c4:965:f8c0 with SMTP id b22-20020a6b6716000000b007c40965f8c0mr123712ioc.2.1707502380948;
        Fri, 09 Feb 2024 10:13:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV+hAq4woSYvYtLnH423Qm3mhJbvXxVa7UwEPhsPlwjUX0A7IfbUQbHYADXBYY/E+Bljzv/m44Q/izmIs3QRM6n8TUYEdJ6BJ6v6v+eVt7Aef5f2qZuJzpxUKS0869z0Wd1znFVpE2zv5V5JxByMjX66t7kviHbyIroazTFaZPra7mM7t/WjFi08xobQHwkrq31SMiY2hBbObTqLSVVjp+FrILKbaFFFlwI6lfcOU/RzrNBRE/DPspLHe5we0jD7R2lFaO90YeghIbl6es=
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id eq22-20020a0566384e3600b0047356b21448sm107308jab.132.2024.02.09.10.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 10:13:00 -0800 (PST)
Message-ID: <9a7294ef-6812-43bb-af50-a2b4659f2d15@kernel.dk>
Date: Fri, 9 Feb 2024 11:12:59 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs, USB gadget: Rework kiocb cancellation
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
 Sandeep Dhavale <dhavale@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20240208215518.1361570-1-bvanassche@acm.org>
 <9e83c34a-63ab-47ea-9c06-14303dbbeaa9@kernel.dk>
 <20240209-katapultieren-lastkraftwagen-d28bbc0a92b2@brauner>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240209-katapultieren-lastkraftwagen-d28bbc0a92b2@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/9/24 2:34 AM, Christian Brauner wrote:
>> Why don't you just keep ki_cancel() and just change it to a void return
>> that takes an aio_kiocb? Then you don't need this odd switch, or adding
>> an opcode field just for this. That seems cleaner.
>>
>> Outside of these little nits, looks alright. I'd still love to kill the
>> silly cancel code just for the gadget bits, but that's for another day.
> 
> Well, I'd prefer to kill it if we can asap. Because then we can lose
> that annoying file_operations addition. That really rubs me the wrong way.

Greg, can you elaborate on how useful cancel is for gadgets? Is it one
of those things that was wired up "just because", or does it have
actually useful cases?

Because cancel, internally in aio, makes sense on eg a poll request. But
we don't need extra support for that, that's all internal to aio. It
doesn't make sense for O_DIRECT IO on a regular file, as there's no way
to cancel that anyway.

Reason I'm asking is that we have this broken cancel infrastructure that
we can either attempt to make work, at a cost of adding an operation to
the file_operations struct, or we can just get rid of it.

-- 
Jens Axboe


