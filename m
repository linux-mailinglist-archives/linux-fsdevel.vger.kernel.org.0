Return-Path: <linux-fsdevel+bounces-17205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5746A8A8D33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 22:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088C91F2297D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 20:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE8247F63;
	Wed, 17 Apr 2024 20:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="au2DcBRj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF5644C7B;
	Wed, 17 Apr 2024 20:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713386717; cv=none; b=jDH5xuLJbG6r20B3n2TKYje3AqesRpXvVO14WZOltwBqFmWSrGieeypIul6zYr4obzIm9UsTZfK1hbSttOatNxUrlXYfb4wDfqXFh5SB9OKbazGHR0Qv8cYc2CjVcsw1TVNJqKyTaL7jKNhspz1P8qk62sGOCCizqbMbr2RzEzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713386717; c=relaxed/simple;
	bh=wlIgsqiPUF9bkmZTjmmRjmIDrDC3JSbRWMjul89Oki8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgeGLye2Tw3wUn1nzHJysjkfFWAkQgSmpsg/C1WZjyEWIHQd8rYTYpFrEmV8jeiIV7a0QZr9kotucruZyFeLKSZk3BGNWE2sPvPY8fSKIQQW63oUy0jE6qLnau5DJL4VAp+hfSPeF8OdERoP+3Oqq3h9+tIOj8xvvixHnW6YJ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=au2DcBRj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BvHSSwDgZvfid1sqlQ1o/inIrOdXBqnLwTqg0dZSKDY=; b=au2DcBRjLagu7riDaYwmuhQlr8
	1sN/vD6VJwfFlUQEDBtksahdUlaFRNeq7KD8l4pO+a5xnsn7CYm6uxK4mZwvxxnTuPJYYfWH3RssR
	8ZOZRlGfQvUTbuxz8mQT596e8AQZX2nQp+ZEDi1Vd0wVmAvquUPxnbz5uYoyBna+UIW8vTzgFF08w
	YZr7C+F35vr+O+nLFUUSktfpoEgGd4IVaVwIt+zV6HsNapeXMGxQZWV+rK0FWrIzgrFHAhD7xmeh6
	S+T8rLkiEcNIReTcDGXGCwqddPljPoZKqnn3BLcn/N01SZOcICi1zTgx1IsnQb84lk0Btz9r/tWM4
	4zSWze/w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rxC9P-00EdzQ-24;
	Wed, 17 Apr 2024 20:45:03 +0000
Date: Wed, 17 Apr 2024 21:45:03 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de,
	axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>,
	Christian Brauner <brauner@kernel.org>, linux-pm@vger.kernel.org
Subject: [RFC] set_blocksize() in kernel/power/swap.c (was Re: [PATCH vfs.all
 22/26] block: stash a bdev_file to read/write raw blcok_device)
Message-ID: <20240417204503.GD2118490@ZenIV>
References: <49f99e7b-3983-8074-bb09-4b093c1269d1@huaweicloud.com>
 <20240410105911.hfxz4qh3n5ekrpqg@quack3>
 <20240410223443.GG2118490@ZenIV>
 <20240411-logik-besorgen-b7d590d6c1e9@brauner>
 <20240411140409.GH2118490@ZenIV>
 <20240412-egalisieren-fernreise-71b1f21f8e64@brauner>
 <20240412112919.GN2118490@ZenIV>
 <20240413-hievt-zweig-2e40ac6443aa@brauner>
 <20240415204511.GV2118490@ZenIV>
 <20240416063253.GA2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416063253.GA2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Apr 16, 2024 at 07:32:53AM +0100, Al Viro wrote:

> kernel/power/swap.c:371:        res = set_blocksize(file_bdev(hib_resume_bdev_file), PAGE_SIZE);
> kernel/power/swap.c:1577:               set_blocksize(file_bdev(hib_resume_bdev_file), PAGE_SIZE);
> 	Special cases (for obvious reasons); said that, why do we bother
> with set_blocksize() on those anyway?

AFAICS, we really don't need either - all IO is done via hib_submit_io(),
which sets a single-page bio and feeds it to submit_bio{,_wait}()
directly.  We are *not* using the page cache of the block device
in question, let alone any buffer_head instances.

Could swsusp folks comment?

