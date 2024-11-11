Return-Path: <linux-fsdevel+bounces-34196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 792669C3911
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 08:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2771D282361
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 07:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6FD158D79;
	Mon, 11 Nov 2024 07:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EkXzvGw+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD0E15099D
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731310626; cv=none; b=AKGCyd9ote2rzKlSIzBmzClR9clTaBqtqap9M65qkHHWmz6viWPsDush7Sz7bKMFJl/QHSZbY++nmHcJ2iMZ94xMZ6VUa0ZwX0CbcqiULsUUYMHXo0xs52nhSMW3oVyO3weuuX3YzFzD+uagESHWHWJGRcaVVJENR52crQW6ug4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731310626; c=relaxed/simple;
	bh=LNXT5L5pAyJeBHwVXH87IcXq0a4Go5G2sCIXtbUsKHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=brSqeoYHe159ey09nOTmkMQFZBDmpcmiBKnF1sc1nX7jIABr4qEW+OZGcAEUTxnYRbpseobtUTFYcBsRHofHs/J+k2iYJK8IKxH0UGBkHPCd8VnuJjYPSpt5aYH2ZpxC96tGnBhwfsC5d/JZkhRn4iY6RvTZeS2UNMVFGLlzOqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EkXzvGw+; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53a0c160b94so4986465e87.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Nov 2024 23:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731310622; x=1731915422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wpKSDFeLAAMM/qLa3qwScjMkR1oy5/1l/X/FnO2b6m4=;
        b=EkXzvGw+q4/kRI9/tNfpCtNBKYmCYLTZfPXiFHOslh+CkGYZDHINSZYtW7onLPdLZ1
         ZM5DUT263acsjcKD+jRTRgqoM1Ano0E9bsohX1RRzSWaPlaM5+Yg9tbZLNA5VCda7MkE
         Qa37gPsY43n6vvxLLjLQct2eunmpIrIf7B8fRgYH9UP9+jXqbFsjLpmBNUZWUUNXU3LF
         9L0LaMiDDURkp2wBjKR58ydPVPye3yEy61/77zb1uaduB2niscEiDE6tUn1H+wk7Tbq8
         OUZMzrlC4dsm55AxjuRUnwUlGchglf/1PnSerm7pyJgzhbYclUdzIBZdlSPBW3WkjcFY
         Yb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731310622; x=1731915422;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpKSDFeLAAMM/qLa3qwScjMkR1oy5/1l/X/FnO2b6m4=;
        b=V9pT9lWmBp/di5RTp3MQG7npqk6BYURoG7RrzLo4jY/UCj+dixjD3w0SKU6jh1iWp9
         zjYjjW6cssv+mQXb/XAZfpbDVPPOFsK+4mGZFPXxajUtQPnPb8APyR7qnENRPIG2xh2U
         Xll4/8tjVZ5YS3gDFeHXg0Bwz+hl9mylPp2Nn6XZbO/G8ZqSBuLU5yZ7rRTBPGXGmTOF
         G4m2ynGz8VAzEAHqgxiykRIR2d68nX5Z9UfMltWlNF20JQhyUpZqIj1IKdI6gQ1yjIbt
         Og6E8jSDsLSSRcK9hiXnOod8DbzqTDaG9bna/XCO9IN7fDK73AeSL0Vviqi4kcwLIykD
         AjSA==
X-Gm-Message-State: AOJu0Yw9kVxvrhquHMbFCiKLVsFJYECiILrwnnUJTAjd6idPxaF/gdTS
	ybYehx0Ju8oD76obbPSjt0Z/UGnPafyZdfrbjQHrm20CuKCXNY+Thh3gez4ZHCc=
X-Google-Smtp-Source: AGHT+IFfI5830PAgikqPuW6i+tE8Q9VP27Jb6NMbngysyvPz3iGzz85igEEHPUyV3rzJ1AREVjop9A==
X-Received: by 2002:a05:6512:10c9:b0:536:52ed:a23f with SMTP id 2adb3069b0e04-53d86254bdamr4279452e87.0.1731310622083;
        Sun, 10 Nov 2024 23:37:02 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e416casm70143165ad.146.2024.11.10.23.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 23:37:01 -0800 (PST)
Message-ID: <d5dca4eb-2294-4d24-9e36-dac8be852622@suse.com>
Date: Mon, 11 Nov 2024 18:06:57 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: About using on-stack fsdata pointer for write_begin() and
 write_end() callbacks
To: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <561428e6-3f71-48cb-bd73-46cc21789f6f@gmx.com>
 <ZzGbioLSB3m7ozq1@infradead.org>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <ZzGbioLSB3m7ozq1@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/11 16:22, Christoph Hellwig 写道:
> On Mon, Nov 11, 2024 at 02:57:06PM +1030, Qu Wenruo wrote:
>> Hi,
>>
>> Recently I'm working on migrating btrfs_buffered_write() to utilize
>> write_begin() and write_end() callbacks.
> 
> Why?  They aren't exactly efficient, and it's just going to create
> more Churn for Goldwyn's iomap work.

So it is not recommended to go the write_begin() and write_end() 
callbacks at all?
Or just not recommended for btrfs?

I know there are limits like those call backs do not support 
IOCB_NOWAIT, and the memory allocation inefficient problem (it should 
only affect ocfs2), but shouldn't we encourage to use the more common 
paths where all other fses go?

> 
>> Currently only the following filesystems really utilizing that pointer:
>>
>> - bcachefs
>>    Which is a structure of 24 bytes without any extra pointer.
> 
> And as pointed out last time willy and I did go through the users of
> write_begin/end this is just dead code that is never called.
> 
>> Thus I'm wondering should we make perform_generic_write() to accept a
>> *fsdata pointer, other than making write_begin() to allocate one.
>> So that we only need to allocate the memory (or use the on-stack one)
>> once per write, other than once per folio.
> 
> And that scheme was one of my suggestions back then, together with
> removing write_begin/end from address_space_operations because they
> aren't operations called by MM/pagecache code, but just callbacks
> provided by the file system to perform_generic_write.
>

Mind to point me to the old discussion thread? I'd like to know why we 
didn't go that path.

Thanks,
Qu


