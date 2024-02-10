Return-Path: <linux-fsdevel+bounces-11038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFD3850295
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 05:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927A41C22BE4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 04:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6ED6AB7;
	Sat, 10 Feb 2024 04:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iJ3OtuSV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D85524A
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Feb 2024 04:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707541186; cv=none; b=cbNSKMbvbeW0cVWSoC7bdiaCiaQJY6vQJG2s68uq7fvM+BjjywG0tVkz6uvi0HZ9N/P5ZnqmH5ecUy299yP1Rabta2voWqgb9KQd8E0DYjpMszZwoullN/8ubzXJcYGFRI38Z8eBhOJxytxSRVo2a9mZF/u5uNs9pbKdux8yLME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707541186; c=relaxed/simple;
	bh=1hMSzKlU/8kdzNK0ZhfKer6MS58iESJPzqeH9XaJRhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=puNGy7eqvR8a+sHrb64rLIfwTwK7DNa0DBGsoqVfV6dQT2N/hoUmX10gjqt2HkEIh9smy61qjK/Ds3PsU6hcbn9l27jDvrnasPFpH+/LB+tmU7atN/4dxlRkD8/K3c2CqP1hKe0P1QNmqsKR3apeWECZ4p4mbtNZyhpbdQVm4X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iJ3OtuSV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=3Nljb9PCm+3BSksLB4/hye2aApASFSnrOrHjYRJX5Kk=; b=iJ3OtuSV5XS2/o4y71qAOLhhjW
	iAWpvuu4D2hHS53tl/JLJslI+Ub5O8dSN4eew0QtNuiR6wXpBo+17Dq8akHdlO2P6nqjiczbBPOJg
	gHpBKnmA47Gk+WJHq1QOQvAxhMO/Qh/Ut2v+e9ZP89n4I3qWbOC13OHQJRXjIoZqoyVFXIWqy7XHL
	Xuq+yRlhduOnZ+qF1Tp/Uk2sKGji98Uf4nGpJnuZB9guE56vP5SXCEwCmDVBNPdYia9Xw81qbpxtK
	UDoi7v378I+2VuFDl+cXHmXcRN8dLsrm6KbjeMh8JLPf8RNfZ1GOvJsZTBKZ3YN1eAMLCUfvfUUla
	agt6NNtA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYfSp-00000001DjS-3MFq;
	Sat, 10 Feb 2024 04:59:43 +0000
Message-ID: <fbb4cbf0-5cb8-40b6-b1a5-b61ca4a30a79@infradead.org>
Date: Fri, 9 Feb 2024 20:59:41 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/hfsplus: wrapper.c: fix kernel-doc warnings
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>
References: <20231206024317.31020-1-rdunlap@infradead.org>
 <8e6759b1-15da-40b7-85a5-7c6ae91d51e5@acm.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <8e6759b1-15da-40b7-85a5-7c6ae91d51e5@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/9/24 13:57, Bart Van Assche wrote:
> On 12/5/23 18:43, Randy Dunlap wrote:
>> - * @op: direction of I/O
>> - * @op_flags: request op flags
>> + * @opf: request op flags
> 
> (just noticed this patch)
> 
> The new comment is worse than the original comments. This would be a
> better explanation of the 'opf' argument:
> 
> + * @opf: I/O operation type and flags

Agreed. I'll send an update.

thanks.
-- 
#Randy

