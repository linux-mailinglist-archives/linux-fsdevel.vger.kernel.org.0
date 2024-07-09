Return-Path: <linux-fsdevel+bounces-23380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 178E892B726
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 13:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1D6F1F23B99
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 11:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4BE15D5C4;
	Tue,  9 Jul 2024 11:19:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3625415B116;
	Tue,  9 Jul 2024 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523990; cv=none; b=g6PIO4M7hdcBgVtHRfho/HC7x4PhdQRjHad0l/8dWpFOO8uYfNmLsR76ZL0pz9g09icT+6r2xb/n8RpIvG4lPGJNTERnbfQ29BamHU9LECi5P+aTSYEYyXO0fmt+B9qPl97JxXqgRp/Ja3djRqrYwRTYpeojwziYEAQ441mw1jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523990; c=relaxed/simple;
	bh=GBdf7gsXI/J/tlkDnqZgJfaLZwg8UeyOQKv1oBzT2JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKHUlTHe3Ftac2kyKABIlj3RQvnZanUagQnHDYSvguPwfxrsqwYx2uwHu/ZZ4uEwnIyqNLSK+05iZG6+IDBNvDPXzjjYal2N/Kv7MlQbPFjtkNfsBQIX7yk90RQt6RXL5Rovt6MKzbx13IdYlvusKznOlosiyZp5feAo2LChTUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4A43168BEB; Tue,  9 Jul 2024 13:19:46 +0200 (CEST)
Date: Tue, 9 Jul 2024 13:19:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.g.garry@oracle.com>,
	chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v2 10/13] xfs: Unmap blocks according to forcealign
Message-ID: <20240709111946.GA5130@lst.de>
References: <20240705162450.3481169-1-john.g.garry@oracle.com> <20240705162450.3481169-11-john.g.garry@oracle.com> <20240706075858.GC15212@lst.de> <Zo0JghFEaqxBs41l@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo0JghFEaqxBs41l@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 09, 2024 at 07:57:22PM +1000, Dave Chinner wrote:
> No code should be doing "if (forcealign) ... else if (realtime) ..."
> branching for alignment purposes. All the code should all be
> generic based on the value xfs_inode_alloc_unitsize() returns.

Yes, please.


