Return-Path: <linux-fsdevel+bounces-64207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD25EBDCD12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 09:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF5A3A8419
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 07:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5408429BDBC;
	Wed, 15 Oct 2025 07:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foHpd7vV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAB720B7EE;
	Wed, 15 Oct 2025 07:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760511941; cv=none; b=uuJUDYpQFLimCqCV6As3QdI1cdVaIJ2zNdF1CHlEcp7/NXm3YN6oOuKaUAcF74YYR+LeRQ9Na6TZXW5jD0RsPeBE9Nlt9w6Ce8LLLoXK7ds86C1gHh+b4/phjHiaCoBez8u1qEUpJLugBkVXjoxmVLRw6C35ZAtPmUXa+J2UziQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760511941; c=relaxed/simple;
	bh=S4ISIxsDbh66QNuheYs7XjdrsB7o2PxzZSVLohh+obw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rDKbW1xX4jwLuI1OJW9T9I6c/RdoYUDeKjx/VhZU6qumXrWMHvaxQ4D0iq/ODCE2RfGtPGaOIxFjzW4nG0JIq8u7LRryOycZX9Er3KmqWGL5ZokmWdvzevpmoPz7xuEHycfAQAxbKLZHmLezvOgCF5slT5kswkUV5Ud/dbl9LCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foHpd7vV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0574C4CEF8;
	Wed, 15 Oct 2025 07:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760511941;
	bh=S4ISIxsDbh66QNuheYs7XjdrsB7o2PxzZSVLohh+obw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=foHpd7vVDBJjU1ci9E7s8nn/l9bqYBG5rN0PjgBzLkdDeogU0pbmzwSWGHVfOcZTy
	 Cs3XSrRV1zyY6J60ADwW0j9Q9hucBNQwkSzNCm5pRNCqSBCuGKv9Ny+YbA7NulI/8T
	 G91f1ES7kt+9UxIukV2IEt4yOo85i+EqwJEiIrYsl4r11bc0JSFSFpk/ZgKVPzYJHJ
	 RK8SrVjVV1OfeN5rN1gAULbWWoT9QVE65X4edo6Aifh1zQcH1RPwarp80yqw2d5HGT
	 ope0GyXxl0LZ3LBjWCzXn7pFvtRjB5xIYoAZhU7T6V6Af5AvZInNE6gPgtG2Fgjtuo
	 vO8QjedNG93xA==
Message-ID: <c0274733-bb5d-4692-8288-fbdc7c35800b@kernel.org>
Date: Wed, 15 Oct 2025 16:05:38 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] writeback: cleanup writeback_chunk_size
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
 hans.holmberg@wdc.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
References: <20251015062728.60104-1-hch@lst.de>
 <20251015062728.60104-2-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251015062728.60104-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/10/15 15:27, Christoph Hellwig wrote:
> Return the pages directly when calculated instead of first assigning
> them back to a variable, and directly return for the data integrity /
> tagged case instead of going through an else clause.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

