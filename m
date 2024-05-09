Return-Path: <linux-fsdevel+bounces-19191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 582FE8C11B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 17:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC83E1F22131
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 15:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C1115E7F2;
	Thu,  9 May 2024 15:09:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8124A15279B;
	Thu,  9 May 2024 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267391; cv=none; b=cLyrvhNWD52UBrEHkD69RAf1rsfN+no71tlNsTO2h+AaHPsMom2sjaVFKFU6lb5QJdkcVWeD0S5d/U53sZYtPG5xUEVjgDVZR0rpLAdUOKSD6iD0DT3TS+4FkX1hJDrUlTZdXgR6yJfx/JGcvnJd8r2CkY9cnT+rNKXOsEryoZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267391; c=relaxed/simple;
	bh=m/mj82g4kipyCvgCvGF0gsyIQCYOGawLVXdpuxgZEyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLugyAF/ISW8ZhkX08EIJlZtgrU0GZYUHG+JS96toULxv0fQlj9qqcytCPyaDKwSwV2K+vLhGmne0EDEwcprcLV/CGQzv878ets5sg7XCTu21evwN49W7YN+8ZsDVtXrCgsSgnzcd4d6vOwGASK2zp5mVtiA79TYkmAAJZ1hERI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4A618227A87; Thu,  9 May 2024 17:09:43 +0200 (CEST)
Date: Thu, 9 May 2024 17:09:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, hch@lst.de,
	willy@infradead.org, mcgrof@kernel.org, akpm@linux-foundation.org,
	brauner@kernel.org, chandan.babu@oracle.com, david@fromorbit.com,
	gost.dev@samsung.com, hare@suse.de, john.g.garry@oracle.com,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	ritesh.list@gmail.com, ziy@nvidia.com
Subject: Re: [RFC] iomap: use huge zero folio in iomap_dio_zero
Message-ID: <20240509150942.GA15127@lst.de>
References: <ZjpSx7SBvzQI4oRV@infradead.org> <20240508113949.pwyeavrc2rrwsxw2@quentin> <Zjtlep7rySFJFcik@infradead.org> <20240509123107.hhi3lzjcn5svejvk@quentin> <ZjzFv7cKJcwDRbjQ@infradead.org> <20240509125514.2i3a7yo657frjqwq@quentin> <ZjzIb-xfFgZ4yg0I@infradead.org> <20240509143250.GF360919@frogsfrogsfrogs> <ZjzmNF51yb_EyP4W@infradead.org> <20240509150828.GK360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509150828.GK360919@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 09, 2024 at 08:08:28AM -0700, Darrick J. Wong wrote:
> Oh.  Right, this is for bs>ps.  For that case it makes sense to fail the
> mount.  I was only thinking about bs<=ps with large folios, where it
> doesn't.
> 
> (Would we use the zero-hugepage for large folios on a 4k fsblock fs?)

The direct I/O zeroing code always deals with sub-blocksize amounts.
The buffered zeroing path can deal with larger amounts in a few
cases, but that goes through the page cache anyway.


