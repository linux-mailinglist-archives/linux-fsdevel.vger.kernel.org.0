Return-Path: <linux-fsdevel+bounces-11013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9BF84FCEB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 20:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778F91C2316C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 19:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB2D83CC2;
	Fri,  9 Feb 2024 19:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fE3e2E+J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A327B7BB17
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 19:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507305; cv=none; b=pbmyZ5s5+VAAPc1T+99J0t9s2QW2HBuJCcmKj+jUgXCi9t3DUsTSZ5E7TmKYGe1fOpVP+vlk9K6/yn1TgdDc8uheiwpl5l4NHU5NZsRB7vez7Srh0GWof2PE06aUfVMVTeaWhXkTmYAjK8lj5oKIW4/TDP/E7OFwaocVtSHv/18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507305; c=relaxed/simple;
	bh=otg8MxRnHl6a9o6+jxLqbvklmDGAhTsr60TAJ8qMVkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LH00c4a3X7jRpClHOl4k2QXy5ETIZy3SGH48iZptVNR3Z9+HJnT6fzZZLSItqiR9ThllqbaHn9PslUFCEekgKR+lACft+hxZzPU0zGk9auMrvG3+O5g5DsMJl6cFLmysnSNNep3mUPg1rLZ7Lh9S27pZz3Vsh6luPeNfuLsqAWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fE3e2E+J; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7c00a2cbcf6so6988239f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 11:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707507301; x=1708112101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WhJmfcnLRTEDlLUHZR6JUXW1OL1TBjJb/6H71AI6gtc=;
        b=fE3e2E+JXaW8E+fRjEEN6Bl4ShLYthCNYqvCfMWVMaZGiij6ieMvf6507UiQjIitIE
         UuHMczLcL7TbL+zX9aeiS0wSq4rB1Hry8eBw4hjPBjcxKWKoWTha0BUKCQvpnpAIjFvx
         8VDXEEB4gHHjbsPh0Wjt+wX4NJrYWqqx93Wpma4qu4YAxTq1wJvr6cy/PbRKEPMoF1Wo
         seiLNys4Kpn34wRwiNNOgZQa/ZxceOEdZY45PKws33rPcXDxas5lGVomNPGDlOrZik1q
         TPThh0J5pPN5aGODQAb1cNYSjtNbuzxnIBAeJQQMkkmN9YMJoVHtHDP5ImG8ti1JYSfI
         P2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707507301; x=1708112101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WhJmfcnLRTEDlLUHZR6JUXW1OL1TBjJb/6H71AI6gtc=;
        b=sa47cs/DmJ43fTBIZybCAUz2uuLcyYlQDhgnO5vMWsmAukODlV90KCD6EoqDEQTtwR
         bp9N1esTZuT37gkrOf8ck1nrqwikG82YwVyIxr1pXAmB94XIZDO4ZM6u9Jifu6bsTezP
         ZktlJjC2duAQpKmJW4BYoN3edC2fh0LJ6zxfZPiQGveJd3L3rZXKrQWuSAQz83JVpdpt
         pp0js2vwSuPjUbcsPLktNt1QgW7BtwvMA/Bf1fESgZ0w5+slU0sxrMRObUUaQ4KJIxqg
         XEqF/ZS1UgpghEUrC/+T64h4ZRnartJI1/X7IQg5oXpfvYon+waNiuj1MUly/vR+siJD
         6PYQ==
X-Gm-Message-State: AOJu0YxfR3Z73gijSUN8YljCAJW+P6pwhli41pYdNmsZoyrh9b41IVOL
	Nd6Qu9oejjYec5k2CoAv5R5r8By/z8DxxER+IjikOS6J33weQdnox1p3kY2lLy0=
X-Google-Smtp-Source: AGHT+IFBUXQIj/WaKpvlBTWXSLI8f4vUKyMUFEGegn0Dctn/ln9dACvLj0Cgmt0hAH6hXNAIFDDCwA==
X-Received: by 2002:a05:6e02:1a05:b0:363:c63a:7960 with SMTP id s5-20020a056e021a0500b00363c63a7960mr283790ild.3.1707507301655;
        Fri, 09 Feb 2024 11:35:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXtTsF02s03+zkDebinXKv/o8NjM02l181rtId3SxPGojjxw2QBiucIvMy7EQMwEe+PvnITVpKxG1wSUkdCO9Asvd/Vf6X3lVdIMdOrklj54ewbH5d9vHhY/O5ZPEAQBKx3nGg7bNJV4xsOf98io0XC/2FVJGadkY7qDZfdiSIvyQNPfo5dqJds49l+dBgn/oRH7IuhZAoaXAzwxYFdUEEQqI6nqzQvE9Lz/7nTZaW8cMO6B4DZREM5bjTKDsBkqJJB
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y2-20020a056e02128200b00363d4d565d3sm263805ilq.69.2024.02.09.11.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 11:35:01 -0800 (PST)
Message-ID: <74b10d9d-b030-4fac-a01d-ff4057d1e319@kernel.dk>
Date: Fri, 9 Feb 2024 12:34:59 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fs, USB gadget: Remove libaio I/O cancellation support
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Avi Kivity <avi@scylladb.com>, Sandeep Dhavale <dhavale@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20240209193026.2289430-1-bvanassche@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240209193026.2289430-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/9/24 12:30 PM, Bart Van Assche wrote:
> Originally io_cancel() only supported cancelling USB reads and writes.
> If I/O was cancelled successfully, information about the cancelled I/O
> operation was copied to the data structure the io_cancel() 'result'
> argument points at. Commit 63b05203af57 ("[PATCH] AIO: retry
> infrastructure fixes and enhancements") changed the io_cancel() behavior
> from reporting status information via the 'result' argument into
> reporting status information on the completion ring. Commit 41003a7bcfed
> ("aio: remove retry-based AIO") accidentally changed the behavior into
> not reporting a completion event on the completion ring for cancelled
> requests. This is a bug because successful cancellation leads to an iocb
> leak in user space. Since this bug was introduced more than ten years
> ago and since nobody has complained since then, remove support for I/O
> cancellation. Keep support for cancellation of IOCB_CMD_POLL requests.

This is hilarious! But also great news, as we can just kill it with
fire. For the patch:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


