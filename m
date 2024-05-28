Return-Path: <linux-fsdevel+bounces-20321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2308D16F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 11:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424291F2373C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 09:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2039413D52A;
	Tue, 28 May 2024 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EewEnhWt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3AE4594A;
	Tue, 28 May 2024 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887593; cv=none; b=qf0huSNedkpQUjSibBXfnjbhxGb8DnkeQgc52pzqB/bI3/LGSgF8Qba/apqDcqwtupo5lEXOg0MJjwiTAFRihGr5QxCLXWY8syaQ0b0GGDFHrhIMitx0felBJrf+APmZhhwEsBhbs6G00jV65WeSz/1hxQWpqf245Aibqjem5CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887593; c=relaxed/simple;
	bh=VZyli5BDb0C7SpDT6Pbwmvg/7m3zh4VbxAZv0BGVJiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s9xpGFLREsWc03PSiWFDwV08cvz8pv75/ET5KqoiSNWsnx1cD4O2+8TbVPp1Gb8oPGcIzywwIOTrm+AAFUnEb/j4CCi0ybGyd1UJGxEC1+5Lq4gjABJVQ+jGJDmdvMA4l6cLoXIdQa2zVFOOjne4jDScJxQSJKF9pnmU+iHfyVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EewEnhWt; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716887587; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LGdTH9CYlq+eD3X+u8Vp575bSvRHvT7qvTa1TOKVCPY=;
	b=EewEnhWtqPik1CPlbQK//lnQT/J3FURYJuTWw8fyRLNjFK2gtVlieGYAdjQ2MnwEFncBnB9J/a0rvJuX6lxLWAHrClnPYqB4G7qpiCJgFDCZtYMXOqZefojbHM7eVDl2Jv7IuFjHxI45I8IMMGBRd8zRoy5cp+fQEDRoSaKOfXg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W7P7ceH_1716887585;
Received: from 30.97.48.200(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W7P7ceH_1716887585)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 17:13:06 +0800
Message-ID: <36c14658-2c38-4515-92e1-839553971477@linux.alibaba.com>
Date: Tue, 28 May 2024 17:13:04 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] fuse: introduce fuse server recovery mechanism
To: Christian Brauner <brauner@kernel.org>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, Miklos Szeredi
 <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, winters.zc@antgroup.com
References: <20240524064030.4944-1-jefflexu@linux.alibaba.com>
 <CAJfpeguS3PBi-rNtnR2KH1ZS1t4s2HnB_pt4UvnN1orvkhpMew@mail.gmail.com>
 <858d23ec-ea81-45cb-9629-ace5d6c2f6d9@linux.alibaba.com>
 <6a3c3035-b4c4-41d9-a7b0-65f72f479571@linux.alibaba.com>
 <ce886be9-41d3-47b6-82e9-57d8f1f3421f@linux.alibaba.com>
 <20240528-pegel-karpfen-fd16814adc50@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240528-pegel-karpfen-fd16814adc50@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian,

On 2024/5/28 16:43, Christian Brauner wrote:
> On Tue, May 28, 2024 at 12:02:46PM +0800, Gao Xiang wrote:
>>
>>
>> On 2024/5/28 11:08, Jingbo Xu wrote:
>>>
>>>
>>> On 5/28/24 10:45 AM, Jingbo Xu wrote:
>>>>
>>>>
>>>> On 5/27/24 11:16 PM, Miklos Szeredi wrote:
>>>>> On Fri, 24 May 2024 at 08:40, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>>>>
>>>>>> 3. I don't know if a kernel based recovery mechanism is welcome on the
>>>>>> community side.  Any comment is welcome.  Thanks!
>>>>>
>>>>> I'd prefer something external to fuse.
>>>>
>>>> Okay, understood.
>>>>
>>>>>
>>>>> Maybe a kernel based fdstore (lifetime connected to that of the
>>>>> container) would a useful service more generally?
>>>>
>>>> Yeah I indeed had considered this, but I'm afraid VFS guys would be
>>>> concerned about why we do this on kernel side rather than in user space.
>>
>> Just from my own perspective, even if it's in FUSE, the concern is
>> almost the same.
>>
>> I wonder if on-demand cachefiles can keep fds too in the future
>> (thus e.g. daemonless feature could even be implemented entirely
>> with kernel fdstore) but it still has the same concern or it's
>> a source of duplication.
>>
>> Thanks,
>> Gao Xiang
>>
>>>>
>>>> I'm not sure what the VFS guys think about this and if the kernel side
>>>> shall care about this.
> 
> Fwiw, I'm not convinced and I think that's a big can of worms security
> wise and semantics wise. I have discussed whether a kernel-side fdstore
> would be something that systemd would use if available multiple times
> and they wouldn't use it because it provides them with no benefits over
> having it in userspace.

As far as I know, currently there are approximately two ways to do
failover mechanisms in kernel.

The first model much like a fuse-like model: in this mode, we should
keep and pass fd to maintain the active state.  And currently,
userspace should be responsible for the permission/security issues
when doing something like passing fds.

The second model is like one device-one instance model, for example
ublk (If I understand correctly): each active instance (/dev/ublkbX)
has their own unique control device (/dev/ublkcX).  Users could
assign/change DAC/MAC for each control device.  And failover
recovery just needs to reopen the control device with proper
permission and do recovery.

So just my own thought, kernel-side fdstore pseudo filesystem may
provide a DAC/MAC mechanism for the first model.  That is a much
cleaner way than doing some similar thing independently in each
subsystem which may need DAC/MAC-like mechanism.  But that is
just my own thought.

Thanks,
Gao Xiang

> 
> Especially since it implements a lot of special semantics and policy
> that we really don't want in the kernel. I think that's just not
> something we should do. We should give userspace all the means to
> implement fdstores in userspace but not hold fds ourselves.

