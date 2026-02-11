Return-Path: <linux-fsdevel+bounces-76944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPuQNXaGjGmfqAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 14:39:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8652C124D86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 14:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A618302A073
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 13:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308A0287265;
	Wed, 11 Feb 2026 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHkWlHHr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFE127E076
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770817112; cv=none; b=SMsRC+RkyZQnx7on07g2n6r0Du87XmEqN64tOHpsyp0fa38vii4C+H6w2oHqCdxsQTRmx+fxNcTG0mm+e2UhF+NkU0jRVjsdSJk5vHESUD2qwXBv5HUX1Ii/tLsI5INt/na0EQbT1f+5vIu7uYlR8gmwsQGuJQxe5MEV6ayiF7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770817112; c=relaxed/simple;
	bh=3kr/X7EVzbCTl45y7tiiOecsEIRUyFN7X9DQHGs+Djw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FaWYjGhVRFvkCIu2QDflHvQhQDb+iBm5H4wDD1Pa1hlQcDYkUJbwnAD2NN8qldMJjmiXrqwE0V6GuzoBUr8qTejvvzKy6KlENH37HWQY+OwCMjedS39lavGiKiv+N3PUYr8oq27UnEf2Vd2dG0ru32lEWhiXKrhzlHKbTdX1lv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHkWlHHr; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aadac3e23dso18573535ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 05:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770817111; x=1771421911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMvjs/DsalGRLabtIAjuej/4mud68+thdemO/4XZvPQ=;
        b=AHkWlHHrzG1//Ut+UL6Z/5E5mMAMvYW8I+7ejd9FiSADgrDion4MpMHIpZ/quKVck0
         fH6id4FvXkKgcjrMSv17i78K/uqgNRZbvg1FBS3JzyoGjUOW1/WIn9QFC7NocLkBD/kL
         EU1sCrDWp/iagvsU9HaTf9bX6uu4BC5hOUL6e45yHN8qTTDXFVV3bbpTJTYrqJiEBASl
         d5Hiy4AXu5mTVVTKJE3C0c2ViH6h1uFsI9q51cAC049vIrQnaF0Xkznuaju3T3P6qVmX
         dmRKE/+pvOl0nQuq2aPwDYa9g1aSrRuVHDSYW01ylFD16Yr5g3nXz7DFv+7SNT20ROY5
         kwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770817111; x=1771421911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMvjs/DsalGRLabtIAjuej/4mud68+thdemO/4XZvPQ=;
        b=g/AigRfyLjvte7ArIFOCB9S54nyZqk6XCBPoaX3/NEuaB3zUyt5gxGF5HH4YziW1vt
         KEr67zACBpMatElIOUDSpkCixcj5D5O60spgmj+5H9yx/227Gz1Ii++27VC4jFukbLlb
         8F6NxL3eYMXXCCp4NiRY9uXehE4PaWL7MI/KStF3bE7fIGeFG/CFVZTkZrSxKu8NfVdk
         DOCexAPRQQnvA4qPgGY7s0WXILF3w2SBAAlqF/TJY54Y+f2B/2TlwkIeAtvci77Vrtft
         yE31Fspfkm1Gcuc8HSdwTK+s9U5DIztGndtE7zk1SX1X/YGV8GowkK7ibkjBgNcSC/6s
         GTRg==
X-Forwarded-Encrypted: i=1; AJvYcCX5CmjhE68woVKEYTiC/WL+tZunYUlLRsvJv9b1i17mEpNK65Kr6Zl+LDxO7yZJNinNDqV6Hf45ffxRP6rO@vger.kernel.org
X-Gm-Message-State: AOJu0YwOIHjo9EiQb13mJlW+cSeEsk74JwjKDi0k3EHMaYw1QYVvQYcR
	AxquulTL/AqS/KZ9Jj+6dPcX1AuZMU6nknhJy/yIo4GQqhWj5ee0/b5t
X-Gm-Gg: AZuq6aK3q9oX5LKjfeoLKScSsnyHlo3cdnjHtrLBqYl5H8cE6faQDN8cJ8DmPIxvTJ3
	06+NcmthvIWbI0yp2/EZFLy2P3+rgtbVaFNeviAGXOo9+YcV925qPrtVMnB5PGZMD87nUFackKX
	HLADnqfz7e9espTeg0AiCBCS68+pdbs1f1hQOkRi2c86hUtKGiy4QYYzx5sNQ8tsn5lPRqGrVSu
	xWcXY1WJ5TcJua8ugFcgS9ydZIaASWnfBbnsAhW3nuA50m8hdBia+G2agfXblR+ZS2yVc8hHdj5
	Ac+FjPDMEdUOJVdZ71Gz/BhIHNcFtzPC+YPseLJpqkNfypPPl3D2dBEolLIchvSgPjlxKQ53rC5
	G+VwQwqKEct38qwZwhtGah26E+lCEd2cS3tX7vSFBVgVlYMfqJ8tjEiHY+nGFxnK/7HRcrE9rMY
	SDMDu+QATXYcE7RoalK+Ct9zTYVbkr/PKbZIVXgzci+f7nZ3iE4paAkuncnjUp1CqKpDMbBgxHw
	Q==
X-Received: by 2002:a17:902:ce90:b0:2a9:5c0b:e5d3 with SMTP id d9443c01a7336-2ab278045ebmr24703725ad.20.1770817110987;
        Wed, 11 Feb 2026 05:38:30 -0800 (PST)
