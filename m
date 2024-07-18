Return-Path: <linux-fsdevel+bounces-23962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F35AA937051
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 23:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4751F22849
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 21:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C119145FF9;
	Thu, 18 Jul 2024 21:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aI/HQQMY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5273913DDAA
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 21:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721339839; cv=none; b=ngF+ROq0CTHZw4Iq8C3zWGHRwObIyNXl5pzkv5Km5KY9UDJRq6SaB6ewwuiMFCb/O04cNRPfQiWCq3YQBh+CPA/D7k9aYW+mwLRJv+9evTpmb6hPdPjjMXt3A5t5cTByPoV+llgNx7q7Whgd90EFAXyYEH89Ld34rluLthn0Omw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721339839; c=relaxed/simple;
	bh=ogHknSejCorWhlB/t4mBO3MMBpcZB1DkyMXAoSQrImg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W5L83xGztdFWWL2UQdpaWqFW3y8NevCvBi+XMZhbHTx5Nro9W7dsqIPASZ/XZgLzJKkB3FZUKCqcAXSCCAeZkX5O7Fcpg15UisK0pmFlOqPDtgLmFGfWT1BDp0eeHuKp0vpBNOkBZdExWJsvLv6Nm/Nd3h8PjTnbLhJ64msyUBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aI/HQQMY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721339836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJ6vFpLli/kfgHJpi8uPI81PNlMpZh0cEDyy0hSnSes=;
	b=aI/HQQMYrd4VytaWDiLiH9DUMrk9yjSwjHVWufBXMWSMc+zCK0z0GZNwxqmUqie7PZ1LwZ
	obxpucmdlnLv0+aj2NZIfVF3YSJa9Uhl/fWlMnSkxpzJVFzy7NwurTBx0UdOPpySYHW7hA
	zVyS5UIUW895myn/EstjfgaU/uR91es=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-TctQkS6jNbWx0Tw5SMvQUg-1; Thu,
 18 Jul 2024 17:57:12 -0400
X-MC-Unique: TctQkS6jNbWx0Tw5SMvQUg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EAB27195609E;
	Thu, 18 Jul 2024 21:57:09 +0000 (UTC)
Received: from [10.22.32.50] (unknown [10.22.32.50])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5F53D1955D42;
	Thu, 18 Jul 2024 21:57:08 +0000 (UTC)
Message-ID: <e6132b5a-813e-4bb8-a096-7ca4f0b3cc45@redhat.com>
Date: Thu, 18 Jul 2024 17:57:07 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bcachefs changes for 6.11
To: Matthew Wilcox <willy@infradead.org>,
 Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <r75jqqdjp24gikil2l26wwtxdxvqxpgfaixb2rqmuyzxnbhseq@6k34emck64hv>
 <CAHk-=wigjHuE2OPyuT6GK66BcQSAukSp0sm8vYvVJeB7+V+ecQ@mail.gmail.com>
 <5ypgzehnp2b3z2e5qfu2ezdtyk4dc4gnlvme54hm77aypl3flj@xlpjs7dbmkwu>
 <ZpmItplPA5_zmAmC@casper.infradead.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZpmItplPA5_zmAmC@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


On 7/18/24 17:27, Matthew Wilcox wrote:
> On Thu, Jul 18, 2024 at 05:20:54PM -0400, Kent Overstreet wrote:
>> From: Kent Overstreet <kent.overstreet@linux.dev>
>> Date: Thu, 18 Jul 2024 17:17:10 -0400
>> Subject: [PATCH] lockdep: Add comments for lockdep_set_no{validate,track}_class()
>>
>> Cc: Waiman Long <longman@redhat.com>
>> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
>>
>> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
>> index b76f1bcd2f7f..bdfbdb210fd7 100644
>> --- a/include/linux/lockdep.h
>> +++ b/include/linux/lockdep.h
>> @@ -178,9 +178,22 @@ static inline void lockdep_init_map(struct lockdep_map *lock, const char *name,
>>   			      (lock)->dep_map.wait_type_outer,		\
>>   			      (lock)->dep_map.lock_type)
>>   
>> +/**
>> + * lockdep_set_novalidate_class: disable checking of lock ordering on a given
>> + * lock
>> + *
>> + * Lockdep will still record that this lock has been taken, and print held
>> + * instances when dumping locks
>> + */
> Might want to run this through kernel-doc.  I'm pretty sure it wants
> macro comments to be formatted like function comments.  ie:
>
> /**
>   * lockdep_set_novalidate_class - Disable lock order checks on this lock.
>   * @lock: The lock to disable order checks for.
>   *
>   * Lockdep will still record that this lock has been taken, and print held
>   * instances when dumping locks.
>   */
>
>>   #define lockdep_set_novalidate_class(lock) \
>>   	lockdep_set_class_and_name(lock, &__lockdep_no_validate__, #lock)

Yes, that is true. It is not in the proper kernel-doc format. Either use 
the proper format or use a single "*" instead.

Cheers,
Longman


