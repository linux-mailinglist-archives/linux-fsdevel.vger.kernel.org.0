Return-Path: <linux-fsdevel+bounces-71667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E025DCCC3FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 15:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86D9D3009F27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 14:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02D8285CB9;
	Thu, 18 Dec 2025 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="UPOMHvyJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEAE257852;
	Thu, 18 Dec 2025 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766067729; cv=none; b=fjJiDOrFjlqIKOMVYK47/Vyi2evGBqo8anQ961MCn/gPpPMVBWNktNhHEoKgN6EyRTlJ4jUU8bQVVCgnIWUrOxqAPqzMxRrZJoCeKdEvAX9S/+Qq54kvLPjuY23cWHiQQuVufWrlh5Wjms2gEXDIus15hzACdLebh3FgjseoHH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766067729; c=relaxed/simple;
	bh=/nh/yMoEzB3ZoZPaje/c2xtCyPzMqldjTm8yiAfq0mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBT4OEflsLSj0Bu9BEqz8IBWqyIOLrNsHcHe6zLGB/8Qmkn6+h6pRqbQ2JzZ8XYbT3GHQCrmSt0og/bniFUrhR+iQMcntlUMc2tmLIkE0LzxWOGergFqF6A2DgLCgx81+y/PxajCI6LTv4/d1q0X9U6e35Y3lCU6ad7o7ZmmVjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=UPOMHvyJ; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id A8AA514C2D6;
	Thu, 18 Dec 2025 15:22:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1766067723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kjzX04s5ES239u2ZRb9JKfFexa4mrIRPj9QCx2jfXAk=;
	b=UPOMHvyJjLmalszlmOccjY31YS65de3//YxYjZ3M5bP1pE4wdocXyxcOiwAMHUjMXGXoUF
	3nDwdaVCByxuR6hbZdy+f5FoLwaa/5Ng/Pb9RJyN9vs04hnLVxKodCspEOVrOLRjqhdz3e
	i2QTWfvGl/MOh3Fn9HwqSmm9wTDI62Gp6OhjPc0R1fym8wNn8lOgy5IH/UzAnIxSF1Y+fJ
	BXA6foxUFKDuIEZyyiYSrz7mfL2qnrRGwfGYyQHj3NtbAoo5N0ACHd77O/X2BKpq6W4odl
	sx5gsIVeHtUOiLCyUZeDOYjQFEVdSWo6I9hMFzzuNdblJvAcVuhhU+ybzr8CHg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 6986aa46;
	Thu, 18 Dec 2025 14:21:58 +0000 (UTC)
Date: Thu, 18 Dec 2025 23:21:43 +0900
From: asmadeus@codewreck.org
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Chris Arges <carges@cloudflare.com>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] 9p/virtio: restrict page pinning to user_backed_iter()
 iovec
Message-ID: <aUQN96w9qi9FAxag@codewreck.org>
References: <20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org>
 <2332946.iZASKD2KPV@weasel>
 <aUMlUDBnBs8Bdqg0@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aUMlUDBnBs8Bdqg0@codewreck.org>

asmadeus@codewreck.org wrote on Thu, Dec 18, 2025 at 06:49:04AM +0900:
> Christian Schoenebeck wrote on Wed, Dec 17, 2025 at 02:41:31PM +0100:
>> Something's seriously messed up with 9p cache right now. With today's git 
>> master I do get data corruption in any 9p cache mode, including cache=mmap, 
>> only cache=none behaves clean.
> 
> Ugh...

I've updated from v6.18-rc2 + 9p pull requests to master and I can't
reproduce any obvious corruption, booting an alpine rootfs over 9p and
building a kernel inside (tried cache=loose and mmap)

Won't be the first time I can't reproduce, but what kind of workload are
you testing?
Anything that might help me try to reproduce (like VM cpu count/memory)
will be appreciated, corruptions are Bad...

Thanks,
-- 
Dominique

