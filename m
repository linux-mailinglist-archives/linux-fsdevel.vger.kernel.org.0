Return-Path: <linux-fsdevel+bounces-71341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21319CBE5B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 15:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACD48301B81D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 14:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2337D33FE1A;
	Mon, 15 Dec 2025 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t0NoRFkg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8691D33E36A
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 14:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808281; cv=none; b=juCoHY4Lo6twQgBi0eXlUAtbX7n1gXTXANG9AOSwjL7KLUHgijcUSXQ7dvSCdnsUszPs8Jn+NX0cwnenCK8I43YYCerG7HIw8UyG/9pVU5bncFv8YKS20dWlNPjE83Lx7WlTFg1TGoQsCikUdTnfQLzyC4bEpSm9hzy/XhpDcpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808281; c=relaxed/simple;
	bh=DVXX00EvWSkvKgIKYW6V02V2bN4a5dGFmPLMTUDmkgs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kahjBx5M2UNLAJgM6lje1gAYPKCGwi3M1OCHoICZcg6yzpLJi+sJsP+31iLofYc3H3O/jvi7mnqzHCwFiU5pLQ7ZW62SlBkRznBvvYAYPpztb4UjTwouOTumw2ezL5Y0p2SBGC1PftPDIuuXrzS0nBtWt8CRzcHS+ugeRf28wuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t0NoRFkg; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765808270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2w9jfozl4pegwTIhi1nuDTYSt+1YDok7xKyhV+Gat4I=;
	b=t0NoRFkg+xVOYewT1Y/OXijRVKM/ZqYjS8HJrH1HTlaezWGTsc35M625VSofKi/f9rZsZs
	WRLqDOe07blna9I6pzr5ONssUa4diF2k6iCX7qp7f5aJ4G/CR+OG2XLKKtg42yRp4OG2iv
	hq3HT3mshKUzlmhOgoij/cxxKXBRFB4=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] namespace: Replace simple_strtoul with kstrtoul to parse
 boot params
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <3hnvigpwa2jomy6wimsdkkz4da64x7nsk4ffoko47ocpokqbou@fqymwie5damt>
Date: Mon, 15 Dec 2025 15:17:14 +0100
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <E07BDF4C-F76A-4050-A4B9-3D2A362A3ABE@linux.dev>
References: <20251214153141.218953-2-thorsten.blum@linux.dev>
 <3hnvigpwa2jomy6wimsdkkz4da64x7nsk4ffoko47ocpokqbou@fqymwie5damt>
To: Jan Kara <jack@suse.cz>
X-Migadu-Flow: FLOW_OUT

On 15. Dec 2025, at 10:15, Jan Kara wrote:
> On Sun 14-12-25 16:31:42, Thorsten Blum wrote:
>> Replace simple_strtoul() with the recommended kstrtoul() for parsing the
>> 'mhash_entries=' and 'mphash_entries=' boot parameters.
>> 
>> Check the return value of kstrtoul() and reject invalid values. This
>> adds error handling while preserving behavior for existing values, and
>> removes use of the deprecated simple_strtoul() helper.
>> 
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> ...
> 
>> @@ -49,20 +49,14 @@ static unsigned int mp_hash_shift __ro_after_init;
>> static __initdata unsigned long mhash_entries;
>> static int __init set_mhash_entries(char *str)
>> {
>> -	if (!str)
>> -		return 0;
>> -	mhash_entries = simple_strtoul(str, &str, 0);
>> -	return 1;
>> +	return kstrtoul(str, 0, &mhash_entries) == 0;
>> }
>> __setup("mhash_entries=", set_mhash_entries);
> 
> I'm not very experienced with the cmdline option parsing but AFAICT the
> 'str' argument can be indeed NULL and kstrtoul() will not be happy with
> that?

I don't think 'str' can be NULL. If you don't pass a value, 'str' will
be the empty string (just tested this).

Thanks,
Thorsten


