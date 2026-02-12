Return-Path: <linux-fsdevel+bounces-77012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAktI3mxjWmz5wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 11:54:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0774E12CBBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 11:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6584430E9E94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 10:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AF63218DD;
	Thu, 12 Feb 2026 10:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhfGAhM4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1807731E106
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 10:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770893553; cv=none; b=i8sb4leVJy74DTIlqXJMRa/1/CJgabJkHEHM1R7WWIgVwWufxxu3dir6UZKs5Z5siqrA9ci+GPPLqBx5SZjV6Lk8msWUBlfz5QQYQcdDXLFcDl7zG2JLXi4bxKifx50/7fJ1MhTwv/3H0h6GOiolbIhj4eKnrjEd4WQJxEt+bu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770893553; c=relaxed/simple;
	bh=vDmlrrh4BLYaRR2l3ElM2gSOc+TGgSPsvhONw2b2DjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HObdl5EXDWafm7Y3B+Nwzp1gg0GomsCKceF0oKffEojyb2SMvoqsHQBX1t+4pBxWK2DslD1nL7YXTXCLOhsf+sUEuNxQswfKe44JRCNqwzCHitlMxFcynim6JNX1MCMuUU+lxRfP3Y6ANXv+UXBxUxt3Z56dKg5kAWAGTJKrf58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhfGAhM4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso26211795e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 02:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770893549; x=1771498349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i7QK3EogTA2awwuFyYLWPGKb9u4Hhfpc0q+gDE6cl74=;
        b=fhfGAhM4OqwHWwaKNJtPn6hovTbFJlEicirI7hVY70vcZX6IAbyu9SOVTNKGxsW02g
         b9ZEO8fT6ljEDJ7+bb/vu1EGOGjIZWI3vJc0wTABTZ/wDp7tLtxVl1Ro9UU8MkLlNYfT
         r6FSzw032GNVVsS+J94iNH8iL5R9nvl2v8qVtRxvs3TlUyiwUapST6F6RYXIM5/7iFux
         MkNr8bhthdICvViw0fdunLrqu/FkVpAF+QVXRr8gGCynVqyrVJIJAkmnm3ifWYmKZ3jg
         dCerdnrM/7BOetdaRDh2Ur3Rmx7QsskMV0iwj1ZQsuKIQKKvBMaM8cpzZ3XKzp00U4Dx
         Q/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770893549; x=1771498349;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i7QK3EogTA2awwuFyYLWPGKb9u4Hhfpc0q+gDE6cl74=;
        b=j/iBedCLL9NeZNVLeq/7rLq0ypONGF2D01gvYS4h+aXr3371hz7CSeujXCvouBl9Yo
         M900DjgV5Y6kD1Wk7bKrxQXAB9nz8M+E6/Pvl/bDT7CKz1jLa/aAj7jKjGjtOYNyQ0Cw
         pnDRoEy5zUXMllYrDBLodPXQPo1pw9XcnLZ6WbiTKYGwqrB7W3YitutFmC2AHoNBcmUU
         vQ/ULPAvDKdB6jgj7QMDtVE+R5qpiIk7kxAvkvPrZeBDVa5zRtZdzVhym31ZShnl02rB
         gMIAdQcOw1ZH6RIT5ZbpiqIBv7Wm0oNIjiyOBfjdI6o/bkReVpraEhHSNE689/Mc0n1m
         VjNw==
X-Forwarded-Encrypted: i=1; AJvYcCVY6vaTZBQmNzdbEQmEeI5xtLXmcpvgEgJnWtROrfvxM2VjXMlCnvh9WGSa2nJaur4EZKWvf32AI/+x3+o/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0SPH19w0bIXIoGZKSJpqrWb9lJa7BRrpSSB8YoK/74Lmkbvys
	tn8vZP/BPsCBB6etE2IP6eQmPgu3g/GqrWzv5VyRf7pMPJ6SDXpPBE+wBOXEFuGY
