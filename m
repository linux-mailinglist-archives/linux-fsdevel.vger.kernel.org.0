Return-Path: <linux-fsdevel+bounces-37972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CC19F9920
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 19:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB14716AD98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 18:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C86221458;
	Fri, 20 Dec 2024 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oB7DVBRq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061681925A0
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734717673; cv=none; b=Zag/9uiXyggeyZE91+rVUMt5TRJDD8o+l9c8/EX/q3/i1o0i8w4Mni3y1OiNemv7Ta5OOQ1i3toDrBpVzqBtbphH+O+gmRibpKj3sbUld+0ouIGhqjLPkMsOecSv+xs2HVDOxrv32B2wR4CbTMAiB9zy0PWTLcsreqoia+rU52o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734717673; c=relaxed/simple;
	bh=S2mfVFA6eCCmxCGx46BFpia5QUPhfhbfZwUcARiRClY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6PZOV7PdNdziboDotlhN9mNUMXcdcEolwFO7qdW2XS+HmOLuEIKcUnjtiYPS7mX8Se5yBpPYM7QSoUKqtV2Lq19EtEmdJZhleukTH+wFDUL5CwHCY37RdfCaDWo5FFEON/6tHdp3x+rcSntHw5S5sd0T2flU6/mLuwuJLT5F+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oB7DVBRq; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 20 Dec 2024 10:01:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734717668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GG97n8pvnK3qNACAT32sPck6VocOseRnV8c+9OSvhT8=;
	b=oB7DVBRqPZaJWMbi8t212AVXeNA5hcYJJdTsv4fcC9ZVHW6YR3qwWuvUN/MRtt7CTo86PZ
	rPHy7DJAsyALSWdvx7q+GUBQwnVGditDIHraSvCZ8Y5stMSTRsqJAVcT1kTJDN7V4Ht5um
	YZ+bOmXqKlqWQaaJWBvh6PTSbc1r6VQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: David Hildenbrand <david@redhat.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Joanne Koong <joannelkoong@gmail.com>, Zi Yan <ziy@nvidia.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, josef@toxicpanda.com, 
	linux-mm@kvack.org, kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>, 
	Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
Message-ID: <qsytb6j4j6v7kzmiygmmsrdgfkwszpjudvwbq5smkhowfd75dd@beks3genju7x>
References: <968d3543-d8ac-4b5a-af8e-e6921311d5cf@redhat.com>
 <ssc3bperkpjyqdrlmdbh2woxlghua2t44tg4cywj5pkwwdcpdo@2jpzqfy5zyzf>
 <7b6b8143-d7a4-439f-ae35-a91055f9d62a@redhat.com>
 <2e13a67a-0bad-4795-9ac8-ee800b704cb6@fastmail.fm>
 <ukkygby3u7hjhk3cgrxkvs6qtmlrigdwmqb5k22ru3qqn242au@s4itdbnkmvli>
 <CAJnrk1bRk9xkVkMg8twaNi-gWBRps7A6HubMivKBHQiHzf+T8w@mail.gmail.com>
 <2bph7jx4hvhxpgp77shq2j7mo4xssobhqndw5v7hdvbn43jo2w@scqly5zby7bm>
 <71d7ac34-a5e5-4e59-802b-33d8a4256040@redhat.com>
 <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm>
 <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Dec 20, 2024 at 03:49:39PM +0100, David Hildenbrand wrote:
> > > I'm wondering if there would be a way to just "cancel" the writeback and
> > > mark the folio dirty again. That way it could be migrated, but not
> > > reclaimed. At least we could avoid the whole AS_WRITEBACK_INDETERMINATE
> > > thing.
> > > 
> > 
> > That is what I basically meant with short timeouts. Obviously it is not
> > that simple to cancel the request and to retry - it would add in quite
> > some complexity, if all the issues that arise can be solved at all.
> 
> At least it would keep that out of core-mm.
> 
> AS_WRITEBACK_INDETERMINATE really has weird smell to it ... we should try to
> improve such scenarios, not acknowledge and integrate them, then work around
> using timeouts that must be manually configured, and ca likely no be default
> enabled because it could hurt reasonable use cases :(

Just to be clear AS_WRITEBACK_INDETERMINATE is being used in two core-mm
parts. First is reclaim and second is compaction/migration. For reclaim,
it is a must have as explained by Jingbo in [1] i.e. due to potential
self deadlock by fuse server. If I understand you correctly, the main
concern you have is its usage in the second case.

The reason for adding AS_WRITEBACK_INDETERMINATE in the second case was
to avoid untrusted fuse server causing pain to unrelated jobs on the
machine (fuse folks please correct me if I am wrong here). Now we are
discussing how to better handle that scenario.

I just wanted to point out that irrespective of that discussion, the
reclaim will have handle the potential recursive deadlock and thus will
be using AS_WRITEBACK_INDETERMINATE or something similar.

[1] https://lore.kernel.org/all/d48ae58e-500f-4ef1-bc6f-a41a8f5b94bf@linux.alibaba.com/

