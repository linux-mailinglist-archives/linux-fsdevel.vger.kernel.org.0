Return-Path: <linux-fsdevel+bounces-70589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05803CA16A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 20:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7452B3002889
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 19:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCC5325735;
	Wed,  3 Dec 2025 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMpOx5U0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291A4316184;
	Wed,  3 Dec 2025 19:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764790503; cv=none; b=NhXhIQM1RriS9bDe5Ep5HCt36uCq/0D5Jlj1fSu/bGVLPx9ml/YXm2Y99y3JRr/wqQETURZLXcA6DAPm9DSsoZe5vR1SonhZc4QowPcKucGYR4pNy6kNz69yalby/SiBX1J86XiHDXrEuY+3wVl/E1EvsnoUm1e+XrS/0/z4D58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764790503; c=relaxed/simple;
	bh=yW8wL8LE2AZ9Pp3nc5eXQNh9A5Z+GhYj0dSwhIj9Dog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jsN8D1Brhtyyq6wHkxnjIvNuijAredAXgUYDp8AKXaKXhvV40YvW4xML9Twb4VBlIXSPqckYBB6PaHHFgXGVZUdilyfSxibzKss+kG1d6KMzbKsOMSP6yDEasE7OWmfHZjX9kI5UiM0kC9hp+dC2PHyaVbpGmhg5utXyKsTeUvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMpOx5U0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AEEC19422;
	Wed,  3 Dec 2025 19:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764790502;
	bh=yW8wL8LE2AZ9Pp3nc5eXQNh9A5Z+GhYj0dSwhIj9Dog=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pMpOx5U0U0lbF7J8EUTR91x3VgtfHdvGGOy7CxVJstVPcDn1PfH2wgsF2qkzFl1pf
	 wcf9Z+5xUUmrOclI015pNdokXiiE9eAX6iBTCUDs3whc/D68yhM8RjIY+OOb3ba6dJ
	 nX6Dp94nL6ndVsNnLI9vLSvkCYqJzEk5lOGXXhRnAmv2Ckj8vF8W/0RYmNQe5Qp8YI
	 8bW1ja3wG9zhqAAY3PDYL2pE8d/e6T10gQCK2ppYczcrW+hQxDhzkw6QcSnwtzKrEg
	 iCVdA/bR0RStnUi0Pz/HdGayD52wSAP9fzZ6G5XnxSBzxMrJBKiNk+PULR7/cyYUbd
	 Zgiwkn6EPkKKg==
Message-ID: <a5da76b6-6b84-42b7-a9c5-8f271a546af1@kernel.org>
Date: Wed, 3 Dec 2025 14:35:00 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] filelock: add lease_dispose_list() helper
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>,
 Alexander Aring <alex.aring@gmail.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jonathan Corbet <corbet@lwn.net>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251201-dir-deleg-ro-v1-0-2e32cf2df9b7@kernel.org>
 <20251201-dir-deleg-ro-v1-1-2e32cf2df9b7@kernel.org>
 <9a6f7f4b-dc45-4288-a8ee-6dcaabd19eb9@app.fastmail.com>
 <697eb0d57f34882317e1f5cd73951f1e3b1e3175.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <697eb0d57f34882317e1f5cd73951f1e3b1e3175.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/25 2:33 PM, Jeff Layton wrote:
> On Wed, 2025-12-03 at 13:55 -0500, Chuck Lever wrote:
>>
>> On Mon, Dec 1, 2025, at 10:08 AM, Jeff Layton wrote:
>>> ...and call that from the lease handling code instead of
>>> locks_dispose_list(). Remove the lease handling parts from
>>> locks_dispose_list().
>>
>> The actual change here isn't bothering me, but I'm having trouble
>> understanding why it's needed. It doesn't appear to be a strict
>> functional prerequisite for 2/2.
>>
> 
> It's not. We can table this patch for now if that's preferable, but I
> do think it's a worthwhile cleanup.
>  
>> A little more context in the commit message would be helpful.
>> Sample commit description:
>>
>>   The lease-handling code paths always know they're disposing of leases,
>>   yet locks_dispose_list() checks flags at runtime to determine whether
>>   to call locks_free_lease() or locks_free_lock().
>>
>>   Split out a dedicated lease_dispose_list() helper for lease code paths.
>>   This makes the type handling explicit and prepares for the upcoming
>>   lease_manager enhancements where lease-specific operations are being
>>   consolidated.
>>
> 
> I may crib this if I end up resending it.
> 
>> But that reflects only my naive understanding of the patch. You
>> might have something else in mind.
>>
>>
> 
> Nope, no ulterior motive here. It's just a nice to have cleanup that
> helps to further separate the lock and lease handling code.

