Return-Path: <linux-fsdevel+bounces-65068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F00BFAC63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 10:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0BA91A04EBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 08:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1714B3081B2;
	Wed, 22 Oct 2025 08:02:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81E7301704;
	Wed, 22 Oct 2025 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120178; cv=none; b=GjW+agkxvH+4z9h0r30IGdYFFcY1Seb2tX1p1kPDJyP9LNN445lxYmJMePOcLG2aKj8AHatfxx9oVTc4IKhq8cq/UHKZBdxbTnO54b7SYAkBE0vbUp4smnURXllqADH+o7Iy+I0Xbrn/ZU98na/KXH1pr/Ni8eIc2SF5VHsnXGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120178; c=relaxed/simple;
	bh=Vz83S0BrXYx5LND9ujOcllPaK5lSvNweJYeF5O5BUKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBu71682mA8DPMIFxZBa2IZIqRBHcaRbKgbOOgsXkuqa1mk+zn+6e668rvHwXc7O5GNXhom2JQhbNt+JQfcAgclE5g05LiguF3JZdXDfeRFvYQ2bmD2o3OPMw/ewEv9WwooTwJeMU0BZnmEPtIcaiPPAL+taPGiiW7bqtq/bm0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5D3EE227A88; Wed, 22 Oct 2025 10:02:52 +0200 (CEST)
Date: Wed, 22 Oct 2025 10:02:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, axboe@kernel.dk,
	brauner@kernel.org, josef@toxicpanda.com, jack@suse.cz,
	jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC PATCH 4/5] fs: propagate write stream
Message-ID: <20251022080251.GB9997@lst.de>
References: <20250729145135.12463-1-joshi.k@samsung.com> <CGME20250729145338epcas5p4da42906a341577997f39aa8453252ea3@epcas5p4.samsung.com> <20250729145135.12463-5-joshi.k@samsung.com> <20250812082404.GD22212@lst.de> <78e760ed-1ba3-4a06-ac51-45b4cd2c05e0@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78e760ed-1ba3-4a06-ac51-45b4cd2c05e0@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 16, 2025 at 03:17:50PM +0530, Kanchan Joshi wrote:
> On 8/12/2025 1:54 PM, Christoph Hellwig wrote:
> > On Tue, Jul 29, 2025 at 08:21:34PM +0530, Kanchan Joshi wrote:
> >> bio->bi_write_stream is not set by the filesystem code.
> >> Use inode's write stream value to do that.
> > Just passing it through is going to create problems.  i.e. when
> > the file system does it's own placement or reserves ids.  We'll need
> > an explicit intercept point between the user write stream and what
> > does into the bio.
> > 
> 
> For that intercept point - will you prefer a generic helper, say 
> fs_resolve_write_stream(), that will call a new inode operation that 
> filesystem will implement?

I don't remember what the patch was doing, but basically the file system
should be explicitly set bio->bi_write_stream instead of automatically
inheriting it.  Where the file system uses helpers we'll have to find
a way to propagate it.  For iomap one option could be to make the file
system return it in struct iomap.

