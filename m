Return-Path: <linux-fsdevel+bounces-67440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC19C4037F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 14:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 888594F1C63
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 13:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7932231A053;
	Fri,  7 Nov 2025 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y+WoDj/0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EF02DCF5D;
	Fri,  7 Nov 2025 13:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523731; cv=none; b=F+C+G3MRIeni3GtQjg/JlFXVeSDH/uPqaKme1r/gBSslWw/w3f5iLvSZv29Ue1+evK5KhhRd4L8a6sIsfRDX/bGytnb+kCUY2dDOSyr4VQg/Rw77AZmb/ETHfCgh3e068nUEbJgFn/4sI38odrRSU0abjVS2aOI3xJDH2WKLCOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523731; c=relaxed/simple;
	bh=XvW2XDh0nLavk/x8BSTrXYMJ1gxlwYZszuI7sfzT6FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlV6ukQ4NC01f5uincktFn9SBoVHuj8HwP1PSHmvREil5MKq2Yr8Hz4TK5mQNVV7oA+OgH8Cc0OcVt9O7lI2wcuMu/PYdUhfMftfESFm/04X6neViaB1f+yQE2E4gCBYZ4Uec6c5erl14AflTBO2gPCjYkkfWbVomFvyDf9FRGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y+WoDj/0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f6WjNOU1AVaRifsa7mEVnBHRw8msX2kcDkubjL0eGu0=; b=Y+WoDj/0T3tAjHAeg/rx1OQCCx
	zTK35chGnfgRWFjjW6j2oTvA+o2BedBqUyaIVbCb+lE0Ryel0o0XYt2u0YMlTnZP7z3LatdYAcF7v
	r01irScoe5tyfiTNCUrHlFWdJ6wBZnC6n6FDsdut5/cOi90KKrgg5hbKX/Z+5w2ByYx8+gf3R2Mwp
	cf9opACVgIun9jWJyRYniRjgRXqqtayXPeL4yqKFuu5Pj+Gqkqx4JTlQRlMbis+L+hElPXeTwTEdI
	ViRhL3FsNfU4ymqAjOb6NoxXWkS4WYjMHsc+1P9M0NEqM+JARLcTTzNySQ4qmwvpN0t+64x18hUDO
	3HEjWkCg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHMw4-0000000HRIQ-24Yr;
	Fri, 07 Nov 2025 13:55:28 +0000
Date: Fri, 7 Nov 2025 05:55:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/6] iomap, xfs: lift zero range hole mapping flush into
 xfs
Message-ID: <aQ36UJ6qyCjUM41M@infradead.org>
References: <20251016190303.53881-1-bfoster@redhat.com>
 <20251016190303.53881-3-bfoster@redhat.com>
 <20251105003114.GY196370@frogsfrogsfrogs>
 <aQtuPFHtzm8-zeqS@bfoster>
 <20251105222350.GO196362@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105222350.GO196362@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 05, 2025 at 02:23:50PM -0800, Darrick J. Wong wrote:
> Then we change the interface so that ->iomap_begin always sets read_map
> to a mapping from which file data can be read, and write_map is always
> set to a mapping into which file data can be written.  If a filesystem
> doesn't support out of place writes, then it can ignore write_map and
> write_map.type will be IOMAP_NULL.

Please don't.  The whole two maps in one operation thing was a giant
mistake, let's not double down on that.  The only places that actually
need it is the buffered write read-modify-write code, and the unshare
and zeroing code that reuse that in ugly ways.  We need to untangle
that properly:

 - for the buffered write read-modify-write just do a separate iomap
   operation for the partial read
 - for zeroing do a separate query for holes and for the overwrite
   space allocation if the file system needs it due to COW
 - same for unshare


