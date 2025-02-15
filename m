Return-Path: <linux-fsdevel+bounces-41768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78967A36C06
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 05:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC4E1895D4B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 04:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FAE17A586;
	Sat, 15 Feb 2025 04:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TliPwz51"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B33144304;
	Sat, 15 Feb 2025 04:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739594783; cv=none; b=nxqP4gp4/0a2fy8xCKEIvQtQ5DD7t3j+XC+i554+40Bcm/H9wQjlFCb1tEIXmSJhpJHjQnvIO3DTUa/9p+g+2dIjr3GM4oowbWU4EAdWFwdNS34XUraC4Qqrtunn8GLKtooNt1egEFRAcHXotCvzM+D5gLBLjg4vtsraoDg+lFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739594783; c=relaxed/simple;
	bh=7tGM0SaioGTHdxHwmEBHFMiUmAy6bZ8jASfCtdUUoik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ri99UmS+swKYjcqSUqNXhRluCiK18MSEEaBY+TaEwWdiuq4HkYv6FFamWBeLa0q5qO550AhFLXUcApfmFigez7Yyyi+gxOTKiZ5SgR5QnqnDyR2vUBrQeYkVwd/HcA88WNVGWkeG23EblnwQbSj/EYUmoMmwDL08ZHyevMRckBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TliPwz51; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8jWYBOowS5WbYaa9hRL01OWLM2Ql55snHaZOf3ObIvg=; b=TliPwz51X0ZnB+pU3IayANBq6V
	sDqBn/t7T4Qc49rEzNfO4gZErURm9J2ob57HLcKuXusetIrCZSZ+LWOMyoP+5e1NzEU74341fBeVU
	jp524JKx4ABZYV6ZG2m54KV7LbAU13pQAo3IjoxJ7VuFaJcXTMR7UjC08cXFMDu2a+mo/XyLShnwB
	Qcyhns6CmfMdaBoFngjt5/v159qEd6qIFrMq6gzmotCU+jtRWOhpfmEoz9LtS3pHSa2nxvgn4SrlX
	HgTLXrQSQwZpi8aeOQPYgT5qe4lqzjXJxsK8nh9OGmW4XjfrIyL2WdULNa2yRNeURMRx8F+arY7qM
	//dX1LDg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tjA4G-0000000ETmF-3N76;
	Sat, 15 Feb 2025 04:46:16 +0000
Date: Sat, 15 Feb 2025 04:46:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Luis Henriques <luis@igalia.com>
Cc: Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [RFC] odd check in ceph_encode_encrypted_dname()
Message-ID: <20250215044616.GF1977892@ZenIV>
References: <20250214024756.GY1977892@ZenIV>
 <20250214032820.GZ1977892@ZenIV>
 <bbc3361f9c241942f44298286ba09b087a10b78b.camel@kernel.org>
 <87frkg7bqh.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frkg7bqh.fsf@igalia.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 14, 2025 at 04:05:42PM +0000, Luis Henriques wrote:

> So, IIRC, when encrypting the snapshot name (the "my-snapshot" string),
> you'll use key from the original inode.  That's why we need to handle
> snapshot names starting with '_' differently.  And why we have a
> customized base64 encoding function.

OK...  The reason I went looking at that thing was the race with rename()
that can end up with UAF in ceph_mdsc_build_path().

We copy the plaintext name under ->d_lock, but then we call
ceph_encode_encrypted_fname() which passes dentry->d_name to
ceph_encode_encrypted_dname() with no locking whatsoever.

Have it race with rename and you've got a lot of unpleasantness.

The thing is, we can have all ceph_encode_encrypted_dname() put the
plaintext name into buf; that eliminates the need to have a separate
qstr (or dentry, in case of ceph_encode_encrypted_fname()) argument and
simplifies ceph_encode_encrypted_dname() while we are at it.

Proposed fix in git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #d_name

WARNING: it's completely untested and needs review.  It's split in two commits
(massage of ceph_encode_encrypted_dname(), then changing the calling conventions);
both patches in followups.

Please, review.

