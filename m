Return-Path: <linux-fsdevel+bounces-53221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940FEAEC5BD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Jun 2025 10:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF3A6E1BAD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Jun 2025 08:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69D5223710;
	Sat, 28 Jun 2025 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="WG8/E/v5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from vps01.wiesinger.com (vps01.wiesinger.com [46.36.37.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EBA221FD8;
	Sat, 28 Jun 2025 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.36.37.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751098091; cv=none; b=UTvE2L9INfuWKGgNM3GkuaeGgNcxJxSHuj4oRIyPYsvhVq8HOX4uxZjJj5hFu1KLj34DkrScyLSIQJ7yhZ819x+J6t9LUQF2tIZbAwN9/8iJZ4ZRgrPBNDLrxtJvl027A4Fmj6EetPJZhl3A8IWUaImGTwvVj/s1AS98rnwg+aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751098091; c=relaxed/simple;
	bh=q55JQTKEtkZNEFxfWSuufk4z52CToxwjOSJP8koqfog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rIJ+pcZlycY1R7KQ1r1qkw3fTbgBdgjWNh6Py5YIGEgggitsqHZseQcaNybWi8dEmxeUqnKDlmtB2IpLlQBBJh67tbDKswzmDjd3KHoxGqt9eFiTZ6Y6Dl7OwWfhABNOdc7w+mpxmW48xxGRqBjsBTAP3GbqzYN+OjaRW3RtYH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com; spf=pass smtp.mailfrom=wiesinger.com; dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b=WG8/E/v5; arc=none smtp.client-ip=46.36.37.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiesinger.com
Received: from wiesinger.com (wiesinger.com [84.112.177.114])
	by vps01.wiesinger.com (Postfix) with ESMTPS id 919E99F31F;
	Sat, 28 Jun 2025 10:06:48 +0200 (CEST)
Received: from [192.168.32.192] (bgld-ip-192.intern [192.168.32.192])
	(authenticated bits=0)
	by wiesinger.com (8.18.1/8.18.1) with ESMTPSA id 55S86kp7305086
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 28 Jun 2025 10:06:46 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com 55S86kp7305086
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
	s=default; t=1751098007;
	bh=WmV7WtQQ17wwtJyVDyq7EY/V9V+f8ZCDTRAQLmKN30A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WG8/E/v5H01SZWJ2IyJRGQtCsngIWgEqOFkIHzJDa4bNxsscfuS3fk9F/xXXW+puh
	 FA2E+Tb4YU0DNOA2tKkqmXj4TTb/ui7AoFFjc5cX6ZYDQwBxoFIxa8Ig2/wNWKoN1p
	 TTqtU7Rn4LoZUYAopg+xovIlwKni7zif/g3Y9vNkFjZxRVaDpmqGzCQaBiUqKr3N8S
	 S+ipWRXHvoCkg1bEq5MbHECtKVtqKBjin330MmXDHTVxV9PEc3Ot/2yBqmJHaw4xTy
	 uMr73PdNk1bi4X8ruicbwVEhSpQ/iURxvdvjPzcIHeDqtt/7xXiuKA53QIIj6PqcmK
	 i+s+bOH4yz7nAcPDo+9TQVdCyvOXMJF5qrxMA2FgBWv/2dlPQgArKTvKidN4KoQeHf
	 qLZLzIq8Co358xqfmj6pjWErZZ+ANRYWxHnW8ip4cbNJbENovryvHw/rAxEm1OFHV9
	 HlQW3MSjLTkM/DrQ3GY37mxCT7R5FD+Lm/cixWjuYFeP8YlsKujnX2qyrICHg0itae
	 xU6QT1lpugBOxgG8CjxP7bT4t2DL28DRpDMTDVuE94KUcoyH+rZl2L8w2/buQVaPDq
	 42+BGS70vsymM1ZcjSs8dUusr5SDdmJG0YKfpt3toL1zdX+gcKmttejqCHokGzeXix
	 5VPfaNkSlidXV6Bg9rViX5tM=
Message-ID: <e1c38d04-94bc-40ca-896a-ab883ec22867@wiesinger.com>
Date: Sat, 28 Jun 2025 10:06:46 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc4
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kerenl@vger.kernel.org
References: <ahdf2izzsmggnhlqlojsnqaedlfbhomrxrtwd2accir365aqtt@6q52cm56jmuf>
 <CAHk-=wi+k8E4kWR8c-nREP0+EA4D+=rz5j0Hdk3N6cWgfE03-Q@mail.gmail.com>
From: Gerhard Wiesinger <lists@wiesinger.com>
In-Reply-To: <CAHk-=wi+k8E4kWR8c-nREP0+EA4D+=rz5j0Hdk3N6cWgfE03-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.06.2025 05:21, Linus Torvalds wrote:
> On Thu, 26 Jun 2025 at 19:23, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>> per the maintainer thread discussion and precedent in xfs and btrfs
>> for repair code in RCs, journal_rewind is again included
> I have pulled this, but also as per that discussion, I think we'll be
> parting ways in the 6.17 merge window.
>
> You made it very clear that I can't even question any bug-fixes and I
> should just pull anything and everything.
>
> Honestly, at that point, I don't really feel comfortable being
> involved at all, and the only thing we both seemed to really
> fundamentally agree on in that discussion was "we're done".
>
Hello Linus,

Do you think the "hard rules" for "no features" in the "fixing merge 
window" also apply for modules in Linux kernel which are marked as 
experimental (as long no other code outside of the module itself is 
changed)?

I understand your points fully for non experimental code but maybe it is 
a solution is to have different rules for code marked as experimental 
code. Every user who uses experimental features should be aware that 
potential non stable code is used.

Maybe you can think of it.

Thnx.

Ciao,

Gerhard



