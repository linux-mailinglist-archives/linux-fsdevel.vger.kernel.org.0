Return-Path: <linux-fsdevel+bounces-50588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6938AACD89A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 09:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F78A188DA86
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 07:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E74221F11;
	Wed,  4 Jun 2025 07:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGb8k9Wq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AB013AD05;
	Wed,  4 Jun 2025 07:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749022283; cv=none; b=rn//0a+SWzyxfXo30u+EwKZ72dzG6ChVQtmMRfR9kvTicBrrMln7kedpJ/2cbdD76zexFJgeKTyZxDqX9K71lBGvJYz0LbdJMLpY5vuUw+Nb7cK6LCXFJXpgPHBmvMkFQDSCzrUsUJGbaRavAgupX3FUcCJ1lvaPR+AD9vrw1aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749022283; c=relaxed/simple;
	bh=CoUYZg4cbHXIK3YnOrrX6RWNoH7Arv+dVw/7EPD8JQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5tGeD9I9xVDoQFn5r+LKLJgfaIgKlnACwWcjMMNThyl3Cxld4sH8TxkSK0TimynMtF7vWxcP5qqlwGh5xZXwXRfvR3FAff2VJMAj61tgD+qZL/OwoQiwHXPuOAQNXuYg9y2vhBTzpzrkvrUNusRH6DhBFKFMtOEQGIoQMi9Maw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGb8k9Wq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E234EC4CEE7;
	Wed,  4 Jun 2025 07:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749022281;
	bh=CoUYZg4cbHXIK3YnOrrX6RWNoH7Arv+dVw/7EPD8JQ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vGb8k9Wq4mWOWYluRmLs+xHWkD9PVOjantV9mwXywJoURpAWY0Y2jRWlWj9+Yj6pt
	 jN0N3CT2fTdBaU4zloJd56/5RV1UX9uPiG6SyOojZCyXYUjaXoUYgvM0m2CPlfCJFI
	 0AWAk7f0Nt8XSoSLJ3USI9sykqV4eSKZB7hyXs5keplrgQmNuRxiq3chcW6WS6+m4J
	 EeUnEGGZpP/7uKAs05J7TAuEQHkYWI3G2semklq0gv0I04/t3Sw3RwXG36b8Rilj+Q
	 7nXZEpZbLIaRA40ba5JKBOFRJq2nOT2Auew+obXpw9ftwW9VFCuGv6JGTSMvKFJTiN
	 HlZzKVCfKtkEQ==
Message-ID: <ee8952a0-d0ee-47db-8012-abb2722ae7ef@kernel.org>
Date: Wed, 4 Jun 2025 16:29:43 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] xfs, iomap: Handle writeback errors to prevent silent
 data corruption
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Christoph Hellwig <hch@infradead.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Christian Brauner <brauner@kernel.org>, djwong@kernel.org, cem@kernel.org,
 linux-xfs@vger.kernel.org, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 Sathya Prakash <sathya.prakash@broadcom.com>,
 Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
References: <aD03HeZWLJihqikU@infradead.org>
 <CALOAHbDxgvY7Aozf8H9H2OBedcU1efYBQiEvxMg6pj1+arPETQ@mail.gmail.com>
 <aD5obj2G58bRMFlB@casper.infradead.org>
 <CALOAHbCWra+DskmcWUWJOenTg9EJQfS23Hi-rB1GLYmcRUKf4A@mail.gmail.com>
 <aD5ratf3NF_DUnL-@casper.infradead.org>
 <CALOAHbB_p=rxT2-7bWudKLUgbD7AvNoBsge90VDgQFpakfTbCQ@mail.gmail.com>
 <aD58p4OpY0QhKl3i@infradead.org>
 <e2b4db3d-a282-4c96-b333-8d4698e5a705@kernel.org>
 <CALOAHbA_ttJmOejYJ+rrRdzKav_BPtwxuKwCSAf2dwLZJ1UyZQ@mail.gmail.com>
 <26d6d164-5acd-4f85-a7ac-d01f44fb5a87@kernel.org>
 <aD8Jmmd4Aiy1HElV@infradead.org>
 <abe44d8f2bebe805dd0975be198994c89a100644.camel@HansenPartnership.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <abe44d8f2bebe805dd0975be198994c89a100644.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/3/25 11:57 PM, James Bottomley wrote:
> On Tue, 2025-06-03 at 07:41 -0700, Christoph Hellwig wrote:
>> [taking this private to discuss the mpt drivers]
>>
>>> Hmmm... DID_SOFT_ERROR... Normally, this is an immediate retry as
>>> this normally is used to indicate that a command is a collateral
>>> abort due to an NCQ error, and per ATA spec, that command should be
>>> retried. However, the *BAD* thing about Broadcom HBAs using this is
>>> that it increments the command retry counter, so if a command ends
>>> up being retried more than 5 times due to other commands failing,
>>> the command runs out of retries and is failed like this. The
>>> command retry counter should *not* be incremented for NCQ
>>> collateral aborts. I tried to fix this, but it is impossible as we
>>> actually do not know if this is a collateral abort or something
>>> else. The HBA events used to handle completion do not allow
>>> differentiation. Waiting on Broadcom to do something about this
>>> (the mpi3mr HBA driver has the same nasty issue).
>>
>> Maybe we should just change the mpt3 sas/mr drivers to use
>> DID_SOFT_ERROR less?  In fact there's not really a whole lot of
>> DID_SOFT_ERROR users otherwise, and there's probably better status
>> codes whatever they are doing can be translated to that do not
>> increment the retry counter.
> 
> The status code that does that (retry without incrementing the counter)
> is DID_IMM_RETRY.  The driver has to be a bit careful about using this
> because we can get into infinite retry loops.

James,

Thank you for the information. Will have a try again at changing the driver to
use this.


-- 
Damien Le Moal
Western Digital Research

