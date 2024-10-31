Return-Path: <linux-fsdevel+bounces-33370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E791A9B8422
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 21:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DF3A1F23DEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 20:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3911BDA99;
	Thu, 31 Oct 2024 20:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T+1tP24o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A8C19ABB4
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 20:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730405212; cv=none; b=KeZlywT+us577us7ea6Fomf5V9Q1lrH6R6IMuERwQBppCSVEZdljEAKmymI7oK8qDmJaxlEr9wU5foCjMFvLIc6IMGyts1avRIF9mpT+9viOrDrJYEA1h64lilWuUkPcNicLoEZxTpdiIV+vE6hUG0wi1l0WS0Ye0moeLYQUPPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730405212; c=relaxed/simple;
	bh=xYp87ytXITIBe+LgHJTWBTLcpckebczgMOYRxTkeeGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZ+5cYV5H5FuGL7sz2/AtD1yOu3CI3brXbuSX3rh5UoFkqI1Cll9IJrZ9esDFdRvsV0kD5vsCg9O5msctQQyw2tVPIJi6kgHJFIdJEvH0alwDkSMmW1Hb9IbIN7UIhOxqyW3ED/gzf5xhz0FBSDfaKZ0DGcel1Jmzh/dhjOywCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T+1tP24o; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 31 Oct 2024 13:06:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730405208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3piDMTe1Kk4AU/igSSQtPB4+xpblPFIYxIyz1dyWvI=;
	b=T+1tP24oQEx0lYJwh8asvqHHD7CJAWJxtU/lIN3BRw2a2NNmTEgeTEWYIHLFKdGuAY7eFr
	2HNS4bD5SOrL5n8pmwz9EUxrnl6tR6cjMEg8oTEsIRPS3SRQFe7kpowy+TEhLXZdV1+Z9E
	worvHcF1Vz1omdEvc8aKnEQ1Hyzv5ko=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, hannes@cmpxchg.org, linux-mm@kvack.org, 
	kernel-team@meta.com, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and
 internal rb tree
Message-ID: <ipa4ozknzw5wq4z4znhza3km5erishys7kf6ov26kmmh4r7kph@vedmnra6kpbz>
References: <CAJnrk1b=ntstDcnjgLsmX+wTyHaiC9SZ7cdSRF2Zbb+0SAG1Zw@mail.gmail.com>
 <023c4bab-0eb6-45c5-9a42-d8fda0abec02@fastmail.fm>
 <CAJnrk1aqMY0j179JwRMZ3ZWL0Hr6Lrjn3oNHgQEiyUwRjLdVRw@mail.gmail.com>
 <c1cac2b5-e89f-452a-ba4f-95ed8d1ab16f@fastmail.fm>
 <CAJnrk1ZLEUZ9V48UfmXyF_=cFY38VdN=VO9LgBkXQSeR-2fMHw@mail.gmail.com>
 <rdqst2o734ch5ttfjwm6d6albtoly5wgvmdyyqepieyjo3qq7n@vraptoacoa3r>
 <ba12ca3b-7d98-489d-b5b9-d8c5c4504987@fastmail.fm>
 <CAJnrk1b9ttYVM2tupaNy+hqONRjRbxsGwdFvbCep75v01RtK+g@mail.gmail.com>
 <4hwdxhdxgjyxgxutzggny4isnb45jxtump7j7tzzv6paaqg2lr@55sguz7y4hu7>
 <CAJnrk1aY-OmjhB8bnowLNYosTP_nTZXGpiQimSS5VRfnNgBoJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aY-OmjhB8bnowLNYosTP_nTZXGpiQimSS5VRfnNgBoJA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 31, 2024 at 12:06:49PM GMT, Joanne Koong wrote:
> On Wed, Oct 30, 2024 at 5:30 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
[...]
> >
> > Memory pool is a bit confusing term here. Most probably you are asking
> > about the migrate type of the page block from which tmp page is
> > allocated from. In a normal system, tmp page would be allocated from page
> > block with MIGRATE_UNMOVABLE migrate type while the page cache page, it
> > depends on what gfp flag was used for its allocation. What does fuse fs
> > use? GFP_HIGHUSER_MOVABLE or something else? Under low memory situation
> > allocations can get mixed up with different migrate types.
> >
> 
> I believe it's GFP_HIGHUSER_MOVABLE for the page cache pages since
> fuse doesn't set any additional gfp masks on the inode mapping.
> 
> Could we just allocate the fuse writeback pages with GFP_HIGHUSER
> instead of GFP_HIGHUSER_MOVABLE? That would be in fuse_write_begin()
> where we pass in the gfp mask to __filemap_get_folio(). I think this
> would give us the same behavior memory-wise as what the tmp pages
> currently do,

I don't think it would be the same behavior. From what I understand the
liftime of the tmp page is from the start of the writeback till the ack
from the fuse server that writeback is done. While the lifetime of the
page of the page cache can be arbitrarily large. We should just make it
unmovable for its lifetime. I think it is fine to make the page
unmovable during the writeback. We should not try to optimize for the
bad or buggy behavior of fuse server.

Regarding the avoidance of wait on writeback for fuse folios, I think we
can handle the migration similar to how you are handling reclaim and in
addition we can add a WARN() in folio_wait_writeback() if the kernel ever
sees a fuse folio in that function.

