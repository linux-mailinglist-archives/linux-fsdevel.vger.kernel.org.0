Return-Path: <linux-fsdevel+bounces-75594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL8OB9mheGljrgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 12:30:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5A99398F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 12:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 047983005590
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 11:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020ED346FB8;
	Tue, 27 Jan 2026 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="F5epTk4C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6B6346AD6
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 11:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769513428; cv=none; b=aDYlEgF4hhwU9xL6cTmV4e+KiTgDrJHdjVqfXrM7hEaLKdGd1ZIy70WhruwTEvYV5/WPksBtKmnEG/eqozAW44KdW6XcFq+/x3B4R39tJ9kPW/LEsT/z8Ma9FhxNMMZl9EtEw76yy3ibNuuS+pI0DofqMqKYA4Pzyz/zjnnYuvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769513428; c=relaxed/simple;
	bh=o8Io8/hWRxAovokNMOULHaIbf3YxCVNwXXDTc6dNhno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q4y3d2mH4cVrcxZXkmF1JZeWbEQOAOXqlk91kUCeC1Rj04qXqQF6RIeF4YEVJGIgAEXgQaTdI2zMIeYsuziQ9KbaCaoCSaWBgIltfQuKBWpkhid0VsbZ056q48RbMQbtIaV2GfuUjl94xiosZDm5AJe+PGcbWkmECbvP8tt7Os4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=F5epTk4C; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769513416; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=58AnQu0DkhQoL75+KkYy8p21Okp6HCTqT+1U6QZZaDQ=;
	b=F5epTk4C0glxhvwHep86imadMTW2WM3nNE2msQVaUpz+B43cO2uyT4EJz7gQEhrzC7oPA4BgF8osG64f56/7LdBfFwK7ehMGmtVLVQVz/N484+xSlE0ORJc+yTg8WjGcSrmKkdh8wmZYq0Bu6LxvPhowDH2AUaod5yseTulSaBM=
Received: from 30.221.146.176(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Wy.glWK_1769513415 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 27 Jan 2026 19:30:16 +0800
Message-ID: <66e4e378-1e65-49f3-853b-276ab04bc594@linux.alibaba.com>
Date: Tue, 27 Jan 2026 19:30:14 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: mark DAX inode releases as blocking
To: Sergio Lopez Pascual <slp@redhat.com>, "Darrick J. Wong"
 <djwong@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
References: <20260118232411.536710-1-slp@redhat.com>
 <20260126184015.GC5900@frogsfrogsfrogs>
 <5a9bdacc-a385-474e-9328-6ff217f6916b@linux.alibaba.com>
 <CAAiTLFULeJw2y53dM2QqDqHv2ycD8rZmptVX7yRML0_XVneY=g@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAAiTLFULeJw2y53dM2QqDqHv2ycD8rZmptVX7yRML0_XVneY=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75594-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jefflexu@linux.alibaba.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F5A99398F
X-Rspamd-Action: no action



On 1/27/26 7:18 PM, Sergio Lopez Pascual wrote:
> Jingbo Xu <jefflexu@linux.alibaba.com> writes:
> 
>> On 1/27/26 2:40 AM, Darrick J. Wong wrote:
>>
>>> I wonder if fuse ought to grow the ability to whine when something is
>>> trying to issue a synchronous fuse command while running in a command
>>> queue completion context (aka the worker threads) but I don't know how
>>> difficult that would *really* be.
>>
>> I had also observed similar issue where the FUSE daemon thread is
>> hanging in:
>>
>> request_wait_answer
>> fuse_simple_request
>> fuse_flush_times
>> fuse write_inode
>> writeback_single_inode
>> write_inode_now
>> fuse_release
>> _fput
>>
>> At that time I had no idea how FUSE daemon thread could trigger fuse
>> file release and thus I didn't dive into this further...
>>
>> I think commit 26e5c67deb2e ("fuse: fix livelock in synchronous file put
>> from fuseblk workers") is not adequate in this case, as the commit only
>> makes FUSE_RELEASE request asynchronously, while in this case the daemon
>> thread can wait for FUSE_WRITE and FUSE_SETATTR.
>>
>> Maybe the very first entry i.e. fuse_release() needs to be executed in
>> an asynchronous context (e.g. workqueue)...
> 
> Do you have the rest of the stacktrace? We need to know if it's running
> in the context of the worker thread, as otherwise it must be a different
> problem.


This is observed in scenarios of FUSE rather than virtiofs.

The complete stacktrace of FUSE daemon worker thread (in userspace) is like:

 request_wait_answer
 fuse_simple_request
 fuse_flush_times
 fuse write_inode
 writeback_single_inode
 write_inode_now
 fuse_release
 __fput
 ____fput
 task_work_run
 exit_to_user_mode_prepare
 syscall exit_to_user_mode
 do_syscall_64
 entry_SYSCALL_64_after_hwframe



-- 
Thanks,
Jingbo


