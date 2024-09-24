Return-Path: <linux-fsdevel+bounces-29933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F66983CEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 08:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF88428242D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 06:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D645F5A79B;
	Tue, 24 Sep 2024 06:17:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757691B85EB;
	Tue, 24 Sep 2024 06:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158646; cv=none; b=F2ii59nHFhI9v8HZzAsJUjnaQzoGQ75uQRr1DA+9GuE/5j1XzmoDpq0tHkasb98yaRoiVocJFQ7kUGewR1h8OCz9awL6uEuUb6506zL3YqH5sStxHtHThGGr2zO+cjFffzNBFjgXGGphFWa/7BT08OqWHBMGRwfEGL/arDh4HB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158646; c=relaxed/simple;
	bh=EynF5x8i3TEKTkw8e7/bXdZ5YKiX3VLUSu5fx0A/UYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGCd8yH56Gq6jx9vQ1a24h8Bhecq8RhI5ZTMvpABfcKXym44cd+VZqfLXzK5ZgAD3RvK8L5qcSNLZ9Mcjo2HL2P8iUcv7JLJBHzr3YJRuCi89KOEw/23gmWLojiQa6elU96LzLcZOkCwaCYCFDu+j/OvpvEnP4anDxPJMWdpXFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AE9AB227A8E; Tue, 24 Sep 2024 08:17:19 +0200 (CEST)
Date: Tue, 24 Sep 2024 08:17:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>,
	Ritesh Harjani <ritesh.list@gmail.com>, chandan.babu@oracle.com,
	djwong@kernel.org, dchinner@redhat.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	catherine.hoang@oracle.com, martin.petersen@oracle.com
Subject: Re: [PATCH v4 00/14] forcealign for xfs
Message-ID: <20240924061719.GA11211@lst.de>
References: <8734m7henr.fsf@gmail.com> <ZufYRolfyUqEOS1c@dread.disaster.area> <c8a9dba5-7d02-4aa2-a01f-dd7f53b24938@oracle.com> <Zun+yci6CeiuNS2o@dread.disaster.area> <8e13fa74-f8f7-49d3-b640-0daf50da5acb@oracle.com> <ZvDZHC1NJWlOR6Uf@dread.disaster.area> <20240923033305.GA30200@lst.de> <cfdbb625-90b8-45d1-838b-bf5b670f49f1@oracle.com> <20240923120715.GA13585@lst.de> <c702379b-3f37-448d-ac28-ec1e248a6c65@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c702379b-3f37-448d-ac28-ec1e248a6c65@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 23, 2024 at 01:33:12PM +0100, John Garry wrote:
>> As a first step by not making it worse, and that not only means not
>> spreading the rtextent stuff further,
>
> I assume that refactoring rtextent into "big alloc unit" is spreading 
> (rtextent stuff), right? If so, what other solution? CoW?

Well, if you look at the force align series you'd agree that it
spreads the thing out into the btree allocator.  Or do I misread it?

>
>> but more importantly not introducing
>> additional complexities by requiring to be able to write over the
>> written/unwritten boundaries created by either rtextentsize > 1 or
>> the forcealign stuff if you actually want atomic writes.
>
> The very original solution required a single mapping and in written state 
> for atomic writes. Reverting to that would save a lot of hassle in the 
> kernel. It just means that the user needs to manually pre-zero.

What atomic I/O sizes do your users require?  Would they fit into
a large sector size now supported by XFS (i.e. 32k for now).


