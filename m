Return-Path: <linux-fsdevel+bounces-55917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4B4B0FE81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 03:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E54DC5412DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 01:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA437261B;
	Thu, 24 Jul 2025 01:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EnAfWo6y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3020614286;
	Thu, 24 Jul 2025 01:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753322088; cv=none; b=AUQJ82FI/7VEkPlr9RpBePnOqHqi28LYzjmJFyW2bG+PFOofNwN16osW0XKnrjhtbLwnO30ZPyHA3QIn1hrA1h7/dkwppAYjptoth4XPPLX5KgF2QdGzId6llcZyovmHXYhwcvuQl+lKo8OuybsGrEiYLqsdaG8va3ZU+ifsul4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753322088; c=relaxed/simple;
	bh=TL2oFXIDdFEaQTeHY749EzPbR4yInffmqFMXyr9J8h4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BW90IuiDmN+qR+3gwgfUDUEYl7mOU8XzHd0PHGFk0EzOIkyPLY1CyXWxofcs88NlbjuqwDoiFdmuU8tQBBVwjEdl+d45hezsRmZ6cM1YpusJFfFN60CUXRMmZZMRotr7saDFQuMURUAl8+w1JwjkXqUCrpkt7O4eTeLAqjdP0Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EnAfWo6y; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=gt99ZL11NftF0tgwHS5Fp8cvOJq8ExHVRAMy6E/IxNA=;
	b=EnAfWo6y+d1amiyQamzEYsuwyveMSeXEAx8zntSG+JnIbzl+ZXyMhrSpocSKP7
	JsY2X6gIgA/CLH1GMKc4OjlcnyMN6rn6nTPYbMYSSoZZy6nUeKHmozktFG5t+VmD
	XXj4I9CaS4Ehr7OpCwLQxYtLnAYklmdjJ7QNhUX9IL2QE=
Received: from [10.42.12.6] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3NWpQkoFodDt5Gw--.23202S2;
	Thu, 24 Jul 2025 09:54:26 +0800 (CST)
Message-ID: <07dd7e42-b2c4-4fbb-87f3-ab888d11256d@163.com>
Date: Thu, 24 Jul 2025 09:54:24 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] mm/filemap: Avoid modifying iocb->ki_flags for
 AIO in filemap_get_pages()
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Chi Zhiling <chizhiling@kylinos.cn>
References: <20250723101825.607184-1-chizhiling@163.com>
 <20250723101825.607184-3-chizhiling@163.com>
 <aIDy076Sxt544qja@casper.infradead.org>
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <aIDy076Sxt544qja@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3NWpQkoFodDt5Gw--.23202S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJryUGF4fWw43Jr4xCFWxJFb_yoW8WrWUpr
	WrAa4vka1xXa1UZrWfAw12qa1jg34DJayrA3W7Ka1DAr98t3sakF4ftFyjkay7Jrn8XF4I
	va10yFykAFW0yrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRSD7-UUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/1tbiFASUnWiBj9Y5sAAAsg

On 2025/7/23 22:33, Matthew Wilcox wrote:
> On Wed, Jul 23, 2025 at 06:18:24PM +0800, Chi Zhiling wrote:
>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>
>> Setting IOCB_NOWAIT in filemap_get_pages() for AIO is only used to
>> indicate not to block in the filemap_update_page(), with no other purpose.
>> Moreover, in filemap_read(), IOCB_NOWAIT will be set again for AIO.
>>
>> Therefore, adding a parameter to the filemap_update_page function to
>> explicitly indicate not to block serves the same purpose as indicating
>> through iocb->ki_flags, thus avoiding modifications to iocb->ki_flags.
>>
>> This patch does not change the original logic and is preparation for the
>> next patch.
> 
> Passing multiple booleans to a function is an antipattern.
> Particularly in this case, since we could just pass iocb->ki_flags
> to the function.
> 
> But I think there's a less complicated way to do what you want.
> Just don't call filemap_update_page() if there are uptodate folios
> in the batch:
> 
> +++ b/mm/filemap.c
> @@ -2616,9 +2616,10 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
>                          goto err;
>          }
>          if (!folio_test_uptodate(folio)) {
> -               if ((iocb->ki_flags & IOCB_WAITQ) &&
> -                   folio_batch_count(fbatch) > 1)
> -                       iocb->ki_flags |= IOCB_NOWAIT;
> +               if (folio_batch_count(fbatch) > 1) {
> +                       err = -EAGAIN;
> +                       goto err;
> +               }


Yes, this is a completely better way.


Would you mind if I add
"Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>"
in the next version?

>                  err = filemap_update_page(iocb, mapping, count, folio,
>                                            need_uptodate);
>                  if (err)

Thanks,


