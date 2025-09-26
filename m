Return-Path: <linux-fsdevel+bounces-62877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574F4BA3BF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 15:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4AE2626BBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 13:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319042F5A10;
	Fri, 26 Sep 2025 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9DG3Roo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850A32750F3;
	Fri, 26 Sep 2025 13:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891780; cv=none; b=W3GP02VOk815AzLDKFAf6TrkrgXavHG7u9ihe9ss9XCr5sA1dPPyvfU/WI24cSfN7P+mG+9seXnxww6zLc+H7bGQtdFnBxqNUxbIq8TE1V6nTNpIgZHJA+gfK0hUhWgWioTqPTQVsas/e6Xe/S+Hi+v0rwYbqjzxgNbVes9kC98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891780; c=relaxed/simple;
	bh=8ID9kGz/82/5N4qiWEJYj9mxFgAxoPaXujfJi5jWldY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZfVAapNN+rK3vJvgPahufbjnkbmDd16kUg/Q+8xOL/UOX88Bqc8NPA4eaUK64f2zLe+7sHnn+c25TVyHA9ik12eYwYfA5QRQZGbOt7yyhlF113Mt93ualVJYpVUT8SYGRwqzXEHjfhzf3Y1TuIJy34Hon6yEg4NbI3rNlryXVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9DG3Roo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36FCC4CEF4;
	Fri, 26 Sep 2025 13:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758891780;
	bh=8ID9kGz/82/5N4qiWEJYj9mxFgAxoPaXujfJi5jWldY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P9DG3Roo0YahBPpM1s9x1TtrXqzuQai1Ss9HiKgxBz45f6Qx0B2Bz6mw47xXRXYZI
	 4b1o4oUM8RgevdgET4g06PvTq37v4s4eBGbmPwocN5sEuGiqEm5mY/BBzbfk1xOSAZ
	 mfcR91ADhP/4+/smxsSP6VeC+wHZ3Weoue4BCz9BAjZLGaa4SYy8WMgkPk3cROk6QF
	 HqqE3QKVCy49QXZVsEbcsG0su9BrfkrIYH+lV7m8k8xkaZ1hGpUQxyw9k5i8cRVFjZ
	 BfgzTWKni4KhIaYbuQqUW+Wj/Yqv/A2oRNASOJQTwTH2xnn8wtSi3qLzVx1bHOa/mb
	 QuVdLmwTeMZSg==
Message-ID: <a99fdcba-ab77-4a40-bc97-9794ebfdb059@kernel.org>
Date: Fri, 26 Sep 2025 09:02:58 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fs: Plumb case sensitivity bits into statx
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Volker Lendecke <Volker.Lendecke@sernet.de>
References: <20250925151140.57548-1-cel@kernel.org>
 <aNYUfyiVMaWtQ0V5@infradead.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aNYUfyiVMaWtQ0V5@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/25 9:20 PM, Christoph Hellwig wrote:
> On Thu, Sep 25, 2025 at 11:11:40AM -0400, Chuck Lever wrote:
>> +	if (request_mask & STATX_CASE_INFO) {
>> +		stat->result_mask |= STATX_CASE_INFO;
>> +		/* STATX_CASE_PRESERVING is cleared */
>> +		stat->case_info = statx_case_ascii;
> 
> FAT is using code pages specified on the command line for it's case
> insensitivity handling, which coverse much more than ASCISS.

I noticed that a mount option controls whether the filename encoding is
UTF-8. Clearly this will need more logic to set the correct bit.


>> +/* Values stored in the low-order byte of .case_info */
>> +enum {
>> +	statx_case_sensitive = 0,
>> +	statx_case_ascii,
>> +	statx_case_utf8,
>> +	statx_case_utf16,
>> +};
> 
> What are these supposed to mean?

For the moment, the meaning is unclear because I simply wanted to
demonstrate that more than one behavior can be reported. Someone with
greater expertise than mine can help refine the specific semantics.


> ASCII, utf8 and utf16 are all
> encodings and not case folding algorithms.  While the folding is obvious
> for ASCII, it is not for unicode and there are all kinds of different
> variants.

Fair enough... this is the right spot to report those variants. Or we
can decide that is inconsequential or impossible and simply reduce this
to a single "filename case is {in}sensitive" bit.


> Also I don't know of any file systems using utf16 encoding
> and even if it did, it would interact with the VFS and nfsd using
> utf8.  Note that the 16-bit ucs-2 encoding used by windows file systems
> is a different things than unicode encodings like utf16.

Sure, UTF16 can be dropped or replaced.


-- 
Chuck Lever

