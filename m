Return-Path: <linux-fsdevel+bounces-33384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF9B9B8628
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 23:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70AA41C21094
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 22:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828141CDFC5;
	Thu, 31 Oct 2024 22:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iRM13131"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5531C7B62
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 22:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730414305; cv=none; b=OOyg/wiHeGZUgA7Pro1AqTgP7xRcRjWnpWgirjkW+8h19Ae5AJ5ty9TkHc5M/OKQWL7DkPbpOeixcddTuvS9u+2WEWbM4y+8qa6BsgRewCZ+0GLkA9gpkiJ3Ci93jhqCs/ntYg+lhm+It4+5pY3V+jQ6kITlA4PjLsayUB4WnVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730414305; c=relaxed/simple;
	bh=pEtJFirKYNPDxNHu1rbuUAcZ2a+FlpqDvHvQ9or4KQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6mxjOQ+nFJGAajMpxeXUbbBYj+ZVqhhtaykHJRX2rxyCHztzv56JYthEILStVjm9QD/JcikclquRh/3SKB++E2r3aZ3V0kRhKuT0EAAjdVJdO4tz7s7j1Li1itLSnNtEqDkvbwjOHNWq2XuIAWdzJXFjsOTv8wZj8U/rzE6nDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iRM13131; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 31 Oct 2024 15:38:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730414291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=74hfOt/lovYKoEC45qaB+42kzXinawa2j3XQtAHYyFk=;
	b=iRM13131QsDUGMtXwAkzV5OvK/9XPSdi/CE9XIu/2W7LzSrhw1f7pI8glxlDDZYFwjHmve
	1lgOjPtdO4MT3mVWYcXRdjttDeEAb4ZZeC2wGyqe5zosxcFWneRn13ERYc29rTC8shpsDV
	RbeU2F7cCTM8a7TgH3rOzsJ4ruqzFN0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, hannes@cmpxchg.org, linux-mm@kvack.org, 
	kernel-team@meta.com, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and
 internal rb tree
Message-ID: <fqfgkvavsktbgonbdpy766bl3c2634b4c7aghi4tndwurxqhp2@qphspeeemlzg>
References: <CAJnrk1aqMY0j179JwRMZ3ZWL0Hr6Lrjn3oNHgQEiyUwRjLdVRw@mail.gmail.com>
 <c1cac2b5-e89f-452a-ba4f-95ed8d1ab16f@fastmail.fm>
 <CAJnrk1ZLEUZ9V48UfmXyF_=cFY38VdN=VO9LgBkXQSeR-2fMHw@mail.gmail.com>
 <rdqst2o734ch5ttfjwm6d6albtoly5wgvmdyyqepieyjo3qq7n@vraptoacoa3r>
 <ba12ca3b-7d98-489d-b5b9-d8c5c4504987@fastmail.fm>
 <CAJnrk1b9ttYVM2tupaNy+hqONRjRbxsGwdFvbCep75v01RtK+g@mail.gmail.com>
 <4hwdxhdxgjyxgxutzggny4isnb45jxtump7j7tzzv6paaqg2lr@55sguz7y4hu7>
 <CAJnrk1aY-OmjhB8bnowLNYosTP_nTZXGpiQimSS5VRfnNgBoJA@mail.gmail.com>
 <ipa4ozknzw5wq4z4znhza3km5erishys7kf6ov26kmmh4r7kph@vedmnra6kpbz>
 <CAJnrk1aZV=1mXwO+SNupffLQtQNeD3Uz+PBcxL1TKBDgGsgQPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aZV=1mXwO+SNupffLQtQNeD3Uz+PBcxL1TKBDgGsgQPg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 31, 2024 at 02:52:57PM GMT, Joanne Koong wrote:
> On Thu, Oct 31, 2024 at 1:06 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Thu, Oct 31, 2024 at 12:06:49PM GMT, Joanne Koong wrote:
> > > On Wed, Oct 30, 2024 at 5:30 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > [...]
> > > >
> > > > Memory pool is a bit confusing term here. Most probably you are asking
> > > > about the migrate type of the page block from which tmp page is
> > > > allocated from. In a normal system, tmp page would be allocated from page
> > > > block with MIGRATE_UNMOVABLE migrate type while the page cache page, it
> > > > depends on what gfp flag was used for its allocation. What does fuse fs
> > > > use? GFP_HIGHUSER_MOVABLE or something else? Under low memory situation
> > > > allocations can get mixed up with different migrate types.
> > > >
> > >
> > > I believe it's GFP_HIGHUSER_MOVABLE for the page cache pages since
> > > fuse doesn't set any additional gfp masks on the inode mapping.
> > >
> > > Could we just allocate the fuse writeback pages with GFP_HIGHUSER
> > > instead of GFP_HIGHUSER_MOVABLE? That would be in fuse_write_begin()
> > > where we pass in the gfp mask to __filemap_get_folio(). I think this
> > > would give us the same behavior memory-wise as what the tmp pages
> > > currently do,
> >
> > I don't think it would be the same behavior. From what I understand the
> > liftime of the tmp page is from the start of the writeback till the ack
> > from the fuse server that writeback is done. While the lifetime of the
> > page of the page cache can be arbitrarily large. We should just make it
> > unmovable for its lifetime. I think it is fine to make the page
> > unmovable during the writeback. We should not try to optimize for the
> > bad or buggy behavior of fuse server.
> >
> > Regarding the avoidance of wait on writeback for fuse folios, I think we
> > can handle the migration similar to how you are handling reclaim and in
> > addition we can add a WARN() in folio_wait_writeback() if the kernel ever
> > sees a fuse folio in that function.
> 
> Awesome, this is what I'm planning to do in v3 to address migration then:
> 
> 1) in migrate_folio_unmap(), only call "folio_wait_writeback(src);" if
> src->mapping does not have the AS_NO_WRITEBACK_WAIT bit set on it (eg
> fuse folios will have that AS_NO_WRITEBACK_WAIT bit set)
> 
> 2) in the fuse filesystem's implementation of the
> mapping->a_ops->migrate_folio callback, return -EAGAIN if the folio is
> under writeback.

3) Add WARN_ONCE() in folio_wait_writeback() if folio->mapping has
AS_NO_WRITEBACK_WAIT set and return without waiting.

> 
> Does this sound good?

Yes.