Yep, it's a good clean-up.


>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>>  fs/locks.c | 29 +++++++++++++++++++----------
>>>  1 file changed, 19 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/fs/locks.c b/fs/locks.c
>>> index 
>>> 7f4ccc7974bc8d3e82500ee692c6520b53f2280f..e974f8e180fe48682a271af4f143e6bc8e9c4d3b 
>>> 100644
>>> --- a/fs/locks.c
>>> +++ b/fs/locks.c
>>> @@ -369,10 +369,19 @@ locks_dispose_list(struct list_head *dispose)
>>>  	while (!list_empty(dispose)) {
>>>  		flc = list_first_entry(dispose, struct file_lock_core, flc_list);
>>>  		list_del_init(&flc->flc_list);
>>> -		if (flc->flc_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT))
>>> -			locks_free_lease(file_lease(flc));
>>> -		else
>>> -			locks_free_lock(file_lock(flc));
>>> +		locks_free_lock(file_lock(flc));
>>> +	}
>>> +}
>>> +
>>> +static void
>>> +lease_dispose_list(struct list_head *dispose)
>>> +{
>>> +	struct file_lock_core *flc;
>>> +
>>> +	while (!list_empty(dispose)) {
>>> +		flc = list_first_entry(dispose, struct file_lock_core, flc_list);
>>> +		list_del_init(&flc->flc_list);
>>> +		locks_free_lease(file_lease(flc));
>>>  	}
>>>  }
>>>
>>> @@ -1620,7 +1629,7 @@ int __break_lease(struct inode *inode, unsigned int flags)
>>>  	spin_unlock(&ctx->flc_lock);
>>>  	percpu_up_read(&file_rwsem);
>>>
>>> -	locks_dispose_list(&dispose);
>>> +	lease_dispose_list(&dispose);
>>>  	error = wait_event_interruptible_timeout(new_fl->c.flc_wait,
>>>  						 list_empty(&new_fl->c.flc_blocked_member),
>>>  						 break_time);
>>> @@ -1643,7 +1652,7 @@ int __break_lease(struct inode *inode, unsigned 
>>> int flags)
>>>  out:
>>>  	spin_unlock(&ctx->flc_lock);
>>>  	percpu_up_read(&file_rwsem);
>>> -	locks_dispose_list(&dispose);
>>> +	lease_dispose_list(&dispose);
>>>  free_lock:
>>>  	locks_free_lease(new_fl);
>>>  	return error;
>>> @@ -1726,7 +1735,7 @@ static int __fcntl_getlease(struct file *filp, 
>>> unsigned int flavor)
>>>  		spin_unlock(&ctx->flc_lock);
>>>  		percpu_up_read(&file_rwsem);
>>>
>>> -		locks_dispose_list(&dispose);
>>> +		lease_dispose_list(&dispose);
>>>  	}
>>>  	return type;
>>>  }
>>> @@ -1895,7 +1904,7 @@ generic_add_lease(struct file *filp, int arg, 
>>> struct file_lease **flp, void **pr
>>>  out:
>>>  	spin_unlock(&ctx->flc_lock);
>>>  	percpu_up_read(&file_rwsem);
>>> -	locks_dispose_list(&dispose);
>>> +	lease_dispose_list(&dispose);
>>>  	if (is_deleg)
>>>  		inode_unlock(inode);
>>>  	if (!error && !my_fl)
>>> @@ -1931,7 +1940,7 @@ static int generic_delete_lease(struct file 
>>> *filp, void *owner)
>>>  		error = fl->fl_lmops->lm_change(victim, F_UNLCK, &dispose);
>>>  	spin_unlock(&ctx->flc_lock);
>>>  	percpu_up_read(&file_rwsem);
>>> -	locks_dispose_list(&dispose);
>>> +	lease_dispose_list(&dispose);
>>>  	return error;
>>>  }
>>>
>>> @@ -2726,7 +2735,7 @@ locks_remove_lease(struct file *filp, struct 
>>> file_lock_context *ctx)
>>>  	spin_unlock(&ctx->flc_lock);
>>>  	percpu_up_read(&file_rwsem);
>>>
>>> -	locks_dispose_list(&dispose);
>>> +	lease_dispose_list(&dispose);
>>>  }
>>>
>>>  /*
>>>
>>> -- 
>>> 2.52.0
> 


-- 
Chuck Lever

