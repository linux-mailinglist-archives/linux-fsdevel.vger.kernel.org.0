Return-Path: <linux-fsdevel+bounces-39189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560A5A11314
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 22:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 757CC1675E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 21:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1770E20C00A;
	Tue, 14 Jan 2025 21:32:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-12.prod.sxb1.secureserver.net (sxb1plsmtpa01-12.prod.sxb1.secureserver.net [188.121.53.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9D729406
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 21:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736890350; cv=none; b=PPhPn0byP/29WZXr4SXk7tG5u504zTc+cRHH2UYcJN1Od1xHS1Oefwm9b02KBsUVW4UGCu8WwEIkynmBqlsZtlkAqze0Kx4PFXXV/tAyPmqtjPsxGCoktPYv0McOhPV9ObZLNjHmMhqY5+R5AzWSZLKJzpBGkOWUW/usQr2WnI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736890350; c=relaxed/simple;
	bh=cnOEmvb5OkrPGkK4dKfXE0vYco/hg0BsfIcJmFusjNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQwX6muWR+cQ7FRfLWn/UGicALfty9ApMjB3kzPRy/wEcBnh5rpiGp4ry7N3pQFEIm2eynDA8YhbVg1ll1HX60moJkkAG2qHo4lpUQtQAO4OlUW2O3nAf+EeMMMswYegJRNOmmrYduzWox6jzJtgBVEWJnv+vauIgQOWHkhb7bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id XoDvt575dxZ1ZXoDvtRqjh; Tue, 14 Jan 2025 14:13:20 -0700
X-CMAE-Analysis: v=2.4 cv=S8MjwJsP c=1 sm=1 tr=0 ts=6786d370
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=FXvPX3liAAAA:8
 a=aJ2FpNpiM_XpSbliDKwA:9 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <699b01ba-146d-4669-8521-e8d012c6e28b@squashfs.org.uk>
Date: Tue, 14 Jan 2025 21:12:53 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] squashfs: Fix "convert squashfs_fill_page() to take a
 folio"
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: squashfs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20250110163300.3346321-1-willy@infradead.org>
 <20250110163300.3346321-2-willy@infradead.org>
Content-Language: en-US
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <20250110163300.3346321-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfAYAI12+DkpbT++IdQXi7iCcI5QfnZHw6D2tywCbyigO+zt+GIPF8JEdB9b/pAEym8yXd1KG36dSRPEXXPUHJZxKM/meqFXpSZveF7acde7dLTY8fVpU
 f7Kzr+cFcpskAzNAI41bE9eLhW35HtwX4s40zn39Y++DhD4R2Emq2Fgpj/LKTf+F8f/eJMvMb7qua5pXWLi/v6AZ+wMnshfqWmHQ/XMF6JkPIGfGrc8T8Vo/
 urMymLTctcHcc77anzYvIUlBV+AhXpG16uHibnysATDiqM+fmQFg/baIN8vkiNbMiQKV7D8jSL3z1gPXxFoEUPNstrJdpLUqjvEjWihXNVcPwY4ZU9QoebPQ
 7TSoxTLf



On 1/10/25 16:32, Matthew Wilcox (Oracle) wrote:
> I got the polarity of "uptodate" wrong.  Rename it.  Thanks to
> Ryan for testing; please fold into above named patch, and he'd like
> you to add
> 
> Tested-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>
Tested-by: Phillip Lougher <phillip@squashfs.org.uk>

> ---
>   fs/squashfs/file.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index da25d6fa45ce..018f0053a4f5 100644
> --- a/fs/squashfs/file.c
> +++ b/fs/squashfs/file.c
> @@ -400,7 +400,7 @@ void squashfs_copy_cache(struct folio *folio,
>   			bytes -= PAGE_SIZE, offset += PAGE_SIZE) {
>   		struct folio *push_folio;
>   		size_t avail = buffer ? min(bytes, PAGE_SIZE) : 0;
> -		bool uptodate = true;
> +		bool updated = false;
>   
>   		TRACE("bytes %zu, i %d, available_bytes %zu\n", bytes, i, avail);
>   
> @@ -415,9 +415,9 @@ void squashfs_copy_cache(struct folio *folio,
>   		if (folio_test_uptodate(push_folio))
>   			goto skip_folio;
>   
> -		uptodate = squashfs_fill_page(push_folio, buffer, offset, avail);
> +		updated = squashfs_fill_page(push_folio, buffer, offset, avail);
>   skip_folio:
> -		folio_end_read(push_folio, uptodate);
> +		folio_end_read(push_folio, updated);
>   		if (i != folio->index)
>   			folio_put(push_folio);
>   	}

