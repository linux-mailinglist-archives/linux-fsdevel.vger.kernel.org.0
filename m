Return-Path: <linux-fsdevel+bounces-38281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D9D9FEA8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 21:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1911619E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 20:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFA619A298;
	Mon, 30 Dec 2024 20:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gs81fd6Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AB6173
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Dec 2024 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735589471; cv=none; b=GLr8X3rBe1gsQaHu+O2h+PS7fole7iQ9H5vlTHwHj/ah7P5mYXhR8yu2N2FIo3sw2ds3VBoGkjRgbeIj0ErRJMpyuIR32rkbkBOb2iG4CjidUxBhry6v9sv5cOUED2EZN0H7gwyu3pGYL5j7ewQ8aP/QiGs0t2+2Z1G6cklMiu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735589471; c=relaxed/simple;
	bh=STbvKzwCSQnEnRvOvixulL4zCfaj6mC/vErK/wGcETM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pd3sJJxKBdd1d1ScrhmHgvoqUvebck0qO9DHgaX1NoueT1YLg2fn24bCkMZQzwt+ey4tQsgplZt3DxJlq0PPcbEGHpolQxW+nbbYC3kI+6hjk/f+f7PSb/GrGST088dWQvN7P5+f0LhOpwifHkOs4DFY4an5dx3Qy7aNQZK3SSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gs81fd6Z; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 30 Dec 2024 12:11:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1735589467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FsvS6b4VeGJacIpC2JSzYns9sLMAO1pS2QTr6Qurca8=;
	b=gs81fd6ZAfZ6B8OjLx6ilkCNZB40c31cEOJE1Isp2WqwSc9e7d7T2yR3yQuTE8qTCGrEEF
	O2SXbN/bhq9W6OjpPWityywPDF4+G/xhxC1FvpPfrnON7UCFw9xFyBLCUwFczbclqwa3rI
	3gq3D6gci01IO5G4O+TluwZ3WOsARXY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: David Hildenbrand <david@redhat.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, 
	Bernd Schubert <bernd.schubert@fastmail.fm>, Zi Yan <ziy@nvidia.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, josef@toxicpanda.com, 
	linux-mm@kvack.org, kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>, 
	Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
Message-ID: <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
References: <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm>
 <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com>
 <qsytb6j4j6v7kzmiygmmsrdgfkwszpjudvwbq5smkhowfd75dd@beks3genju7x>
 <3f3c7254-7171-4987-bb1b-24c323e22a0f@redhat.com>
 <kyn5ji73biubd5fqbpycu4xsheqvomb3cu45ufw7u2paj5rmhr@bhnlclvuujcu>
 <c91b6836-fa30-44a9-bc15-afc829acaba9@redhat.com>
 <h3jbqkgaatads2732mzoyucjmin6rakzsvkjvdaw2xzjlieapc@k6r7xywaeozg>
 <0ed5241e-10af-43ee-baaf-87a5b4dc9694@redhat.com>
 <CAJnrk1ZYV3hXz_fdssk=tCWPzD_fpHyMW1L_+VRJtK8fFGD-1g@mail.gmail.com>
 <446704ab-434e-45ac-a062-45fef78815e4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446704ab-434e-45ac-a062-45fef78815e4@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Dec 30, 2024 at 08:52:04PM +0100, David Hildenbrand wrote:
> 
[...]
> > I'm looking back at some of the discussions in v2 [1] and I'm still
> > not clear on how memory fragmentation for non-movable pages differs
> > from memory fragmentation from movable pages and whether one is worse
> > than the other. Currently fuse uses movable temp pages (allocated with
> > gfp flags GFP_NOFS | __GFP_HIGHMEM), and these can run into the same
> 
> Why are they movable? Do you also specify __GFP_MOVABLE?
> 
> If not, they are unmovable and are never allocated from
> ZONE_MOVABLE/MIGRATE_CMA -- and usually only from MIGRATE_UNMOVBALE, to
> group these unmovable pages.
> 

Yes, these temp pages are non-movable. (Must be a typo in Joanne's
email).

[...]
> 
> I assume not regarding fragmentation.
> 
> 
> In general, I see two main issues:
> 
> A) We are no longer waiting on writeback, even though we expect in sane
> environments that writeback will happen and we it might be worthwhile to
> just wait for writeback so we can migrate these folios.
> 
> B) We allow turning movable pages to be unmovable, possibly forever/long
> time, and there is no way to make them movable again (e.g., cancel
> writeback).
> 
> 
> I'm wondering if A) is actually a new issue introduced by this change. Can
> folios with busy temp pages (writeback cleared on folio, but temp pages are
> still around) be migrated? I will look into some details once I'm back from
> vacation.
> 

My suggestion is to just drop the patch related to A as it is not
required for deadlock avoidance. For B, I think we need a long term
solution which is usable by other filesystems as well.

