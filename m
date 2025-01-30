Return-Path: <linux-fsdevel+bounces-40452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A1AA23748
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 23:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADAED3A534F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 22:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D1A1F151A;
	Thu, 30 Jan 2025 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZgfJNtQp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEE51E4B2
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 22:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738276451; cv=none; b=BJP6rVJYil8UbbD2pwzBzggaCcvVWRpBaaMm1yO+3jixRz4iBh8qaFJlCNtXF4Tf4z2zze8ERTmNN5YB43kKAXNInVhz5fVn54v1nbCc07dXsE5zl4yewIxrSZkC7t5IpyBKqZmfTPZoNPFeAFLcetuXz2RAjHKdI8Md+gVFlM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738276451; c=relaxed/simple;
	bh=QUXRcH3PvItOfGNCN9WXABWY5dRu8YXB41G5R1l310k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5gKhZNMwBAl0xx4Nd4iAn3OtPsW2ZkItw5a5bHjce8YMisdhcQj4HG10eztIVoAOdDRRk1TRs5tZYllFtJKxruFdXJv64j1vonFrYqVGzva3A/qEjcR/FOTV5hrjEEZ87wX7xKqjPYbaPlYk6nTOsaTS1sFA6fgrl6dsWGM8B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZgfJNtQp; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 30 Jan 2025 14:33:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738276441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lqDBs28UY+vyMRF9P3GmfFSE5VYbAkGtu2cFiNCq+E4=;
	b=ZgfJNtQpuW6OR2UioMpO3e+CRls1HBx9yWGOI3OtHc0bNhd+TDyT4v5WiOA1/OLtqXFzHB
	TTIZQHcpckr5e43+tbYVmaVI8Xl97n+PcaKNQPzsFJ2/cK8g/4NTdxFTov8FaN/fOWdHYT
	19fbbhiZexxJNl6sqdofqRKVY0z8pQ8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Jeff Layton <jlayton@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [LSF/MM/BPF TOPIC] Migrating the un-migratable
Message-ID: <euzurxcimhegubx7cisr7rh7z2jymd2zkc65zy6x2t2dv44ycz@m6skjuezgup3>
References: <882b566c-34d6-4e68-9447-6c74a0693f18@redhat.com>
 <Z5vzuii9-zS-WsCH@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5vzuii9-zS-WsCH@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 30, 2025 at 09:48:42PM +0000, Matthew Wilcox wrote:
> On Wed, Jan 29, 2025 at 05:10:03PM +0100, David Hildenbrand wrote:
> > As one example, in context of FUSE we recently discovered that folios that
> > are under writeback cannot be migrated, and user space in control of when
> > writeback will end. Something similar can happen ->readahead() where user
> > space is in charge of supplying page content. Networking filesystems in
> > general seem to be prone to this as well.
> 
> You're not wrong.  The question is whether we're willing to put the
> asterisk on "In the presence of a misbehaving server (network or fuse),
> our usual guarantees do not apply".  I'm not sure it's a soluble
> problem, though.  Normally writeback (or, as you observed, readahead)
> completes just fine and we don't need to use non-movable pages for them.
> 
> But if someone trips over the network cable, anything in flight becomes
> unmovable until someone plugs it back in.  We've given the DMA address
> of the memory to a network adapter, and that's generally a non-revokable
> step (maybe the iommu could save us, but at what cost?)
> 

My position is more aligned with Willy's. We definitely should discuss
if we can solve the general problem of (im)movability due to writeback
or readahead but I think targeting precise problem will be more
fruitful. Untrusted fuse server deliberatly causing immovable memory is
a real problem as anyone can run fuse server and mount fuse without any
permissions. At least to me a misbehaving but trusted server is less of
an (practical) issue. (Please correct me if I miss something like this
is also a real issue in multi-tenancy world).

Joanne has some ideas [1] on fuse specific solution but having a
discussion on general solution would be beneficial as well.

[1] https://lore.kernel.org/all/CAJnrk1ZCgff6ZWmqKzBXFq5uAEbms46OexA1axWS5v-PCZFqJg@mail.gmail.com/

