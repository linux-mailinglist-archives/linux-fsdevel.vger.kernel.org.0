Return-Path: <linux-fsdevel+bounces-20326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75778D177A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 11:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83471C213BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 09:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D5916ABDE;
	Tue, 28 May 2024 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AlVD+CyP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF59155C8F;
	Tue, 28 May 2024 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716889524; cv=none; b=PUesc+3jGGsidogL63lWQ5jhkFiD2B0tS56r+zNo/YEOMvMembn/dtcLTGCO6pI9aVdjdjn9ZL84z2x6gMllSRnnlik9c5OUHa/CKoMwKxXjsK13eum7OtpeGNZDp28t6xaG0gcz4nHkmXtsJOtaanFsIMlooeUvcaJQ/3Nz1DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716889524; c=relaxed/simple;
	bh=UGQfz+RIjFLy/PjRAKDnS1o4zUhUG9NZtpBCzO6xlFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EYBit63BWxJVzyfzh6CqVQvfmCRlH/OrNl2dhHa2ZK4u6glew2lxU24abpD20qI+vJjnTmS6kXlAe8SpcOeKitzDbYj48SRcCFmg8Ynbuej0uwhMYlDuNKbQ4NlCUL6EGCaTNUYFrtUEHYL5FS8O3+rrO8aLRrMVTKzKDeF1KeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AlVD+CyP; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716889519; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=iCvwyX9e33nD2Ny1HnKr50ExkwS6rywvhg/eC24fyVY=;
	b=AlVD+CyPTQUztA44Ap3llMlkqtzLu6T3YJEGsgsw6MWIq7D8Ni9dD3dDCDlzcuhXVv8ooRsyOBOY4ltbAwIE3+Yvv6Nyyr0/tIn8BI2VduRu/g5EIjZ7taaA2rvh8Ga/sLK+6Mqh161gxsrNWVhrAOHrNTs2hpWf8mzC6E4UJUI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W7PHPTi_1716889517;
Received: from 30.221.144.199(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W7PHPTi_1716889517)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 17:45:19 +0800
Message-ID: <ba6ed143-95c3-41fd-b31c-37e94fc98840@linux.alibaba.com>
Date: Tue, 28 May 2024 17:45:16 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] fuse: introduce fuse server recovery mechanism
To: Christian Brauner <brauner@kernel.org>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, winters.zc@antgroup.com
References: <20240524064030.4944-1-jefflexu@linux.alibaba.com>
 <20240528-jucken-inkonsequent-60b0a15d7ede@brauner>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240528-jucken-inkonsequent-60b0a15d7ede@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Christian,

Thanks for the review.


On 5/28/24 4:38 PM, Christian Brauner wrote:
> On Fri, May 24, 2024 at 02:40:28PM +0800, Jingbo Xu wrote:
>> Background
>> ==========
>> The fd of '/dev/fuse' serves as a message transmission channel between
>> FUSE filesystem (kernel space) and fuse server (user space). Once the
>> fd gets closed (intentionally or unintentionally), the FUSE filesystem
>> gets aborted, and any attempt of filesystem access gets -ECONNABORTED
>> error until the FUSE filesystem finally umounted.
>>
>> It is one of the requisites in production environment to provide
>> uninterruptible filesystem service.  The most straightforward way, and
>> maybe the most widely used way, is that make another dedicated user
>> daemon (similar to systemd fdstore) keep the device fd open.  When the
>> fuse daemon recovers from a crash, it can retrieve the device fd from the
>> fdstore daemon through socket takeover (Unix domain socket) method [1]
>> or pidfd_getfd() syscall [2].  In this way, as long as the fdstore
>> daemon doesn't exit, the FUSE filesystem won't get aborted once the fuse
>> daemon crashes, though the filesystem service may hang there for a while
>> when the fuse daemon gets restarted and has not been completely
>> recovered yet.
>>
>> This picture indeed works and has been deployed in our internal
>> production environment until the following issues are encountered:
>>
>> 1. The fdstore daemon may be killed by mistake, in which case the FUSE
>> filesystem gets aborted and irrecoverable.
> 
> That's only a problem if you use the fdstore of the per-user instance.
> The main fdstore is part of PID 1 and you can't kill that. So really,
> systemd needs to hand the fds from the per-user instance to the main
> fdstore.

Systemd indeed has implemented its own fdstore mechanism in the user space.

Nowadays more and more fuse daemons are running inside containers, but a
container generally has no systemd inside it.
> 
>> 2. In scenarios of containerized deployment, the fuse daemon is deployed
>> in a container POD, and a dedicated fdstore daemon needs to be deployed
>> for each fuse daemon.  The fdstore daemon could consume a amount of
>> resources (e.g. memory footprint), which is not conducive to the dense
>> container deployment.
>>
>> 3. Each fuse daemon implementation needs to implement its own fdstore
>> daemon.  If we implement the fuse recovery mechanism on the kernel side,
>> all fuse daemon implementations could reuse this mechanism.
> 
> You can just the global fdstore. That is a design limitation not an
> inherent limitation.

What I initially mean is that each fuse daemon implementation (e.g.
s3fs, ossfs, and other vendors) needs to make its own but similar
mechanism for daemon failover.  There has not been a common component
for fdstore in container scenarios just like systemd fdstore.


I'd admit that it's controversial to implement a kernel-side fdstore.
Thus I only implement a failover mechanism for fuse server in this RFC
patch.  But I also understand Miklos's concern as what we really need to
support daemon failover is just something like fdstore to keep the
device fd alive.


-- 
Thanks,
Jingbo

