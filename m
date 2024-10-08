Return-Path: <linux-fsdevel+bounces-31316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C7C9947A2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 13:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C002872AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 11:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F781D6DA3;
	Tue,  8 Oct 2024 11:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JteG29r4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B54176FA7;
	Tue,  8 Oct 2024 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728388179; cv=none; b=dQYjb5GVd+/ElujCllmx/uMvzHDTNNRjRsQNqdXVIVGSFXrsingdnUQ8Kz2V5baWgGoW47Ll9vgY6odnzLY5tHUe62Nqe9IN/p1rZKFQ+9b3EXVczy7A1jfpbhZVBfwk4TeWrtU55EzyQ0dOMxitpmSXRVlPGzWCOIx1/m6bla4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728388179; c=relaxed/simple;
	bh=oNbUcL+CWC8MEQpExAL16Ue2D7U2ea9NJhkt7zF3eb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YT2TpgsSuupAxQY91Q64FiVxr0TenevP8xEG+S+iQHA+18I/is98roXpcn187BLV5ofo0t+yIO0NqrO6fsN1wojUykzglc2TfxUcLhKwcQ8rDW1woZAHX1dhS8vROHRmTWi0adI44J3UhCIqswHH/rDfsBQJLAr1xEuB2OnYsSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JteG29r4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=awNsU8kM1gVB2hmGRFW5nD6DpdqCrn8A9zApWM8go6M=; b=JteG29r4u7xWDca3q521WGut1p
	+W3eln9BohXAIUrXhRM6XRBWCUs6mMh15B8wUEdnqCOz56ViTP0Sw/+Wvt+nufSaS/pzC7P0suvka
	3zhloUFhkynsKq7ADkTSLRMM7hmfnqnCB8r+xQZrHT7RbWTd+1FhM2MRpOxtIpowWyNodfiJ1+1WL
	oafDlRbcEokBkwzHyBv+OGAKvfntAeYfKS9NY+Ju0NjSMdL0clrF6Eozpdw30yI+n6ELNEFa8aqR4
	K981aSZJ0O5YhTu9Npmh0LGyxxKz+zqGLsp0HKXfjFqL1zi6l95XMWx9FEJpbVYVq1i9xh3pprrwH
	/3ROin+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sy8id-00000005h9k-2aVa;
	Tue, 08 Oct 2024 11:49:35 +0000
Date: Tue, 8 Oct 2024 04:49:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Allison Karlitskaya <allison.karlitskaya@redhat.com>,
	Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH 1/2] fs/super.c: introduce get_tree_bdev_by_dev()
Message-ID: <ZwUcT0qUp2DKOCS3@infradead.org>
References: <20241008095606.990466-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008095606.990466-1-hsiangkao@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 08, 2024 at 05:56:05PM +0800, Gao Xiang wrote:
> As Allison reported [1], currently get_tree_bdev() will store
> "Can't lookup blockdev" error message.  Although it makes sense for
> pure bdev-based fses, this message may mislead users who try to use
> EROFS file-backed mounts since get_tree_nodev() is used as a fallback
> then.
> 
> Add get_tree_bdev_by_dev() to specify a device number explicitly
> instead of the hardcoded fc->source as mentioned in [2], there are
> other benefits like:
>   - Filesystems can have other ways to get a bdev-based sb
>     in addition to the current hard-coded source path;
> 
>   - Pseudo-filesystems can utilize this method to generate a
>     filesystem from given device numbers too.
> 
>   - Like get_tree_nodev(), it doesn't strictly tie to fc->source
>     either.

Do you have concrete plans for any of those?  If so send pointers.
Otherwise just passing a quiet flag of some form feels like a much
saner interface.


