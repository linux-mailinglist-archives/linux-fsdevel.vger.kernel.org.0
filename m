Return-Path: <linux-fsdevel+bounces-21755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7E29096A5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 09:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B8E28324C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 07:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B641917BC9;
	Sat, 15 Jun 2024 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WwzXgvcX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A6A17BBE;
	Sat, 15 Jun 2024 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718438365; cv=none; b=QAMPXC8p1D6eu45yZWnhQ1YP+k7CSTeMw6BlKLEE8KxJMOth+6c5AsQjWHou5buF3mXyQFvhun6Yd76RhA8dkXkENZ7OFeNNbPthYen+nvVyFdai00GAblVVHhFyR2CPgxjIYhUYEi2+51q2jC11P1OGGTJ1Usho/ghCyyWQ+F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718438365; c=relaxed/simple;
	bh=XD6NEkLXoMXmOu+t+IhgS6fj1j4ej3Cs6eE4qHj7MNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTK31oiIRqTVNrD1YKuxx2jVbY9YZGa7Sj7augnoBwrliPJLXCZFFH9CXoydZzZnsR3ohkUAQBThWPgJwwcnchImAdO5lRfmoQwB06r9ao8nbhB8AOSnekX+u3zW8cewJc4hiufblO/RtgyX7/L0A+DpMQWifCVlG2lTKMP4hUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WwzXgvcX; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ewv/lUU1C8csZZTchChyJDKI+EHR7TVXCVzLeQxBxNA=; b=WwzXgvcXARbpW5zc+lneOi2sd2
	25xo3US7jRzkbV8L3DZGPTNbBa1WBBbgv4uerR45oNnjtmgEXMhp9Sn/MXW9tCOzPOAZU/5ceLwn5
	TIHb0NKtMllt5SomQ05AioBI0r9oLYC64wQBDlDeW9n1i4B8SHi1Voy7W7PeEqkk9w3vHnnJ6JmLU
	mmrmJFgEJ9CTr1Z5hGrpoVzVYSJcNw//JtUn8q8ovSVcghKEMVOopZ0L2pdygLiOKdietdImJBduw
	Q7Jysj+ysFxDqPoE2e31tnHfLAb3Fzziel1BpJJEH1oroVnnmPanbNr5hgk3U9mySOqQIxmkWmarA
	k/bVJ16w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sIOJX-00A7V2-32;
	Sat, 15 Jun 2024 07:59:08 +0000
Date: Sat, 15 Jun 2024 08:59:07 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Congjie Zhou <zcjie0802@qq.com>, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: modify the annotation of vfs_mkdir() in fs/namei.c
Message-ID: <20240615075907.GQ1629371@ZenIV>
References: <20240615030056.GO1629371@ZenIV>
 <tencent_63C013752AD7CA1A22E75CEF6166442E6D05@qq.com>
 <Zm000qL0N6XY7-4O@infradead.org>
 <20240615065528.GP1629371@ZenIV>
 <Zm1DZaaUF_tspmmQ@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zm1DZaaUF_tspmmQ@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Jun 15, 2024 at 12:31:49AM -0700, Christoph Hellwig wrote:
> On Sat, Jun 15, 2024 at 07:55:28AM +0100, Al Viro wrote:
> > It is an inode of _some_ dentry; it's most definitely not that
> > of the argument named 'dentry'.
> 
> No need to explain it here, the point was that this belongs into a
> useful commit message.

Seeing that fsdevel is archived, it might be worth spelling out,
actually...

Anyway, yes, something like "correct the inline descriptions of
vfs_mkdir() et.al." ought to go into commit message.  And it really
ought to cover not just vfs_mkdir() - other similar comments from
the same commit (6521f8917082 "namei: prepare for idmapped mounts")
have similar issues.  "Create a device node or file" for
vfs_mknod() probably ought to be "Create a device node or other
special file", while we are at it...

