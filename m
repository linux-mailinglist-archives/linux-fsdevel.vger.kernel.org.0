Return-Path: <linux-fsdevel+bounces-33841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC129BFA81
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 00:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A2928457F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 23:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B3120E00C;
	Wed,  6 Nov 2024 23:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gXs7qhov"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6E91E04AC
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Nov 2024 23:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730937391; cv=none; b=GLvV4z6mgX7erwBgSQuvj4lFnuxDEaYyMDe2P2fcQl2oUGeCH5HyRDFYPquSSbOWclzwwXFhrNlzCkhlSdybWRrnfA9I7Wh4hfWgWdLCJBsIZycV20bVdn/ejyYnRVzGLRwhmhmskfxT75BWLZhV3ug0taK5pzmMPBTsW/ppuwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730937391; c=relaxed/simple;
	bh=17hqZQBvyXMncvHerWB98+Qft24xcCU27QYBQggL27g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CC5W/LHpg35oRD7Q0DrGgugUHu2375sxocyK0zHjPC3t7ImkyBC4MDZInFkEXEL8eugV6fAsxOhVOX/0TxS4+Cu0mZMPuIgm12OpaIem3YmvyzQcrla6LWtX6XqEn58ZkSuONdaaM143K1Gz6Wp9SVC57ypGtMZloAiQnqffgqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gXs7qhov; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 6 Nov 2024 15:56:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730937385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WwjeiWb2K0qdNecBV8zVccaOFulKNeLja/T2sJGrqx8=;
	b=gXs7qhovA7Kr7NkqaAV458vaw1Tsdw7BPpxBHUmuXkh1bzfYyISZrFwFYbyJCN2Mdaj/yD
	g+xeVWd87RNCASIe40UyPESC+mFlTykpKcvxaEM7vSafAWwP39khI3cio31wXbpJ6wKfyu
	FDHWQfKX3CpEr3qvDtqKJLMSQopZlEs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, hannes@cmpxchg.org, linux-mm@kvack.org, 
	kernel-team@meta.com, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and
 internal rb tree
Message-ID: <nvcbtm3b3liqhhkmmbjxg5oakonkcbimf7et2scgwo3zuprigx@ycqf2udv34jl>
References: <CAJnrk1ZLEUZ9V48UfmXyF_=cFY38VdN=VO9LgBkXQSeR-2fMHw@mail.gmail.com>
 <rdqst2o734ch5ttfjwm6d6albtoly5wgvmdyyqepieyjo3qq7n@vraptoacoa3r>
 <ba12ca3b-7d98-489d-b5b9-d8c5c4504987@fastmail.fm>
 <CAJnrk1b9ttYVM2tupaNy+hqONRjRbxsGwdFvbCep75v01RtK+g@mail.gmail.com>
 <4hwdxhdxgjyxgxutzggny4isnb45jxtump7j7tzzv6paaqg2lr@55sguz7y4hu7>
 <CAJnrk1aY-OmjhB8bnowLNYosTP_nTZXGpiQimSS5VRfnNgBoJA@mail.gmail.com>
 <ipa4ozknzw5wq4z4znhza3km5erishys7kf6ov26kmmh4r7kph@vedmnra6kpbz>
 <CAJnrk1aZV=1mXwO+SNupffLQtQNeD3Uz+PBcxL1TKBDgGsgQPg@mail.gmail.com>
 <fqfgkvavsktbgonbdpy766bl3c2634b4c7aghi4tndwurxqhp2@qphspeeemlzg>
 <CAJnrk1bdJ7E1z_fWpXe1VHk6o-ZYdN+WaVpS4W0oz_6MZNPacA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1bdJ7E1z_fWpXe1VHk6o-ZYdN+WaVpS4W0oz_6MZNPacA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Nov 06, 2024 at 03:37:11PM -0800, Joanne Koong wrote:
> On Thu, Oct 31, 2024 at 3:38 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Thu, Oct 31, 2024 at 02:52:57PM GMT, Joanne Koong wrote:
> > > On Thu, Oct 31, 2024 at 1:06 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > >
> > > > On Thu, Oct 31, 2024 at 12:06:49PM GMT, Joanne Koong wrote:
> > > > > On Wed, Oct 30, 2024 at 5:30 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > > [...]
> > > > > >
> > > > > > Memory pool is a bit confusing term here. Most probably you are asking
> > > > > > about the migrate type of the page block from which tmp page is
> > > > > > allocated from. In a normal system, tmp page would be allocated from page
> > > > > > block with MIGRATE_UNMOVABLE migrate type while the page cache page, it
> > > > > > depends on what gfp flag was used for its allocation. What does fuse fs
> > > > > > use? GFP_HIGHUSER_MOVABLE or something else? Under low memory situation
> > > > > > allocations can get mixed up with different migrate types.
> > > > > >
> > > > >
> > > > > I believe it's GFP_HIGHUSER_MOVABLE for the page cache pages since
> > > > > fuse doesn't set any additional gfp masks on the inode mapping.
> > > > >
> > > > > Could we just allocate the fuse writeback pages with GFP_HIGHUSER
> > > > > instead of GFP_HIGHUSER_MOVABLE? That would be in fuse_write_begin()
> > > > > where we pass in the gfp mask to __filemap_get_folio(). I think this
> > > > > would give us the same behavior memory-wise as what the tmp pages
> > > > > currently do,
> > > >
> > > > I don't think it would be the same behavior. From what I understand the
> > > > liftime of the tmp page is from the start of the writeback till the ack
> > > > from the fuse server that writeback is done. While the lifetime of the
> > > > page of the page cache can be arbitrarily large. We should just make it
> > > > unmovable for its lifetime. I think it is fine to make the page
> > > > unmovable during the writeback. We should not try to optimize for the
> > > > bad or buggy behavior of fuse server.
> > > >
> > > > Regarding the avoidance of wait on writeback for fuse folios, I think we
> > > > can handle the migration similar to how you are handling reclaim and in
> > > > addition we can add a WARN() in folio_wait_writeback() if the kernel ever
> > > > sees a fuse folio in that function.
> > >
> > > Awesome, this is what I'm planning to do in v3 to address migration then:
> > >
> > > 1) in migrate_folio_unmap(), only call "folio_wait_writeback(src);" if
> > > src->mapping does not have the AS_NO_WRITEBACK_WAIT bit set on it (eg
> > > fuse folios will have that AS_NO_WRITEBACK_WAIT bit set)
> > >
> > > 2) in the fuse filesystem's implementation of the
> > > mapping->a_ops->migrate_folio callback, return -EAGAIN if the folio is
> > > under writeback.
> >
> > 3) Add WARN_ONCE() in folio_wait_writeback() if folio->mapping has
> > AS_NO_WRITEBACK_WAIT set and return without waiting.
> 
> For v3, I'm going to change AS_NO_WRITEBACK_RECLAIM to
> AS_WRITEBACK_MAY_BLOCK and skip 3) because 3) may be too restrictive.
> For example, for the sync_file_range() syscall, we do want to wait on
> writeback - it's ok in this case to call folio_wait_writeback() on a
> fuse folio since the caller would have intentionally passed in a fuse
> fd to sync_file_range().
> 

Sounds good.

