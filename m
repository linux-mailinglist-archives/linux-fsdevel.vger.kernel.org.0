Return-Path: <linux-fsdevel+bounces-77140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDAEC9Akj2lNKAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 14:19:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D663A136489
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 14:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 272FF304EE8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 13:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5AD2C3256;
	Fri, 13 Feb 2026 13:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gX4xVvcn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7689135E527
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770988739; cv=none; b=iM0eB/51Ch16/+pLjhV+GyquWenOi2sm4DlI1x4yjw1uMztxf3g9OsGHs/hzw1zzB8bal5MTjrqdnpZtcJbDf0oqDUMEBaNnXEueH8qtjoEmxEwKijNCRFE48P5+R/iA2Nw1UCyJFTjhq4t/2OeXYP5AGqU5UQ0WXkyUrHDk30c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770988739; c=relaxed/simple;
	bh=LJr2jgrgWo1iaGCszr5qVaw8VpFia2R1vnTqMdqOSxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmreV3LR+GuOR66BiNrDFkZse9443PBl3Yw1tKEVrEyvG20GFIxYIYh3Ch/4ZB1pjvMODX2H9HQiVLtzeSgnrdD9bEWBOxZSEpmQGcRgXB0C9yhpfAuWpW+0dG4ISi/PP0H95LXe3zRQfv26A+8hENHPtOUP1Bf2OzMU6A7USlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gX4xVvcn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48069a48629so8273105e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 05:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770988736; x=1771593536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EdbNZMookr9gU/wJbJhrJqdiKH6nPXeyzs59kSKGWX4=;
        b=gX4xVvcnGB06xk0dmaGgh2nLCN1YUSmZ23y0h1/7890OJgZH71VeuWgFNCraTsSFub
         /invN7GJlTjpd+qKBH8CDZT383LtXwgEXxtdhXK5yGOhosvIDTPxODJezouqI0ofG/Bp
         FzJ7H57R59Pizp2GnncCv6tP6bzGuSHPUgp40BZO1R8w7HwoNBsEAv1utRAfxK36PSUm
         l5/lxlGYTDlDTe04GevNK+1Tg5kOPpUuXoFErk0+km2UNUZCBVmCeg1yg0Ca+n+iE/zI
         x2qMD4/E5qPxFmcNpguAh0aTbWtAy/66VW0eY0cGFP397QkfF5vtUNuh447di2V+mhj/
         y+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770988736; x=1771593536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EdbNZMookr9gU/wJbJhrJqdiKH6nPXeyzs59kSKGWX4=;
        b=rC12j6z8uZy0w9Ol6anb23UWg+yZcsfqtrYmTPB46P0RqSaY3yBgcsrREh2xgFcgOy
         uAIVAKCqYmUTartvBVpS1WorYD8jheZiCN+b5xjUyAhJYThNoYM4AYdw/eiVbG66vEw/
         wN/cxb6YY1ojSexiPjnapu69qqngB4skaOv7Sp14vPdWRpbNv6P6cKrHvt8bWUX4x6tx
         F3ddjE4YdjiN5b7bySD1Wjj2hBcXt4yRhNMG73EUoIukSr53RhIRv5rBSCm9NlQYOVBl
         tMmruQwvotjE1gthPehMy0a8kPPA0mAgwDFV56XI3HwgCaJZU1UPojqfHdFpn0VoFdnj
         Tz4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5yAuP/MS4+Ii0jWjeS7J3hN68O69sdELb8tmN3J1yDRT12AbvaiaTGRAz4L+SRGUT3Ev3fiR0dhBvrKI8@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb5+EvELT7P3vxIGO4kf8Nu6VVJW8aGXouj6VazwNc27W+BR2U
	+mw9o9rx9vnxtAulgECtUwKvEzbyXHWfyPRDjNhW0dvLfup6qOd9wjNw
