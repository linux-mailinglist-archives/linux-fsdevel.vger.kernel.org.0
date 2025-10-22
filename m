Return-Path: <linux-fsdevel+bounces-65067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E03B4BFABE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 10:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFD5405C5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 08:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880012FFFA4;
	Wed, 22 Oct 2025 08:01:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A290221FDA;
	Wed, 22 Oct 2025 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120080; cv=none; b=V9RsqYXBBMuXKJf/DJOlpd5NwiRz5C25F11QXKDmkY4HfshXneCub1fXmON8iyGAjKlsOla7sDLiEOQce+6xoek5EtbEBhUM8G4sqtwHtSRIIAoIyf2ydScMMpzXyyE0AvgqZ7SoxWMXSCbPu9zF5E4lkahGchGKlqdgmrSdM4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120080; c=relaxed/simple;
	bh=wOX0iSJsgkprjWOzRP3ZMWC3L9S/47SuVmCaRFyl/8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjzs/ZxmYTp6xl3sYJvye/w7E2OTDWK0zIyzFUaso7Erwwlnr05HLeSBffvxO604HgmFiJ9G38i1ltjiMNLD2caqeF2EIrrOa7khuO+UVlDSFxjShUY4ZIBhwzFkWjgUBgM7cN0R7qsgGFGUbzSLpPqYo0lHj36zEz8uaborvlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6B39F227AAA; Wed, 22 Oct 2025 10:01:11 +0200 (CEST)
Date: Wed, 22 Oct 2025 10:01:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, axboe@kernel.dk,
	brauner@kernel.org, josef@toxicpanda.com, jack@suse.cz,
	jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [RFC PATCH 2/5] fs: add the interface to query user write
 streams
Message-ID: <20251022080110.GA9997@lst.de>
References: <20250729145135.12463-1-joshi.k@samsung.com> <CGME20250729145335epcas5p462315e4dae631a1d940b6c3b2b611659@epcas5p4.samsung.com> <20250729145135.12463-3-joshi.k@samsung.com> <20250812082240.GB22212@lst.de> <4cf4ebdd-a33f-4ff5-8016-aff8a6a87c54@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cf4ebdd-a33f-4ff5-8016-aff8a6a87c54@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 16, 2025 at 03:27:22PM +0530, Kanchan Joshi wrote:
> On 8/12/2025 1:52 PM, Christoph Hellwig wrote:
> > On Tue, Jul 29, 2025 at 08:21:32PM +0530, Kanchan Joshi wrote:
> >> Add new fcntl F_GET_MAX_WRITE_STREAMS.
> >> This returns the numbers of streams that are available for userspace.
> >>
> >> And for that, use ->user_write_streams() callback when the involved
> >> filesystem provides it.
> >> In absence of such callback, use 'max_write_streams' queue limit of the
> >> underlying block device.
> > As mentioned in patch 1, I think we'd rather dispath the whole fcntl
> > to the file system, and then use generic helpers, which will give
> > more control of the details to the file system.
> 
> 
> I could not follow it, can you please expand that a bit.
> Should I get F_GET_MAX_WRITE_STREAMS dispatched to new inode operation.

Handle all of F_GET_MAX_WRITE_STREAMS in the file system and add a new
file operation for it.

