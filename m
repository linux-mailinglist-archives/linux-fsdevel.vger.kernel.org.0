Return-Path: <linux-fsdevel+bounces-43448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D06FA56BEF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 16:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7DBD3AA371
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 15:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D58521CC69;
	Fri,  7 Mar 2025 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="U+c0IOxt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401A221C9F3;
	Fri,  7 Mar 2025 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361116; cv=none; b=aRaemDe9/Wx9UOMS/FqFdWV4UL9nJIC2m/AZZLY8BQQInG/1Zgke8nvGWOZaOYJPsl0NwfXPeiY3H54DSZSiDSV5Ty9syGj5rHIf/9+hIbpte4KcHzy4+n8IFuBRL7xytKfQiH1WOFNNS6oSesliAPpi977fP8M08p4J6lnK3tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361116; c=relaxed/simple;
	bh=N2tNOHCz17NVqXk9emM1DtMNhrrP/2lfot3/2H8iUjc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CRk6fJ9UNrFE7g1KhqYEM7Txuhim+UbaMI30pKPenjHLddju0W+s9fmWCwnODAM2ynhbe++luRn1p8cLXHIBq6jW9aqruxHQwY6ohEocOizS0HFeQaDW32rmckeOmTarZWl0//ytelleDk7YmQ5w8eOPUY5bMnWsJDpIoukcs/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=U+c0IOxt; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E458441061
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1741361108; bh=6uBJ1YUDIOKuMkF8J+Ow27cEIe6pHr5CJF/jr/dLLA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=U+c0IOxtLK/yHL6U9gVkTGNWfKeHe7Cxjetxvjp7L3+fhF0t5VqDLayHbnkOecFGu
	 qYn3EHi24lLNRlLwjvlcLjABGf3zNwLrc8NYTpQSqMb92Gzc3qmlijh49B1IC8QrGG
	 UGpuzlIDPTGX+TwKiLQ0xQM6aM9HjXgxRQ5961CtqRyW7hfcBlIFZrACerkGfbpFkp
	 qu8xTV/BIFh3GFTh4pYOiZCjBYXHWrLS+X/cWVmYzCIxv2PeaasmQLVOj730bUc7dd
	 7PzVO1c/UzvHCkp59SI9KNrfQho474Mgp4bMa0u0xA2UxewlYHUGniiP9REVJ7Voo4
	 LlVqxpyEj6WqQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E458441061;
	Fri,  7 Mar 2025 15:25:07 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Pratyush Yadav <ptyadav@amazon.de>
Cc: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Hugh
 Dickins <hughd@google.com>, Alexander Graf <graf@amazon.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, David Woodhouse
 <dwmw2@infradead.org>, James Gowans <jgowans@amazon.com>, Mike Rapoport
 <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Pasha Tatashin
 <tatashin@google.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Dave
 Hansen <dave.hansen@intel.com>, David Hildenbrand <david@redhat.com>, Jason
 Gunthorpe <jgg@nvidia.com>, Matthew Wilcox <willy@infradead.org>, Wei Yang
 <richard.weiyang@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, kexec@lists.infradead.org
Subject: Re: [RFC PATCH 2/5] misc: add documentation for FDBox
In-Reply-To: <mafs0v7skj3m2.fsf@amazon.de>
References: <20250307005830.65293-1-ptyadav@amazon.de>
 <20250307005830.65293-3-ptyadav@amazon.de> <87ikok7wf4.fsf@trenco.lwn.net>
 <mafs0v7skj3m2.fsf@amazon.de>
Date: Fri, 07 Mar 2025 08:25:07 -0700
Message-ID: <87ecz87tik.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pratyush Yadav <ptyadav@amazon.de> writes:

> On Fri, Mar 07 2025, Jonathan Corbet wrote:
>
>> Pratyush Yadav <ptyadav@amazon.de> writes:
>>
>>> With FDBox in place, add documentation that describes what it is and how
>>> it is used, along with its UAPI and in-kernel API.
>>>
>>> Since the document refers to KHO, add a reference tag in kho/index.rst.
>>>
>>> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
>>> ---
>>>  Documentation/filesystems/locking.rst |  21 +++
>>>  Documentation/kho/fdbox.rst           | 224 ++++++++++++++++++++++++++
>>>  Documentation/kho/index.rst           |   3 +
>>>  MAINTAINERS                           |   1 +
>>>  4 files changed, 249 insertions(+)
>>>  create mode 100644 Documentation/kho/fdbox.rst
>>
>> Please do not create a new top-level directory under Documentation for
>> this; your new file belongs in userspace-api/.
>
> I did not. The top-level directory comes from the KHO patches [0] (not
> merged yet). This series is based on top of those. You can find the full
> tree here [1].
>
> Since this is closely tied to KHO I found it a good fit for putting it
> on KHO's directory. I don't have strong opinions about this so don't
> mind moving it elsewhere if you think that is better.

I've not seen the KHO stuff, but I suspect I'll grumble about that too.
Our documentation should be organized for its audience, not for its
authors.  So yes, I think that your documentation of the user-space
interface should definitely go in the userspace-api book.

Thanks,

jon

(Who now realizes he has been arguing this point of view for over ten
years ... eventually it will get across... :)

