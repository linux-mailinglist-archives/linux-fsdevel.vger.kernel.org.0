Return-Path: <linux-fsdevel+bounces-36588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBF59E6391
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 02:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9F31162ED5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 01:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CD61EB2F;
	Fri,  6 Dec 2024 01:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jL9gnZT1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465CD10957
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 01:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733449642; cv=none; b=YqrqvNo1+BEIuMlMrZJqZ9DhSqUYgNEAUJKHkL+8gnJwRnckUtEv6s6DbHOlNY0woPTRTSWIwXrEe6Kwb7JcKHYvqgZPurglfz0dV+a1Z5qyUnRXIA9G6yNP1okk+MOdimZvxwq0deNPCtH398LpkWjqBgSszH+M9Fiscvs2Wzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733449642; c=relaxed/simple;
	bh=nSuSOCLY5kcpBwONWO3FW0tsFHj3LZinSbpp5CoHrTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PqFG1lZTk8zgOhEJKFvG2VE1fRXeRXYEXSg3NmZJ1v/vbQwiXo8cGPrHYTfs0Hr1kqIkPvQaRPODKazydwj57JTxF+vPlQF0zxyX4sWpRddlNbDbcG3acroo4Y54qsBJpPf4gxRINbF09qwDCDjGayp3NajOO6VnUH2ib8rKsls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jL9gnZT1; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733449631; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=edn/tWY5NfPv16tKhWY1VSgNmrG1u9fXdJulDeY1qK8=;
	b=jL9gnZT1FPs0g+tuVBYA8oL4Uk9zcFz44DI5V+HwkguUeXoEw66DXaAiR8+X5YWAPrD5Onvt9rLMV5Cz7eqhUDyaP9KmseJW/InHFEHubzH8hszURvtSAArt+kgQaayDBvfR3odq3jPeBCi2OGZyrFXdQVhJK+1Wlc9aes9WQpY=
Received: from 30.221.145.242(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WKugndf_1733449630 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Dec 2024 09:47:10 +0800
Message-ID: <80ee53a6-085a-4aff-b528-0e32b4780c03@linux.alibaba.com>
Date: Fri, 6 Dec 2024 09:47:07 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: Prevent hung task warning if FUSE server gets stuck
To: Etienne <etmartin4313@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, etmartin@cisco.com
References: <20241204164316.219105-1-etmartin4313@gmail.com>
 <15ff89fd-f1b1-4dc2-9837-467de7ee2ba4@linux.alibaba.com>
 <CAMHPp_SwH_sq9vCHMyev6QJbtGFkNL5fpX3ZXSHLF4zz0T3_+w@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAMHPp_SwH_sq9vCHMyev6QJbtGFkNL5fpX3ZXSHLF4zz0T3_+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/6/24 1:09 AM, Etienne wrote:
> On Wed, Dec 4, 2024 at 8:51 PM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>>
>>
>> On 12/5/24 12:43 AM, etmartin4313@gmail.com wrote:
>>> From: Etienne Martineau <etmartin4313@gmail.com>
>>>
>>> If hung task checking is enabled and FUSE server stops responding for a
>>> long period of time, the hung task timer may fire towards the FUSE clients
>>> and trigger stack dumps that unnecessarily alarm the user.
>>
>> Isn't that expected that users shall be notified that there's something
>> wrong with the FUSE service (because of either buggy implementation or
>> malicious purpose)?  Or is it expected that the normal latency of
>> handling a FUSE request is more than 30 seconds?
> 
> In one way you're right because seeing those stack dumps tells you
> right away that something is wrong with a FUSE service.
> Having said that, with many FUSE services running, those stack dumps
> are not helpful at pointing out which of the FUSE services is having
> issues.
> 
> Maybe we should instead have proper debug in place to dump the FUSE
> connection so that user can abort via
> /sys/fs/fuse/connections/'nn'/abort
> Something like "pr_warn("Fuse connection %u not responding\n", fc->dev);" maybe?

If the goal is to identifying which fuse connection is problematic, then
yes, it is not that easy to do that as the hung task has no concept of
underlying filesystem.  It is not what the hung task mechanism needs to do.

To do that, at least you should record the per-request timestamp when
the request is submitted, or a complete timeout mechanism in FUSE as
pointed by Joanne [1].

[1]
https://lore.kernel.org/linux-fsdevel/20241114191332.669127-1-joannelkoong@gmail.com/


> 
> Also, now that you are pointing out a malicious implementation, I
> realized that on a system with 'hung_task_panic' set, a non-privileged
> user can easily trip the hung task timer and force a panic.
> 
> I just tried the following sequence using FUSE sshfs and without this
> patch my system went down.
> 
>  sudo bash -c 'echo 30 > /proc/sys/kernel/hung_task_timeout_secs'
>  sudo bash -c 'echo 1 > /proc/sys/kernel/hung_task_panic'
>  sshfs -o allow_other,default_permissions you@localhost:/home/you/test ./mnt
>  kill -STOP `pidof /usr/lib/openssh/sftp-server`
>  ls ./mnt/
>  ^C

IMHO hung_task_panic shall not be enabled in productive environment.



-- 
Thanks,
Jingbo

