Return-Path: <linux-fsdevel+bounces-19171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A74678C0FA6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 14:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60DED283A62
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 12:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA7214B948;
	Thu,  9 May 2024 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="ENoWDIlM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85281DA4D;
	Thu,  9 May 2024 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715257885; cv=none; b=m18pxgywvVySW5w59gHLsnihwZIVwNRPy1nM+rPK1YmDq5yTlNt4ScSfs3Ft7UpJKxzb9+PsoMxUX4vmuFRSyvI/SDs/ir6+fYzbjihrQAG5H+5lIJHVYh4y8+uM6bCBuUfUU/OErFzptUnD43ypLeRlZvfpviE8H1wTPeT9vAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715257885; c=relaxed/simple;
	bh=TrIT4sozvI5rvBSMIRgj1iOqe27OC70E6GfMShUnt7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUb4f7NmSGtH4MUmrNIpkNVTR0AwDzj8bfikMbn35aBjCi1UP0bKJM0x6qxrkA2VPJsESME3mzxDr72qqzaHJW64QEUKvj0as67dJndpbcdywki4SeGmyJSVdcsRMJW8aZBo8lF4eE9k6InsYutmGQrvFElcwlp5f82uHiXdIWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=ENoWDIlM; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4VZrwL2LXfz9sr9;
	Thu,  9 May 2024 14:31:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1715257874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=syRYsn5YkWqtDoVOn9NFuMpVM6WQHaccjb1P8o4QWJk=;
	b=ENoWDIlMdBwQF+JZTxrddQuXCrXDJ+v2SKC5XavGOjx+KmlSGRIwmfCuaoeWSfFnH8+wHA
	StaYVY4Kr7IGwafjdTi4Qkgqj37BX4BeZ3HOoI++h/IiaTr1oWCJjEU2QBjcMpaVzUYZfb
	UAVH5b+3A0WyHilnOL9AM109fpZ+FqCVqtqfuyHVBAoocTrTgdz1mGISKjvxHYGV7Lrorf
	d0C6EFvJI+FOS+M8rmeinVfSc9mhtp1qXE1Ubol1xItY2EZcip0kIwoErd61IGMOVVmOJT
	zgKDepUg03xCT9crOatZUxzBLG/fS2p9Kef8nGb150xtT6w4l01r6fm8UPXVgA==
Date: Thu, 9 May 2024 12:31:07 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: hch@lst.de, willy@infradead.org, mcgrof@kernel.org,
	akpm@linux-foundation.org, brauner@kernel.org,
	chandan.babu@oracle.com, david@fromorbit.com, djwong@kernel.org,
	gost.dev@samsung.com, hare@suse.de, john.g.garry@oracle.com,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	ritesh.list@gmail.com, ziy@nvidia.com
Subject: Re: [RFC] iomap: use huge zero folio in iomap_dio_zero
Message-ID: <20240509123107.hhi3lzjcn5svejvk@quentin>
References: <20240503095353.3798063-8-mcgrof@kernel.org>
 <20240507145811.52987-1-kernel@pankajraghav.com>
 <ZjpSx7SBvzQI4oRV@infradead.org>
 <20240508113949.pwyeavrc2rrwsxw2@quentin>
 <Zjtlep7rySFJFcik@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zjtlep7rySFJFcik@infradead.org>
X-Rspamd-Queue-Id: 4VZrwL2LXfz9sr9

On Wed, May 08, 2024 at 04:43:54AM -0700, Christoph Hellwig wrote:
> On Wed, May 08, 2024 at 11:39:49AM +0000, Pankaj Raghav (Samsung) wrote:
> > At the moment, we can get a reference to the huge zero folio only through
> > the mm interface. 
> > 
> > Even if change the lower level interface to return THP, it can still fail
> > at the mount time and we will need the fallback right?
> 
> Well, that's why I suggest doing it at mount time.  Asking for it deep
> down in the write code is certainly going to be a bit problematic.

Makes sense. But failing to mount because we can't get a huge zero folio
seems wrong as we still can't guarantee it even at mount time.

With the current infrastructure I don't see anyway of geting a huge zero
folio that is guaranteed so that we don't need any fallback.

Let me know what you think.
-- 
Pankaj Raghav