X-Gm-Gg: AZuq6aIwJsdniKvRCSWE7CZzGLrSargR1eDlfioMMpDnWMzAr0uxFij3UlzFxi+no+R
	0T9xNNGXu047bBZ1GOQw3whVNt2WygwWt/2ArZBSCEc5h6kXMDs0GS2QibQ0en+7sTm3ms/EiX7
	H2x8pMRCWlOz8oeaFs4LzxY5UK+KKLkF8IR2QpIu6OPCexQt/knb+4BhPryOmcPiPhnTWStUbSk
	9sQpVc/Uvj+y5bIa6UbEse1xlGnA9yqXQ2E4IBp7UD9dhYpOgF3V5IO+Vs85Pb3LGULv4j9lmgE
	V6/ACauRQof9D4mpz+WYJdKypE9wjDtzWORcgxBY48Aq6uebhMD3UyW03yVZcl/7RAvNAg/6lld
	+LjcT/fKOrRSRBNJx6mC9ZLctpDIaKSsbHpwSTy67tZb7VSdON1CMBsB3DtJLnjxHrRTxUzZFtQ
	KnOCSDIi4fg0+RRpo8FmPya9y70Q74jIwfuzAUNICo3nhE2hujbuZ5sqXojr9Me3DK2/zSZOQtv
	RJf4jjJ4dO53nM9Nc8i+tUS97K1XmpmipvGOZW2G7SHtLmXFyx6laRrYGc3lbnWvHh7tIjiSDhr
	Ag==
X-Received: by 2002:a05:600d:486:10b0:483:6a8d:b2f9 with SMTP id 5b1f17b1804b1-4836a8db4f0mr14923255e9.5.1770893549133;
        Thu, 12 Feb 2026 02:52:29 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4836131d52bsm36821225e9.28.2026.02.12.02.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 02:52:28 -0800 (PST)
Message-ID: <809cd04b-007b-46c6-9418-161e757e0e80@gmail.com>
Date: Thu, 12 Feb 2026 10:52:29 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/11] io_uring/kbuf: add support for kernel-managed
 buffer rings
To: Christoph Hellwig <hch@infradead.org>,
 Joanne Koong <joannelkoong@gmail.com>
Cc: axboe@kernel.dk, io-uring@vger.kernel.org, csander@purestorage.com,
 krisman@suse.de, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
References: <20260210002852.1394504-1-joannelkoong@gmail.com>
 <20260210002852.1394504-4-joannelkoong@gmail.com>
 <89c75fc1-2def-4681-a790-78b12b45478a@gmail.com>
 <CAJnrk1ZZyYmwtzcHAnv2x8rt=ZVsz7CXCVV6jtgMMDZytyxp3A@mail.gmail.com>
 <1c657f67-0862-4e13-9c71-7217aeecef61@gmail.com>
 <CAJnrk1YXmxqUnT561-J7seaicxFRJTyJ=F3_MX1rmtAROC6Ybg@mail.gmail.com>
 <aY2mdLkqPM0KfPMC@infradead.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aY2mdLkqPM0KfPMC@infradead.org>
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
	TAGGED_FROM(0.00)[bounces-77012-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[infradead.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
X-Rspamd-Queue-Id: 0774E12CBBB
X-Rspamd-Action: no action

On 2/12/26 10:07, Christoph Hellwig wrote:
> On Wed, Feb 11, 2026 at 02:06:18PM -0800, Joanne Koong wrote:
>>> I don't think I follow. I'm saying that it might be interesting
>>> to separate rings from how and with what they're populated on the
>>> kernel API level, but the fuse kernel module can do the population
>>
>> Oh okay, from your first message I (and I think christoph too) thought
>> what you were saying is that the user should be responsible for
>> allocating the buffers with complete ownership over them, and then
>> just pass those allocated to the kernel to use. But what you're saying
>> is that just use a different way for getting the kernel to allocate
>> the buffers (eg through the IORING_REGISTER_MEM_REGION interface). Am
>> I reading this correctly?
> 
> I'm arguing exactly against this.  For my use case I need a setup
> where the kernel controls the allocation fully and guarantees user
> processes can only read the memory but never write to it.  I'd love
> to be able to piggy back than onto your work.

IORING_REGISTER_MEM_REGION supports both types of allocations. It can
have a new registration flag for read-only, and then you either make
the bounce avoidance optional or reject binding fuse to unsupported
setups during init. Any arguments against that? I need to go over
Joanne's reply, but I don't see any contradiction in principal with
your use case.

-- 
Pavel Begunkov


