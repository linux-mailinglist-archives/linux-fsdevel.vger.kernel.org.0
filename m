Return-Path: <linux-fsdevel+bounces-69214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD1DC73176
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 10:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 04B872FC12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 09:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1F6302CC9;
	Thu, 20 Nov 2025 09:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5C3KmUZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55352DE6EF;
	Thu, 20 Nov 2025 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763630448; cv=none; b=eCgngzO+wbqfULZP7CHGzrb9Uv+m4j8KNEdUDzvOdbdXIDY25Vlt2VuNZaMDNN208Z7RJLqVKKZ/KzoyO5b4zNOk5AvMMwHt869hXTPKgd/ISFIFnheV2aM1id/5s0jWybOZuZX2W5R8Q/zx51f36lwYMRaQqsFozhO1D7r9+9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763630448; c=relaxed/simple;
	bh=yz6BSooJtJ3bZJrufTJyKFke5JjVJzklkiFp+AbB178=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a77LSYJtdf0zYIgoMYCwKYiA63tFVeIurYgtzHuI5yd7zDJ2020mFNujYEWK2p/A97DHxwDPB9zH4w5We9uSzay+x4uBZi1ufDBqIM70zJZW1CvYMFPY7eNV5Vb/g3UjtkQHni9NNHGVod6E8o+o1qzaleqgtuC9WoJQIHqKGcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5C3KmUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8231AC4CEF1;
	Thu, 20 Nov 2025 09:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763630448;
	bh=yz6BSooJtJ3bZJrufTJyKFke5JjVJzklkiFp+AbB178=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A5C3KmUZfkpWslBQLW4BDvGrTpFmFmj/djXS3U+y5Bwrb9i7UEHNxpcyANvo+KlU2
	 KjBMLkSiPDTfvzuGsqHUX0yV9H42wyR6HuuIgC/ziI6MLxIXyNk+NVy08lR3ezxAZ1
	 ht417KItqUmrdzZuozECQUeGw2AdRNgihsNRIMFQ25C3EWhw5QKRbrG3l2PoQeatFq
	 A8F1lOiIs7wFiv0k2TvGObBO3NEpmJkHalRemBG2osAwt84p2uoVJGvHvPfxDSKoQ5
	 RqVocKXd2RJ+GkuARkNclM62jazaGr/gs+5e077hvBSxxrQ0GULlkcjU6Uq7DCpgQK
	 JUVs/Wz3fkL4w==
Message-ID: <7430fd6f-ead2-4ff8-8329-0c0875a39611@kernel.org>
Date: Thu, 20 Nov 2025 10:20:41 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 39/44] mm: use min() instead of min_t()
To: david.laight.linux@gmail.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Christoph Lameter
 <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Mike Rapoport <rppt@kernel.org>, Tejun Heo <tj@kernel.org>,
 Yuanchu Xie <yuanchu@google.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
 <20251119224140.8616-40-david.laight.linux@gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251119224140.8616-40-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/25 23:41, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
> Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long'
> and so cannot discard significant bits.

I thought using min() was frowned upon and we were supposed to use 
min_t() instead to make it clear which type we want to use.

Do I misremember or have things changed?

Wasn't there a checkpatch warning that states exactly that?

-- 
Cheers

David

