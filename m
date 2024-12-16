Return-Path: <linux-fsdevel+bounces-37492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6A29F31B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 14:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E941887C01
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 13:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F61205AA4;
	Mon, 16 Dec 2024 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQcHWBex"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53B12054F3;
	Mon, 16 Dec 2024 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734356349; cv=none; b=tYico4LnQr5WQYFgn35AOcA33ZpZVmCPpLj2XQ+4QVfwypHJ2xVR4wBtfk696qSlHzJfey2luqXgBk3bqQiwEo8FOiEwhuzi1zLf2N74EaY8XD7I9MnXor/SZv+5+747Dz74r4XMyA9KHeAobne6vYqH++m58OIIL9qe77LfHUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734356349; c=relaxed/simple;
	bh=70Nusa1jB1c9tdJOkuqKSzoonCVWxZZ+0Qgz642MpNI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FHgdk0c8Vt14xN0Ln6k6Rj03ypc1vArCuVaaTNKOWAlV1pI4OBhs2xqdqqtGY16U04yfXlITd8iGWYq41kJAtRXhZqY1QYZ/mCZ3JmcMzdcwk5xC9aYDYKtWq+jSYqS3JXDadWlWsyvXyKB/QuPkzKMwKWeN5iKc3F1U01HEgmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQcHWBex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D7CC4CED0;
	Mon, 16 Dec 2024 13:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734356349;
	bh=70Nusa1jB1c9tdJOkuqKSzoonCVWxZZ+0Qgz642MpNI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RQcHWBex8iJgfrYary36U3cvf6PndC2aJCM0qFYEyJIAQsSVoSczn0zCb2y2gKfaz
	 GEynYeJN7lHnAyLSBqYdMwwxEURPDwvhdEFVW+5a+oPuFji5nlFcCRbZAAeiFhWS3x
	 wDufJth+Af4GWjMd2rfwU3elf968oZZdGTHNd+guPDk4fhmf4RlBrMbnLqB9n7bb43
	 HXKiavGri/bWX47oCYKVY20oMkjpSeiOsX2SjlAcr+YSBSISqxitBiN/wdrAWKwNWf
	 hnlZWg0czt71yYQp54wpfHjOcDun5EkZnT7vXDEpaYx97JZbQPX83vZMWEGiMWBCdf
	 LXXhjxqkq+Osg==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "'cel@kernel.org'" <cel@kernel.org>,  Hugh Dickins <hughd@google.com>,
  Christian Brauner <brauner@kernel.org>,  Al Viro
 <viro@zeniv.linux.org.uk>,  "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>,  "linux-mm@kvack.org"
 <linux-mm@kvack.org>,  "yukuai3@huawei.com" <yukuai3@huawei.com>,
  "yangerkun@huaweicloud.com" <yangerkun@huaweicloud.com>,  Chuck Lever
 <chuck.lever@oracle.com>,  "stable@vger.kernel.org"
 <stable@vger.kernel.org>,  Jeff Layton <jlayton@kernel.org>,  Yang Erkun
 <yangerkun@huawei.com>
Subject: Re: [PATCH v5 1/5] libfs: Return ENOSPC when the directory offset
 range is exhausted
In-Reply-To: <95d0b9296e3f48ffb79a1de0b95f4726@AcuMS.aculab.com> (David
	Laight's message of "Sun, 15 Dec 2024 19:35:57 +0000")
References: <20241215185816.1826975-1-cel@kernel.org>
	<20241215185816.1826975-2-cel@kernel.org>
	<95d0b9296e3f48ffb79a1de0b95f4726@AcuMS.aculab.com>
Date: Mon, 16 Dec 2024 13:39:06 +0000
Message-ID: <mafs0o71b21dx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Dec 15 2024, David Laight wrote:

> From: cel@kernel.org
>> Sent: 15 December 2024 18:58
>> 
>> From: Chuck Lever <chuck.lever@oracle.com>
>> 
>> Testing shows that the EBUSY error return from mtree_alloc_cyclic()
>> leaks into user space. The ERRORS section of "man creat(2)" says:
>> 
>> >	EBUSY	O_EXCL was specified in flags and pathname refers
>> >		to a block device that is in use by the system
>> >		(e.g., it is mounted).
>> 
>> ENOSPC is closer to what applications expect in this situation.
>> 
>> Note that the normal range of simple directory offset values is
>> 2..2^63, so hitting this error is going to be rare to impossible.
>> 
>> Fixes: 6faddda69f62 ("libfs: Add directory operations for stable offsets")
>> Cc: <stable@vger.kernel.org> # v6.9+
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>> Reviewed-by: Yang Erkun <yangerkun@huawei.com>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/libfs.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/fs/libfs.c b/fs/libfs.c
>> index 748ac5923154..f6d04c69f195 100644
>> --- a/fs/libfs.c
>> +++ b/fs/libfs.c
>> @@ -292,7 +292,9 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
>> 
>>  	ret = mtree_alloc_cyclic(&octx->mt, &offset, dentry, DIR_OFFSET_MIN,
>>  				 LONG_MAX, &octx->next_offset, GFP_KERNEL);
>> -	if (ret < 0)
>> +	if (unlikely(ret == -EBUSY))
>> +		return -ENOSPC;
>> +	if (unlikely(ret < 0))
>>  		return ret;
>
> You've just added an extra comparison to a hot path.
> Doing:
> 	if (ret < 0)
> 		return ret == -EBUSY ? -ENOSPC : ret;
> would be better.

This also has two comparisons: one for ret < 0 and another for ret ==
-EBUSY. So I don't see a difference. I was curious to see if compilers
can somehow optimize one or the other, so I ran the two on godbolt and I
see no real difference between the two: https://godbolt.org/z/9Gav6b6Mf

-- 
Regards,
Pratyush Yadav

