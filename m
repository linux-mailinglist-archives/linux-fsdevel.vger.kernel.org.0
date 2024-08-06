Return-Path: <linux-fsdevel+bounces-25068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFFC9488C0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 06:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94F61F238FC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 04:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D511BBBE0;
	Tue,  6 Aug 2024 04:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pisiyhq5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2831BB686;
	Tue,  6 Aug 2024 04:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722920351; cv=none; b=FOtJei21Fv0Tz8FHDzt5Qa9gCZEygYVSE8jsMDIL3aH3y+Yg0fkLs7iTD4dE6g6/LY/hEmYawN8ogU2AunLlpcauwQ+XSp/S7nxf2DrwrpSFkzdWxb21IiRaw+lSwdyezTjZyEIVVB1S3E5uUnjMbtY/DZ/Osgp0swtIt81+j8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722920351; c=relaxed/simple;
	bh=sX5iIPSYoGHXXoo45QtTl6/7C4wdW//PkjhtUbTc2QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGmZ4UjLgO9/XXfTVUfp6uxItXPzLMaMfBGWs1jHMPH5dH+6Oa4SDxNaPvou5aVPGxXc2yLgA9E52jwhlIPr34pDP5ZIROZfF/oi6wru5eGYE3Y9ysS+7wNcPlKjxShmTpzAZd82C2jPuDBlJ34J9tLxFlMV416jAd15iuMmpuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pisiyhq5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=L4/FILXA7iZugntM3tril41FJCD37PeVSEelkErPAeo=; b=pisiyhq5awucHxEkKD4APLenrI
	kaIfXIZI3KtuCPn8xIICbX00Qj7o3faEQTgrBibXaiQ7nfHAA9GF2JynDgNkUr2UmAaeFQ5XvtTSn
	GOjgJosAV447IrW5mRl6RJw3YpRom6TxBAuJ2SnjBEqZ8/MCDs56mAgM6E/v+9gfAzOruqMqBDAxZ
	kULe7l4jDdDwYnbsaGPz58OjDMlzrVOaceWQcwJ8VDoIXvYQocY/0r9UVzperNOX/ZHOyKzhirB2M
	vgTHCkZYh8oLPJbrKwQhofC+1PfHro4uwUUXedWfZMO242SAm1rUQX+KOWY+mjGLThyUUSXMW1OjJ
	irWvb3jQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sbCHp-00000001qT7-3dlh;
	Tue, 06 Aug 2024 04:59:05 +0000
Date: Tue, 6 Aug 2024 05:59:05 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, phillip@squashfs.org.uk,
	squashfs-devel@lists.sourceforge.net,
	syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V7] squashfs: Add symlink size check in squash_read_inode
Message-ID: <20240806045905.GM5334@ZenIV>
References: <20240805014037.GF5334@ZenIV>
 <20240806025609.1193466-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806025609.1193466-1-lizhi.xu@windriver.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 06, 2024 at 10:56:09AM +0800, Lizhi Xu wrote:

> > Please, show me an unsigned int value N such that
> > 
> > _Bool mismatch(unsigned int N)
> > {
> > 	u32 v32 = N;
> > 	loff_t v64 = N;
> > 
> > 	return (v32 > PAGE_SIZE) != (v64 > PAGE_SIZE);
> > }
> This always return 0, why are you asking this?

Because that implies the equivalence between

	symlink_size = le32_to_cpu(something);
	if (symlink_size > PAGE_SIZE)
		return -EINVAL;
	inode->i_size = symlink_size;

and

	inode->i_size = le32_to_cpu(something);
	if (inode->i_size > PAGE_SIZE)
		return -EINVAL;

However, you seem to find some problem in the latter form, and
your explanations of the reasons have been hard to understand.

> > Again, on all architectures inode->i_size is capable of representing
> > all values in range 0..4G-1 (for rather obvious reasons - we want the
> > kernel to be able to work with files larger than 4Gb).  There is
> > no wraparound of any kind on that assignment.

> The type of loff_t is long long, so its values range is not 0..4G-1.

6.3.1.3[1] When a value with integer type is converted to another integer type
other than _Bool, if the value can be represented by the new type, it is unchanged.

Possible values of u32 are all in range 0..4G-1.  All numbers in that range
(and many others as well, but that is irrelevant here) can be represented by
loff_t.  In other words, nothing overflow-related is happening.  

