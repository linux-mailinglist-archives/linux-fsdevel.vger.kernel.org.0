Return-Path: <linux-fsdevel+bounces-25071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AC29489AF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 08:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09591F24047
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 06:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D571BCA15;
	Tue,  6 Aug 2024 06:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tLb0j6vw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E8E15B147;
	Tue,  6 Aug 2024 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722927523; cv=none; b=jLnaEhXV5UPQUavQqPAaE0VLH53WOjjpPYx3Z2Kqm8/1h4zr46qZtOw7oNHTzRxC84FROCv/a6soNSEcm9zFcO9SO8KDJD3r9jsLwptSLqXnTvYsXxahcibqEC4Oc2TMaE+saPTQC2RCL1ZdaGyY1bCaQ+2V2k+wYJPv6ewqFJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722927523; c=relaxed/simple;
	bh=cxeh+0h1Dn0J1ShfXMr07zffXAo0VlsxFKFZ9TCgsFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lr1LGw28w2VTAaChDoZZ9GuqFVz2oIuPsI8NeVv+NZlyOXrWdB6FDptiRmU8OXs9bfLyyYSc38X9UpCUXYyUvsyOBX6oJIAbak3jEN1/ZgDT7s5i9CegzLfepevpFH/3mgBNkVj4CXDY6rGFo7TkndznchEYbKHsquYN65IUa/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tLb0j6vw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VKN0UULIdJHn5RllNLZv2kwGuMI46u6UhRv3TC+5aNM=; b=tLb0j6vwBJ92jhcfV8anvIR/UE
	LFwlX5J193Lbe17u2fAyxaUpOxrNxMDoOb7vRk3XhAWf4jzUmkCB04Hoo6NnZ7d7gEm2QHah9sT5Z
	e+2LHyRPxbtNOSeq7EbXakWok//my4LcHRtBGzI82qIfDlp5x866ZGPIVQQ+Sk7KnD8vXLdIbBeUM
	zsiySpKM1lTmPu8TySYe0BS8EBCWMEVn0wia9J8FPEXt3Ohuvy6+oJkUxO2EjeNw1/occh6GFzMIu
	Oro6T6foCwWyywSypSgo8JjsMXUakleh3hOdEZry7FkmNr3L9V8GuKSJt07oqXoeFX//hPQ/GQ8Ru
	Vt0OsF5g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sbE9U-00000001rKK-2Jti;
	Tue, 06 Aug 2024 06:58:36 +0000
Date: Tue, 6 Aug 2024 07:58:36 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, phillip@squashfs.org.uk,
	squashfs-devel@lists.sourceforge.net,
	syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V7] squashfs: Add symlink size check in squash_read_inode
Message-ID: <20240806065836.GN5334@ZenIV>
References: <20240806045905.GM5334@ZenIV>
 <20240806061912.3774595-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806061912.3774595-1-lizhi.xu@windriver.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 06, 2024 at 02:19:12PM +0800, Lizhi Xu wrote:

> > However, you seem to find some problem in the latter form, and
> > your explanations of the reasons have been hard to understand.
> Here are the uninit-value related calltrace reports from syzbot:
> 
> page_get_link()->
>   read_mapping_page()->
>     read_cache_page()->
>       do_read_cache_page()->
>         do_read_cache_folio()->
>           filemap_read_folio()->
>             squashfs_symlink_read_folio()
> 
> fs/squashfs/symlink.c
>  8 static int squashfs_symlink_read_folio(struct file *file, struct folio *folio)
>  7 {
>  6         struct inode *inode = folio->mapping->host;
>  5         struct super_block *sb = inode->i_sb;
>  4         struct squashfs_sb_info *msblk = sb->s_fs_info;
>  3         int index = folio_pos(folio);
>  2         u64 block = squashfs_i(inode)->start;
>  1         int offset = squashfs_i(inode)->offset;
> 41         int length = min_t(int, i_size_read(inode) - index, PAGE_SIZE);
> 
> Please see line 41, because the value of i_size is too large, causing integer overflow
> in the variable length. Which can result in folio not being initialized (as reported by 
> Syzbot: "KMSAN: uninit-value in pick_link").

What does that have to do with anything?  In the code you've quoted, ->i_size - index
is explicitly cast to signed 32bit.  _That_ will wrap around.  On typecast.  Nothing
of that sort would be present in
	if (inode->i_size > PAGE_SIZE)
as you could have verified easily.

At that point the only thing I can recommend is googling for "first law of holes".

