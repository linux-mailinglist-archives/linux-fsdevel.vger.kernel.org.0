Return-Path: <linux-fsdevel+bounces-11181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664D6851DDF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 20:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932491C21763
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 19:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4D24654F;
	Mon, 12 Feb 2024 19:28:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A335845C18;
	Mon, 12 Feb 2024 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707766087; cv=none; b=AEc0/w1QsblWTslJ++Oy6YTS+uHZnDTMRwacyYcIoZe7dCAaXdp6CCGeL2OXXGiFPXt9OI+X4BiwnhgzZ5OTGRSFMsbo0NAsGBCEUS/BCuhRMtrawhpzWoqoyS49DGfdj/xg7FT+g1F6dEP03sMzaHpiFmUAnPIGjNfSNA1M7nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707766087; c=relaxed/simple;
	bh=oX3KI5dCCNi1lSCS7AZPVFpiNTbUOTFE6Qw6GTFVYfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cb1ApQ92DGjaektsQxXgt3+KZQePT8e1pdrKI1IuGzM0BsKwG0+Pr5mhkDPnvOkQFg3QFuAaAUwv17/XnDAsNQSyemmKaY3wNFsKKUqMuCab7BoyXdVCeiQfbFlAmTKRloDDsukpH6dIkyqOiVbUZS8j3s38DejiKCeieCZDjsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c03d6e5e56so773391b6e.1;
        Mon, 12 Feb 2024 11:28:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707766084; x=1708370884;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oX3KI5dCCNi1lSCS7AZPVFpiNTbUOTFE6Qw6GTFVYfg=;
        b=C957Dtt399uxFpCkOKTfHilhJ3F9cAWJ9ykhnsqpRLVuZx0mKhPcEpoQqGYc0S+Ea5
         un3OZNEfsnxq4yPQ5h/MGL+2l6ncUCmT/fm5AcdQBXJzk8FaWeJnz1n9d+xKHLW4qH/S
         p8ICBCtZ2ebGsVCN6yprsJLARxcRANyoIGX5bTi2H3qeXnz5/uK3OlWteZpThrILCZmd
         cjacHb9vHUTB+e/jUdmkyUGaJ4QZDBZYlec7/JleGMuSOrwF8seUHQxmDWvJClxkJnzH
         4O1kRk+iUiN4PCeKg5ZWevbJJhDUirIuT1LpZYtWHDcj05/PNMvgNKOC2mebeFi/yrVo
         ixvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFrSx6t9mc1+B7wg9wMKgWmNqv0OPtTVXOWzd0WQ5kccqW8PncMT0sFIlueZRXcBDBHicVBEBIjTxQlWKeVePjdurHpy1tDryajmtPmOBHdTlHH4NCBplSbQcOoXSIVzjcKxBdbQ==
X-Gm-Message-State: AOJu0Yz0zhsF3nURnY105opP4OA5wFMYK/EbzeefPwXSTl9uAjO5gEye
	ZJRsUPmqvS8x0KcAvHUiH0w44fPRuZxoPGngqMGr0DIL0OI3fDMl
X-Google-Smtp-Source: AGHT+IFMBXa2YD/yLM0Waohsogq5i8wTlUdjTol9bgBe6MJf+GTMNm+LdMm374K0IlJBpgnDgzkYFg==
X-Received: by 2002:a05:6358:999e:b0:179:1f8b:445a with SMTP id j30-20020a056358999e00b001791f8b445amr9498668rwb.22.1707766084516;
        Mon, 12 Feb 2024 11:28:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVL0aDYPOurhVg9Tka+0JLdWIiBkmMJJBL8zm6g1WGJkuzxB2I6DlVsZsVi3ZSzjybTeGj4Q1sSUpyooxcCQkl3fnf9hI7lpVVBsWk7JcUq0WEmxHzwT0IPZPvqEMojnH0CzlhSfbHzDrtVkGq5++fQesKpboNJ6CCJYOBfTh79czGAMzJ8J2nZ2ySQb8iPWhUxupasjkH0mhasf8CH6xEvddEJLR+noLjCtScJV/wE+K4qVpjs3Q8vWBmBFg==
Received: from ?IPV6:2620:0:1000:8411:dfc4:6edd:16dd:210a? ([2620:0:1000:8411:dfc4:6edd:16dd:210a])
        by smtp.gmail.com with ESMTPSA id w13-20020aa7858d000000b006e03b82016asm5905491pfn.33.2024.02.12.11.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 11:28:04 -0800 (PST)
Message-ID: <4e47c7d4-ece3-4b8e-a4df-80d212f673fb@acm.org>
Date: Mon, 12 Feb 2024 11:28:02 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs, USB gadget: Rework kiocb cancellation
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
 Sandeep Dhavale <dhavale@google.com>, stable@vger.kernel.org
References: <20240208215518.1361570-1-bvanassche@acm.org>
 <9e83c34a-63ab-47ea-9c06-14303dbbeaa9@kernel.dk>
 <20240209-katapultieren-lastkraftwagen-d28bbc0a92b2@brauner>
 <9a7294ef-6812-43bb-af50-a2b4659f2d15@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <9a7294ef-6812-43bb-af50-a2b4659f2d15@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/9/24 10:12, Jens Axboe wrote:
> Greg, can you elaborate on how useful cancel is for gadgets? Is it one
> of those things that was wired up "just because", or does it have
> actually useful cases?

I found two use cases in the Android Open Source Project and have submitted
CLs that request to remove the io_cancel() calls from that code. Although I
think I understand why these calls were added, the race conditions that
these io_cancel() calls try to address cannot be addressed completely by
calling io_cancel().

Bart.


