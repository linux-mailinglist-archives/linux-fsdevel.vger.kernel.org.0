Return-Path: <linux-fsdevel+bounces-53752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A19DAF6708
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 02:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD60F17B75A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 00:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2692D14885D;
	Thu,  3 Jul 2025 00:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KP1x+ZS8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAEC2F43
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 00:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751504181; cv=none; b=te7QBdmlICptp+rhQYzJ77EETv09zy60CRnGIYz5dNXif8WczfDxOUAw5b8cBr+3DOVWRAdzCKJCcd0lwg0BCc/v+Lm9r9JgG4uN3XMpW7XIv4YCwCLIdLrESEoZowu1fk+UKC602YNc+eNLDgNAcpTNQrzOMkU4xtA3dVjlvsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751504181; c=relaxed/simple;
	bh=u5kuoGoXD/stLVrZyBmzV1dmZVmj1zSLvJ4RalGT6CY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CvghFsQHWupWPEa0sINEjk/ZGqsoFB+68KVN5I/6yPjZP/cObGhX9tqbS60Jk6JdvnW311AehY8iBD0H8IY2Ev/yf4nWv7FUR8P6N2rVswrSZMwZCWn/tJHhOEXiwhlOST4nJgvyL39A4eNmeuHetoHpIWgooOrmCLlIGPQmJVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KP1x+ZS8; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3df4bdadca5so17581455ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 17:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751504176; x=1752108976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gla6qP1t7YkfAtEHd9+jQ2W8xSnenoBZz1/ucOZWmds=;
        b=KP1x+ZS8LlfghX6j1WwF8VnMB72fqsZmv9UqTxj4pYH+qwTyb2EgV8xGHQsS21zbve
         zIpl67XrUKSAvAK6yPUKyBw6j64iIxDAy5kGL70q9YKGs1fERvfNd0hfXWlfnkVZ6oB/
         jeNxVzpDGJbVCfZ52CZRaWJ6IRdRwEtfOqEqO8AMLKcIYWTNPEQLAXRK4C8WlPgQdxV8
         npbq2RFi1yWJmnI6P2BW2+ZaycKUPkyqxL3ZFDRtbzSCfPShf6z+VNhbGfmZm8pwpUil
         t0IZTZQmS9TmpqGxZsRi6YwFy0fjvU1bmSdug/e3abKm0VOP8JCMY9RszjpKV/aNxptF
         Cx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751504176; x=1752108976;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gla6qP1t7YkfAtEHd9+jQ2W8xSnenoBZz1/ucOZWmds=;
        b=lU0+P+WgpliLDUA8Wk9mMi38YeWY1azsrBrQjJFJMuJTwiyNVDUhD4jHmrW0Z9tzaR
         GYPnKoy2ERBlsMVXQq/sOf+F1n9FAIqYABYQ46nVMw0lztlZhCT+GALRnapoPNCQ2YM5
         r0cmAOJcDTT8+UN7GT6uUvXwj4nH+mw85lhEPs+Zh0s1g+gp/C3LLYBhDQNg86Uz7Nmr
         mqExZSaGHNx5A1HB8TJK6VoVy5V/AcckPssu8G9e8MVYMB7BjePyorVT1eFYQmvzvNnY
         MUoAtUlw8/lhnMLhur4kIs6XfannHMGcK3dhC1FsHBwUmHZ48QbL8TRv2fkzX0DMXpBp
         eEBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9a2ibMVT5UDYR2FOAJdBqdv/2Boe2EC/pRFWp61X8X0h71PWujyozB+W9y2UdBz5auhzYUoB7eWZJ6F8X@vger.kernel.org
X-Gm-Message-State: AOJu0YzgMXGC6Vc8ztjeeN6uCs9xe7ZRUOiegqUVusmVQdEIl+ns58a7
	ig247WBHqo0IiCFrJQhSdbNdhGPePchxdECkcBZOFCpftJMfa13rzwUj7fDJhNK79Fk=
X-Gm-Gg: ASbGncs75VoDqIcuy+onj98vKZtwvEJPk9W1pSljVnYj+Rmkss8Y3PlFxBtRnoDn8R9
	Rz4ahWyeNaGMQsiQD6wb1PZTxfwh9rYKJp2NJt/a++EXxxFF2sNT+9MBRejhV3JVhhyIa9zmZZa
	GA10cR8yCpMovg3xI8YrHedyTNdtxQ79yp6wtI6RFTNnhYrwckJzNgSghVSGZ5rZRhGARCN3mNc
	/ZqNVkIm0g7ogJmJ5PjO8AS6fXnzKo3buRW3X0GQxj3RdCqMUhOjYAYA96N5KjGjYEGQ4+Zrsm+
	EVppgITnY67tJYJ5GlbAePc76DAC6YbAmVoRu/c6H8hgNQlnmqbgcO8YNH8=
X-Google-Smtp-Source: AGHT+IHVeyE4FS4TVhh7Og7XFxFfwxtZOPNp0ZpGWvvrw7Wd/PRX6REYiRhsuDEP240fqLJ9kNxiKg==
X-Received: by 2002:a05:6e02:1987:b0:3df:4046:93a9 with SMTP id e9e14a558f8ab-3e054923dc4mr62019995ab.5.1751504176280;
        Wed, 02 Jul 2025 17:56:16 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50204aae3ccsm3260651173.116.2025.07.02.17.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 17:56:15 -0700 (PDT)
Message-ID: <30afcf80-a49c-4c5a-9979-2f27142f7251@kernel.dk>
Date: Wed, 2 Jul 2025 18:56:14 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH 01/11] zynqmp: don't bother with
 debugfs_file_{get,put}() in proxied fops
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20250702211305.GE1880847@ZenIV> <20250702211408.GA3406663@ZenIV>
 <175149835231.467027.7368105747282893229.b4-ty@kernel.dk>
 <20250703002329.GF1880847@ZenIV>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250703002329.GF1880847@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/25 6:23 PM, Al Viro wrote:
> On Wed, Jul 02, 2025 at 05:19:12PM -0600, Jens Axboe wrote:
>>
>> On Wed, 02 Jul 2025 22:14:08 +0100, Al Viro wrote:
>>> When debugfs file has been created by debugfs_create_file_unsafe(),
>>> we do need the file_operations methods to use debugfs_file_{get,put}()
>>> to prevent concurrent removal; for files created by debugfs_create_file()
>>> that is done in the wrappers that call underlying methods, so there's
>>> no point whatsoever duplicating that in the underlying methods themselves.
>>>
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [10/11] blk-mq-debugfs: use debugfs_get_aux()
>>         commit: c25885fc939f29200cccb58ffdb920a91ec62647
> 
> Umm...  That sucker depends upon the previous commit - you'll
> need to cast debugfs_get_aux() result to void * without that...

Gah ok - wasn't cleear since I wasn't CC'ed on the series, just the
single patch. If it's a single patch, I'm assuming it's good to go
if it looks good.

I'll just drop it.

-- 
Jens Axboe


