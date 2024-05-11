Return-Path: <linux-fsdevel+bounces-19300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C26878C2F95
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 06:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57F02B23275
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 04:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6DF374C2;
	Sat, 11 May 2024 04:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAUZrh/3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AB827452
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 04:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715403269; cv=none; b=RXDpbmIUlQvlY4LBEijuSYSfeIgZKn6DDcb/zxTOM/BuUYBRXMdzHi3jo3y0rJ+7CdWKWRVHdX9TRMKmqBr8wJJmJg/yhQQWEUg8ry1/zT4QyBD+NUaM9+vmjym3NX3jq35b58SxpkVGcvQwNzXjY5WfKzjj/1wnvtS35Ver8Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715403269; c=relaxed/simple;
	bh=PZxvjCwkmqy4Kk1WbdE0dtHt9EvxAkHlndSZ9qp4B30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptVrsmkpTUXlE5fqWG/l//j1ZCwH77UAOstFWeYhJSdFkFGXmbT6VfIabvGW/SYEMVhysK+YEZbTo4g0nfEzrYktKyUZuh3XAmLeOQMLoJIiBjmsyQi0XD0pkEMhRxeuCRX8whJPmguWyUtcrgvdc6AHk3r/ItuD2LFnz16hnU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fAUZrh/3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715403266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CnT7Dx+BR0GDqsz6yMdUQPXrBQN26c3ziycSek6jPTI=;
	b=fAUZrh/3P+D0Az1Kex/4kEI843rrrxzYsKENSMwMbwl92mqxWP/HiRrTCtgJJVSvwa8WnQ
	gAdUNCI/Doa2ndhdlkUXQnisEzvMbr0IWs4gnVwaUxlblj8mDaURCs0z7qePkPbRVmmnq4
	k9FHSxjmhrSzTY8CO/BymR9bLLChKtY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-RTGsDTnsP3GglgEFNj75Zw-1; Sat,
 11 May 2024 00:54:20 -0400
X-MC-Unique: RTGsDTnsP3GglgEFNj75Zw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1CDE23806735;
	Sat, 11 May 2024 04:54:20 +0000 (UTC)
Received: from [10.22.8.62] (unknown [10.22.8.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0BA6A2A8101;
	Sat, 11 May 2024 04:54:18 +0000 (UTC)
Message-ID: <bed71a80-b701-4d04-bf30-84f189c41b2c@redhat.com>
Date: Sat, 11 May 2024 00:54:18 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fs: dcache: Delete the associated dentry when
 deleting a file
To: Yafang Shao <laoar.shao@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, Wangkai <wangkai86@huawei.com>,
 Colin Walters <walters@verbum.org>
References: <20240511022729.35144-1-laoar.shao@gmail.com>
 <CAHk-=wjs8MYigx695jk4dvF2vVPQa92K9fW_e6Li-Czt=wEGYw@mail.gmail.com>
 <CALOAHbCECWqpFzreANpvQJADicRr=AbP-nAymSEeUzUr3vGZMg@mail.gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CALOAHbCECWqpFzreANpvQJADicRr=AbP-nAymSEeUzUr3vGZMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 5/10/24 23:35, Yafang Shao wrote:
>> pointless (because the dentry won't be reused, so DCACHE_CANT_MOUNT
>> just won't matter).
>>
>> I do worry that there are loads that actually love our current
>> behavior, but maybe it's worth doing the simple unconditional "make
>> d_delete() always unhash" and only worry about whether that causes
>> performance problems for people who commonly create a new file in its
>> place when we get such a report.
>>
>> IOW, the more complex thing might be to actually take other behavior
>> into account (eg "do we have so many negative dentries that we really
>> don't want to create new ones").
> This poses a substantial challenge. Despite recurrent discussions
> within the community about improving negative dentry over and over,
> there hasn't been a consensus on how to address it.

I had suggested in the past to have a sysctl parameter to set a 
threshold on how many negative dentries (as a percentage of total system 
memory) are regarded as too many and activate some processes to control 
dentry creation. The hard part is to discard the oldest negative 
dentries as we can have many memcg LRU lists to look at and it can be a 
time consuming process. We could theoretically start removing dentries 
when removing files when 50% of the threshold is reached. At 100%, we 
start discarding old negative dentries. At 150%, we stop negative dentry 
creation altogether.

My 2 cents.

Cheers,
Longman