Received: from ?IPV6:240e:390:a90:6d21:e579:6116:b665:1484? ([240e:390:a90:6d21:e579:6116:b665:1484])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2984c0d8sm28723825ad.13.2026.02.11.05.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 05:38:30 -0800 (PST)
Message-ID: <b77acdf8-0320-4f69-8478-0e2665a0755a@gmail.com>
Date: Wed, 11 Feb 2026 21:38:23 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 03/22] ext4: only order data when partially block
 truncating down
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ojaswin@linux.ibm.com, ritesh.list@gmail.com, hch@infradead.org,
 djwong@kernel.org, libaokun1@huawei.com, yangerkun@huawei.com,
 yukuai@fnnas.com, Zhang Yi <yi.zhang@huaweicloud.com>
References: <b889332b-9c0c-46d1-af61-1f2426c8c305@huaweicloud.com>
 <ocwepmhnw45k5nwwrooe2li2mzavw5ps2ncmowrc32u4zeitgp@gqsz3iee3axr>
 <1dad3113-7b84-40a0-8c7e-da30ae5cba8e@huaweicloud.com>
 <7hy5g3bp5whis4was5mqg3u6t37lwayi6j7scvpbuoqsbe5adc@mh5zxvml3oe7>
 <3ea033c1-8d32-4c82-baea-c383fa1d9e2a@huaweicloud.com>
 <yhy4cgc4fnk7tzfejuhy6m6ljo425ebpg6khss6vtvpidg6lyp@5xcyabxrl6zm>
 <665b8293-60a2-4d4d-aef5-cb1f9c3c0c13@huaweicloud.com>
 <ac1f8bd8-926e-4182-a5a3-a111b49ecafc@huaweicloud.com>
 <yrnt4wyocyik4nwcamwk5noc7ilninlt7cmyggzwhwzjjsjzfc@uxdht432fgzm>
 <d8b84bb5-8fb4-48fe-9ccb-7a0b724eb4b9@gmail.com>
 <3dv6rb4223ngpj2duqm5smvmlpwhbvgyiksfkzmyfxhchejgon@eoo2kitdbdpq>
Content-Language: en-US
From: Zhang Yi <yizhang089@gmail.com>
In-Reply-To: <3dv6rb4223ngpj2duqm5smvmlpwhbvgyiksfkzmyfxhchejgon@eoo2kitdbdpq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76944-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,fnnas.com,huaweicloud.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yizhang089@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8652C124D86
X-Rspamd-Action: no action

On 2/11/2026 7:42 PM, Jan Kara wrote:
> On Wed 11-02-26 00:11:51, Zhang Yi wrote:
>> On 2/10/2026 10:07 PM, Jan Kara wrote:
>>> On Tue 10-02-26 20:02:51, Zhang Yi wrote:
>>>> On 2/9/2026 4:28 PM, Zhang Yi wrote:
>>>>> On 2/6/2026 11:35 PM, Jan Kara wrote:
>>>>>> On Fri 06-02-26 19:09:53, Zhang Yi wrote:
>>>>>>> On 2/5/2026 11:05 PM, Jan Kara wrote:
>>>>>>>> So how about the following:
>>>>>>>
>>>>>>> Let me see, please correct me if my understanding is wrong, ana there are
>>>>>>> also some points I don't get.
>>>>>>>
>>>>>>>> We expand our io_end processing with the
>>>>>>>> ability to journal i_disksize updates after page writeback completes. Then
>>>>
>>>> While I was extending the end_io path of buffered_head to support updating
>>>> i_disksize, I found another problem that requires discussion.
>>>>
>>>> Supporting updates to i_disksize in end_io requires starting a handle, which
>>>> conflicts with the data=ordered mode because folios written back through the
>>>> journal process cannot initiate any handles; otherwise, this may lead to a
>>>> deadlock. This limitation does not affect the iomap path, as it does not use
>>>> the data=ordered mode at all.  However, in the buffered_head path, online
>>>> defragmentation (if this change works, it should be the last user) still uses
>>>> the data=ordered mode.
>>>
>>> Right and my intention was to use reserved handle for the i_disksize update
>>> similarly as we currently use reserved handle for unwritten extent
>>> conversion after page writeback is done.
>>
>> IIUC, reserved handle only works for ext4_jbd2_inode_add_wait(). It doesn't
>> work for ext4_jbd2_inode_add_write() because writebacks triggered by the
>> journaling process cannot initiate any handles, including reserved handles.
> 
> Yes, we cannot start any new handles (reserved or not) from writeback
> happening from jbd2 thread. I didn't think about that case so good catch.
> So we can either do this once we have delay map and get rid of data=ordered
> mode altogether or, as you write below, we have to submit the tail folios
> proactively during truncate up / append write - but I don't like this
> option too much because workloads appending to file by small chunks (say a
> few bytes) will get a large performance hit from this.
> 

Yeah, so let's keep the buffered_head path as it is now, and only modify 
the iomap path to support the new post-EOF block zeroing solution for 
truncate up and append write as discussed.

Cheers,
Yi.

>> So, I guess you're suggesting that within mext_move_extent(), we should
>> proactively submit the blocks after swapping, and then call
>> ext4_jbd2_inode_add_wait() to replace the existing
>> ext4_jbd2_inode_add_write(). Is that correct?
> 
> 								Honza


