Return-Path: <linux-fsdevel+bounces-18406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D26D8B85C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 08:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E7091C224FB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 06:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621B74CDEC;
	Wed,  1 May 2024 06:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EaI8uCgo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2327F;
	Wed,  1 May 2024 06:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714546577; cv=none; b=EEoTV7mTFPAhNTPIAcJ1x4m3tR0PF5eV5Q3Iyt4NBPBwPyZQyyr/L+oQfnEK11RPWGLLl7i3hvNrfFImTndacNTRsqU0JFpEqmpCqnw3X6i0/OTxRlYImMxfNfFtS9eG03yr0yIoj9s+zj47VNKmLwijfaG9G4QJaWDhBwubsuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714546577; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+XmO1zwBya5VdofWrtj9f3SVlUAfJ9Ka4oOLFERgz9kEs2RbeG+Zh0VNC+oe8nyuWDcScrI2PmrKNzRA9NmJuyx5WMpYFYmRtJqftMX1IhdtaldKv/qSvKbfHOzTJNTCwt8bs3aT+2qJ2XLwPJ/964rdiwkV2bfSOZsUd26skw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EaI8uCgo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=EaI8uCgoYM4D2x4Ivw+bflpaFv
	sJZjt0hEtFjS0Q8ZeX5u1zNV2i/hEDrNid4y7QN9WrAh/2zM7qO8dvutiCLnKRlTlaJdHwdDXqP5P
	uQkvq/tlhIy7bbMvwEVu7ESoG50oCkxx90Qartk79SzqvU8cZ7hkjiEoZqFI7y3ZzsPgZTPwJmELi
	6FSIVArSkJa+9y0xe6c3KGxwiSU/ZZ/94jboc7q16qS6vAkKfpq1cg0SeYyo1nWJDDB6A0ayOvF6p
	7MjcdmW9zwBwfX9uvZkUIcJd3Dv4TiFjJov0TPtPTzZ1IsIzy7LSG1hGVuMlAD8Vmos92KEysw/Wp
	ZjZ6t+OQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s23t2-00000008iKp-14pB;
	Wed, 01 May 2024 06:56:16 +0000
Date: Tue, 30 Apr 2024 23:56:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, ebiggers@kernel.org, linux-xfs@vger.kernel.org,
	alexl@redhat.com, walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/26] xfs: minor cleanups of xfs_attr3_rmt_blocks
Message-ID: <ZjHnkCT9xQEZxLxt@infradead.org>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680429.957659.11765566491777130541.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171444680429.957659.11765566491777130541.stgit@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


