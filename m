Return-Path: <linux-fsdevel+bounces-15352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A380788C68E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 16:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD5F30797C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 15:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4E413C813;
	Tue, 26 Mar 2024 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Z1dniA31"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBB913CC46;
	Tue, 26 Mar 2024 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466017; cv=none; b=FTM4uJ1vItrCT6z1Wk5YvcCZ1rpa24eR9sp3wvM8XuIjDMMbTlZFziTpOVvvz+BaemUBqN8O6fhDsyxzwQ7yz22aDMGsBwuj6CnYlKPTEOd8dnWP0GzwnkZbWy4ykAuIRdkjwxi8ZkRQ8j8aACDphiHB9PyQDTUhh4APySBSTYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466017; c=relaxed/simple;
	bh=eI4IyOhFaJQIAiifFI9TCY/+heTJv1Nh7hTCSX/BhKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQNieL2bRj2fsKGFz7q96dIb8ARDTHS/Zx8cS9rRzIx9zUMXPA7bX4L6ZNpSFPCEs8an5+Rg85JFaWuAbqNpPf1Na8Yp4904T1/39GhrBo/EaImuouvA1BY9xyrn8/XCl+nmRrYxBC9sHfIFzrTF5LGXa+vvpa61VEaGDN76JYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Z1dniA31; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4V3tRP2bGRz9sp7;
	Tue, 26 Mar 2024 16:06:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1711465569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+6K4b9S76Ab2/ngd1mwoc6s0B1aFx0F1dzGraTAPTo=;
	b=Z1dniA31y8YJOkfxRBC/wzJxbGe3+dlDsJzHmNtsHPD9XoCv00T3xKLOTp5Amc00d0HCPd
	DhEP8NmzCSEjd5SJcG5i27AzDDXVCMLkeLhxt/KuFHbsixMk1sHXmFz4arVxvqRtSle0gF
	00LVx0BNQYJLokqADG41AaT0NnCWAXdFc6Lh0zQIYXPb8a9WaNZEU0+BooPjrxV5RrLYvN
	7EUKVlI9Fek3Naga9sYuZR1InqWPxiDz3Gq5p9mqn+UxfZE/DN6+B2gPyHSgPDlNq2jw49
	pQ9wpBlRyXsoygLRXNCUTUtc+uv2uNBIROhm67MepXW5gYfsHzsG9PLh/ilhZA==
Message-ID: <1b99068c-ac1b-4121-93f4-23ba4863b8b0@pankajraghav.com>
Date: Tue, 26 Mar 2024 16:06:02 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 00/11] enable bs > ps in XFS
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Matthew Wilcox <willy@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 gost.dev@samsung.com, chandan.babu@oracle.com, mcgrof@kernel.org,
 djwong@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 david@fromorbit.com, akpm@linux-foundation.org,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
 <ZgHOK9T2K9HKkju1@casper.infradead.org>
 <2508c03b-c26c-42ce-872d-3c5107a4d8a0@suse.de>
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <2508c03b-c26c-42ce-872d-3c5107a4d8a0@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4V3tRP2bGRz9sp7

On 26/03/2024 10:53, Hannes Reinecke wrote:
> On 3/25/24 20:19, Matthew Wilcox wrote:
>> On Wed, Mar 13, 2024 at 06:02:42PM +0100, Pankaj Raghav (Samsung) wrote:
>>> This is the third version of the series that enables block size > page size
>>> (Large Block Size) in XFS. The context and motivation can be seen in cover
>>> letter of the RFC v1[1]. We also recorded a talk about this effort at LPC [3],
>>> if someone would like more context on this effort.
>>
>> Thank you.  This is a lot better.
>>
>> I'm still trying to understand your opinion on the contents of the
>> file_ra_state.  Is it supposed to be properly aligned at all times, or
>> do we work with it in the terms of "desired number of pages" and then
>> force it to conform to the minimum-block-size reality right at the end?
>> Because you seem to be doing both at various points.
> 
> Guess what, that's what I had been pondering, too.
> Each way has its benefits, I guess.
> 
> Question really is do we keep the readahead iterator in units of pages,
> and convert the result, or do we modify the readahead iterator to work
> on folios, and convert the inputs.
> 
> Doesn't really matter much, but we need to decide. The former is probably easier on the caller, and
> the latter is easier on the consumer.
> Take your pick; I really don't mind.
> 
> But we should document the result :-)
> 

Having experimented both approaches, I prefer the latter as it looks more consistent and
contain the changes to few functions.

> Cheers,
> 
> Hannes
> 

