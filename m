Return-Path: <linux-fsdevel+bounces-41206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1108A2C50C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 15:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9B1162FB7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 14:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEFC23E249;
	Fri,  7 Feb 2025 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QciSzymz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F60D1DED5A
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738937942; cv=none; b=SbQPH0JcW6lk0RFfPBwgk8zhyCwn5419104efqQyergjXVo9XfowLINQH2Pndc30BJ6V4UmQrJAYfPXSY5Oni/6GpO6fMEGcimLnD+hCHyN8PUMlqlwvhFv3XIjGtJbaBmHg6UjHWhVs2iKy0wkHAK38QXFAqE6Fwq/MUdj5MOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738937942; c=relaxed/simple;
	bh=BQh1DC/s6XAzLavG6g2D45gXzxL7TOYsNKNn2SxKqeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQKk3zjLuYKWcFpG+qpi42aACyFQOk1FCVMpgeVdc4TR4e2ENDLPxOli7xolm2XAg74+zeaq9/A5StNrXYtQLHXcHJio6bZPS3cC0xTSj33EPg2ejb+9O7rPWBer85BdG6DCrvW/yCKAoSFUFps+Ele8Pixw7a6U3so1NpLNdTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QciSzymz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Su5e5/2QDmn9B8VUGXjbH+IecyO8E2BpXOg0xMcQNLw=; b=QciSzymzagzk/PndI7nO88BRNF
	vTnfPTA/zlyxiwhAu+0gCn/XjG881HwVU6WLaNNm9icAbuY2UORaTL45fWovb3MZPy4EQWNTvcWxz
	kIbvfkI/ZutmqQp8wwQMVTy/0Rk3gwSsA2S4ADyeYoZZ1BsNLkNSuDSZmc+34l534WA1FhAeQ5ntq
	nyrjj2zRpeBp2hlhUcEp3EGmeabHHEtIp97y9Fi5gVy1gV+AIEAwmkvp15G5dz00uiGF7lwG9pGth
	TFpbKV0V1xLNUtI0E99rieAwNv+t8bE7NspQulCfsnBsBGWjiw0eM13fXcq1Xz3e1e7uxJ7HGgj73
	3oBbX9IQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgPC6-00000007wP9-19U5;
	Fri, 07 Feb 2025 14:18:58 +0000
Date: Fri, 7 Feb 2025 14:18:58 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Amir Goldstein <amir73il@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH] fs: don't needlessly acquire f_lock
Message-ID: <Z6YWUhiqfos7f7Sj@casper.infradead.org>
References: <20250207-daten-mahlzeit-99d2079864fb@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-daten-mahlzeit-99d2079864fb@brauner>

On Fri, Feb 07, 2025 at 03:10:33PM +0100, Christian Brauner wrote:
> Before 2011 there was no meaningful synchronization between
> read/readdir/write/seek. Only in commit
> ef3d0fd27e90 ("vfs: do (nearly) lockless generic_file_llseek")
> synchronization was added for SEEK_CUR by taking f_lock around
> vfs_setpos().
> 
> Then in 2014 full synchronization between read/readdir/write/seek was
> added in commit 9c225f2655e3 ("vfs: atomic f_pos accesses as per POSIX")
> by introducing f_pos_lock for regular files with FMODE_ATOMIC_POS and
> for directories. At that point taking f_lock became unnecessary for such
> files.
> 
> So only acquire f_lock for SEEK_CUR if this isn't a file that would have
> acquired f_pos_lock if necessary.

What workloads benefit from this optimisation?

