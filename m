Return-Path: <linux-fsdevel+bounces-58135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A1EB29ED5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 12:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC2218A40DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 10:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97561310622;
	Mon, 18 Aug 2025 10:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DMd43+nv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23EF15573A;
	Mon, 18 Aug 2025 10:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755511508; cv=none; b=Jvo6unh6bVCjePRwfd8QG6SPBN7HhD/wL0wKCNE2EfxAxdntNvdmyo7mOy/2HChB+H6k579Mm3f0yQPfjmn07XMexSU9hdFzukNs20uiTE4prTBjcAFbXV4vzmTKN43itNFLv3ssMM+dVofCzHwr8kpILBblbEaPEMkOLSQ2nuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755511508; c=relaxed/simple;
	bh=l1KEDj31YEXYocPjGR5R8CCG6e8dn/BZexL6e906Au4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U2v0iC6KUrQZqsWFh4exASyoeqbRUOBDkswW1MOQSTHfTVG21fgOL0jPeh7gXg4Hbk4OHXvy7Jf6itTNgXsnKFG2sF3Y+YHUkVy8ihk3VHTZmeBlITp+xjKWPJnwqP4jk+3plv1h99VKJe7Ga+hkBOjDfivOxVsgLqTmv48zVpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DMd43+nv; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=awwiyH3s0NQNHsdDw497b+l067+DM4LXdYTHuIVv1cU=;
	b=DMd43+nvcqImVbvhqh2Eh3CORxPAIEFx6XRQ6CnPrNU0umuSnWA/D2Do/IpaJr
	7L/6t5O3wmyj8afVUQyYT9GsmycrULrVuWRrOnvmT55HTdrL/+2MRwb1hMdVa+Kv
	UC3GIMEzsFdhkxaDdha0udI/OzBSn0t32THn0K56Wg7Xs=
Received: from [10.42.20.201] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD31_+o+qJoFtABCQ--.9173S2;
	Mon, 18 Aug 2025 18:04:25 +0800 (CST)
Message-ID: <9b3116ba-0f68-44bb-9ec9-36871fe6096e@163.com>
Date: Mon, 18 Aug 2025 18:04:23 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mpage: terminate read-ahead on read error
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, Namjae Jeon <linkinjeon@kernel.org>,
 Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>,
 Chi Zhiling <chizhiling@kylinos.cn>
References: <20250812072225.181798-1-chizhiling@163.com>
 <20250817194125.921dd351332677e516cc3b53@linux-foundation.org>
Content-Language: en-US
From: Chi Zhiling <chizhiling@163.com>
In-Reply-To: <20250817194125.921dd351332677e516cc3b53@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD31_+o+qJoFtABCQ--.9173S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw1DWrWrtw1xJr15JFW8JFb_yoW5Ar4kpr
	WFkFyktr9rJrWrZr1xJFsrJry8C3yI9a15GF93Ga47AF45WFyakryfKFW5ZayIyr97Ga1v
	vw409FyfZF1DZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U8uciUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbBaxStnWii93RePwAAsn

On 2025/8/18 10:41, Andrew Morton wrote:
> On Tue, 12 Aug 2025 15:22:23 +0800 Chi Zhiling <chizhiling@163.com> wrote:
> 
>> From: Chi Zhiling <chizhiling@kylinos.cn>
>>
>> For exFAT filesystems with 4MB read_ahead_size, removing the storage device
>> during read operations can delay EIO error reporting by several minutes.
>> This occurs because the read-ahead implementation in mpage doesn't handle
>> errors.
>>
>> Another reason for the delay is that the filesystem requires metadata to
>> issue file read request. When the storage device is removed, the metadata
>> buffers are invalidated, causing mpage to repeatedly attempt to fetch
>> metadata during each get_block call.
>>
>> The original purpose of this patch is terminate read ahead when we fail
>> to get metadata, to make the patch more generic, implement it by checking
>> folio status, instead of checking the return of get_block().
>>
>> ...
>>
>> --- a/fs/mpage.c
>> +++ b/fs/mpage.c
>> @@ -369,6 +369,9 @@ void mpage_readahead(struct readahead_control *rac, get_block_t get_block)
>>   		args.folio = folio;
>>   		args.nr_pages = readahead_count(rac);
>>   		args.bio = do_mpage_readpage(&args);
>> +		if (!folio_test_locked(folio) &&
>> +		    !folio_test_uptodate(folio))
>> +			break;
>>   	}
>>   	if (args.bio)
>>   		mpage_bio_submit_read(args.bio);
> 
> So...  this is what the fs does when the device is unplugged?
> Synchronously return an unlocked !uptodate folio?  Or is this specific
> to FAT?

It's fs behavior,

AFAIK, all filesystems that use mpage will lock the folio until I/O 
finishes or encounters an error. This avoids races like buffered writes, 
etc. The uptodate flag being set or not depends on the I/O status.


So, if a folio is synchronously unlocked and non-uptodate, should we 
quit the read ahead?

I think it depends on whether the error is permanent or temporary, and 
whether further read ahead might succeed.

A device being unplugged is one reason for returning such a folio, but 
we could return it for many other reasons (e.g., metadata errors).

I think most errors won't be restored in a short time, so we should quit 
read ahead when they occur.


Besides, IOMAP also quits read ahead when some errors are encountered in 
iomap_begin().

> 
> I think a comment here telling readers why we're doing this would be
> helpful.  It isn't obvious that we're dealing with e removed device!

okay, I will comment here.
/*
  * If read ahead failed synchronously, it may cause by removed device,
  * or some filesystem metadata error.
  */

> 
> Also, boy this is old code.  Basically akpm code from pre-git times.
> It was quite innovative back then, but everybody who understood it has
> since moved on,  got senile or probably died.  Oh well.

Actually, I think this patch is safe, but I'm not sure if we should fix 
this issue. After all, this code has existed for a long time, and it's 
quite rare to unplug the device during a copy operation :)


Thanks,
Chi Zhiling


