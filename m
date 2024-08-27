Return-Path: <linux-fsdevel+bounces-27404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CA19613E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38821C23173
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6071CB14E;
	Tue, 27 Aug 2024 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbK0XZfZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537921C7B6F;
	Tue, 27 Aug 2024 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775710; cv=none; b=an7kruJcWcBQO7MaQ7NaEU4XamKgC5Lr2LL+nKSBCeZ1eGL5nY1p+GXB+TUCo6GoI2SmPOlpkyqgjQsIPu7KcUEuAA39xIeGs9cIIMTim/xTPzy5sDmsHDUaOiKA0zF1/xL43O4MULgCv69A4u+ZjqQUG2Y2IncaD6+C1ehl23k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775710; c=relaxed/simple;
	bh=JQr73mjboc/Gct44z8kRql9dmLTPg3NLsDKBXdOnwm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLfnjkJUT+iPjnR4qoheoI1bD4+vrkmy1rdFiFehGfTxPitgsKFWND1cOTGbW8vWTx0pdGzvdKUHWRWYT1fdgt98RB003JJZ/9gXEpKbCgO22UAik0qBgqBpJommosh1GUx6OpvKtvQMPpXNd4PMZeWnL8qHgTbJVhS/zp05apk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbK0XZfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C379C582B2;
	Tue, 27 Aug 2024 16:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724775710;
	bh=JQr73mjboc/Gct44z8kRql9dmLTPg3NLsDKBXdOnwm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LbK0XZfZ9eMtMU8it2cTplP+mQ7sw0UfXUmcxwMu34Fb8pYlNgF++otgsJcoUAdQg
	 85Ais4em+TiRz8BjNN9FN+Zu7gUNYsz3VFZAI6WHUcl0isDPI8A0cn0PUIHKZTxwEE
	 vn7Y/4nWh1QJ4IXbwWlGhKDllrSAfQrBkQ5W73x9MifG1xYbz9aTUJ9P7HflHbUItG
	 7F8RRaJxMePdOQwve1okTJaQx7dt5JYm3fV0J937G2kg03KVaz3TKlS05Wwy9nldpB
	 OR7YtssyYw0nt9J7egA6TzqtUReeQbHu8xhGiObRLolkpKVRXnfzEjlbyw+4e6qLUD
	 LvKm2FmiZPZFQ==
Date: Tue, 27 Aug 2024 09:21:49 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/10] iomap: improve shared block detection in
 iomap_unshare_iter
Message-ID: <20240827162149.GW865349@frogsfrogsfrogs>
References: <20240827051028.1751933-1-hch@lst.de>
 <20240827051028.1751933-3-hch@lst.de>
 <20240827054424.GM6043@frogsfrogsfrogs>
 <20240827054757.GA11067@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827054757.GA11067@lst.de>

On Tue, Aug 27, 2024 at 07:47:57AM +0200, Christoph Hellwig wrote:
> On Mon, Aug 26, 2024 at 10:44:24PM -0700, Darrick J. Wong wrote:
> > Maybe we should rename it then?
> > 
> > IOMAP_F_OUT_OF_PLACE_WRITE.
> > 
> > Yuck.
> > 
> > IOMAP_F_ELSEWHERE
> > 
> > Not much better.  Maybe just add a comment that "IOMAP_F_SHARED" really
> > just means an out of place write (aka srcmap is not just a hole).
> 
> Heh.
> 
> For writes it usually means out of place write, but for reporting
> it gets translated to the FIEMAP_EXTENT_SHARED flag or is used to
> reject swapon.  And the there is black magic in DAX.

Hee hee.  Yeah, let's leave IOMAP_F_SHARED alone; an out of place write
can be detected by iter->srcmap.type != HOLE.

The patch looks fine so
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

