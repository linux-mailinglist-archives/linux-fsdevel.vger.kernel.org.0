Return-Path: <linux-fsdevel+bounces-37867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B324E9F82F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 19:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0D216463C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FE619B5A9;
	Thu, 19 Dec 2024 18:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XWu/F61J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EEC190685
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 18:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734631885; cv=none; b=eM4Cv7nMBcaDCVr9G05f8DjZSgHEraewots+4kdURYHkFdYahsyq9js61+iaX3dlbkOmI14ngTC1UIBCOlB6hu7dODSafteqsaHv3ZS1IJfZx5OJlPdefjywy/BU0PkTx1oCgrbEVFFWb66Ai9VwuMbBMJMrX4CuI3ww9iXRra8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734631885; c=relaxed/simple;
	bh=zSbjPyw7j9hXCHrENFLlr+nkG5Ei9TTsQcWMSjqJ2VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBp4zxhynHVU3lYHpbXn9WPF4giT5COTUpJsyoFnMv+QH7iLzy4ikZVcVoXxvKFQy85Zr2xrLDppHnbQYGVKSEscbqqP94vp5KbjlLLwlAJjVOEEGDgZvsUOe8hiPHngzrskJL/M8yMRvzHyh0v1qIJh/knftSOOVaSLEdlMlGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XWu/F61J; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 19 Dec 2024 10:11:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734631880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sjCPTeoBFBOxGbENHBqM+WQSgCJtTcDAl8A3/hfu7uQ=;
	b=XWu/F61J1maGQXECTYk6663rMRiFmld5MkqcVVRrPxYSdtcXqMhA1XcEHLR3iMCBE9zrZl
	xIaQ+9F/pb5ndI45JMEq7ybSVYA2hRiCl19FEI0vXHug106+qTfZAF36zvdsQ0niBmkF9/
	TnJ2wNn4aO3G2mRJm2ljLbgoKlvW+lw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Joanne Koong <joannelkoong@gmail.com>, 
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, josef@toxicpanda.com, 
	linux-mm@kvack.org, kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>, 
	Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
Message-ID: <t77ou63ksuk3xgpxly5bzefll2ld5trb4iccovmo3j3vbxiiux@hmjsr4ghmnru>
References: <gdu7kmz4nbnjqenj5vea4rjwj7v67kjw6ggoyq7ok4la2uosqa@i5gxpmoopuii>
 <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
 <onnjsfrlgyv6blttpmfn5yhbv5q7niteiwbhoze3qnz2zuwldc@seooqlssrpvx>
 <43e13556-18a4-4250-b4fe-7ab736ceba7d@redhat.com>
 <ggm2n6wqpx4pnlrkvgzxclm7o7luqmzlv4655yf2huqaxrebkl@2qycr6dhcpcd>
 <968d3543-d8ac-4b5a-af8e-e6921311d5cf@redhat.com>
 <ssc3bperkpjyqdrlmdbh2woxlghua2t44tg4cywj5pkwwdcpdo@2jpzqfy5zyzf>
 <7b6b8143-d7a4-439f-ae35-a91055f9d62a@redhat.com>
 <CAJnrk1YFix0W5OW6351UsKujFYLcXnwZJaWYSJTYZMpQWwk5kA@mail.gmail.com>
 <7810ab2c-1f80-4c78-9b75-db20a78af5e3@fastmail.fm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7810ab2c-1f80-4c78-9b75-db20a78af5e3@fastmail.fm>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 19, 2024 at 07:04:40PM +0100, Bernd Schubert wrote:
> 
> 
> On 12/19/24 18:55, Joanne Koong wrote:
> > On Thu, Dec 19, 2024 at 9:26 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 19.12.24 18:14, Shakeel Butt wrote:
> >>> On Thu, Dec 19, 2024 at 05:41:36PM +0100, David Hildenbrand wrote:
> >>>> On 19.12.24 17:40, Shakeel Butt wrote:
> >>>>> On Thu, Dec 19, 2024 at 05:29:08PM +0100, David Hildenbrand wrote:
> >>>>> [...]
> >>>>>>>
> >>>>>>> If you check the code just above this patch, this
> >>>>>>> mapping_writeback_indeterminate() check only happen for pages under
> >>>>>>> writeback which is a temp state. Anyways, fuse folios should not be
> >>>>>>> unmovable for their lifetime but only while under writeback which is
> >>>>>>> same for all fs.
> >>>>>>
> >>>>>> But there, writeback is expected to be a temporary thing, not possibly:
> >>>>>> "AS_WRITEBACK_INDETERMINATE", that is a BIG difference.
> >>>>>>
> >>>>>> I'll have to NACK anything that violates ZONE_MOVABLE / ALLOC_CMA
> >>>>>> guarantees, and unfortunately, it sounds like this is the case here, unless
> >>>>>> I am missing something important.
> >>>>>>
> >>>>>
> >>>>> It might just be the name "AS_WRITEBACK_INDETERMINATE" is causing
> >>>>> the confusion. The writeback state is not indefinite. A proper fuse fs,
> >>>>> like anyother fs, should handle writeback pages appropriately. These
> >>>>> additional checks and skips are for (I think) untrusted fuse servers.
> >>>>
> >>>> Can unprivileged user space provoke this case?
> >>>
> >>> Let's ask Joanne and other fuse folks about the above question.
> >>>
> >>> Let's say unprivileged user space can start a untrusted fuse server,
> >>> mount fuse, allocate and dirty a lot of fuse folios (within its dirty
> >>> and memcg limits) and trigger the writeback. To cause pain (through
> >>> fragmentation), it is not clearing the writeback state. Is this the
> >>> scenario you are envisioning?
> >>
> > 
> > This scenario can already happen with temp pages. An untrusted
> > malicious fuse server may allocate and dirty a lot of fuse folios
> > within its dirty/memcg limits and never clear writeback on any of them
> > and tie up system resources. This certainly isn't the common case, but
> > it is a possibility. However, request timeouts can be set by the
> > system admin [1] to protect against malicious/buggy fuse servers that
> > try to do this. If the request isn't replied to by a certain amount of
> > time, then the connection will be aborted and writeback state and
> > other resources will be cleared/freed.
> > 
> 
> I think what Zi points out that that is a current implementation issue
> and these temp pages should be in a continues range. 
> Obviously better to avoid a tmp copy at all.

The current tmp pages are allocated from MIGRATE_UNMOVABLE. I don't see
any additional benefit of reserving any continuous unmovable memory
regions for tmp pages. It will just add complexity without any clear
benefit.

