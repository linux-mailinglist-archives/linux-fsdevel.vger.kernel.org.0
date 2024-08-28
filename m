Return-Path: <linux-fsdevel+bounces-27517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B05961DC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 06:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933411F24766
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 04:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E4B1494AC;
	Wed, 28 Aug 2024 04:49:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B223C3D96A;
	Wed, 28 Aug 2024 04:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724820575; cv=none; b=QSrSiq693/Btb6JKa+DYNEDck0rwkqh+4a0bvRMekRt+KATeVOBifc4wNgvYsakBqq+KKrmmuSSHlq5tqs/wOsVYwPND3CSuxvLwxv4mSbV878s4zfGAwECAcXqhGJ75NHIEhPrqDklXjRF7i9z3LxbZuD850NObyCW3lEtFx4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724820575; c=relaxed/simple;
	bh=pD00pe3Y9KEKmLgyJWzTvba2VXiU4LtRm1OaMtwmCSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXv74NUEfbV3vMH2MEplU16fH+2q0/kglj+NeYzCTCudeQkRAW7URW0YGBqhwiBOoTglcT+QCSjGuDiQcd6OTBWkyvlU+O3i5j7ewd3ouD52mfBTOxmcmjzws43bERTRC7ep/AQcDYaF+urHbjX3ra25SeMbQGiKba21u9NDR3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C56FD227A88; Wed, 28 Aug 2024 06:49:30 +0200 (CEST)
Date: Wed, 28 Aug 2024 06:49:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/10] iomap: improve shared block detection in
 iomap_unshare_iter
Message-ID: <20240828044929.GB31463@lst.de>
References: <20240827051028.1751933-1-hch@lst.de> <20240827051028.1751933-3-hch@lst.de> <20240827054424.GM6043@frogsfrogsfrogs> <20240827054757.GA11067@lst.de> <20240827162149.GW865349@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827162149.GW865349@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 27, 2024 at 09:21:49AM -0700, Darrick J. Wong wrote:
> > For writes it usually means out of place write, but for reporting
> > it gets translated to the FIEMAP_EXTENT_SHARED flag or is used to
> > reject swapon.  And the there is black magic in DAX.
> 
> Hee hee.  Yeah, let's leave IOMAP_F_SHARED alone; an out of place write
> can be detected by iter->srcmap.type != HOLE.

I can probably come up with a comment that includes the COWextsize hints
in the definition of out of place writes and we should be all fine..


