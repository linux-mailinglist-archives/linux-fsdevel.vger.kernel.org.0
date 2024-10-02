Return-Path: <linux-fsdevel+bounces-30724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D18B98DEAA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 17:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EBB91C23BF0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 15:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2208748F;
	Wed,  2 Oct 2024 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HHnI0b1g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278FB1D079C;
	Wed,  2 Oct 2024 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882128; cv=none; b=mWunRkeS1VoURHnDgovXmBOFmFfiRZWSN7kCQ3zbzJkDpgKlS3GKLF+FyyLLbgpsT4cA3s/EpjDQJGn2RMrug1MH+6Axk74r3YxsJjRbuAA3K68W0W0NiSw1IGucTw+LsLfWuZvLz+DB9kEVSMXZApRz1fy2fdGpVHY53KOIp7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882128; c=relaxed/simple;
	bh=U3q1EIOGnEcUZGmcBvZCSksbFHXbVNSDjnhntr+ls+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJz6//5n4jBgi8TqF8lXNTm1qlOzOdxtptzg34Un670FDfWJsCXsjwyrkVOtEHpaZfxZgEgmgGYTL500Y1AMw8Wk+70sAAfjjEJPLZT7tzqO3FBKIiQmsu1qWf4VQRtyrkn/GIe7+3AW9DLazdb28ucJ6TlunYYcGF7DLO/8hwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HHnI0b1g; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aSQeh0gFXbWqOTHPCP9FQ9610juPXd6SxsIGJ80ffO4=; b=HHnI0b1goRK5QFcgpCUV4zFYa5
	j1o1ZwTV/XvA2/zrCdVTFxKvnuBawhU5OETxD0ij8Bc1fRqMPYtUl0SbYpx8X/HuCS1VYdtIdDule
	ft8+lqBEskakZFSfasDEW4BzMAJVd6w0erPRN0k/gerP0yxOHcfI7vOhS6d/xrCQ2LmsfWWLzjYgP
	8+jb8KGxinee87Fd8VwLEsy6JuUK38/AzQq+x+9ZBg/e7R1AWvyCAE5ZQ4mJgiXImqxbWigdTfDxi
	shVHtWeQBkHj0c4f0zlhAceuh0a6vn/kgPPHkoIoXNLphOqfU486hS8taANkFIoRm9IUNEn+9Otj7
	8VpynsVg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sw14Y-00000006aA5-34TL;
	Wed, 02 Oct 2024 15:15:26 +0000
Date: Wed, 2 Oct 2024 08:15:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Brian Foster <bfoster@redhat.com>, sunjunchao2870@gmail.com,
	jack@suse.cz
Subject: Re: [PATCH 2/2] iomap: constrain the file range passed to
 iomap_file_unshare
Message-ID: <Zv1jjqpd0A5_BH8X@infradead.org>
References: <20241002150040.GB21853@frogsfrogsfrogs>
 <20241002150213.GC21853@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002150213.GC21853@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 02, 2024 at 08:02:13AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> File contents can only be shared (i.e. reflinked) below EOF, so it makes
> no sense to try to unshare ranges beyond EOF.  Constrain the file range
> parameters here so that we don't have to do that in the callers.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

