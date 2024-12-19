Return-Path: <linux-fsdevel+bounces-37861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1099F82AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D58168674
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B4F1A08D1;
	Thu, 19 Dec 2024 17:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pkrYbA5H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F44A199234
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630887; cv=none; b=IoUt/7dFCmOmEwOBkpRDMq6M/vfzET0a3//1cQBJ2FhAnOea81+TM1fg/9fAZCYpBvc+mjDhTGj8UB3jJe/pAGTdMTbWepQWPZN5MePeC0p50dYLEKNGiwVEFD4VHE9VUVxgsVp3aBvDegM8y0hLSvnmljWWYCq+7Hf7+/LzsQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630887; c=relaxed/simple;
	bh=ekj/+fX+YyUg/9Gu7dxKl0VILpsHRs6FBEDhFhZxKDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plFylNVkq+q1PBFWTrlWRgiedJs2Up6G7Hpp1pfd3UEZvveXz6HqTa3M7BkUCZZsONw3dFHttkolGvj7aOgdrWKELcnwUAE0zQxQ9lcMM2bzpalEckYgT059PoJmeO/yA2DKkChFQHV57QuD6/GPkoxLLjPgdktvMPOICAEXkyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pkrYbA5H; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 19 Dec 2024 09:54:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734630882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Lw4IPAij3tp3i78gRJgMk6al8HXCXv1KaFKHJliJ10=;
	b=pkrYbA5Htsgt2HBkWjXQ2C6SYUk9xVqd67BaTeAzUmcEXq+6F7115NsZ8bRG7lSg1wrcfg
	pnX37TRRyU8xISw7aVmh+P/JmDyRroZnETr/+99rbayv5qXIDKb+eT1oP8XFlVh6+DE8aU
	re8oukJks6LhlEfOwJUUk9DaLCd4Wng=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, 
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, josef@toxicpanda.com, 
	linux-mm@kvack.org, kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>, 
	Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
Message-ID: <2bph7jx4hvhxpgp77shq2j7mo4xssobhqndw5v7hdvbn43jo2w@scqly5zby7bm>
References: <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
 <onnjsfrlgyv6blttpmfn5yhbv5q7niteiwbhoze3qnz2zuwldc@seooqlssrpvx>
 <43e13556-18a4-4250-b4fe-7ab736ceba7d@redhat.com>
 <ggm2n6wqpx4pnlrkvgzxclm7o7luqmzlv4655yf2huqaxrebkl@2qycr6dhcpcd>
 <968d3543-d8ac-4b5a-af8e-e6921311d5cf@redhat.com>
 <ssc3bperkpjyqdrlmdbh2woxlghua2t44tg4cywj5pkwwdcpdo@2jpzqfy5zyzf>
 <7b6b8143-d7a4-439f-ae35-a91055f9d62a@redhat.com>
 <2e13a67a-0bad-4795-9ac8-ee800b704cb6@fastmail.fm>
 <ukkygby3u7hjhk3cgrxkvs6qtmlrigdwmqb5k22ru3qqn242au@s4itdbnkmvli>
 <CAJnrk1bRk9xkVkMg8twaNi-gWBRps7A6HubMivKBHQiHzf+T8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1bRk9xkVkMg8twaNi-gWBRps7A6HubMivKBHQiHzf+T8w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 19, 2024 at 09:44:42AM -0800, Joanne Koong wrote:
> On Thu, Dec 19, 2024 at 9:37 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
[...]
> > >
> > > The request is canceled then - that should clear the page/folio state
> > >
> > >
> > > I start to wonder if we should introduce really short fuse request
> > > timeouts and just repeat requests when things have cleared up. At least
> > > for write-back requests (in the sense that fuse-over-network might
> > > be slow or interrupted for some time).
> > >
> > >
> >
> > Thanks Bernd for the response. Can you tell a bit more about the request
> > timeouts? Basically does it impact/clear the page/folio state as well?
> 
> Request timeouts can be set by admins system-wide to protect against
> malicious/buggy fuse servers that do not reply to requests by a
> certain amount of time. If the request times out, then the whole
> connection will be aborted, and pages/folios will be cleaned up
> accordingly. The corresponding patchset is here [1]. This helps
> mitigate the possibility of unprivileged buggy servers tieing up
> writeback state by not replying.
> 

Thanks a lot Joanne and Bernd.

David, does these timeouts resolve your concerns?

