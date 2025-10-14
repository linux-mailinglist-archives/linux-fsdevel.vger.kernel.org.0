Return-Path: <linux-fsdevel+bounces-64077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40175BD7535
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 06:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E194227E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 04:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F9030CDBE;
	Tue, 14 Oct 2025 04:53:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A05330BB89;
	Tue, 14 Oct 2025 04:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760417611; cv=none; b=UHHxh96XjlBmEJ7sHiyDd0lAHcnjqkdOsJpjkjEi8aoPC0f42yOhEIr3LnKdSVFNVLkovYfKT4OY566NuWUwAftznkVLC0f8tpJKrRE5e7RU1vc6J/o+5sG0wJ4ico29s8X085jeSyaJH1p3nsGZr5JYs0YNOEvxgh32299+Wqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760417611; c=relaxed/simple;
	bh=EIMyaPN+e4RlDyzsTqvcbYfkjxs+/uvliBFzVy4ZHVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3chWJArLqXppquyjlscPg0uIcDxJ77wfRbaKRwAyhscs96GQxPdi4p0JwOxpNFYjMf+O0CD0SUgRs20AVw2Cp9/YwxXceq2iGe97ysPYfGTenYdNdqLpvNyU5Hmb/CZX9SNM7gP8jD9Q5M576B4wKyiz3rElG24/nqDerMuF8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E5B4F227AAA; Tue, 14 Oct 2025 06:53:25 +0200 (CEST)
Date: Tue, 14 Oct 2025 06:53:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
	v9fs@lists.linux.dev, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net, ocfs2-devel@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 07/10] mm: remove __filemap_fdatawrite
Message-ID: <20251014045325.GD30978@lst.de>
References: <20251013025808.4111128-1-hch@lst.de> <20251013025808.4111128-8-hch@lst.de> <t4y7xtgfnzfpfupnb7on33n6qzrfxfphsm2hqsa5rx4liqvvbc@wwj7ckhyilpo>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t4y7xtgfnzfpfupnb7on33n6qzrfxfphsm2hqsa5rx4liqvvbc@wwj7ckhyilpo>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 13, 2025 at 01:59:21PM +0200, Jan Kara wrote:
> > -	return __filemap_fdatawrite(mapping, WB_SYNC_NONE);
> > +	return filemap_fdatawrite_range_kick(mapping, 0, LLONG_MAX);
> >  }
> >  EXPORT_SYMBOL(filemap_flush);
> 
> filemap_fdatawrite_range_kick() doesn't exist at this point in the series.

It does exist even in the current upstream kernel.
filemap_fdatawrite_kick doesn't exist yet.


