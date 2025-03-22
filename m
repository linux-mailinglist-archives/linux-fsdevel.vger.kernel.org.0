Return-Path: <linux-fsdevel+bounces-44787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43763A6C9D5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 11:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9B61898A28
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 10:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E8D1F9F51;
	Sat, 22 Mar 2025 10:50:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881AB1F3B83;
	Sat, 22 Mar 2025 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742640605; cv=none; b=P4lwCiTe7MBFkJYk1ZnV9VwWrqYLN/VvkNdeuP9KtENgcqQwj+EsOuFUvUnE85BamPLuw/DJw7ZZIMvY9ZbKHseAjtP6mtzzhPBz6eyQ2GsQhmJaI2k17C8nL1CjyPxCXFpVK5TQBb0uEHnlH0SfQaMXuOSTXVH03y82UnmEDJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742640605; c=relaxed/simple;
	bh=gsahR1oB90R8c4rPTINpZtRZT0Pye22nXzuunvePvxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nL/IWy7jW8V+FYy22AHTuR3KLvdyuUAr4ze3yIm14yC9DhFL6t7Jjqm6vCcl4NgwJmIldiGbORiHmfJxnaLkDOv1eRJizhHFvXq8cqBM+RPWQLBlPg2cYd/TECrE96LUtuS1zAzcurCjDNA/uxGwcOnOQybKJW2VDWZAzsLRxxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4ZKbNV3mTdz9sRr;
	Sat, 22 Mar 2025 11:37:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZVkpUIXXOmBQ; Sat, 22 Mar 2025 11:37:14 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4ZKbNV2nyTz9sPd;
	Sat, 22 Mar 2025 11:37:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 44CC88B765;
	Sat, 22 Mar 2025 11:37:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id AWnK_vc2Tu5r; Sat, 22 Mar 2025 11:37:14 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D83FF8B763;
	Sat, 22 Mar 2025 11:37:13 +0100 (CET)
Message-ID: <d20eec71-2be7-45ea-a57a-ad24e6718424@csgroup.eu>
Date: Sat, 22 Mar 2025 11:37:12 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] XArray: revert (unintentional?) behavior change
To: Andrew Morton <akpm@linux-foundation.org>,
 Tamir Duberstein <tamird@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20250321-xarray-fix-destroy-v1-1-7154bed93e84@gmail.com>
 <20250321213733.b75966312534184c6d46d6aa@linux-foundation.org>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250321213733.b75966312534184c6d46d6aa@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 22/03/2025 à 05:37, Andrew Morton a écrit :
> On Fri, 21 Mar 2025 22:17:08 -0400 Tamir Duberstein <tamird@gmail.com> wrote:
> 
>> Partially revert commit 6684aba0780d ("XArray: Add extra debugging check
>> to xas_lock and friends"), fixing test failures in check_xa_alloc.
>>
>> Fixes: 6684aba0780d ("XArray: Add extra debugging check to xas_lock and friends")
> 
> Thanks.
> 
> 6684aba0780d appears to be only in linux-next.  It has no Link: and my
> efforts to google its origin story failed.  Help?
> 

Apparently comes from git://git.infradead.org/users/willy/xarray.git

