Return-Path: <linux-fsdevel+bounces-56753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFCEB1B3ED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 15:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B8E44E2523
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 13:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29801A23A0;
	Tue,  5 Aug 2025 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="O1qhnFL+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7591F19A;
	Tue,  5 Aug 2025 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754398905; cv=none; b=CMh1uiWJOFFRPNf0dxVUqh9gRVBMT+nQ3VaUx1XbN2NxNk3YWhWAein+Dmz1dV8CQ2uQR8WJpoMdyIbgG2NUOKFYTDQT3M9QsKDKfsMoHnu6QcQ47Q0RkFpShErKUXH7y1Nqt4JGUw7nSxDT9JObYwGgH9EgeS91qyDHEQElcRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754398905; c=relaxed/simple;
	bh=ileFvsHjabfVRxw1MDew59PE6tMBoncnJbyg5LbwBxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s17KvZYf/c/XnEbczuRDAjvA63DNyNWj32krUjVOSLbfjQivpaA2FJSOy3gKjpEftnugOat4yB6EpV9FKtUQCylj1GNqL2t4gduSOtWgrztYoSzKG51vxNrCf9yG05itMViT+hvyLRGidGwGFu80BWynipbVnhD542hU3euT+sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=O1qhnFL+; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/d+dg7cO3eDA5tEQZRg19r22HlNvg8xOVpbz/n+a3rs=; b=O1qhnFL+ctBuAhiF816Luq6j6Q
	aGzeesnj4+K0R6mAOUEeDTpWhesEFbTjW6d4I4aLz5quxgDpgYIN/v1L3PkUKf47RIZLmg3bbjz1o
	rhwE072Xn0qGh3WTGLWWTSBwjjTxq9JWbO7LukuvPMQK4VPULCZJL20SjBSxlebm45rDDckd2ooVV
	t2jPp/rQMt41wLNI3cZWl7jyHzEpZTIbv/rnTUGgTfqcvQE1eAgQ9NFPC31RbvOrxzgm9tLKdjzdV
	iJhiwtS+eDs7Pcpx64B+e5K6nkEjLW61kIZNR8TZfwTy1nN7m5vFZeGpBfjlkUfHwZCovajUjNcRB
	mAeJVo5A==;
Received: from [191.204.199.202] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1ujHII-009hGF-DK; Tue, 05 Aug 2025 15:01:30 +0200
Message-ID: <a7f2500d-75db-4baa-9d87-07346839478d@igalia.com>
Date: Tue, 5 Aug 2025 10:01:25 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 2/8] ovl: Create ovl_strcmp() with casefold support
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 Theodore Tso <tytso@mit.edu>, Gabriel Krisman Bertazi <krisman@kernel.org>,
 linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, kernel-dev@igalia.com
References: <20250805-tonyk-overlayfs-v2-0-0e54281da318@igalia.com>
 <20250805-tonyk-overlayfs-v2-2-0e54281da318@igalia.com>
 <20250805050809.GA222315@ZenIV>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20250805050809.GA222315@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 05/08/2025 02:08, Al Viro escreveu:
> On Tue, Aug 05, 2025 at 12:09:06AM -0300, André Almeida wrote:
> 
>> +static int ovl_strcmp(const char *str, struct ovl_cache_entry *p, int len)
> 
>> +	if (p->map && !is_dot_dotdot(str, len)) {
>> +		dst = kmalloc(OVL_NAME_LEN, GFP_KERNEL);
> 
> ...`
> 
>> +	kfree(dst);
>> +
>> +	return cmp;
>> +}
>> +
> 
>> @@ -107,7 +145,7 @@ static struct ovl_cache_entry *ovl_cache_entry_find(struct rb_root *root,
>>   	while (node) {
>>   		struct ovl_cache_entry *p = ovl_cache_entry_from_node(node);
>>   
>> -		cmp = strncmp(name, p->name, len);
>> +		cmp = ovl_strcmp(name, p, len);
>>   		if (cmp > 0)
>>   			node = p->node.rb_right;
>>   		else if (cmp < 0 || len < p->len)
> 
> Am I misreading that, or do really we get a kmalloc()/kfree() for each
> sodding tree node we traverse on rbtree lookup here?

Yes, this is what's implemented here, as it is. Alternatively, I could 
allocate one buffer prior to the rbtree search/insert to be reused, and 
free it later... I going to add that for the v3.

