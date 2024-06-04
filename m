Return-Path: <linux-fsdevel+bounces-20920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7F68FAC24
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 09:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6C31F2234E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 07:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C91140E2F;
	Tue,  4 Jun 2024 07:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AJzjWWAF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D155313DDD3;
	Tue,  4 Jun 2024 07:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717486583; cv=none; b=dmxDr9HAPB75t59AF7Y6u+lDPq8GUND3DUb2+Y3O8rMC3hDQKQzB15/N9tCAgMAPm5eBvQPFf6CVT4u8et/+0hwSNTV2p+XJYPbbxU1IesNdkG9E77yxXJTfN//cl50E6lGZswZMzC2I01/FjRyR8CYDwqyM97A0mwF26vE9xDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717486583; c=relaxed/simple;
	bh=Fw2dlhvUDvhaiIAs+Ca0alCjR7N9kP9wakSguQ5bY00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bNyOGaG77zu6b3pUaN2wZa5jGYkh+4eUL41Um3BMMLtuWiYwndkSee16PN+0ZAyq5e2E7/XDc2W6ufP/TPbigxekvmWCp1f77ZpLJG1fTS67nC+XsVfshfylvvhWtrGWzfmHq5yw2Snh1dUzEpZhhsiGWDskvcHARJHR6F9tTkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AJzjWWAF; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717486577; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ODwm6X80T2O9PNIpKJj73Wx7jHKcAvCfBJLjUeUP88g=;
	b=AJzjWWAFf4KwF6ByDbP9e9Uv+RuCU+0//hjRCA+Y2ocAJv3Kuj2VkBre0UuaDEBCBFA8kUjC1kbBD+nC1Po0BSIRvvLOoQV/LL48cBjqein9TrGCRVTXjaMQ3rICe+Ti0bqMrq6sGWCwwxp/lnViuNw1/4qjOQ3RNMM7Q8x9eqw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W7q92aK_1717486576;
Received: from 30.221.146.134(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W7q92aK_1717486576)
          by smtp.aliyun-inc.com;
          Tue, 04 Jun 2024 15:36:17 +0800
Message-ID: <ffca9534-cb75-4dc6-9830-fe8e84db2413@linux.alibaba.com>
Date: Tue, 4 Jun 2024 15:36:15 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [HELP] FUSE writeback performance bottleneck
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 lege.wang@jaguarmicro.com
References: <495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com>
 <67771830-977f-4fca-9d0b-0126abf120a5@fastmail.fm>
 <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>
 <bd49fcba-3eb6-4e84-a0f0-e73bce31ddb2@linux.alibaba.com>
 <CAJfpegsfF77SV96wvaxn9VnRkNt5FKCnA4mJ0ieFsZtwFeRuYw@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJfpegsfF77SV96wvaxn9VnRkNt5FKCnA4mJ0ieFsZtwFeRuYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/24 3:27 PM, Miklos Szeredi wrote:
> On Tue, 4 Jun 2024 at 03:57, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
> 
>> IIUC, there are two sources that may cause deadlock:
>> 1) the fuse server needs memory allocation when processing FUSE_WRITE
>> requests, which in turn triggers direct memory reclaim, and FUSE
>> writeback then - deadlock here
> 
> Yep, see the folio_wait_writeback() call deep in the guts of direct
> reclaim, which sleeps until the PG_writeback flag is cleared.  If that
> happens to be triggered by the writeback in question, then that's a
> deadlock.
> 
>> 2) a process that trigfgers direct memory reclaim or calls sync(2) may
>> hang there forever, if the fuse server is buggyly or malicious and thus
>> hang there when processing FUSE_WRITE requests
> 
> Ah, yes, sync(2) is also an interesting case.   We don't want unpriv
> fuse servers to be able to block sync(2), which means that sync(2)
> won't actually guarantee a synchronization of fuse's dirty pages.  I
> don't think there's even a theoretical solution to that, but
> apparently nobody cares...

Okay if the temp page design is unavoidable, then I don't know if there
is any approach (in FUSE or VFS layer) helps page copy offloading.  At
least we don't want the writeback performance to be limited by the
single writeback kworker.  This is also the initial attempt of this thread.

-- 
Thanks,
Jingbo

