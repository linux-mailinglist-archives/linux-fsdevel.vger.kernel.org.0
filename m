Return-Path: <linux-fsdevel+bounces-18398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D7E8B85AA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 08:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69DA91F2342D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 06:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01383E487;
	Wed,  1 May 2024 06:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q1JRASe7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EDB29CF7;
	Wed,  1 May 2024 06:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714546047; cv=none; b=kab96/ljRurGzX4VfoSz9qsawtLofbSCIsafwb97QLV0P68AG77kOe63F3k0oTQD8Gan+cZmBbz3Olmb97YEsJF3+Z9IPBdrEb5Rm3ZnKBkEgDvRmqALkfG61V2Nkt4TPs6UbKJGZm3NZPIMb8vS5/6iHauWIz8oW+/AkUpsdZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714546047; c=relaxed/simple;
	bh=8eu5jBhcF+JTwF9edxhk6fR88p2fSd3KVnVvEBD8Mfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gC11z0wXmy/R0pj3aSAaY98WhXnXZHiz2IPUSl2K38XQbuSUBIBx6cQaOAcNbw7FiWjOs4CmY9zyLJMQXMMMuCU51WncFKy/owcju6yg0BeS4q7awNUrNFHNvfWWaiE4lRJSlRFlPnebiEw91qGOnBVyfF0nq+/0Fo5TRzSSflM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q1JRASe7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=n70Vzf/KupcSs33nA2VNBogORzGpGkXecImO/4Ac2Jc=; b=q1JRASe7P7SWO32+rpLaoFEdTe
	a78xpX4H80ozq7RKAex9ATg+sNyXxoKnv/IZ7fI6P47TFDkXkOxAmpZD3k+No4z25TkxXPuAsjaHZ
	5tjuokzG1g0pbX5+xSWfKBKL0xNog/4AjX+/QPxtKJxRvfx1bf8X37Lrs7NBF04LE6y23urG57fma
	ps2hB4Ylt9gb92dIMnjDCaKxtlVi0NQCzPZzOS7vUHq4lgd5pZxMhB0JvpFsz7Y+XdujyaHlLK4Mi
	P15EEcV+mzvFeDRhJ/IhgDCiIo9bcZPetHHFBWbHav78dU39TwwOC89Ji3rq5rLYP0KjOEwDbQR9r
	qfnXNmlQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s23kR-00000008hZJ-3VN6;
	Wed, 01 May 2024 06:47:23 +0000
Date: Tue, 30 Apr 2024 23:47:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, ebiggers@kernel.org, linux-xfs@vger.kernel.org,
	alexl@redhat.com, walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 19/26] xfs: don't bother storing merkle tree blocks for
 zeroed data blocks
Message-ID: <ZjHle-WDezhehB6a@infradead.org>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680689.957659.7685497436750551477.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171444680689.957659.7685497436750551477.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 29, 2024 at 08:29:03PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Now that fsverity tells our merkle tree io functions about what a hash
> of a data block full of zeroes looks like, we can use this information
> to avoid writing out merkle tree blocks for sparse regions of the file.
> For verified gold master images this can save quite a bit of overhead.

Is this something that fsverity should be doing in a generic way?
It feels odd to have XFS behave different from everyone else here,
even if this does feel useful.  Do we also need any hash validation
that no one tampered with the metadata and added a new extent, or
is this out of scope for fsverity?


