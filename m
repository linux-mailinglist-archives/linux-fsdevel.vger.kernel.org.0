Return-Path: <linux-fsdevel+bounces-37804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8839F7E4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 16:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F400E165032
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 15:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0642022577E;
	Thu, 19 Dec 2024 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kFBaxCNY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1338B13D279
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734623049; cv=none; b=JpJom7fF28aG9Hr2ElakajIEcnO0V8dM6P+i75BqwU23VnB3T8xm302ubX87s6tLxfENnu5Mtcx+QAoqkYWGnkEo/JbYD0CvSCylME9bYoFgcY0OWSLPLxUNOcVEf7QXUfVM6KXgpFDJH9FctuGy030FoZ2bUp9Z3cJZIsc6tN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734623049; c=relaxed/simple;
	bh=2yWC83ILukzVHK4EmKQ9yonXb8+2KjTwq/dQn8BcRYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0iGK8bLeAO/nk9Dezb8VDzDdlk3lLktySYN0DD7gRJRobZtYKJkxZWuTwz4/h2Xo7D8InePFWfZRtOflDjTzYu4VwCQvpkHmxGEqYtdup38hN5QD/F2K5PhMveXMYBjRTcJXDKuc8qfolwT1fz6k1NjM1POPzxO8tHkHymbsMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kFBaxCNY; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 19 Dec 2024 07:43:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734623042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7g/PF04FsAPs2GzOKqJJ1GMhuC0DMBMF8FNWeAiFFPk=;
	b=kFBaxCNYE5umwjL8ZWMQqcdXKESsQOP9fus8r4bTmlZYBrIfLRLDDrp1QJJN2MnWG9ce+T
	XbbZmLqpn6pdz1VN0dX9iu8Y8r1n/jOeQMqY2+TM+y9Z256+LiSr6KqebyHdoPDCdejL/x
	lOct0DX+44+A84dXzWDVv9HEVuN609E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: David Hildenbrand <david@redhat.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, linux-mm@kvack.org, kernel-team@meta.com, 
	Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>, 
	Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
Message-ID: <hltxbiupl245ea7b4rzpcyz3d62mzs6igcx42g7zsksanbxqb3@sho3dzzht3rx>
References: <20241122232359.429647-1-joannelkoong@gmail.com>
 <20241122232359.429647-5-joannelkoong@gmail.com>
 <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9a76cb3-5827-4b2c-850f-8c830a090196@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 19, 2024 at 02:05:04PM +0100, David Hildenbrand wrote:
> On 23.11.24 00:23, Joanne Koong wrote:
> > For migrations called in MIGRATE_SYNC mode, skip migrating the folio if
> > it is under writeback and has the AS_WRITEBACK_INDETERMINATE flag set on its
> > mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the mapping, the
> > writeback may take an indeterminate amount of time to complete, and
> > waits may get stuck.
> > 
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> >   mm/migrate.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index df91248755e4..fe73284e5246 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
> >   		 */
> >   		switch (mode) {
> >   		case MIGRATE_SYNC:
> > -			break;
> > +			if (!src->mapping ||
> > +			    !mapping_writeback_indeterminate(src->mapping))
> > +				break;
> > +			fallthrough;
> >   		default:
> >   			rc = -EBUSY;
> >   			goto out;
> 
> Ehm, doesn't this mean that any fuse user can essentially completely block
> CMA allocations, memory compaction, memory hotunplug, memory poisoning... ?!
> 
> That sounds very bad.

The page under writeback are already unmovable while they are under
writeback. This patch is only making potentially unrelated tasks to
synchronously wait on writeback completion for such pages which in worst
case can be indefinite. This actually is solving an isolation issue on a
multi-tenant machine.

