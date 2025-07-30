Return-Path: <linux-fsdevel+bounces-56343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73F4B16230
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 16:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 077D1162646
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 14:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACC32D8DD9;
	Wed, 30 Jul 2025 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B8Dqw9bp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718282D613;
	Wed, 30 Jul 2025 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884247; cv=none; b=HjeMaujAy0nfuitTjFTRZ4pdZIwsbGisD1xVaKJjjDc+aIaQHUuuacHS9wquFF9yV94tau5AW737yL86Raf0ASCbAJTo7upzh4LInEsz9W2El9whq2FQ+U5yrq9Sdxxj2oQWe9yEOCIG+o6YJUqxacRM/eWQFTbPl4neX+7a7CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884247; c=relaxed/simple;
	bh=YLSfW17T9EaJwX2zsIfpdLJzPFa2O5m2IzdlEfrjEpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaP8luzRSWX5oSSj58FiEBPbpTylH8Lse33Q2fMJBwJcDye7yK8GZ+zGtBvrk3sdv1GfPwsUW3mGX7qibQadFmOZmxfHknIrhz2NSmf+QAEwn7dSvHURDYu7HczSWa739prLfpTCQ7yE8b7YWrDsPgsLZ7MaHZPjJ4+9t3NPCwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B8Dqw9bp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YLSfW17T9EaJwX2zsIfpdLJzPFa2O5m2IzdlEfrjEpE=; b=B8Dqw9bpOiAhHVrTzhvXMKg+7u
	5+eCPCHaLcy4qdaeg+Z71lm5lwezolUkLi98CMv7cnryxS5jqMVCsUvviSyyKLucGT8K99m9Hac89
	gXKgrGIBZblrooweQ6OIPronBKnaU3eTiiUutiww78S78CuVpeixL8fnmMzGSQetAimKcmcWCXJtr
	Ap1TRp1LJZw5Wi7pZufWPyhIlzyN1DoQzTEV81zvWu1pNnYmmkL4xZW9i/QDmev46cFub2CZ+ROox
	VDPvv1gSSiFOtN8zJ8XQmXhflwAZOJwJd6Iri5hJyNElzPJ/yXRn015Yvf/3kCFh4F8JgCf8sZLq2
	SFvqT/Yg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh7PV-00000001gaY-3qH3;
	Wed, 30 Jul 2025 14:04:01 +0000
Date: Wed, 30 Jul 2025 07:04:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] iomap: Fix broken data integrity guarantees for O_SYNC
 writes
Message-ID: <aIomUR0kDpb8W2G9@infradead.org>
References: <20250730102840.20470-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730102840.20470-2-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 30, 2025 at 12:28:41PM +0200, Jan Kara wrote:
> Commit d279c80e0bac ("iomap: inline iomap_dio_bio_opflags()") has broken
> the logic in iomap_dio_bio_iter() in a way that when the device does
> support FUA (or has no writeback cache) and the direct IO happens to
> freshly allocated or unwritten extents, we will *not* issue fsync after
> completing direct IO O_SYNC / O_DSYNC write because the
> IOMAP_DIO_WRITE_THROUGH flag stays mistakenly set.

Uh-oh.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

