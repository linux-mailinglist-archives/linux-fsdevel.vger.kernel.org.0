Return-Path: <linux-fsdevel+bounces-29761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 524E497D74A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 17:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4671F25695
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 15:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF20B17DFE8;
	Fri, 20 Sep 2024 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0JsXRzHO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D437E17C22A;
	Fri, 20 Sep 2024 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726844852; cv=none; b=rwUx4E8oHK+x+3TNHY93+RnPtYTUtR3Tu/002a0jZFz/G2iN9pnWpBA6NlXAdpqrAh7iN6nDxIE+F/oZphDJJqf0+3esTIveB1kz4KfrLVxalc991VV+pfyV6aFalaj+kcr09YX6R48dGE5MOAx8zqsOhynn4FiUfJn/r/Vif9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726844852; c=relaxed/simple;
	bh=YSB/R5z7mV9kKTgso8yheN7y0ygQZYcVM4zbKGdn/dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouhM8Bs695OsKFsZmN2qJhuZqddo3ZnuyM/eI4+8TDu6+Lin477tyQK1gHcEScpjtWnQtbtwugpXmP7sK0fnt6I0MVOeoxJ03FiMcllqEdseobaLk1Fl6KF92sQt54kf4I9aIHsZo29KzY4VhkF4rQSPpTypAq70L61Q8DptcpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0JsXRzHO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uRhXd76oG6Xe53GNWENSD8ghUB51x6RYup6HPOJq9xE=; b=0JsXRzHOC8YB6Cgoa8esQ4h6VK
	3bJ23TlyAI8Vjw8ycaVkCNCeEvGVwwBDRcz9cG9hoIhF/jNLvnDTVFsGIflEfJwAf9jeFxXVBovfm
	vPOwCvnmUJbmclLkyC5bMHazO+qfeezrPsFXFJB/6+W5oNU+eaTbLZ2hoxMCptdGoptUYRRvKPoYj
	hNxPWNR3lT8KKGG3/G+JPJPPivLkJAj8tJcP/LqVg9TH/abYV8JRfNBkEtS3sB4r6b2/oLuVHQjUX
	ZpvlGRGPI4Yrt1LL+FsQX5aaBVupIXatZKj/JFJplVBpZgK9Hq/HpF1in2uReBNiqmXrDQ2t3oz16
	JOzMZKwQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1srfEH-0000000CRd9-28GT;
	Fri, 20 Sep 2024 15:07:29 +0000
Date: Fri, 20 Sep 2024 08:07:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Julian Sun <sunjunchao2870@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/3] vfs: return -EOVERFLOW in generic_remap_checks()
 when overflow check fails
Message-ID: <Zu2PsafDRpsu3Ryu@infradead.org>
References: <20240920123022.215863-1-sunjunchao2870@gmail.com>
 <Zu2EcEnlW1KJfzzR@infradead.org>
 <20240920143727.GB21853@frogsfrogsfrogs>
 <Zu2NeawWugiaWxKA@infradead.org>
 <20240920150213.GD21853@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920150213.GD21853@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Sep 20, 2024 at 08:02:13AM -0700, Darrick J. Wong wrote:
> > Which isn't exactly the integer overflow case described here :)
> 
> Hm?  This patch is touching the error code you get for failing alignment
> checks, not the one you get for failing check_add_overflow.  EOVERFLOW
> seems like an odd return code for unaligned arguments.  Though you're
> right that EINVAL is verrry vague.

I misread the patch (or rather mostly read the description).  Yes,
-EOVERFLOW is rather odd here.  And generic_copy_file_checks doesn't
even have alignment checks, so the message is wrong as well.  I'll
wait for Jun what the intention was here - maybe the diff got
misapplied and this was supposed to be applied to an  overflow
check that returns -EINVAL?


