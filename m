Return-Path: <linux-fsdevel+bounces-75566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PDkIYomeGl7oQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 03:44:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 157198F1F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 03:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C205C3017261
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 02:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B49B2D9EF9;
	Tue, 27 Jan 2026 02:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wytpUNTU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BD42D7BF
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 02:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769481818; cv=none; b=otKHGNSMRmio2LmSmA8ZgJMorBvFW99Q9VtNZ+8+c9uXSNRMKAfM0ZBVnCL5lnOimY+X9EIse/AalNB+X93qrHvsgJ9ZM4Zj8wTsHFdpukv6h9QgIdOCRj7Y2iIcfW/pA5jhql5jWZr2tqrqw6l3GA5n8yGEf0H+ew1NQDTXdWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769481818; c=relaxed/simple;
	bh=CMsfJ+lQR0gF40IeqcYDCdJhPLzwrbk0HglHv3/NzAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gUx+ixQCTo+1GyUSNT+lTe7hduPnHElGlHrywlr7QwSs1Mhvn78fpETJMz6gaHxL5wBl9+VqmFJ0KkbM4Kmjo9mSkWg2G26cCwe30ZWnsJU13PrNb/aZH6L0eud63g+G9YGfTVoNbiCii7g0cYD8dHuWFEUSr7IsGy4bXBYD5d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wytpUNTU; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769481804; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FaYNA7Q2HJOw14zGx7wuqF9H6OMIH+IjVXhVROUzmQE=;
	b=wytpUNTUGxOu5HUVN/IZhiSuXGv4UVXgZ/vgawjC3m8q9c8GTkjWT2RhXdw0yTZmgPuFyD17LZXVEcXSkMx3El1gFuB8ksIszJ5vnfnpd8WQQbUNeANW+f4WSgB/x0rtnnjCeYmfGjb4UhCB7mm9IgCmFMRXoLAZxnSidkdSWEU=
Received: from 30.221.146.176(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Wy-4Ddz_1769481803 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 27 Jan 2026 10:43:24 +0800
Message-ID: <5a9bdacc-a385-474e-9328-6ff217f6916b@linux.alibaba.com>
Date: Tue, 27 Jan 2026 10:43:23 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: mark DAX inode releases as blocking
To: "Darrick J. Wong" <djwong@kernel.org>, Sergio Lopez <slp@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
References: <20260118232411.536710-1-slp@redhat.com>
 <20260126184015.GC5900@frogsfrogsfrogs>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20260126184015.GC5900@frogsfrogsfrogs>
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
	TAGGED_FROM(0.00)[bounces-75566-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 157198F1F6
X-Rspamd-Action: no action



On 1/27/26 2:40 AM, Darrick J. Wong wrote:

> I wonder if fuse ought to grow the ability to whine when something is
> trying to issue a synchronous fuse command while running in a command
> queue completion context (aka the worker threads) but I don't know how
> difficult that would *really* be.

I had also observed similar issue where the FUSE daemon thread is
hanging in:

request_wait_answer
fuse_simple_request
fuse_flush_times
fuse write_inode
writeback_single_inode
write_inode_now
fuse_release
_fput

At that time I had no idea how FUSE daemon thread could trigger fuse
file release and thus I didn't dive into this further...

I think commit 26e5c67deb2e ("fuse: fix livelock in synchronous file put
from fuseblk workers") is not adequate in this case, as the commit only
makes FUSE_RELEASE request asynchronously, while in this case the daemon
thread can wait for FUSE_WRITE and FUSE_SETATTR.

Maybe the very first entry i.e. fuse_release() needs to be executed in
an asynchronous context (e.g. workqueue)...


-- 
Thanks,
Jingbo


