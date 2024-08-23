Return-Path: <linux-fsdevel+bounces-26866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6131895C3BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 05:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867C51C225C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 03:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED9941A80;
	Fri, 23 Aug 2024 03:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XeSmT1ik"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BEA3BB48;
	Fri, 23 Aug 2024 03:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724384087; cv=none; b=YgQaeGOi3xzajqxLz7T49qD1X/Yz42CHECraLOdIxahtwd50p0FqEDECcbguefzfVGHBeavYSp71UG9ecVseiMhi0SVDP/yzrUiNgDE9/Y1LYLjGIjH2MdnqO9fxi3j6fHf7WfXHww32e+G7nbQgXF5TlbQKPfQ5uXlxIrVZlhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724384087; c=relaxed/simple;
	bh=Y7EKGLP1ppW5F5MNmNyc8l2xYsUPS/l5eKpLubfPGNk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ORVtybNHJg50jIYmVQU6+gzXhUyLdBkzgydE1MDfuys00Qe/Q4geM0uzNg2gyypaI95l+MUFvwrLmwcMZxkFvjEGpiOniNq8SCTQOFkZiPxYtVNkbsa7bOTcwPELQ3ZelOVZF15jAC23FOefbBYV3j1oqPJbMH9Os9FCDHIsNik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XeSmT1ik; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724384075; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=u6QuzGPOlPh4Ysj/C9H5NkvgRQdQ+/ttIK44yeggXe4=;
	b=XeSmT1ikRtXnqGYxHZgWyAFQfjCRlc9TymOtYaZRmDprpO9P0XQz2UOZ2cW4TGLV1faLj0dKVpXu9mw2bDGZ5eOVqau3EFJA+sZHq+w0qdEtaO91uWEDacJLnRDeN4Swedj875sKXBqiCcdmvegrs4951vBpZaLC1MFHwkKcM4I=
Received: from 30.221.147.23(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WDS1UhB_1724384073)
          by smtp.aliyun-inc.com;
          Fri, 23 Aug 2024 11:34:34 +0800
Message-ID: <e7a54ce3-7905-4e70-a824-f48a112c1924@linux.alibaba.com>
Date: Fri, 23 Aug 2024 11:34:31 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [HELP] FUSE writeback performance bottleneck
To: Miklos Szeredi <miklos@szeredi.hu>,
 Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 lege.wang@jaguarmicro.com, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com>
 <67771830-977f-4fca-9d0b-0126abf120a5@fastmail.fm>
 <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>
 <bd49fcba-3eb6-4e84-a0f0-e73bce31ddb2@linux.alibaba.com>
 <CAJfpegsfF77SV96wvaxn9VnRkNt5FKCnA4mJ0ieFsZtwFeRuYw@mail.gmail.com>
 <ffca9534-cb75-4dc6-9830-fe8e84db2413@linux.alibaba.com>
 <2f834b5c-d591-43c5-86ba-18509d77a865@fastmail.fm>
 <CAJfpegt_mEYOeeTo2bWS3iJfC38t5bf29mzrxK68dhMptrgamg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJfpegt_mEYOeeTo2bWS3iJfC38t5bf29mzrxK68dhMptrgamg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/24 6:02 PM, Miklos Szeredi wrote:
> On Tue, 4 Jun 2024 at 11:32, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
> 
>> Back to the background for the copy, so it copies pages to avoid
>> blocking on memory reclaim. With that allocation it in fact increases
>> memory pressure even more. Isn't the right solution to mark those pages
>> as not reclaimable and to avoid blocking on it? Which is what the tmp
>> pages do, just not in beautiful way.
> 
> Copying to the tmp page is the same as marking the pages as
> non-reclaimable and non-syncable.
> 
> Conceptually it would be nice to only copy when there's something
> actually waiting for writeback on the page.
> 
> Note: normally the WRITE request would be copied to userspace along
> with the contents of the pages very soon after starting writeback.
> After this the contents of the page no longer matter, and we can just
> clear writeback without doing the copy.

OK this really deviates from my previous understanding of the deadlock
issue.  Previously I thought *after* the server has received the WRITE
request, i.e. has copied the request and page content to userspace, the
server needs to allocate some memory to handle the WRITE request, e.g.
make the data persistent on disk, or send the data to the remote
storage.  It is the memory allocation at this point that actually
triggers a memory direct reclaim (on the FUSE dirty page) and causes a
deadlock.  It seems that I misunderstand it.

If that's true, we can clear PF_writeback as long as the whole request
along with the page content has already been copied to userspace, and
thus eliminate the tmp page copying.

> 
> But if the request gets stuck in the input queue before being copied
> to userspace, then deadlock can still happen if the server blocks on
> direct reclaim and won't continue with processing the queue.   And
> sync(2) will also block in that case.
> 

Hi, Miklos,

Would you please give more details on how "the request can get stuck in
the input queue before being copied userspace"?  Do you mean the WRITE
requests (submitted from writeback) are still pending in the
background/pending list, waiting to be processed by the server, while at
the same time the server gets blocked from processing the queue, either
due to the server is blocked on direct reclaim (when handling *another*
request), or it's a malicious server and refuses to process any request?


-- 
Thanks,
Jingbo

