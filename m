Return-Path: <linux-fsdevel+bounces-35376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B08A9D4664
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 04:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24DC1F2202C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 03:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB261BD9C0;
	Thu, 21 Nov 2024 03:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DopwVdA6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D3713A250;
	Thu, 21 Nov 2024 03:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732161336; cv=none; b=mbsiXqQkXQvX8mcpzq6EISixsKdgDSZmG+3gXYpcqRR8/gSprpvzsqpmOAC6zy/vzKyGWAB3F/wv06+8283DmsWs5LrG7sd6ImWy6A4kXmVZ7pv4RXBInjcaILAFIH+dxzvPXuiDTXCQHNBVjxhLA2+BIJOFgvJx+wINsGA00yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732161336; c=relaxed/simple;
	bh=tQLUE/gi3EGbCHGaJiv63C4EjxkPIgJOhIF+qibu+tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOMR8PyUvH3nOMP2Zv2gsK2ycrEORFsEtG9/0qQUt2ifc/FdkdIKJdnVyo3p5UaKTVkG0kIWX5lsVquydiF785F/lNkZU6Uy8TF6HATErT1uK0Gbq8iQkbrUMqCcHgyYo7UoBm5luQEfpcBAqJPox4nyIWUUVEIQ5rQlsO0JH9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DopwVdA6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ld04TMVD+t82H7O0vb5VDs9spkg+DTGQKeuhllcoYNo=; b=DopwVdA6lp1CvIr+6VhaaeKcIS
	n3xg3Vjz7cuHk2VUv3LMj9z/Z5NJzsQ1b/0Y0A03bu8wm44xnlfmenZXtov33K+fFRhRlKg1nWPD/
	PHONCVbiRnbRWl/ZT5TObpJ8HXsq/BTdNpSdAFSHwBk5oX8FamP+CeG5amu/ccLn+gWgxpaKu2tal
	DJgHjvp3E70MSJ+MQdknXnwuVk9Kkpu5PNsxknRkanseJzQnySDrjw7EBJtfuJ0/u6XEKorfKOSR5
	pfgc1NiVuPaY4/cjoW3ugci1ANsSuUoVATCsOjEzdElmDZD4xQ6pbmlqL0wKsEDKziqWWgUg7+heR
	IPeXQJhg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tDyHx-000000000Hr-0UKE;
	Thu, 21 Nov 2024 03:55:29 +0000
Date: Thu, 21 Nov 2024 03:55:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: almaz.alexandrovich@paragon-software.com, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
	syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V3] fs/ntfs3: check if the inode is bad before creating
 symlink
Message-ID: <20241121035529.GO3387508@ZenIV>
References: <20241120161045.GL3387508@ZenIV>
 <20241121031329.354341-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121031329.354341-1-lizhi.xu@windriver.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 21, 2024 at 11:13:29AM +0800, Lizhi Xu wrote:
>   user_path_at()->
>     filename_lookup()->
>       path_lookupat()->
>         lookup_last()->
>           walk_component()->
>             __lookup_slow()->
>               ntfs_lookup()->
>                 d_splice_alias()->
> 
> 2. The subsequent chmod fails, causing the inode to be set to bad.

What's wrong with "return an error"?

> 3. During the link operation, d_instantiate() is executed in ntfs_link() to associate the bad inode with the dentry.

Yecchhh...  If nothing else, check for is_bad_inode() should be there
for as long as make_bad_inode() is done on live inodes.