X-Gm-Gg: AZuq6aJOEZNmY6Cqd5N22IWBYXqBKXikDET+yEt/AJt4ZAQYuuR0LTQayYDmfjg7lFB
	uf/0/uJxa/2ma8YoTuj7amo6q7x+vL7VvUQ5LvCF8N5Sg9XXgvcoxDyW+aE+5dnNV+eZoHxeF4o
	66LD5nL2sMn9py2MYt0fBdGMSaXOGbu9dOErlzWb846zx2W50l/IXTUTaqCRXyxt+YHVptMEeR2
	HlyNW/8N/3yL25+2XMsab6VeeuDFdCv1lnoZg1SEdy9sie3tBVF5KG2sr/d7B4NNf8+lXI6YjOL
	rc3jtm/LXA5Jimck7YShfKY91pJtvTpB9FJMc6RBxiJSbhe2NlVOfaa0GQOBTbOsHjom04KTVQT
	AHDSx2P/YcNbbD5texecnUXZgCg7sETgA519fy3GnughjSK0duXLd2kjNPYW0hbgftAKICw+6vv
	+U6kCYHTmU4yxtCIuRFIkm+PfhOqxImiPPoLu/x1tUjnfMkK10mwzxQJB6gIYb/GkXc+8h3J3YQ
	b1shySorbjSz0uLsncNc75SMgySjUJrLrRGt7QqCU8rt+AE4bYKbx3aKQ==
X-Received: by 2002:a05:600c:450a:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-48373a4e82emr28804215e9.27.1770988735571;
        Fri, 13 Feb 2026 05:18:55 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:8b14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a10cacsm28759415e9.4.2026.02.13.05.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 05:18:54 -0800 (PST)
Message-ID: <df989700-fc4f-4334-a7c5-a6eeb136ab35@gmail.com>
Date: Fri, 13 Feb 2026 13:18:54 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/11] io_uring/kbuf: add support for kernel-managed
 buffer rings
To: Christoph Hellwig <hch@infradead.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, axboe@kernel.dk,
 io-uring@vger.kernel.org, csander@purestorage.com, krisman@suse.de,
 bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
References: <20260210002852.1394504-1-joannelkoong@gmail.com>
 <20260210002852.1394504-4-joannelkoong@gmail.com>
 <89c75fc1-2def-4681-a790-78b12b45478a@gmail.com>
 <CAJnrk1ZZyYmwtzcHAnv2x8rt=ZVsz7CXCVV6jtgMMDZytyxp3A@mail.gmail.com>
 <1c657f67-0862-4e13-9c71-7217aeecef61@gmail.com>
 <CAJnrk1YXmxqUnT561-J7seaicxFRJTyJ=F3_MX1rmtAROC6Ybg@mail.gmail.com>
 <aY2mdLkqPM0KfPMC@infradead.org>
 <809cd04b-007b-46c6-9418-161e757e0e80@gmail.com>
 <aY7RA8-65WE6Q9Fv@infradead.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aY7RA8-65WE6Q9Fv@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org,purestorage.com,suse.de,bsbernd.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77140-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D663A136489
X-Rspamd-Action: no action

On 2/13/26 07:21, Christoph Hellwig wrote:
> On Thu, Feb 12, 2026 at 10:52:29AM +0000, Pavel Begunkov wrote:
>>> I'm arguing exactly against this.  For my use case I need a setup
>>> where the kernel controls the allocation fully and guarantees user
>>> processes can only read the memory but never write to it.  I'd love
>>> to be able to piggy back than onto your work.
>>
>> IORING_REGISTER_MEM_REGION supports both types of allocations. It can
>> have a new registration flag for read-only, and then you either make
> 
> IORING_REGISTER_MEM_REGION seems to be all about cqs from both your
> commit message and the public documentation.  I'm confused.

Think of it as an area of memory for kernel-user communication. Used
for syscall parameters passing to avoid copy_from_user, but I added
it for a bunch of use cases. We'll hopefully get support at some
point for passing request arguments like struct iovec. BPF patches
use it for communication. I need to respin patches placing SQ/CQ onto
it (avoid some memory waste).

Tbh, I never meant it nor io_uring regions to be used for huge
payload buffers, but this series already uses regions for that.


>> the bounce avoidance optional or reject binding fuse to unsupported
>> setups during init. Any arguments against that? I need to go over
>> Joanne's reply, but I don't see any contradiction in principal with
>> your use case.
> 
> My use case is not about fuse, but good old block and file system
> I/O.

Then I'm confused. Take a look at the other reply, this series is
about buffer rings with kernel memory, it can't work without a kernel
component returning buffers into the ring, and io_uring doesn't do
that. But maybe you're thinking about adding some more elaborate API.

IIUC, Joanne also wants to add support for fuse installing registered
buffers, which would allow zero-copy, but those got split out of
this series.

-- 
Pavel Begunkov


