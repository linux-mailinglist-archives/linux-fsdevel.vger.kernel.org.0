Return-Path: <linux-fsdevel+bounces-22063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CE4911920
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 05:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219051C21B11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 03:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D58412B176;
	Fri, 21 Jun 2024 03:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YfaQwRKU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7038615A
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2024 03:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718941951; cv=none; b=qnQXaft7SArXu4W6idnG0EORBQkODmJKFxMmA6vB15aSkgkAGu3Q5WAZ1NyrlSKoHaxlPGfG78oy2kydful9dVmFkS6TwtBGAgQnRRq8hdx7CYGoPTyauR+FiE7bGXETToVgSgM5F7VyJrMhzLYVsJftPdz24ao0C1FqJRiaKNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718941951; c=relaxed/simple;
	bh=m5ETCLaPN8UR8b5RCn8HPdair4fuPnY0GGTqgRSKIUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lt8KbYN9VSD7RIEAQc30JYabOEKfcWDZjqoPqsGLn4oCQwMAye9y38NfD4WdXXaTqjbcshOEOO4V7g30n5jM5uTWN/igQFzLctm8QqB/Rl4Y0/BTek/mHE6Te/CGZJhOtu3DmsoaGUBlYk9yDK+pL8E0hoYwS0h7Y42I2nclayM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YfaQwRKU; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: ming.lei@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718941947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pqa8BVPWkrn3u7FhgpP65VDfzqynhi2k8FFInyp8MDA=;
	b=YfaQwRKUbS0OlzXx+Obq5JjeZReQHoyPMZwSC4vwwQqKSRsa/S5ypzGxFB1ahrrO3zQzrC
	cf7SeMvnK/QpdRbJMp8NwNQeT6nVA2ofzqjaEqlXVYLqUyE3MeRXjxxEesj7PCpybmvGUi
	17U1HF+Z0ZB/p82W+YLedtVg6T8e75M=
X-Envelope-To: hch@lst.de
X-Envelope-To: willy@infradead.org
X-Envelope-To: lihongbo22@huawei.com
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: axboe@kernel.dk
Date: Thu, 20 Jun 2024 23:52:23 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>, 
	Hongbo Li <lihongbo22@huawei.com>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: bvec_iter.bi_sector -> loff_t? (was: Re: [PATCH] bcachefs: allow
 direct io fallback to buffer io for) unaligned length or offset
Message-ID: <ng5ycfkl6zysjjc7fcdif6r7ww5tkcb2sa4fgs4qvaziotdyo7@hivd42rp5ems>
References: <20240620132157.888559-1-lihongbo22@huawei.com>
 <bbf7lnl2d5sxdzqbv3jcn6gxmtnsnscakqmfdf6vj4fcs3nasx@zvjsxfwkavgm>
 <ZnQ0gdpcplp_-aw7@casper.infradead.org>
 <20240620153050.GA26369@lst.de>
 <hehodpowajdsfscwf7y3yaqsu2byhzkwpsiaesj5sz722efzg4@gwnod5qe7ed4>
 <ZnTb25qQxSi+tNOk@fedora>
 <6b45ixfmsxdsza6csmlnoatuv24ja3ffdp6lzijfhyjyylfofs@4tpl66qhxrr7>
 <ZnT1NGI7jcI//en+@fedora>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnT1NGI7jcI//en+@fedora>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 21, 2024 at 11:36:20AM +0800, Ming Lei wrote:
> On Thu, Jun 20, 2024 at 11:07:19PM -0400, Kent Overstreet wrote:
> > On Fri, Jun 21, 2024 at 09:48:11AM +0800, Ming Lei wrote:
> > > On Thu, Jun 20, 2024 at 11:43:44AM -0400, Kent Overstreet wrote:
> > > > On Thu, Jun 20, 2024 at 05:30:50PM +0200, Christoph Hellwig wrote:
> > > > > On Thu, Jun 20, 2024 at 02:54:09PM +0100, Matthew Wilcox wrote:
> > > > > > I'm against it.  Block devices only do sector-aligned IO and we should
> > > > > > not pretend otherwise.
> > > > > 
> > > > > While I agree with that, the bvec_iter is actually used in a few other
> > > > > places and could be used in more, and the 512-byte sector unit bi_sector
> > > > > is the only weird thing that's not useful elsewhere.  So turning that
> > > > > into a
> > > > > 
> > > > > 	u64 bi_addr;
> > > > > 
> > > > > that is byte based where the meaning is specific to the user would
> > > > > actually be kinda nice.  For traditional block users we'd need a
> > > > > bio_sector() helpers similar to the existing bio_sectors() one,
> > > > > but a lot of non-trivial drivers actually need to translated to
> > > > > a variable LBA-based addressing, which would be (a tiny little bit)
> > > > > simpler with the byte address.   As bi_size is already in bytes
> > > > > it would also fit in pretty naturally with that.
> > > > > 
> > > > > The only thing that is really off putting is the amount of churn that
> > > > > this would cause.
> > > > 
> > > > I'm being imprecise when I just say 'struct bio'; there's things in
> > > > there that are block layer specific but there are also things in there
> > > > you want that aren't block layer specific (completion callback, write
> > > > flags, s/bi_bdev/bi_inode and that as well, perhaps). It's not at all
> > > > clear to me we'd want to deal with the churn to split that up or make
> > > > bio itself less block layer specific (although, but when I say 'aiming
> > > > for commality with struct bio' that sort of thing is what I have in
> > > > mind.
> > > > 
> > > > But more immediately, yes - bi_addr as all we need for this, and like
> > > > you said I think it'd be a worthwhile change.
> > > 
> > > Still not clear why you need unaligned bi_addr for bio, if this bio needs
> > > to call submit_bio(), it has to be aligned. Otherwise, you could invent any
> > > structure for this purpose, and the structure can be payload of bio for
> > > avoiding extra allocation, even it can be FS generic structure.
> > 
> > We want to have fewer scatter/gather list data structures, not more.
> 
> OK, that look fine to change to bi_addr since bvec_iter is widely used now,
> maybe .bi_sector can be moved into bio, cause bvec iterator needn't it.

No, we'd just add a bio_sector() helper that does the shift.

