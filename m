Return-Path: <linux-fsdevel+bounces-20255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF618D0872
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 18:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB78828965D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 16:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F1228387;
	Mon, 27 May 2024 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h6ef4tVo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8C317E901;
	Mon, 27 May 2024 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716827045; cv=none; b=sbi/IJ6UoKe6ZITU3wU0RswpRlE0i4imib0X/8EdicfR746ElspEY4MyoOIgOqrIdykrcR4V1Xea3/BmhMYBd4KgwNGwRTMK4lHoFjEA69s5fEW9fFgeIS0k6w4BmSPGcd7cgD7IoNBBKGZj/pjgvA4po/6UDHqzo5zTzLFA1i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716827045; c=relaxed/simple;
	bh=zT3lpBZ+2fnJDWLc3sht5+aKTyNn+eXHeZ2ka4QD1CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAlbtj1+d0vLs5MaYE9Lm1MlMPE1X7JGFxhZhkpyZpL8/wQNwhocHWRrLhz+ba1d4UbkPeWyW8rayPRQiPrQJeGovZD0wRxky75ICIQ8bkJ95PqdyNFz5RXF9jFQ5Omwawi91vgqOwMCuwlb8eeu3FTg0LFNgh0dCfCSXdacTSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h6ef4tVo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PKe5sDmdxLVMDi1TLTY8eblrDmzTLWLqc3P92QWHeGI=; b=h6ef4tVo/DR8bnv4zxe8tJP+Kg
	sGdSQTmCmQRGTyRKl3IIFSHOUB+8lQhu/a2sKyB+KIrzL8UQ+q8HBD0j/bKbQcATF4KHQAH46QzdX
	BLF3x5fIgqt0kUmyPmz29QMVk6gIyNIgxBirCsMCtSMZmrUt/dJrzGz6a1D74sFbUWUr+7mB071+l
	RkmdI5jgDuQoTi9+fcxo11XTm1QWoQuybTXR5WCsac5OscIn9P+d/WPj5qiO2UhB7apymQG+9bWRB
	MkeUiqREiWGl/ST5NBc88wnCmJs6pmHFlfufdriBmB1X7tGo5SY9wwu+NdueSWqSQ5KVnZnJpvxpq
	QPKFrWLQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBd8k-0000000Fpmc-09dI;
	Mon, 27 May 2024 16:24:02 +0000
Date: Mon, 27 May 2024 09:24:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <ZlSzotIrVPGrC6vt@infradead.org>
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
 <ZlMADupKkN0ITgG5@infradead.org>
 <20240526.184753-detached.length.shallow.contents-jWkMukeD7VAC@cyphar.com>
 <ZlRy7EBaV04F2UaI@infradead.org>
 <20240527133430.ifjo2kksoehtuwrn@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527133430.ifjo2kksoehtuwrn@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, May 27, 2024 at 03:34:30PM +0200, Jan Kara wrote:
> So I was wondering how this is actually working in practice. Checking the
> code, NFS server is (based on configuration in /etc/exports) either using
> device number as the filesystem identifier or fsid / uuid as specified in
> /etc/exports.

Yes, it's a rather suboptimal implementation.

> So returning the 64-bit mount ID from name_to_handle_at() weasels out of
> these "how to identify arbitrary superblock" problems by giving userspace a
> reasonably reliable way to generate this superblock identifier itself. I'm
> fully open to less errorprone API for this but at this point I don't see it
> so changing the mount ID returned from name_to_handle_at() to 64-bit unique
> one seems like a sane practical choice to me...

Well, how about we fix the thing for real:

 - allow file systems to provide a uniqueu identifier of at least
   uuid size (16 bytes) in the superblock or through an export operation
 - for non-persistent file systems allow to generate one at boot time
   using the normal uuid generation helpers
 - add a new flag to name_to_handle_at/open_by_handle_at to include it
   in the file handle, and thus make the file handle work more like
   the normal file handle
 - add code to nfsd to directly make use of this

This would solve all the problems in this proposal as well as all the
obvious ones it doesn't solve.

