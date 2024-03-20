Return-Path: <linux-fsdevel+bounces-14917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C030881793
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 19:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F005D1F22A40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 18:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F73C8529B;
	Wed, 20 Mar 2024 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PDnCBuEZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9DC6AFAE
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710960948; cv=none; b=GF8Ee4HTJh+vu5JKhi48hf6ISEnjIC3BPhmwoIBHRhjm/1fPbGkcV4tksrb1Yx/0hgwLXulY+TJlxcNDJEBMamBmk1GXyMQr708RhYqPiz6HDzTd32tlB4kXmp708wlYLF/dFCbJYzDbllNfShecgtdSzcawQtCwwl8COYE2Vbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710960948; c=relaxed/simple;
	bh=jX6auQ2yeXm6JfhERoc4doEO9Iuu8u+75FYD8DsxT4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibWqrVfLBOsz61qffcO+j1zUdSpr7cLEcNhSILFLjN6m1s0FcN56atBr4VvWTYAWs53xAcyYSJfG4rebuDmhymYOg+eIOmacUtnPwajhMx1gB9ac4UvOhR4v93r6uP8hO7uTbknPW8I2lZfuvFPd6Vgj+D7Q0eRrSmPUm/gM4H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PDnCBuEZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3PmEI0D9WC6qbWjMQFdByNKzMVLkjA1cfp8fJnMIdSU=; b=PDnCBuEZfLfrEv+/kKxhyViKtW
	QaQIvr77L/TQkHjj68hUuIPYk0KmOm4JlZ+WLF+zyuEpW7HmzAKjQGqQUPcNqv0D+YzLQOQV4VASO
	pzDogHHxWuLmgcZPuO/9OxabRb1ADXQpIeh16wAmcCeZ3G1ZRjsw94u3ZRT4YZPq1z1DfHXeWFDp8
	TUCSXpUJ/rroG/xU3vYX9jNSV/2rqfNGZjYE6EZyaw5L2Xvm0hhhMKsYZA5BiO+KF6FrNEe2glgp/
	6JSoZLmdnHAPvmFKMoB7g9sbz1TTfZBpUt85TCoNHs1IKnXlDLYz4q58g+S44SnhtmbWWYNlyNQAN
	Rr21zTBw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rn168-00000004uuD-1AMI;
	Wed, 20 Mar 2024 18:55:36 +0000
Date: Wed, 20 Mar 2024 18:55:36 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, NeilBrown <neilb@suse.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Dave Chinner <david@fromorbit.com>,
	Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <ZfsxKOA5vfa9yo76@casper.infradead.org>
References: <Zd-LljY351NCrrCP@casper.infradead.org>
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>
 <ZeFtrzN34cLhjjHK@dread.disaster.area>
 <pv2chxwnrufut6wecm47q2z7222tzdl3gi6s5wgvmk3b2gq3n5@d23qr5odwyxl>
 <170933687972.24797.18406852925615624495@noble.neil.brown.name>
 <xbjw7mn57qik3ica2k6o7ykt7twryod6rt3uvu73w6xahrrrql@iaplvz7t5tgv>
 <170950594802.24797.17587526251920021411@noble.neil.brown.name>
 <a7862cf1-1ed2-4c2c-8a27-f9d950ff4da5@suse.cz>
 <aaea1147-f015-423b-8a42-21fc18930c8f@moroto.mountain>
 <73533d54-2b92-4794-818e-753aaea887f9@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73533d54-2b92-4794-818e-753aaea887f9@suse.cz>

On Wed, Mar 20, 2024 at 07:48:01PM +0100, Vlastimil Babka wrote:
> On 3/20/24 19:32, Dan Carpenter wrote:
> > On Tue, Mar 12, 2024 at 03:46:32PM +0100, Vlastimil Babka wrote:
> >> But if we change it to effectively mean GFP_NOFAIL (for non-costly
> >> allocations), there should be a manageable number of places to change to a
> >> variant that allows failure.
> > 
> > What does that even mean if GFP_NOFAIL can fail for "costly" allocations?
> > I thought GFP_NOFAIL couldn't fail at all...
> 
> Yeah, the suggestion was that GFP_KERNEL would act as GFP_NOFAIL but only
> for non-costly allocations. Anything marked GFP_NOFAIL would still be fully
> nofail.

GFP_NOFAIL should still fail for allocations larger than KMALLOC_MAX_SIZE.
Or should we interpret that as "die now"?  Or "go into an unkillable
sleep"?  If the caller really has taken the opportunity to remove their
error handling path, returning NULL will lead to a crash and a lot of
beard stroking trying to understand why a GFP_NOFAIL allocation has
returned NULL.  May as well BUG_ON(size > KMALLOC_MAX_SIZE) and give
the developer a clear indication of what they did wrong.


