Return-Path: <linux-fsdevel+bounces-77552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A4aNLCLlWlVSQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 10:51:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A53E154E3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 10:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 011A53032063
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 09:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C57633D6CB;
	Wed, 18 Feb 2026 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuBI3I2e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCBC26B777
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408271; cv=none; b=epa3U8gwMy/tWtqO9ur2bORJi70WDbYv7y39hvpl0KEtJj5oSvyLmfSy4x9roFP4n1fwIFAG0yTeX2MO7VLKMNr0zoUvq5cJ5+0KwLLkFlpQI+g4tbwmQo+DmP2gP3b4Xw0GSDrgFGLlKtV1gjw58aROEssv4q0wePw/oh6h57c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408271; c=relaxed/simple;
	bh=g1w4U29qX516haKnTEyNMj9TGUIXllZWdQYWsWv3Feg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UF89GXVDhVcoTB7nLVcWp4h3zQCv8+N2p5YLDHpOJcvJ5qVy0s/xeOyRY50oudJevZZ3Bwx8cNfPG3A59NhtkVGsTWmzprR3/55YCGtSRb5X6gXaLVRXgcQqnKdqfB/KVrBvH24gGJfkgfIn7W9+gmS2m0MstvW/CTwpspZB1mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuBI3I2e; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43945763558so2216867f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 01:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771408269; x=1772013069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y8lR8H/ikLQCKvg0wb0yyJzqPf6aKANWd0UJElQxO3w=;
        b=EuBI3I2eaYrI8MdSvBxUOgBhXoVW6maYywAylZFJZjpn0klV3onkQURwoG5ZEII0/V
         xmfBzSdo+yBavsSxQFqOWkjSxUqvMeJZy3dRAxG1bWlmCxsk1ru3o2SY3eZt0mzBs9S4
         CDMB+yu+XeaMB6qdOUiFmPLQdWxlrGxkHOj4nV1Mb7ly8Q2JycOCCzlX0IjbXzD4E0Qi
         PuH2hJCNRaYHvXDmBRlruSarf9sBS7ybg0DcLQtHGgBB/TdU3rd2kJEcLXSnw6Ap9hiG
         0f3RVOm7VjbZuJmVfwRtc8SZkVDTZ8mZKveLyZZKtr8rB48fC0yeZuXcnx+/Qw2YNzV0
         W28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771408269; x=1772013069;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8lR8H/ikLQCKvg0wb0yyJzqPf6aKANWd0UJElQxO3w=;
        b=BViKZS3WJlWauWN+Ig+EPSaSrb1Aj2EdVYhUB4MdVMSs00r4yWu+8uW2cVGzS5xm7C
         581lYTdpBCHo+qm4n90Nz5mazUQzgRiiInOiCiQATMRgD1OnkHN+z2mSck9wNgOliple
         +uvKjztFT1nk565vOHxagdsoVpWQAGh+ExCLBSV0JcFNNFtnKe2BYOiM55oWKatRvCA3
         vzlajW48rgXm4yUKgbmgFg5l/NV1ovINKhBlMwVs1X0Z7uLAAo45RUj6a9GrB/Y9joHY
         e3nOZi6rbWy1diwJ474jUlBUyvgafTld3DBjBxEJRqKFZdxgUjBiLJMGaIulzf475Rng
         J5Og==
X-Forwarded-Encrypted: i=1; AJvYcCWjiqITS2+zysIY5VvwZLhBBEKhFs+LK4ABAzQRzYr532uDwnyfiJ3qoHUp0iQZaVsw4agIsmrW2gJO4Ncj@vger.kernel.org
X-Gm-Message-State: AOJu0YzV0t2lmixzaL4bm7e/0kE+H0jPwl3zBwb9i5cFIzoZzry1LWep
	giATEAZykYModj5hYnedlmf3l+1nSKwfX13uz1Tt89kQLrWbeCjKfB85
X-Gm-Gg: AZuq6aKv6i0FsMtF1BvKHhqoISrdOG7NNxExui4i/7t6Y41jhnAdvUhI+Y2DhC4ZGwp
	fZrb4sEXaf79gtT8KNyn8narkSDElMsDSPUb7/r39YMIIvRHUUeKlAnvmcGEdnvVAIP89DwrAwg
	1mMjH7HaPHDsU956GKnDGtSS/5jagIdGjqWWbJ5/N58OWTGOLZK44FDMi+JH8EC28B0YZU8CGHy
	pJCpoq335REF/abTGze4Pl0FamJwffCtMpCjN0a3YsSQ62xenBQhZMCWf77Pu1N+mrJTCJ7guoY
	jvMgSSeY4MH1YazoouV90TeeArZrNXyXh7Jfm71WLX8GJSGBll7MRyttpjDGGnafPl5XWUwSW0k
	NktEJmDOpB97az9kIU8euqh2kXCfw4LXJVgnKLRlErvbe0g7QgdLMtI+B57zKl6Lxr7+Vumm0v4
	SfWZMkBwjkEHXFEN2fabU1JNJGjI0NifdGxwAcvzSRMqa9KK0e04E4lR0KKIgQHSo9gdt7Mjnb2
	ognaMhSmG+Y47HUVA6YLA43L6IiLwQ9PXIeSwL7dcgiQKLhTu0A98MJCV0=
