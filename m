Return-Path: <linux-fsdevel+bounces-60234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A2AB42F50
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 04:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71011B2877C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 02:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1EC13A3ED;
	Thu,  4 Sep 2025 02:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CKzHmoI7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9D02566
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 02:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756951266; cv=none; b=c+eEffAE+a9g9c4A8cMfirXLQRIdo+237m4YGcXhyjf3VRfGjVyj0fUuW8uqm5t5gmdSFeUMfUr0YMnlNCFAmz9AU2picWDiQIvUwRZLReaQVClLSfqL6bpnFuwIpGpatnE/IY0Fv4Z2Uwhm8iUpnLS/bcPnxMJIb8N42PmfLFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756951266; c=relaxed/simple;
	bh=E768eqlK9YiPR10vf4wEb38eH9NH/II/u7fAPmFVCew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XPVeLmJCcD292ZeH8dIvunibQxks17SFemQdhkvFtUTRi1eTORpdDwN6LaObVOB8eGiR+ieGT8gwB5J5//XqsrRhrA5q2qcqQ/bpn+L9nVc8PFkR+3jkdnD+AynIVSFfAhms5hfLzAQ1guttejKldpmpfcZrN4BlsuJJhzJZd8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CKzHmoI7; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756951252; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6KmPdKYb3riZNYxU80tu/VKKjiK9KUlhqqO6iMJL4/o=;
	b=CKzHmoI7hriOx/uDS+SDlh6VtXzz5wC1iLn+gOJ4ddacNHceJckBX+zp6ymZ9hsroo8b7jEICoJ8Wbs9Gej4JVoJNS0u3UAE1/C2l22SmsQV985TEm8a8fTYMTEEGSrnLF+PeAJ4JXTzgZreusGuAMxD0KDd/MSMf+V+jdKJ+sY=
Received: from 30.221.128.146(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WnDhqLM_1756951251 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Sep 2025 10:00:51 +0800
Message-ID: <fb935507-a905-4e87-8cdc-32e2b2dc67d4@linux.alibaba.com>
Date: Thu, 4 Sep 2025 10:00:50 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [WIP RFC PATCH] fs: retire I_WILL_FREE
To: Mateusz Guzik <mjguzik@gmail.com>,
 Mark Tinguely <mark.tinguely@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, ocfs2-devel@lists.linux.dev,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20250902145428.456510-1-mjguzik@gmail.com>
 <aLe5tIMaTOPEUaWe@casper.infradead.org>
 <d40d8e00-cafb-4b0d-9d5e-f30a05255e5f@oracle.com>
 <CAGudoHE4QqJ-m1puk_vk4mdpMHDiV1gpihE7X8SE=bvbwQyjKg@mail.gmail.com>
 <CAGudoHFKmXJGRPedZ9Fq6jnfbiHzSwezd3Lr0uCbP7izs4dhGw@mail.gmail.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <CAGudoHFKmXJGRPedZ9Fq6jnfbiHzSwezd3Lr0uCbP7izs4dhGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 2025/9/3 23:19, Mateusz Guzik wrote:
> On Wed, Sep 3, 2025 at 5:16 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
>>
>> On Wed, Sep 3, 2025 at 4:03 PM Mark Tinguely <mark.tinguely@oracle.com> wrote:
>>>
>>> On 9/2/25 10:44 PM, Matthew Wilcox wrote:
>>>> On Tue, Sep 02, 2025 at 04:54:28PM +0200, Mateusz Guzik wrote:
>>>>> Following up on my response to the refcount patchset, here is a churn
>>>>> patch to retire I_WILL_FREE.
>>>>>
>>>>> The only consumer is the drop inode routine in ocfs2.
>>>>
>>>> If the only consumer is ocfs2 ... then you should cc the ocfs2 people,
>>>> right?
>>>>
>>
>> Fair point, I just copy pasted the list from the patchset, too sloppy.
>>
>>>>> For the life of me I could not figure out if write_inode_now() is legal
>>>>> to call in ->evict_inode later and have no means to test, so I devised a
>>>>> hack: let the fs set I_FREEING ahead of time. Also note iput_final()
>>>>> issues write_inode_now() anyway but only for the !drop case, which is the
>>>>> opposite of what is being returned.
>>>>>
>>>>> One could further hack around it by having ocfs2 return *DON'T* drop but
>>>>> also set I_DONTCACHE, which would result in both issuing the write in
>>>>> iput_final() and dropping. I think the hack I did implement is cleaner.
>>>>> Preferred option is ->evict_inode from ocfs handling the i/o, but per
>>>>> the above I don't know how to do it.
>>>
>>> I am a lurker in this series and ocfs2. My history has been mostly in
>>> XFS/CXFS/DMAPI. I removed the other CC entries because I did not want
>>> to blast my opinion unnecessaially.
>>>
>>
>> Hello Mark,
>>
>> This needs the opinion of the vfs folk though, so I'm adding some of
>> the cc list back. ;)
>>
>>> The flushing in ocfs2_drop_inode() predates the I_DONTCACHE addition.
>>> IMO, it would be safest and best to maintain to let ocfs2_drop_inode()
>>> return 0 and set I_DONTCACHE and let iput_final() do the correct thing.
>>>
>>
> 
> wow, I'm sorry for really bad case of engrish in the mail. some of it
> gets slightly corrected below.
> 
>> For now that would indeed work in the sense of providing the expected
>> behavior, but there is the obvious mismatch of the filesystem claiming
>> the inode should not be dropped (by returning 0) and but using a side
>> indicator to drop it anyway. This looks like a split-brain scenario
>> and sooner or later someone is going to complain about it when they do
>> other work in iput_final(). If I was maintaining the layer I would
>> reject the idea, but if the actual gatekeepers are fine with it...
>>
>> The absolute best thing to do long run is to move the i/o in
>> ->evict_inode, but someone familiar with the APIs here would do the
>> needful(tm) and that's not me.
> 
> I mean the best thing to do in the long run is to move the the write
> to ->evict_inode, but I don't know how to do it and don't have any
> means to test ocfs2 anyway. Hopefully the ocfs2 folk will be willing
> to sort this out?
> 
Blame the histroy, I've found this commit:
513e2dae9422 ("ocfs2: flush inode data to disk and free inode when
i_count becomes zero")

It just make drop immediately and move up write_node_now() into
drop_inode(). So IMO, it looks fine for ocfs2 if setting I_FREEING
before write_inode_now() is safe.

Thanks,
Joseph



