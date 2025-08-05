Return-Path: <linux-fsdevel+bounces-56791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BE5B1BA5E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 20:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED37518A6FDF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 18:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D120299943;
	Tue,  5 Aug 2025 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Sm5P3yQB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DC319E98C;
	Tue,  5 Aug 2025 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419247; cv=none; b=QsVeql9i6jVkkqdYIE7L0FQn4iu2HHurIXPUy9lpqbChQF1mqkV5vQs7RUXQGHJYUHqMfrkc4+uQ6mw0GBV4ssWUxR6nNNUkYKF9SwY6gyB+xpuPoXrbwOLSXMvm8uw70KqgKMpoLVXmIBrUDyCTUqshZk5j6RU+eKHrOcnDCWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419247; c=relaxed/simple;
	bh=sIPUeNyn51MwQcRen63qFH0M1zxVZVeGRf5hgQsJ3fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R9XZTdEk6hinu1cyoJNMTiTvf+uYZPCIVhVMHKcxPCIiMzNCQHZ7iRMWHCK+bVd92jE/d6Z89UO3WEjUQFhPdfSYxYUCuKGcOcwn8MSkVftZmqcz3gF7zld+X2owe+UXwie2h5XlYpJV0b7+7+41+01h2CDCweNVhHpI9q3ceRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Sm5P3yQB; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KciQmJIXbw07cDbx+i2HzfhTEtup2QyBKXkEWtonmtc=; b=Sm5P3yQBIShc3zbeTt7E+XdS+4
	EvScx9z/vp+XzZyTDaceoPdtZEEONqTBWAJmzcnrq/dgKqSSfRNulm9/9u+X+DlQCXeGcG8RqgWy4
	rOlvq4/iFI9fDTruD3xWZcU+KgQUtWRnyv4/5SvgNOhAMzkogNWL4W/a2d/wRmQ+O8I1wnUVOHzcq
	DukqLYB7KBmY4Mjhd6aZB9JsqEKJ/8Kem+uSWZJmjPmiyxciOIKL+Tae/4vScNEe8Y4g3rGHlRcFN
	UsqBN9+3lcGGcDBivDOfM3wXgv/DA13t+5Pl2VjWXp+dVKKw4wG/C0L63CcWeYw5M6famlVX8SdMX
	WBpcoxpA==;
Received: from [191.204.199.202] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1ujMaP-00A38z-Qu; Tue, 05 Aug 2025 20:40:34 +0200
Message-ID: <f5ea7370-c8c3-47c2-88cb-9740d82e87c6@igalia.com>
Date: Tue, 5 Aug 2025 15:40:28 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 2/8] ovl: Create ovl_strcmp() with casefold support
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 Theodore Tso <tytso@mit.edu>, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 kernel-dev@igalia.com
References: <20250805-tonyk-overlayfs-v2-0-0e54281da318@igalia.com>
 <20250805-tonyk-overlayfs-v2-2-0e54281da318@igalia.com>
 <87o6stakb6.fsf@mailhost.krisman.be>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <87o6stakb6.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Gabriel!

Em 05/08/2025 11:56, Gabriel Krisman Bertazi escreveu:
> André Almeida <andrealmeid@igalia.com> writes:
> 
>> To add overlayfs support casefold filesystems, create a new function
>> ovl_strcmp() with support for casefold names.
>>
>> If the ovl_cache_entry have stored a casefold name, use it and create
>> a casfold version of the name that is going to be compared to.
>>
>> For the casefold support, just comparing the strings does not work
>> because we need the dentry enconding, so make this function find the
>> equivalent dentry for a giving directory, if any.
>>
>> As this function is used for search and insertion in the red-black tree,
>> that means that the tree node keys are going to be the casefolded
>> version of the dentry's names. Otherwise, the search would not work for
>> case-insensitive mount points.
>>
>> For the non-casefold names, nothing changes.
>>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>> ---
>> I wonder what should be done here if kmalloc fails, if the strcmp()
>> should fail as well or just fallback to the normal name?
>> ---
>>   fs/overlayfs/readdir.c | 42 ++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 40 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
>> index 83bca1bcb0488461b08effa70b32ff2fefba134e..1b8eb10e72a229ade40d18795746d3c779797a06 100644
>> --- a/fs/overlayfs/readdir.c
>> +++ b/fs/overlayfs/readdir.c
>> @@ -72,6 +72,44 @@ static struct ovl_cache_entry *ovl_cache_entry_from_node(struct rb_node *n)
>>   	return rb_entry(n, struct ovl_cache_entry, node);
>>   }
>>   
>> +/*
>> + * Compare a string with a cache entry, with support for casefold names.
>> + */
>> +static int ovl_strcmp(const char *str, struct ovl_cache_entry *p, int len)
>> +{
> 
> Why do you need to re-casefold str on every call to ovl_strcmp?  Isn't
> it done in a loop while walking the rbtree with a constant "str" (i.e.,
> the name being added, see ovl_cache_entry_find)? Can't you do it once,
> outside of ovl_strcmp? This way you don't repeatedly allocate/free
> memory for each node of the tree (as Viro mentioned), and you don't have
> to deal with kmalloc failures here.
> 

Yes, that's a more reasonable approach, I will do it for v3

>> +
>> +	const struct qstr qstr = { .name = str, .len = len };
>> +	const char *p_name = p->name, *name = str;
>> +	char *dst = NULL;
>> +	int cmp, cf_len;
>> +
>> +	if (p->cf_name)
>> +		p_name = p->cf_name;
> 
> This should check IS_ENABLED(CONFIG_UNICODE) so it can be
> compiled out by anyone doing CONFIG_UNICODE=n
> 
>> +
>> +	if (p->map && !is_dot_dotdot(str, len)) {
>> +		dst = kmalloc(OVL_NAME_LEN, GFP_KERNEL);
>> +
>> +		/*
>> +		 * strcmp can't fail, so we fallback to the use the original
>> +		 * name
>> +		 */
>> +		if (dst) {
>> +			cf_len = utf8_casefold(p->map, &qstr, dst, OVL_NAME_LEN);
> 
> utf8_casefold can fail, as you know and checked.  But if it does, a
> negative cf_len is passed to strncmp and cast to a very high
> value.
> 

ops, that's right, thanks for the feedback!

