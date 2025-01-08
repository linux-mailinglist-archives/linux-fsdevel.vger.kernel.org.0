Return-Path: <linux-fsdevel+bounces-38623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 826CDA04FC9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 02:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239AF188787D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 01:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC7513792B;
	Wed,  8 Jan 2025 01:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hPygx2Wn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECF02C80
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jan 2025 01:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736300434; cv=none; b=fn4RTi5ewZD7RGteWvm8Xyz+N/6TyPdc8O2TO95zbktj5gBsf46JfvdHpT0hcX3v4F35WVFpukATK0bU/KYrC1HJjqhJxOfI+XrdDCJeaV5bIZ1KeTn7XtANSvSdS9yVpko9HgNdcCS2B+igmqr4fvKn60ZE3W4d/n0npwBYbYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736300434; c=relaxed/simple;
	bh=ybFLJkaDRALHV6np8+ksNj5Z2uQ57D+LC/+Ano3kX8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FFglPaidAYtfmaReH+Uc1FAe7iJrRAPwITbgLNBBroZNMobDY1d7U+1isRTlgZL7+6m3OuaDaj5Cn8Y+GZuzsTd0fn8c3E5DaBz1FKUZ+ClOE1DTr/lTHkQOAAk75FtMLyLTPzwE3SfPTMnEVHdFJ2FiXKgE8Xd1k1rgRVsqbII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hPygx2Wn; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736300430; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=e44YPIJX7mdgwR9QtS4wdSipveX6mt2j2rqrldUApVk=;
	b=hPygx2WnrdywNXabr11JBbqQp/wNM4/HczPbkZuN18thG7zwUNwV7NgcXIMtumZoqsoGazDtM/xLfXuC4/20IufUvO2DQ/iM2G+CwECi/fKiPMtNuv5RFZqhPkVNHg5Dz8nHpPloK/XTH1md3ZxBmG+/qIFsHSiV07ghE66rdf8=
Received: from 30.221.145.29(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WNBydP5_1736300427 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 08 Jan 2025 09:40:28 +0800
Message-ID: <4fb67211-d20f-4e36-b62b-2ef15c7aaef8@linux.alibaba.com>
Date: Wed, 8 Jan 2025 09:40:24 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Miklos Szeredi <miklos@szeredi.hu>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: David Hildenbrand <david@redhat.com>,
 Joanne Koong <joannelkoong@gmail.com>,
 Bernd Schubert <bernd.schubert@fastmail.fm>, Zi Yan <ziy@nvidia.com>,
 linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, linux-mm@kvack.org,
 kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>,
 Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
References: <kyn5ji73biubd5fqbpycu4xsheqvomb3cu45ufw7u2paj5rmhr@bhnlclvuujcu>
 <c91b6836-fa30-44a9-bc15-afc829acaba9@redhat.com>
 <h3jbqkgaatads2732mzoyucjmin6rakzsvkjvdaw2xzjlieapc@k6r7xywaeozg>
 <0ed5241e-10af-43ee-baaf-87a5b4dc9694@redhat.com>
 <CAJnrk1ZYV3hXz_fdssk=tCWPzD_fpHyMW1L_+VRJtK8fFGD-1g@mail.gmail.com>
 <446704ab-434e-45ac-a062-45fef78815e4@redhat.com>
 <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
 <CAJnrk1aPCCjbKm+Ay9dz3HezCFehKDfsDidgsRyAMzen8Dk=-w@mail.gmail.com>
 <c04b73a2-b33e-4306-afb9-0fab8655615b@redhat.com>
 <CAJfpegtzDvjrH75oXS-d3t+BdZegduVYY_4Apc4bBoRcMiO-PQ@mail.gmail.com>
 <gvgtvxjfxoyr4jqqtcpfuxnx3y6etbgxfhcee25gmoiagqyxkq@ejnt3gokkbjt>
 <CAJfpegthP2enc9o1hV-izyAG9nHcD_tT8dKFxxzhdQws6pcyhQ@mail.gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAJfpegthP2enc9o1hV-izyAG9nHcD_tT8dKFxxzhdQws6pcyhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/8/25 12:15 AM, Miklos Szeredi wrote:
> On Mon, 6 Jan 2025 at 19:17, Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>
>> On Mon, Jan 06, 2025 at 11:19:42AM +0100, Miklos Szeredi wrote:
>>> On Fri, 3 Jan 2025 at 21:31, David Hildenbrand <david@redhat.com> wrote:
>>>> In any case, having movable pages be turned unmovable due to persistent
>>>> writaback is something that must be fixed, not worked around. Likely a
>>>> good topic for LSF/MM.
>>>
>>> Yes, this seems a good cross fs-mm topic.
>>>
>>> So the issue discussed here is that movable pages used for fuse
>>> page-cache cause a problems when memory needs to be compacted. The
>>> problem is either that
>>>
>>>  - the page is skipped, leaving the physical memory block unmovable
>>>
>>>  - the compaction is blocked for an unbounded time
>>>
>>> While the new AS_WRITEBACK_INDETERMINATE could potentially make things
>>> worse, the same thing happens on readahead, since the new page can be
>>> locked for an indeterminate amount of time, which can also block
>>> compaction, right?
>>
>> Yes locked pages are unmovable. How much of these locked pages/folios
>> can be caused by untrusted fuse server?
> 
> A stuck server would quickly reach the background threshold at which
> point everything stops.   So my guess is that accidentally this won't
> do much harm.
> 
> Doing it deliberately (tuning max_background, starting multiple
> servers) the number of pages that are permanently locked could be
> basically unlimited.

If "limiting the number of actually unmovable pages in a reasonable
bound" is acceptable, maybe we could limit the maximum number of
background requests that the whole unprivileged FUSE servers could achieve.

BTW currently the writeback requests are not limited by max_background
as the writeback routine allocates requests with "force == true".  We
had ever noticed that heavy writeback workload could starve other
background requests (e.g. readahead), in which the readahead routine
were waiting in fuse_get_req() forever until the writeback workload
finished.

-- 
Thanks,
Jingbo

