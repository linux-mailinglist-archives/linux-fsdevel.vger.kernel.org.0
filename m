Return-Path: <linux-fsdevel+bounces-37350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E1C9F1386
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 18:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F1F168702
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 17:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3861E47C5;
	Fri, 13 Dec 2024 17:22:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37EC364D6;
	Fri, 13 Dec 2024 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734110570; cv=none; b=kNe4bo781QM2qgj+Ho61CITe78utAH+E8x+kNcwRh2YA/WlDWJuwQzvAbjJHPsUju6mEQETgZ22aZ1p82EVAmXVtWpJtREaCm/zYnwpbK5H7WpKcX64Fjx4H/bl0x39Y/3GPUp8JvbCzfzyZ5EPd0HAM/3Bzg6a0lUg87B2XgYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734110570; c=relaxed/simple;
	bh=s/3RanWX31525EKgo0No1RXAUxHElCTGWx8EQ+qS2UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvO+kPFqwEIKnz2SvEZRAJ5I3vRvgIBPjI9//jUNGNzEJzUORlZCLLLxMzOzr82PW4dVvo1NggIOycpKtZKsbnKYj2+lOoY2TTnmhOAVuaHtcYZZz/R1klCLdEB9cuygslwJtZ0erMYzjXu2sm6FESo81l0bIBrV/m5dAAuCy9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C992A68BEB; Fri, 13 Dec 2024 18:22:43 +0100 (CET)
Date: Fri, 13 Dec 2024 18:22:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org, djwong@kernel.org,
	cem@kernel.org, dchinner@redhat.com, ritesh.list@gmail.com,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, martin.petersen@oracle.com
Subject: Re: [PATCH v2 0/7] large atomic writes for xfs
Message-ID: <20241213172243.GA30046@lst.de>
References: <20241210125737.786928-1-john.g.garry@oracle.com> <20241213143841.GC16111@lst.de> <51f5b96e-0a7e-4a88-9ba2-2d67c7477dfb@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51f5b96e-0a7e-4a88-9ba2-2d67c7477dfb@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 13, 2024 at 05:15:55PM +0000, John Garry wrote:
> Sure, so some background is that we are using atomic writes for innodb 
> MySQL so that we can stop relying on the double-write buffer for crash 
> protection. MySQL is using an internal 16K page size (so we want 16K atomic 
> writes).

Make perfect sense so far.

>
> MySQL has what is known as a REDO log - see 
> https://dev.mysql.com/doc/dev/mysql-server/9.0.1/PAGE_INNODB_REDO_LOG.html
>
> Essentially it means that for any data page we write, ahead of time we do a 
> buffered 512B log update followed by a periodic fsync. I think that such a 
> thing is common to many apps.

So it's actually using buffered I/O for that and not direct I/O?

> When we tried just using 16K FS blocksize, we found for low thread count 
> testing that performance was poor - even worse baseline of 4K FS blocksize 
> and double-write buffer. We put this down to high write latency for REDO 
> log. As you can imagine, mostly writing 16K for only a 512B update is not 
> efficient in terms of traffic generated and increased latency (versus 4K FS 
> block size). At higher thread count, performance was better. We put that 
> down to bigger log data portions to be written to REDO per FS block write.

So if the redo log uses buffered I/O I can see how that would bloat writes.
But then again using buffered I/O for a REDO log seems pretty silly
to start with.


