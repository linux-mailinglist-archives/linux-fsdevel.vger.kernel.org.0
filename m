Return-Path: <linux-fsdevel+bounces-24627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8E4941CC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 19:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8D11C21CB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 17:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BCE18E020;
	Tue, 30 Jul 2024 17:08:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F32189522
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359318; cv=none; b=q4bpU4BMh4kWJz+iMK++3VGpwSGGvuol0XJsVDe6kokgn+ns5yVZ6F6h5scUE1z0zVYoBCa2rOOmOrA5OGZc0u3zQFBztkCn0XFzzmlnMVlIdmiUfowRw3KZVGGUezN43jBxynYP3MVk85Xvrj/vqjIF5K5MQQVHJp9SINkA0oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359318; c=relaxed/simple;
	bh=dEDHdGLjUOS+uradvlQOEtiDGwQdhaRz7IrbkZBFh3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVTmC5JHLGj3CF1BqsKZkpwKe7mijNAUZhgF0u8RZKsUeVe1hmXufc6MPDiMoRRk23nk9prEtubCWlUAucmC+yhzF8b+K1AY9aNW11dncUBTCgIfON1ZlRMM3+bRJvY5VcakN6WT0ppRnSotAqmwWicd7mntQTrXLXF5KUdDj/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A4FFB68AA6; Tue, 30 Jul 2024 19:08:31 +0200 (CEST)
Date: Tue, 30 Jul 2024 19:08:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Florian Weimer <fweimer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Paul Eggert <eggert@cs.ucla.edu>,
	libc-alpha@sourceware.org, linux-fsdevel@vger.kernel.org,
	Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: posix_fallocate behavior in glibc
Message-ID: <20240730170831.GA31915@lst.de>
References: <20240729160951.GA30183@lst.de> <87a5i0krml.fsf@oldenburg.str.redhat.com> <20240729184430.GA1010@lst.de> <877cd4jajz.fsf@oldenburg.str.redhat.com> <20240729190100.GA1664@lst.de> <8734nsj93p.fsf@oldenburg.str.redhat.com> <20240730154730.GA30157@lst.de> <e2fe77d0-ffa6-42d1-a589-b60304fd46e9@cs.ucla.edu> <20240730162042.GA31109@lst.de> <87o76ezua1.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o76ezua1.fsf@oldenburg.str.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 30, 2024 at 07:03:50PM +0200, Florian Weimer wrote:
> > The only relevant exception is probably ext4 in ext2/ext3 mode, where
> > the latter might still have users left running real workloads on it
> > and not using it for usb disks or VM images.
> 
> Why doesn't the kernel perform allocation in these cases?  There doesn't
> seem to be a file-system-specific reason why it's impossible to do.

Because in general it's a really stupid idea.  You don't get a better
allocation patter, but you are writing every block twice, making things
significantly slower and wearing the device out in the process if it
is flash based.

> At the very least, we should have a variant of ftruncate that never
> truncates, likely under the fallocate umbrella.  It seems that that's
> how posix_fallocate is used sometimes, for avoiding SIGBUS with mmap.
> To these use cases, whether extents are allocated or not does not
> matter.

I don't see how that is related.

> If we removed the fallback code from glibc today, it would just be
> EOPNOTSUPP that leaks to applications, so it's structurally the same
> issue.

Not really.  EOPNOTSUPP is a valid error code, that has historically
been returned by other operating systems and even other libc
implementations for Linux


