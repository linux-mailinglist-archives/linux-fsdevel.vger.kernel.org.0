Return-Path: <linux-fsdevel+bounces-27516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 254F4961DBD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 06:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583221C22A6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 04:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D751487FE;
	Wed, 28 Aug 2024 04:48:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BAD3D96A;
	Wed, 28 Aug 2024 04:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724820535; cv=none; b=OPXzscQRBdRbVc2YEW4FFpSHBoWPOBAoIb0C444sgjOnCq0t7vyftH/DHNv/8c++QkQxgViSlIJo5WM4TZEdqFYqcpl6K9GDmuCzU7h1aQBluiM2ZgLiJFBNyr/8tuepKALq4B1sE9Vq/WH6OjjXarp9AZbqYmNcHqQysyL+KOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724820535; c=relaxed/simple;
	bh=kiHT81fhyIPby1exHgmOJxmZcW/7Jl+utzDPXB/VNhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0LTqD5WpdaKtU/1j/3GbpsgsoM/8tKWPZ7ka8SB426oOt+gxV1JIfjdECiMFHv5lxozq1WGiMrDHD+Z6j0kJ6ovbCRR2Rml7dRUZx53yTy+0IuMyQb4hpWP3VsU8wkOqhlsoQAP67JOB+//5Jsv3C0cU6VO4qJUEdGZn4Z54cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D101C227A88; Wed, 28 Aug 2024 06:48:48 +0200 (CEST)
Date: Wed, 28 Aug 2024 06:48:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/10] iomap: handle a post-direct I/O invalidate race
 in iomap_write_delalloc_release
Message-ID: <20240828044848.GA31463@lst.de>
References: <20240827051028.1751933-1-hch@lst.de> <20240827051028.1751933-2-hch@lst.de> <20240827161416.GV865349@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827161416.GV865349@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 27, 2024 at 09:14:16AM -0700, Darrick J. Wong wrote:
> Is there any chance that we could get stuck in a loop here?  I
> think it's the case that if SEEK_HOLE returns data_end == start_byte,
> then the next time through the loop, the SEEK_DATA will return something
> that is > start_byte.

Yes.

> Unless someone is very rapidly writing and
> punching the page cache?
> 
> Hmm but then if *xfs* is punching delalloc then we're we holding the
> iolock so who else could be doing that?

Yes.  It's only the async direct I/O completions that punch without
the lock.


