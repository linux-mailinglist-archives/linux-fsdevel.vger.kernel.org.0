Return-Path: <linux-fsdevel+bounces-33312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F299B712E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 01:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDE091F21D78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 00:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876E514F90;
	Thu, 31 Oct 2024 00:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vtJrnziU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89890360
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 00:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730334668; cv=none; b=fYQkNlhfbqryfQGkNzD8uPoA4N5p8NN3JE40CSvA6fNwVzs9Zs/otEyNZDT5qZ9ABDJsy68TOrnBLfCne3jVcqN8xUBylpMBIJpGPom7+9slTo5XzPoY3jjIFU/0FUN8hKhmOxproBytglOeQfgytYmpSL028O2o/d26s0Dgb2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730334668; c=relaxed/simple;
	bh=h6tSdwG0rXNowKAgNfpqSRCrjNZWsb3ZmgaUG4Bgbn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrA1aI3fn296c0AVJjTd2MFGdf0/7Un2q1dKRbmhdS1Hkzk3tLAuaHb/lSpamPa4bJx7eTg5VRKNiKX75f1Sc6kiRhUEp2sssB0aX8eLsD7S+nxv01XW0q7m5AnHHNE2ZnXobg9zlOqXqwWfG87r6vnoLW1l5lkOatdXJJgBwkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vtJrnziU; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 30 Oct 2024 17:30:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730334658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uG209TnvILyBQP4D3chubF5E2Ylyx7KK58n/MtjoAMw=;
	b=vtJrnziUcHbfICwEOPH6nzT0/Un49Be1ClRYr7IMpfX42Axs6pawEhyI2W7PeeDNqWhMEV
	DpxINkyLNIiraH8JWBFtDGnhPFhiGwmpC9HDwprsLw2YNkgOdk/HSiaYv9TS64r4imXVlr
	t5747ggqqzHJHIl/wlf3/i554Qb9+Ns=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, hannes@cmpxchg.org, linux-mm@kvack.org, 
	kernel-team@meta.com, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and
 internal rb tree
Message-ID: <4hwdxhdxgjyxgxutzggny4isnb45jxtump7j7tzzv6paaqg2lr@55sguz7y4hu7>
References: <CAJnrk1bzuJjsfevYasbpHZXvpS=62Ofo21aQSg8wWFns82H-UA@mail.gmail.com>
 <0c3e6a4c-b04e-4af7-ae85-a69180d25744@fastmail.fm>
 <CAJnrk1b=ntstDcnjgLsmX+wTyHaiC9SZ7cdSRF2Zbb+0SAG1Zw@mail.gmail.com>
 <023c4bab-0eb6-45c5-9a42-d8fda0abec02@fastmail.fm>
 <CAJnrk1aqMY0j179JwRMZ3ZWL0Hr6Lrjn3oNHgQEiyUwRjLdVRw@mail.gmail.com>
 <c1cac2b5-e89f-452a-ba4f-95ed8d1ab16f@fastmail.fm>
 <CAJnrk1ZLEUZ9V48UfmXyF_=cFY38VdN=VO9LgBkXQSeR-2fMHw@mail.gmail.com>
 <rdqst2o734ch5ttfjwm6d6albtoly5wgvmdyyqepieyjo3qq7n@vraptoacoa3r>
 <ba12ca3b-7d98-489d-b5b9-d8c5c4504987@fastmail.fm>
 <CAJnrk1b9ttYVM2tupaNy+hqONRjRbxsGwdFvbCep75v01RtK+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1b9ttYVM2tupaNy+hqONRjRbxsGwdFvbCep75v01RtK+g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 30, 2024 at 03:51:08PM GMT, Joanne Koong wrote:
> On Wed, Oct 30, 2024 at 3:17 PM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
> >
> >
> >
> > On 10/30/24 22:56, Shakeel Butt wrote:
> > > On Wed, Oct 30, 2024 at 10:35:47AM GMT, Joanne Koong wrote:
> > >> On Wed, Oct 30, 2024 at 10:27 AM Bernd Schubert
> > >> <bernd.schubert@fastmail.fm> wrote:
> > >>>
> > >>>
> > >>> Hmm, if tmp pages can be compacted, isn't that a problem for splice?
> > >>> I.e. I don't understand what the difference between tmp page and
> > >>> write-back page for migration.
> > >>>
> > >>
> > >> That's a great question! I have no idea how compaction works for pages
> > >> being used in splice. Shakeel, do you know the answer to this?
> > >>
> > >
> > > Sorry for the late response. I still have to go through other unanswered
> > > questions but let me answer this one quickly. From the way the tmp pages
> > > are allocated, it does not seem like they are movable and thus are not
> > > target for migration/compaction.
> > >
> > > The page with the writeback bit set is actually just a user memory page
> > > cache which is moveable but due to, at the moment, under writeback it
> > > temporarily becomes unmovable to not cause corruption.
> >
> > Thanks a lot for your quick reply Shakeel! (Actually very fast!).
> >
> > With that, it confirms what I wrote earlier - removing tmp and ignoring
> > fuse writeback pages in migration should not make any difference
> > regarding overall system performance. Unless I miss something,
> > more on the contrary as additional memory pressure expensive page
> > copying is being removed.
> >
> 
> Thanks for the information Shakeel, and thanks Bernd for bringing up
> this point of discussion.
> 
> Before I celebrate too prematurely, a few additional questions:

You are asking hard questions, so CCed couple more folks to correct me
if I am wrong.

> 
> Are tmp pages (eg from folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0)) and
> page cache pages allocated from the same memory pool? Or are tmp pages
> allocated from a special memory pool that isn't meant to be
> compacted/optimized?

Memory pool is a bit confusing term here. Most probably you are asking
about the migrate type of the page block from which tmp page is
allocated from. In a normal system, tmp page would be allocated from page
block with MIGRATE_UNMOVABLE migrate type while the page cache page, it
depends on what gfp flag was used for its allocation. What does fuse fs
use? GFP_HIGHUSER_MOVABLE or something else? Under low memory situation
allocations can get mixed up with different migrate types.

> 
> If they are allocated from the same memory pool, then it seems like
> there's no difference between tmp pages blocking a memory range from
> being compacted vs. a page cache page blocking a memory range from
> being compacted (by not clearing writeback). But if they are not
> allocated from the same pool, then it seems like the page cache page
> blocking migration could adversely affect general system performance
> in a way that the tmp page doesn't?

I think irrespective of where the page is coming from, the page under
writeback is non-movable and can fragment the memory. The question that
is that worse than a tmp page fragmenting the memory, I am not sure.


