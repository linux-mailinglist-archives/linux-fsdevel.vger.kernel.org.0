Return-Path: <linux-fsdevel+bounces-39231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF11A11942
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 06:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A929188B4D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 05:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B792309B8;
	Wed, 15 Jan 2025 05:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wE0/mrnN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1863C22FADE;
	Wed, 15 Jan 2025 05:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736920050; cv=none; b=Yuj4YfhMxz63qOKUQyHruYkONAH7OYiscDsL0NXjCFo++R1C8hqyDohEay/705XFTCv9l/uK0XSjR8IZr8BhP89NxDTISJEYL17+x+XHYbBfO80pjU96XPx9djM/3HJblnXhekoQqSAHGGUX5hh022h1oD2G1WdHWb8bQyshdA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736920050; c=relaxed/simple;
	bh=5jSZK1Z9Bpjw1utOhiCZcKwL8K6rGFX2KAqlrBSB2G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LoUIC3QZYOd4iEhJzmjwH1uzWQ2XoebJn5SV1KPCjSSmQj/XvnKeP8iWDL9b/Jv3T0NXqh3yoCtreQBx5v6oeMpv3GDFF5JthmFs2wJwfTavKVSKwPE5kcgGRNBP7fecjZKOXio0FoukkpFlCCMg+bsvNDHwQGIyCOjs6I7rI3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wE0/mrnN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PRDLe+L5j5CVpXfGzAT5mJagZMzfWPDZP/TxI5B4s3o=; b=wE0/mrnNIEzYpuJmAkwHd41Rmr
	cRphSjuccNZr7gK8qWlSIqk+iUSPCbTtCnbGeKiaiEUvxcVHwuzmyU1feHlv3lOFgEiKP0WIyrNcr
	Y6GYDJEmCf2zJEIahpZUX//xug89MVy8GRwC990I91kHsL/xVWPrUveOJWecema2bUZjll4okJVDb
	qJS13+T1GOd1OlUZ0Z20xAUcW0EhK252SyBv3P2u1x17J7vSCsYCpq0dy5WthycPMXD7YFRZYBXw2
	ITchuS44smER5gtT5CR60ZFB2CglIZ5Ffc8hUZGZX2gwkaIaKmICjBFEr5iIMUVMqpwyPtRXr34p+
	jQzrDzcQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tXwFU-0000000Aiji-2lIy;
	Wed, 15 Jan 2025 05:47:28 +0000
Date: Tue, 14 Jan 2025 21:47:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH RFCv2 2/4] iomap: optional zero range dirty folio
 processing
Message-ID: <Z4dL8PzrIN1NuyZF@infradead.org>
References: <20241213150528.1003662-1-bfoster@redhat.com>
 <20241213150528.1003662-3-bfoster@redhat.com>
 <Z394x1XyN5F0fd4h@infradead.org>
 <Z4Fejwv9XmNkJEGl@bfoster>
 <Z4SbwEbcp5AlxMIv@infradead.org>
 <Z4UkBfnm5kSdYdv3@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4UkBfnm5kSdYdv3@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jan 13, 2025 at 09:32:37AM -0500, Brian Foster wrote:
> In turn, this means that extending write zero range would have either
> physically zeroed delalloc extents or skipped unwritten blocks,
> depending on the situation. Personally, I don't think it really matters
> which as there is no real guarantee that "all blocks not previously
> written to are unwritten," for example, but rather just that "all blocks
> not written to return zeroes on read."

Yes.

> For that reason, I'm _hoping_
> that we can keep this simple and just deal with some potential spurious
> zeroing on folios that are already dirty, but I'm open to arguments
> against that.

I can't see one.  But we really should fine a way to write all this
including the arguments for an again down.


