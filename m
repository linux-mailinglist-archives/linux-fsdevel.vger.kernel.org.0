Return-Path: <linux-fsdevel+bounces-36835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5579E9AF0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 16:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CA818852ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 15:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B488C132105;
	Mon,  9 Dec 2024 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rAwqB3QT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DB178C9C
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733759698; cv=none; b=RC1297rnxuI7P+xoFR7soWCKdiW9YKhZ1LfBn1XEO74gznpb6m06F5/0QieTcAnYczPrd2l/kj9n8m2rU+odkAsCpkOpgEoPhPq/nGTENB1AaccsQ7RW4CkPDLf385EJJQP69hsCABMoFMhNbSjo7I4GsN8T/Ks5SJfFuvFY/Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733759698; c=relaxed/simple;
	bh=PPfu/V9J1rVcnY0eKoprC8/BEk1ckOl4joUQdrdbgY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBN7mFMaXvZ66D7CgC85iycjiy4sVIrhmxhGeqDnc+DEpyZ5Rd7GgCyAfXFagdjpSX8ehMRhYNU/nOnRMGCCQkjUOLnzBderptVLEnzr7Jdzl9dl2TDrfDYP3OnfaVMcR+8KJJ6J4ETTG4I/nz9TL8+FpnYP8moK6smgt72KGqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rAwqB3QT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eIE2QU5IVMvlyIrnVxRGHzA/dVgrGG3AtDwVKovZDs8=; b=rAwqB3QTWnLEd+yPrijkNpCazM
	IPFl3OjJsa+DcSFEZhLtDusLL0cpZekovXAOGBSB1cS/wQAgyTYywNMUlwXfkTfD/L7LS55wKJM30
	UxtYb/Mu+J8UZV7t+GSR/c1LyxUWpQ6PABZ9VoQiYj4Tp6OALhGhoOSSRtT3vq5C1MX282ByqMAc/
	ONlRNITaL/zJiI+zw2wdqP3Y9cAKMTQ2H+ZylxmCy1ViSHN/OTBhjonqI+85hUnuHk3QPalVv0vax
	S9iyBUYS8kim7ZpQaV2RsFKX0FFOyNNltyUed5zgAJEMVFITuNpr9DxHB86VNulkGI5qRqJC6/L9N
	b3jZtkCA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKg60-000000036EV-0u46;
	Mon, 09 Dec 2024 15:54:52 +0000
Date: Mon, 9 Dec 2024 15:54:51 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com, shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: Re: [PATCH v2 10/12] fuse: support large folios for direct io
Message-ID: <Z1cSy1OUxPZ2kzYT@casper.infradead.org>
References: <20241125220537.3663725-1-joannelkoong@gmail.com>
 <20241125220537.3663725-11-joannelkoong@gmail.com>
 <20241209155042.GB2843669@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209155042.GB2843669@perftesting>

On Mon, Dec 09, 2024 at 10:50:42AM -0500, Josef Bacik wrote:
> As we've noticed in the upstream bug report for your initial work here, this
> isn't quite correct, as we could have gotten a large folio in from userspace.  I
> think the better thing here is to do the page extraction, and then keep track of
> the last folio we saw, and simply skip any folios that are the same for the
> pages we have.  This way we can handle large folios correctly.  Thanks,

Some people have in the past thought that they could skip subsequent
page lookup if the folio they get back is large.  This is an incorrect
optimisation.  Userspace may mmap() a file PROT_WRITE, MAP_PRIVATE.
If they store to the middle of a large folio (the file that is mmaped
may be on a filesystem that does support large folios, rather than
fuse), then we'll have, eg:

folio A page 0
folio A page 1
folio B page 0
folio A page 3

where folio A belongs to the file and folio B is an anonymous COW page.

