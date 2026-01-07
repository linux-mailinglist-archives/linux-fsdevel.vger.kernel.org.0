Return-Path: <linux-fsdevel+bounces-72628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE397CFE5DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 15:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2CCD3300A3EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 14:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D20C3446AB;
	Wed,  7 Jan 2026 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlJGPpB4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88184344026;
	Wed,  7 Jan 2026 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796601; cv=none; b=Iv34qh1+WtUTQWz/pzGJ/3bz0jiY8xO9CjlH3JlBoqv8YgZ+NBwSah6gvb4iUge2QXLgR8l2W1I9EaTdKzEx4MSyUPZtiit0XqO4l3wDOUKK7GUFbeSh9uS2OSTr7YynebDFNlKDOV8f6/aUmZxKdTzp4j/Iq3fp7qnkjOjzx2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796601; c=relaxed/simple;
	bh=U3GkqvVUqLIjI1hj3CxuNpDqnrKa0rqNuNhg+EEUs0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HaZW8PAiMA6ns5uvvgeCyuVw8TVgEogBbNynqwFCbFCkCryPTR5c0vYi7O+fhBj4TYxQu2ytv3eIA1m+Y7yA0KCliBNXUA9U/uc4gqn09NV2SbDSqZQlpxcrVnfaUFIQFz9ZzPvVkxIlIwnuPL8LAkjafe8mKIAhEu7hu25efO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlJGPpB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92915C4CEF1;
	Wed,  7 Jan 2026 14:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767796601;
	bh=U3GkqvVUqLIjI1hj3CxuNpDqnrKa0rqNuNhg+EEUs0E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LlJGPpB4PeH97qZ76RytczaHbzZVpk+PYs5EIz8e0zN5N2FTXhH86qT9774UnsbnR
	 VAP3bVJDIQLBfY9/VYuRZ9qNIEzSGGC5QtIjKaxt53YYk/63RiMGwPQ6r8h7JYqQ23
	 hr9f7DrCvnbmteJ8BtvaG1azrrhk+IKWIAB80EvgDcLqGpnsk6WBjUUev4+kjwn5XN
	 fnBkcaHN7760UuFlSFnrwceAYAHJh+EZ5rM8CTy3f2E+6En4gX6VIKua0HkCkzstwG
	 Ghz+OqC/7NijeuY1xDj89O0nbr1g/kT73bTBACxJ3mql0F/yq+I7guzjVpaob375cX
	 IrhTr/2EB+XuQ==
Message-ID: <cb269767-688d-46f1-8d82-1fd6dc32e94d@kernel.org>
Date: Wed, 7 Jan 2026 09:36:39 -0500
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
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <20260107075501.GA19005@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/26 2:55 AM, Christoph Hellwig wrote:
> On Fri, Dec 19, 2025 at 09:11:04AM -0500, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> On NFS servers with fast network links but slow storage, clients can
>> generate WRITE requests faster than the server can flush payloads to
>> durable storage. This can push the server into memory exhaustion as
>> dirty pages accumulate across hundreds of concurrent NFSD threads.
>>
>> The existing dirty page throttling (balance_dirty_pages()) uses
>> per-task accounting with default ratelimits that allow each thread
>> to dirty ~32 pages before throttling occurs. With many NFSD threads,
>> this allows significant dirty page accumulation before any
>> throttling kicks in.
> 
> What makes NFSD so special here vs say a userspace process with a bunch
> of threads?  Also what is the actual problem we're trying to solve?

The problem, as I see it, is that the system is not providing enough
backpressure to slow down noisy clients, allowing them to overwhelm
the server's memory with UNSTABLE WRITE traffic.

This is the same issue, IMO, that Mike's direct I/O is attempting to
address. Our implementation of UNSTABLE WRITE is a denial-of-service
vector.


> I kinda hate having this stuff in NFSD when there's nothing specific
> about nfs serving here.
Don't worry too much about that, these patches are obviously not in any
kind of merge-able shape yet. We do need to understand the metabolism of
UNSTABLE WRITEs, in particular, to get a clear picture of what needs to
be controlled to make the server autonomously stable.


-- 
Chuck Lever

