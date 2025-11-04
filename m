Return-Path: <linux-fsdevel+bounces-66966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB0BC31F35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 16:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC03F3AB315
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 15:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396F2278165;
	Tue,  4 Nov 2025 15:53:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720B227056D;
	Tue,  4 Nov 2025 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762271600; cv=none; b=XJPMENSFfc+LpGLAYU4udt1c8RbUUMuWi5owranelalv9j8uK4FRaez82hE7XwAkK5tKuZz20FG5Fa+Wqhh3QqXAojZpdkFn0NMMIGk7MZ6a+xw0h3DjEUMVjzX22UbgE4RRCKIPQFrBomHkimwogzq+FaTJW6WAdyqndMmQd2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762271600; c=relaxed/simple;
	bh=laMh0SAKRI0I+akncSWHigNwMwyTz5vjMOluixg5Njk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwfSlU2gO6YfxrOxgCSmQ7o4huEpUQ0nJpP0Le/WWyZT5T1UEa6m9ui1B1tg8x4ldVJdn6Zi/Jd8mxS5igQqE8WCWmUmz3LG5+7X59QAwGIriYyS0iY9DSSWUlY8hxRot9KnFPu72vGLKxgV3aP3jP0hbKa37K0MqKzKzpB8s+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 21798227A87; Tue,  4 Nov 2025 16:53:15 +0100 (CET)
Date: Tue, 4 Nov 2025 16:53:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] fs: return writeback errors for IOCB_DONTCACHE in
 generic_write_sync
Message-ID: <20251104155314.GA1056@lst.de>
References: <20251029071537.1127397-1-hch@lst.de> <20251029071537.1127397-3-hch@lst.de> <20251029160101.GE3356773@frogsfrogsfrogs> <20251029163708.GC26985@lst.de> <a05cde7d15d85f2cee6eafdb69b1380c8b704207.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a05cde7d15d85f2cee6eafdb69b1380c8b704207.camel@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 04, 2025 at 05:34:50PM +0530, Nirjhar Roy (IBM) wrote:
> So, what you are saying is file_check_and_advance_wb_err() will
> wait/block till the write back request done in
> filemap_fdatawrite_range_kick() is completely submitted

No, it won't wait.  But filemap_fdatawrite_range_kick isn't asynchronous,
so it doesn't have to wait either.