X-Received: by 2002:a05:6000:1787:b0:435:a594:33dd with SMTP id ffacd0b85a97d-43796afa19fmr36332754f8f.46.1771408268717;
        Wed, 18 Feb 2026 01:51:08 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:aef7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac8d46sm41550552f8f.32.2026.02.18.01.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 01:51:08 -0800 (PST)
Message-ID: <b19e0496-6d3b-4e2b-8853-07848768a553@gmail.com>
Date: Wed, 18 Feb 2026 09:51:07 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH v1 03/11] io_uring/kbuf: add support for kernel-managed
 buffer rings
To: Christoph Hellwig <hch@infradead.org>,
 Joanne Koong <joannelkoong@gmail.com>
Cc: axboe@kernel.dk, io-uring@vger.kernel.org, csander@purestorage.com,
 krisman@suse.de, bernd@bsbernd.com, linux-fsdevel@vger.kernel.org
References: <20260210002852.1394504-4-joannelkoong@gmail.com>
 <89c75fc1-2def-4681-a790-78b12b45478a@gmail.com>
 <CAJnrk1ZZyYmwtzcHAnv2x8rt=ZVsz7CXCVV6jtgMMDZytyxp3A@mail.gmail.com>
 <1c657f67-0862-4e13-9c71-7217aeecef61@gmail.com>
 <CAJnrk1YXmxqUnT561-J7seaicxFRJTyJ=F3_MX1rmtAROC6Ybg@mail.gmail.com>
 <aY2mdLkqPM0KfPMC@infradead.org>
 <809cd04b-007b-46c6-9418-161e757e0e80@gmail.com>
 <CAJnrk1Y6YSw6Rkdh==RfL==n4qEYrrTcdbbS32sBn12jaCoeXg@mail.gmail.com>
 <aY7ScyJOp4zqKJO7@infradead.org>
 <CAJnrk1ZnfdY9j1V8ijWx29jaLcuRH46jpNqR1x5E-Zqfz7MXVg@mail.gmail.com>
 <aZP-6FbNU5oGjrLR@infradead.org>
Content-Language: en-US
In-Reply-To: <aZP-6FbNU5oGjrLR@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77552-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A53E154E3C
X-Rspamd-Action: no action

On 2/17/26 05:38, Christoph Hellwig wrote:
> On Fri, Feb 13, 2026 at 11:14:03AM -0800, Joanne Koong wrote:
>> I think we have the exact same use case, except your buffers need to
>> be read-only. I think your use case benefits from the same memory wins
>> we'll get with incremental buffer consumption, which is the primary
>> reason fuse is using a bufring instead of fixed buffers.
> 
> Yeah.

Provided buffer rings are not useful for storage read/write requests
because they bind to a buffer right away, that's in contrast to some
recv request, where io_uring will first poll the socket to confirm
the data is there, and only then take a buffer from the buffer ring
and copy into it. With storage rw it makes more sense to specify
the buffer directly gain control over where exactly data lands
IOW, instead of the usual "read data into a given pointer" request
semantics like what read(2) gives you, buffer rings are rather
"read data somewhere and return a pointer to where you placed it".

Another problem is that someone needs to return buffers back into
the buffer ring, and it's a kernel private ring. For this patchset
it's assumed the fuse driver is going to be doing that, but there
is no one for normal rw requests.

>> I think you can and it'll be very easy to do so. All that would be
>> needed is to pass in a read-only flag from the userspace side when it
>> registers the bufring, and then when userspace makes the mmap call to
>> the bufring, the kernel checks if that read-only flag is set on the
>> bufring and if so returns a read-only mapping.
> 
> Yes, tat's what I though.  But Pavel seems to disagree?

Yes. You only need buffers, and it'll be better to base on sth that
gives you buffers/memory without extra semantics, i.e.
IORING_MEM_REGION. Or it can be a standalone registered buffer
extension, likely reusing regions internally. That might even yield
a finer API.

-- 
Pavel Begunkov


