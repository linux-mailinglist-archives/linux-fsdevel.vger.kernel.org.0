Return-Path: <linux-fsdevel+bounces-61259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CB9B56BEB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 21:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304713B2072
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 19:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B292E62C0;
	Sun, 14 Sep 2025 19:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RPj6Frg4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FEA2E612F
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Sep 2025 19:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757879440; cv=none; b=HEOQRlnCsf62a7QLDlEyQxSCt7ljIWuDrRCBr/xmnx4H2NSnaZmgry0l98CAtgmuu9pw4Yuw4Y8H/Zg+qkdTZ/hT34X8WbqjNTcKNj1pvO8AqZHzttykuU+BHp8O9zqjM2kZb8AJAnLgd2Aw2XjjBWEPueyvwkdiLJVCFXQ49+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757879440; c=relaxed/simple;
	bh=sxrExdXOTioK1H7c+cm+Z3HWrjMsHiLv8NIzZdRSbp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOKmXUntaMglIT7PhnAUEgXVnZ6xktH2Sra359Cyn3l/7qB+J8ikD78KFBH6Z5R+di22WZd2fpTNp9aVWC9TY3LxRsu/QSTYm6wMqsILC7ixLsDMYouvlW9q8F59yP1PN0O5k3uf90hJ0Z2YVFNxCAKefRIwTED70T0/WSvNI8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RPj6Frg4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dSlT7tjW4uQcz2n4u4CZSaXqO3+ZMdN3hvnJ8CxB/IA=; b=RPj6Frg4Pd+Ocz6+idKdyuS1eo
	TKxSbwx5S2JzsyPP7a95Gj7nTvPTZ9KIf1+0a0lYL48KKvDGOYnYQEBBKBK7PO3JM3tF9x51KcnOe
	CawMMaLIk1JaUfVS8IxEsxSNgDRcFmcLS+nfpY5oypSJcZOLUbbvCqfPO23mkuSPLzb2dQL62bvWC
	3XWxcZOqQyr/ieNM8q87MGffhIhudUW7b8/Ak8QHuWPXwGFdOMmBEsos6U1scO5zJjUK7x0Ke8wOm
	tXPFGNzEpn+NbZQtSISYGSkdPdZHqxMlTfd/g8wNP7sYnN+RqZEGRFyfmmhHjq3Qqingn+ZswOG8g
	lBQon8Tw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxsk6-0000000G1fr-17Z4;
	Sun, 14 Sep 2025 19:50:34 +0000
Date: Sun, 14 Sep 2025 20:50:34 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: NeilBrown <neil@brown.name>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Bernd Schubert <bernd@bsbernd.com>
Subject: Re: ->atomic_open() fun (was Re: [RFC] a possible way of reducing
 the PITA of ->d_name audits)
Message-ID: <20250914195034.GI39973@ZenIV>
References: <20250908090557.GJ31600@ZenIV>
 <175747234137.2850467.15661817300242450115@noble.neil.brown.name>
 <20250910072423.GR31600@ZenIV>
 <20250912054907.GA2537338@ZenIV>
 <CAJfpeguqygkT0UsoSLrsSMod61goDoU6b3Bj2AGT6eYBcW8-ZQ@mail.gmail.com>
 <20250912182936.GY39973@ZenIV>
 <175773460967.1696783.15803928091939003441@noble.neil.brown.name>
 <20250913050719.GD39973@ZenIV>
 <CAJfpegvXtXY=Pbxv+dMGFR8mvWN0DUwhSo6NwaVexk6Y6sao+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvXtXY=Pbxv+dMGFR8mvWN0DUwhSo6NwaVexk6Y6sao+w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Sep 14, 2025 at 09:01:40PM +0200, Miklos Szeredi wrote:
> On Sat, 13 Sept 2025 at 07:07, Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > How would that combined revalidate+open work for fuse, anyway?  The former
> > is basically a lookup - you send nodeid of parent + name, get nodeid +
> > attributes of child.  The latter goes strictly by nodeid of child and
> > gets a 64bit number that apparently tells one opened file from another
> > (not to be confused with fhandle).  Combined request of some sort?
> 
> There are already two combined ones: FUSE_CREATE and FUSE_TMPFILE both
> get nodeid of parent + name and return attributes of child plus opened
> file.  FUSE_CREATE gets invoked in the uncached or cached negative
> case from ->atomic_open() with inode lock for held exclusive.
> 
> That leaves 2 cases:
> 
> - uncached plain open: FUSE_OPEN_ATOMIC with same semantics as
> FUSE_CREATE, inode lock held shared
> 
> - cached positive (plain or O_CREAT): FUSE_OPEN_REVAL getting nodeid
> of parent + name + nodeid of child and return opened file or -ESTALE,
> no locking required

What happens if the latter overlaps with rename?  Or, for a cached
directory inode, with lookup elsewhere picking the same inode as our
cached (and possibly invalid, but we don't know that) dentry?

