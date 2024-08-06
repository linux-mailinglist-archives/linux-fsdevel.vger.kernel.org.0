Return-Path: <linux-fsdevel+bounces-25083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07350948C19
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 11:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861C91F24852
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 09:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942EA1BDA96;
	Tue,  6 Aug 2024 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="nAEJxCgS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=jonathancarter.org header.i=@jonathancarter.org header.b="np9OO1uz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCB51BDA80
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722936084; cv=none; b=kVI2uy1qiZE8Hcq12fOYQW6KBJ7YzuaSOYwZnmyreLarr8iqPQO7GHWlJpsD378kkmyxSkacHoqGWbZSCXn2/R75Ahr+GpEXkO/tQojZ8dg7O8ph0S+3OuvbVUkRma8wgknRIeFKgcLgqapEQQ8A9lF0mu8YOaqbKZV8WJmbrMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722936084; c=relaxed/simple;
	bh=OemcXKUlOGKfrxGp4tbmxuBJNATBLaVCy5GhnZBCjdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sDqrGxOb9eMOPnENGsI5A+v5oBHyoyFPpFk6Y/sShkydS68ADotZlnGdxaix1Uqo+L//IOmz96fy6mNeOZGl3Ws0aEKX5zjbElHbbT/WBFaV1GKJ0eVe+AP+I94CTrtusMjSGjMTwg9cWMw9qRXTxd0zg1JmzcbjqGnO4ZyMbhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=nAEJxCgS; dkim=fail (0-bit key) header.d=jonathancarter.org header.i=@jonathancarter.org header.b=np9OO1uz reason="key not found in DNS"; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Reply-To:Content-ID:Content-Description;
	bh=wF6RYCsrwOK5HCey7P4XZb8UnGF/ZMcoMjrBmDUa5pE=; b=nAEJxCgSXMv26Ij1mWvF4/iodo
	wSAsEgdq65SJ7Ml/Da9iGdLlXdCAqK+2L+QZJXHSRV5MgwN9iRWt2JLF0nme4yLqE8v+/4uWYlOPd
	I9q3FaIWcIiRSq5QGhzSzBeS66iFry23J2yCQxRnQ4ads7/VHxYO9PtVItgosG8KAho+OK6ZZtlS6
	FG4fGyo7xpkx08NPwMR7Cz+DLasqBawE3fOOP31vJ4PMdYqv32zzKeQL676DDfesTD4bXza/EUU6T
	qnSNG5MBiw3dDavxen3ZA72n67ldJpA1QmfcZbHH/A9NvbrfDJ34LTjlOIbg+GTJhXspo6eAjA8KK
	DPt5s5Cw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <jcc@debian.org>)
	id 1sbGNY-000NOk-Iq
	for linux-fsdevel@vger.kernel.org; Tue, 06 Aug 2024 09:21:16 +0000
Received: from mail.jonathancarter.org (localhost [127.0.0.1])
	by mail.jonathancarter.org (Postfix) with ESMTP id 4WdSV24wzQz2XLC
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 09:21:14 +0000 (UTC)
Authentication-Results: mail.jonathancarter.org (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=jonathancarter.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	jonathancarter.org; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:content-language:references:to
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1722936073; x=1725528074; bh=OemcXKUlOGKfrxGp4tbmxuBJNATBLaVCy5G
	hnZBCjdQ=; b=np9OO1uzuZKP6dRhJCp8DOugaz+onlh+FsHW1s30X10vl3QTY69
	mPboubv6V4DX3rwy1hdF6LKomtSISxCGfMz+M/nXR19ige/NFUfY+SZCOcOF8aQ3
	cNXFbOhHsD4hN12yE8X+6GxDBIhNVy62XE8PApB/nYR3pJArSoRfi/ff8kXRle3Y
	efmM4FlTrUqLCAbj+bKNxjSQf4JUhmuQ9Aan/CMHXpr3vF0nS+FmIFtby9kbW3gp
	8M42E8c2+bJ+gMMwjwxb86v8NQXPaCk+KriYe4RFCq0r0Vu0JXD6C+7klOHwRdAJ
	aqrHJoAGBdmcbX/G0yDT/7f/NbhQA8TT89g==
X-Virus-Scanned: Debian amavis at 
Received: from mail.jonathancarter.org ([127.0.0.1])
 by mail.jonathancarter.org (mail.jonathancarter.org [127.0.0.1]) (amavis, port 10026)
 with ESMTP id ZdIEYi0sKxqG for <linux-fsdevel@vger.kernel.org>;
 Tue,  6 Aug 2024 09:21:13 +0000 (UTC)
Received: from [10.8.0.6] (unknown [45.222.31.113])
	by mail.jonathancarter.org (Postfix) with ESMTPSA id 4WdSTy3JLJz2XL5;
	Tue,  6 Aug 2024 09:21:09 +0000 (UTC)
Message-ID: <21872462-7c7c-4320-9c46-7b34195b92de@debian.org>
Date: Tue, 6 Aug 2024 17:21:04 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: bcachefs mount issue
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcache@vger.kernel.org,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 Viacheslav Dubeyko <slava@dubeyko.com>, slava@dubeiko.com
References: <0D2287C8-F086-43B1-85FA-B672BFF908F5@dubeyko.com>
 <6l34ceq4gzigfv7dzrs7t4eo3tops7e5ryasdzv4fo5steponz@d5uqypjctrem>
Content-Language: en-US
From: Jonathan Carter <jcc@debian.org>
Autocrypt: addr=jcc@debian.org; keydata=
 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
 TkkZgS7faBgWCfXaSieOUCHVPkCPtYzWZCTb
Organization: Debian
In-Reply-To: <6l34ceq4gzigfv7dzrs7t4eo3tops7e5ryasdzv4fo5steponz@d5uqypjctrem>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Debian-User: jcc

Hi Kent

On 2024/08/06 09:50, Kent Overstreet wrote:
> Debian hasn't been getting tools updates, you can't get anything modern
> because of, I believe, a libsodium transition (?), and modern 1.9.x
> versions aren't getting pushed out either.
> 
> I'll have to refer you to them - Jonathan, what's going on?

1.9.1 is in unstable. 1.9.4 would be good to go if it wasn't for a build 
failure I haven't had time to figure out, although I e-mailed you about 
it on the 26th (Message-ID: 
<2250a9ef-39e0-4afc-8d0d-2d26fbddbdaa@debian.org>) but haven't received 
any reply yet.

Since the 26th I've also been at DebCamp/DebConf the last two weeks in 
Korea, with way too many other things going on, but when I'm back home 
after my travels I can also ask the Debian Rust team for some assistance 
if you don't beat them to it.

-Jonathan

