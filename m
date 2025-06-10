Return-Path: <linux-fsdevel+bounces-51099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010EEAD2C8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 06:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB733AD81E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 04:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4176425DB07;
	Tue, 10 Jun 2025 04:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k4DwGwOc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760F825D53B;
	Tue, 10 Jun 2025 04:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749529253; cv=none; b=BX34QBkCNurE85HhvTg3UpROy7KEYSIwLiJZrrC2wkNcEfZiiPYXmslb5hP8A2pz2WANAHMhvo52ey3PN+SUQOkHLNY/af/p4ieSqHPCyBI0CsGCm+L0XxNTgEbz2RzVFulPeTKPT6y2Tty+GVM9jK2ye/FmDQ4fIcJS6aOyxFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749529253; c=relaxed/simple;
	bh=kk3zxa42kbov5h0lymJuER94k8amfZ89s0UloGwCA8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hu+mXnihGr02Mj9E80uuAbyU/C7vsuIN/0t/KuzaWZUN3uaTQ5l7n1qaQRQW05b9OFqCMQoqceNVMnH28WlMdQqoDGnPcb07UsLZiOiY1Il2vjynbLtUv+bDGBmeabd8K5LMHlprmNGJ6QcQP6uGTuUOe/F7lTSGtQ8Rb/5SpGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k4DwGwOc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zrJJXWsieR0MemyzwvlFmPTI8u6JRbG1FAK5LcmPD6U=; b=k4DwGwOcY/0Rc2f5K/4iy/Am7w
	6ZBElmx8ADsvH7aKUBfARXuu19vB10Vq65xtANWkORdPlVDzU5SDa23k2SwwKDSJu1SPRc+zrOERW
	fmieZvW3ctuSbf9d7GMCImMjmtidQffzq1kpiO1jZnh1VyPwsz44A/cfdI+28D5q75HRLhlJiKU4M
	rRzyXROpCi80QTlE300hbcNpYLoXijijKi2tIa9eZGlsUQcxxJDjbQEPYBzTCTAG+C28KjTyTrhQ3
	d6NTY3400vGwm4ha2p+jPWq4+QWp4tOWb506nLIXnJ+URKuXjQ/QL1vM6KMKq+qMF/HisovDM3MSd
	/r7si5sw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOqTj-00000005jxb-3M4Q;
	Tue, 10 Jun 2025 04:20:51 +0000
Date: Mon, 9 Jun 2025 21:20:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/7] iomap: move pos+len BUG_ON() to after folio lookup
Message-ID: <aEeyow8IRhSYpTow@infradead.org>
References: <20250605173357.579720-1-bfoster@redhat.com>
 <20250605173357.579720-2-bfoster@redhat.com>
 <20250609161649.GF6156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609161649.GF6156@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 09, 2025 at 09:16:49AM -0700, Darrick J. Wong wrote:
> Hmm.  Do we even /need/ these checks?
> 
> len is already basically just min(SIZE_MAX, iter->len,
> iomap->offset + iomap->length, srcmap->offset + srcmap->length)
> 
> So by definition they should never trigger, right?

Yes, now that it is after the range trim it feels pretty pointless.
So count me in for just removing it.


