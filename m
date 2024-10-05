Return-Path: <linux-fsdevel+bounces-31074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1084E991983
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 20:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC35282A8A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 18:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC3D15B0F4;
	Sat,  5 Oct 2024 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="U7e68Nga"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85C7231C81
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728153073; cv=none; b=M7rWjSU47jEWv+6moU82Zd5kK3cGJbmtiU+o6pOpke61QRJ/APThnetcmfFGVfYe3HzK0HFeLRKR41iSUXADAx24UGaFCc/3GrA582lpkdtwWC5vKPn9bkxHkmHAHR5xIguU2NMcKxierzqiakO6edZx3cWDOdo7ySk30WN9fXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728153073; c=relaxed/simple;
	bh=xCuTxDcJUCt4XYfuX1LTUca68MozuZNyVUIU63Kwu+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fz1pJHCLil6N3obF7n7Vr06dEDIFf2omUBXUVvHpcuBNUkrcCUvqHyBvX79JBlkWw6k8TFpYSeh8NXfXs2IAaCaNfuJa1APtZ+tCJ2MzTFQbKRCrsb8cD8CCiFOTWpVi1wiMZR8iwZTWkcCn1xwOQC0PwJWFmkjU1OLucHbOSJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=U7e68Nga; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UK9HYobtWNw+nKyu9l7GQfPcWBkfTUofDZv1QUmuoss=; b=U7e68Nga+o4nD6qlaxJHmEb7ko
	GcndVVM+yK4ojLmsiqWI1PogFH0aDXNvpsjjuQ7cWl8MTGc9Uc5kaXYwtKDrM7hi9lUewzIJYFCP6
	tCIw9byXMdtWKpNm9o1rNwVgQZTwy5Qo0RHJuB+Tal3D6UxTF8mxBoFDJrHDdjvNPdh9dTwNiE+UU
	YxnznWYLT/9CYjvDSZQJF4KfLAk0VsJwtaonvcW4ZQHbplF4HHmoLqTzweMn80P3rq2Uru9rmZpuo
	y15gjvmrtQNvDKMQfKlpmk87I+WphbuG27GspCE9OlKDa5917AI4ZQxl/ykE8AYw0aWCSlScKSjfd
	nrmEP1mg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sx9Ya-000000017S5-3UQF;
	Sat, 05 Oct 2024 18:31:08 +0000
Date: Sat, 5 Oct 2024 19:31:08 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] UFS: Final folio conversions
Message-ID: <20241005183108.GX4017910@ZenIV>
References: <20241005180214.3181728-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005180214.3181728-1-willy@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Oct 05, 2024 at 07:02:03PM +0100, Matthew Wilcox (Oracle) wrote:
> This is the last use of struct page I've been able to find in UFS.
> All the hard work was done earlier; this is just passing in bh->b_folio
> instead of bh->b_page.
> 
> Matthew Wilcox (Oracle) (5):
>   ufs: Convert ufs_inode_getblock() to take a folio
>   ufs: Convert ufs_extend_tail() to take a folio
>   ufs: Convert ufs_inode_getfrag() to take a folio
>   ufs: Pass a folio to ufs_new_fragments()
>   ufs: Convert ufs_change_blocknr() to take a folio
> 
>  fs/ufs/balloc.c | 16 ++++++++--------
>  fs/ufs/inode.c  | 30 ++++++++++++++----------------
>  fs/ufs/ufs.h    |  8 ++++----
>  3 files changed, 26 insertions(+), 28 deletions(-)

Looks sane (for now - there's really interesting shite around the block
relocation, hole filling, etc.); I've got a bunch of UFS patches and IMO
it makes sense to keep it in the same branch.  Mine is in #work.ufs
and there's pending work locally.

I'll add yours to the mix and see if xfstests catch any problems there;
will post tonight.

