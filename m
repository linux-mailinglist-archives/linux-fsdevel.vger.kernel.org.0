Return-Path: <linux-fsdevel+bounces-72631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B204CFE784
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 16:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00F3F305EFAD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 15:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71F53559E9;
	Wed,  7 Jan 2026 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QisCsLOD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB503559DA;
	Wed,  7 Jan 2026 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767797397; cv=none; b=NzX7+QVfv7kG+ma4T0c5cJnvhe77sN3wNUWPymzOxGrFrBmWVzwIr7L/BmvcSaQeRv9SVeQM074a9iZS80l71vb4056fnvQ3geN2eT6j7lpdZOFCOId5ijSTM1oMmhwzu2r8aQVgwaWBH1Z5nobq/VDjO07aiql2aZ3Ql/1LPFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767797397; c=relaxed/simple;
	bh=j66lzEexSpPcC3oYyLMGHNA0REWDjVJjs19BKH4bbz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EyNV4xgGM7WnlxfBaZTP9svUlEK1P07UGynYHDB2IIQrgu5gF+LjyvKx+VSVxy3o2dYTX+lrJ5lb6MdAvcgLU2wIVOqq6B3P/NO0ejQk9gKP5HqJTJLNJXkATN6De39RyMw6/3x1w50nhgTA6+efZ+3RmXXHYv1jVn5ZxJn/Zs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QisCsLOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46865C4CEF1;
	Wed,  7 Jan 2026 14:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767797396;
	bh=j66lzEexSpPcC3oYyLMGHNA0REWDjVJjs19BKH4bbz0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QisCsLODlmD8mwR9w0lTKYfsJJEsJtkfdC8i0SRZi8A4FyOzSL1LJaOfX164++05k
	 eKxgdgbdRCvJYZu+jVHkK1beRfYXDyKmoRRCmYduZAl/SEUltttxQreUT7kXZPRUtQ
	 Hmh4bnwFxOAVp1fie2HBHnhtF2rEBb5ol40wlSQDNt4I1uI9/ZUTsDrrpk37QZOXaJ
	 zPl1B8lXa/X63dUXfxICcCkGwvR+AExXfQw1RHxHPmq7/QbfwOon7i2q8ZNAJAG7Sx
	 EMrSTTOs7nTbbMrrG3iQWoHDvmEV/IvVklV2PMEu/5vcnaN2M15RviZLWIjb2GqJj1
	 30lvLfERPC0HQ==
Message-ID: <02acb8f9-e60b-413c-a0d3-f1f8dda00ca3@kernel.org>
Date: Wed, 7 Jan 2026 09:49:55 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] NFSD: Add aggressive write throttling control
To: Christoph Hellwig <hch@lst.de>
Cc: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20251219141105.1247093-1-cel@kernel.org>
 <20251219141105.1247093-2-cel@kernel.org> <20260107075501.GA19005@lst.de>
 <cb269767-688d-46f1-8d82-1fd6dc32e94d@kernel.org>
 <20260107144243.GA15228@lst.de>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <20260107144243.GA15228@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/26 9:42 AM, Christoph Hellwig wrote:
> On Wed, Jan 07, 2026 at 09:36:39AM -0500, Chuck Lever wrote:
>>> What makes NFSD so special here vs say a userspace process with a bunch
>>> of threads?  Also what is the actual problem we're trying to solve?
>>
>> The problem, as I see it, is that the system is not providing enough
>> backpressure to slow down noisy clients, allowing them to overwhelm
>> the server's memory with UNSTABLE WRITE traffic.
>>
>> This is the same issue, IMO, that Mike's direct I/O is attempting to
>> address. Our implementation of UNSTABLE WRITE is a denial-of-service
>> vector.
> 
> But how is this different from Samba or a userspace NFS server?
Well it might not be different. But at this point I don't think we know
enough about the problem to say one way or another. I'm just trying to
gather more experimental evidence about what is happening.


-- 
Chuck Lever

