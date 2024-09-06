Return-Path: <linux-fsdevel+bounces-28825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E75496E850
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 05:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3491C21CA2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 03:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8542E3BBF2;
	Fri,  6 Sep 2024 03:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eIWXQ9ZG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFCB481B7
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 03:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725593846; cv=none; b=Wc4ZdcForDEDAKIVTGZVhfpGOzYQGzcjGs1/X7U+3rsTOnEWv4JGXTvPrybGmmx4Sf6fPu84NjkvZspiPY6wZdUnYdhddwOkSjKzXaT2LN36f9v31io7GknkWyGNOyXq2QKde9VLFX96EDjgmmUDRYS4xz+KXkPZMc/Z/N4Qlus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725593846; c=relaxed/simple;
	bh=Y/o0bfttyinU696J8xUrL1gKrVgyaidaQinmhlEDt34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NUJLJMnGo0U4OE8FED+bxC0GySibstnLPmId9z7QuYCRO77f5uRq6KJVUY6AtOynfQuyH0iXemNCj7Ts+GRB0DMyg4vSsE9pp0/FXBIDfkv5xvVAIf82uA/7hJGzienWplcsAIc/xphQhdpaeAzSWgzSfqtMdgXp8FDrrpSd+RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eIWXQ9ZG; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725593835; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DR/fe2PgViFOKgjxArihJ3C3qdQVpSIVSWHyuX/q4UM=;
	b=eIWXQ9ZGHdcn5+bM0Muif77ycUgscX1cTJh+R4M0nEP84DdYUgP2rhcXsa62KL9qpXIQu/ld5wnrh3zqMCBTsOms0tCRTNnyWOnH48t/BgLaO5Aks4a3HDlg2r/qOe64Ews/fqkaQe3BwQnYFH8yvY/RJusL9lifmAx3JnhrsxE=
Received: from 30.221.145.151(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WENqNPg_1725593833)
          by smtp.aliyun-inc.com;
          Fri, 06 Sep 2024 11:37:14 +0800
Message-ID: <3bdd2762-4906-470b-afee-fc79b709a393@linux.alibaba.com>
Date: Fri, 6 Sep 2024 11:37:12 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND] fuse: Enable dynamic configuration of fuse max
 pages limit (FUSE_MAX_MAX_PAGES)
To: Joanne Koong <joannelkoong@gmail.com>,
 Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 sweettea-kernel@dorminy.me, kernel-team@meta.com, laoji.jx@alibaba-inc.com
References: <20240905174541.392785-1-joannelkoong@gmail.com>
 <27b6ad2f-9a43-4938-9f0d-2d11581e8be7@fastmail.fm>
 <CAJnrk1Z6R3cOMeVTaE0L1Nn4WO2K-4d3E0PY+-s_iege0PaEVA@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJnrk1Z6R3cOMeVTaE0L1Nn4WO2K-4d3E0PY+-s_iege0PaEVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/6/24 6:32 AM, Joanne Koong wrote:
> On Thu, Sep 5, 2024 at 2:16 PM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>> Hi Joanne,
>>
>> On 9/5/24 19:45, Joanne Koong wrote:
>>> Introduce the capability to dynamically configure the fuse max pages
>>> limit (formerly #defined as FUSE_MAX_MAX_PAGES) through a sysctl.
>>> This enhancement allows system administrators to adjust the value
>>> based on system-specific requirements.
>>>
>>> This removes the previous static limit of 256 max pages, which limits
>>> the max write size of a request to 1 MiB (on 4096 pagesize systems).
>>> Having the ability to up the max write size beyond 1 MiB allows for the
>>> perf improvements detailed in this thread [1].
>>
>> the change itself looks good to me, but have you seen this discussion here?
>>
>> https://lore.kernel.org/lkml/CAJfpegs10SdtzNXJfj3=vxoAZMhksT5A1u5W5L6nKL-P2UOuLQ@mail.gmail.com/T/
>>
>>
>> Miklos is basically worried about page pinning and accounting for that
>> for unprivileged user processes.
>>
> 
> Thanks for the link to the previous discussion, Bernd. I'll cc Xu and
> Jingbo, who started that thread, to this email.
> 
> I'm curious whether this sysctl approach might mitigate those worries
> here since modifying the sysctl value will require admin privileges to
> explicitly opt into this. I liked Sweet Tea's comment
> 
> "Perhaps, in analogy to soft and hard limits on pipe size,
> FUSE_MAX_MAX_PAGES could be increased and treated as the maximum
> possible hard limit for max_write; and the default hard limit could stay
> at 1M, thereby allowing folks to opt into the new behavior if they care
> about the performance more than the memory?"
> 
> where something like this could let admins choose what aspects they'd
> like to optimize for.

The upper bound of max_pages limit is indeed increased by the sysadmin,
but it can't overwhelms the fact that an unpriviledged fuse server could
still configure a max_pages limit up to the bound and thus causing the
memory pinning issue.

> 
> My understanding of how bigger write buffers affects pinning is that
> each chunk of the write will pin a higher number of contiguous pages
> at one time (but overall for the duration of the write request, the
> number for total pages that get pinned are the same). My understanding
> is that the pages only get pinned when we do the copying to the fuse
> server's buffer (and is not pinned while the server is servicing the
> request).
> 

I think the "possible memory that an unprivileged user is allowed to
pin" by Miklos means the possible memory that an unprivileged (even
malicious) fuse server could pin?

Hi Miklos, would you mind giving more details on this?


-- 
Thanks,
Jingbo

