Return-Path: <linux-fsdevel+bounces-37836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7EF9F8177
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5587E7A24E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1671A9B54;
	Thu, 19 Dec 2024 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mFAxqs9r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FC91A76B0
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734628506; cv=none; b=Vna9M3FNltqh1OB4XQKmOpddRsTCdG557FHk2GXjgAQDP3MfkEbc5IHW5KB03hB76geYuPFBEJGsAQcXo+qiER9Drt+Pd8UnTeDIu+t+ijFoWefIEVdthKucvP4eK8slZzQF1C0ddx8WBJqJKYmA70hXxv1cjY8y4/6lRz+aTiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734628506; c=relaxed/simple;
	bh=7jGIsXlEOJLkkQ7oxm+WDPX3h2416RiBwAVHJQazvio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LR6bky+nUZnmXB2Xax+RybxRkik3LdwWpURrATFu2lRHStFFx1GxsiGJJEsAOuSGsyyUOl8/NtpXW7l3qJtL140O5hlT/4IaHiS6jzKXQ40aDZCqjUxf2NZstCU87XcVkZAdqPpJx3D48xLQ9MgXa2+oQbXQOChirPeL3JwqDgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mFAxqs9r; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 19 Dec 2024 09:14:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734628499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EeFJTG6jg/QfGCeD5x2h9WUaphItSLBzS2trrpbjGwA=;
	b=mFAxqs9r4fwNaYbTrftZXM71IkL/Y+eDsf28w5XiitYUr7TloMku1eHK2DzCPg+Pl9bv/P
	D6hGZA2YTNb7EqlP3x9moAN2gc1+r+Ui+4qCBn7SMewNyIRV8BLH8ubks2NqrDSTvUZzJ4
	PUw3Xepne2lJDgk29j5ZI9B16yILsb4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, Joanne Koong <joannelkoong@gmail.com>, 
	miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, linux-mm@kvack.org, 
	kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>, 
	Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
Message-ID: <ssc3bperkpjyqdrlmdbh2woxlghua2t44tg4cywj5pkwwdcpdo@2jpzqfy5zyzf>
References: <20241122232359.429647-5-joannelkoong@gmail.com>
 <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
 <hltxbiupl245ea7b4rzpcyz3d62mzs6igcx42g7zsksanbxqb3@sho3dzzht3rx>
 <f30fba5f-b2ca-4351-8c8f-3ac120b2d227@redhat.com>
 <gdu7kmz4nbnjqenj5vea4rjwj7v67kjw6ggoyq7ok4la2uosqa@i5gxpmoopuii>
 <C34102A1-F571-4700-8D16-74642046376D@nvidia.com>
 <onnjsfrlgyv6blttpmfn5yhbv5q7niteiwbhoze3qnz2zuwldc@seooqlssrpvx>
 <43e13556-18a4-4250-b4fe-7ab736ceba7d@redhat.com>
 <ggm2n6wqpx4pnlrkvgzxclm7o7luqmzlv4655yf2huqaxrebkl@2qycr6dhcpcd>
 <968d3543-d8ac-4b5a-af8e-e6921311d5cf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <968d3543-d8ac-4b5a-af8e-e6921311d5cf@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 19, 2024 at 05:41:36PM +0100, David Hildenbrand wrote:
> On 19.12.24 17:40, Shakeel Butt wrote:
> > On Thu, Dec 19, 2024 at 05:29:08PM +0100, David Hildenbrand wrote:
> > [...]
> > > > 
> > > > If you check the code just above this patch, this
> > > > mapping_writeback_indeterminate() check only happen for pages under
> > > > writeback which is a temp state. Anyways, fuse folios should not be
> > > > unmovable for their lifetime but only while under writeback which is
> > > > same for all fs.
> > > 
> > > But there, writeback is expected to be a temporary thing, not possibly:
> > > "AS_WRITEBACK_INDETERMINATE", that is a BIG difference.
> > > 
> > > I'll have to NACK anything that violates ZONE_MOVABLE / ALLOC_CMA
> > > guarantees, and unfortunately, it sounds like this is the case here, unless
> > > I am missing something important.
> > > 
> > 
> > It might just be the name "AS_WRITEBACK_INDETERMINATE" is causing
> > the confusion. The writeback state is not indefinite. A proper fuse fs,
> > like anyother fs, should handle writeback pages appropriately. These
> > additional checks and skips are for (I think) untrusted fuse servers.
> 
> Can unprivileged user space provoke this case?

Let's ask Joanne and other fuse folks about the above question.

Let's say unprivileged user space can start a untrusted fuse server,
mount fuse, allocate and dirty a lot of fuse folios (within its dirty
and memcg limits) and trigger the writeback. To cause pain (through
fragmentation), it is not clearing the writeback state. Is this the
scenario you are envisioning?

