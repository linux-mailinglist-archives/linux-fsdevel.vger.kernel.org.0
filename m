Return-Path: <linux-fsdevel+bounces-66176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BADC1845E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 06:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76F33B3F46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 05:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9582F692E;
	Wed, 29 Oct 2025 05:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="E4trfwDo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD7F2F6190;
	Wed, 29 Oct 2025 05:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761714662; cv=none; b=XC7DQgPrhVpUvjMUQFUXO4xn0lMokLMZCM9HWAidDBjsnge67ovU1/EbFBPoA2W4f7lb1ON8KjTvD/DzFNHd6rZNOdMUdNqmsTeUWbhAjNqJAo4IfXjAewi9VYEMnKPvAJ9TZqAnwwCIZl9oRl/lOK30YRVf8Y7cZNLkl/dB+8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761714662; c=relaxed/simple;
	bh=EhgwbRktNMne9VHsUlO/1oxrBnTgDJDYSBE51Al1m0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNIOYxjso9ky0lvobauEww5/mT495S9sq+Vql5NTVQ0bQx7JdVdZ6U0BHHJpxzwF0DlSPIWseBTvd7y+P1aoKBpgdoRQqZPdEUDkTpLDO696aZW5bzkjyPshLLVx17zSic265wRXD3KYQ6Z2ilOCc2TgE7qaZEoXY3t8TVRhmdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=E4trfwDo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/BYNoVmF3YbRiY0Hi/9O43xTzLl3/EW8MXOY/56GuA0=; b=E4trfwDo1S01UKwsa2CrgAOcSE
	ptoeCiFK8So4wlImp/8pjz/VBvtXHnB8B5MDyRYvg1yqGLdg6Tf92LaQjfNi1cdedAP3agZ1WbcNp
	Toh2ZJ7N4fK8LWTgaEb9En4+6sGHZB9iL6nmh7258KhX1IkLOZPj8HC/XgwqzmmEtafzypODzG5bt
	fwomHrB116rASJMqP4x4UdJNY2tD4SGar04GPmSHSEnVu+68QC/yQYWY/mzF2frEWxOl8gDK0uEy9
	OVrO/Ud3CraTGrePIC97bq2rxP3pXsm5U9cT7uuVndAVbke/jLFpn9/5dW08qyUL1FvIPrqIxPapE
	7bfmXpZQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDySS-00000000Yic-41sk;
	Wed, 29 Oct 2025 05:10:53 +0000
Date: Wed, 29 Oct 2025 05:10:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	brauner@kernel.org, jack@suse.cz, raven@themaw.net,
	miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org,
	linux-mm@kvack.org, linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
	selinux@vger.kernel.org, borntraeger@linux.ibm.com,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 06/50] primitives for maintaining persisitency
Message-ID: <20251029051052.GR2441659@ZenIV>
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
 <20251028004614.393374-7-viro@zeniv.linux.org.uk>
 <6d69842d102a496a9729924358c0267f00b170f3.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d69842d102a496a9729924358c0267f00b170f3.camel@HansenPartnership.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Oct 28, 2025 at 08:38:00AM -0400, James Bottomley wrote:
> On Tue, 2025-10-28 at 00:45 +0000, Al Viro wrote:
> [...]
> > +void d_make_discardable(struct dentry *dentry)
> > +{
> > +	spin_lock(&dentry->d_lock);
> > +	dentry->d_flags &= ~DCACHE_PERSISTENT;
> > +	dentry->d_lockref.count--;
> > +	rcu_read_lock();
> > +	finish_dput(dentry);
> > +}
> > +EXPORT_SYMBOL(d_make_discardable);
> 
> I was going to ask why you don't have a WARN_ON if the dentry is not
> persistent here.  Fortunately I read the next patch which gives the
> explanation and saw that you do do this in patch 50.  For those of us
> who have a very linear way of reading and responding to patches, it
> would have been helpful to put a comment at the top saying something
> like persistency will be checked when all callers are converted, which
> you can replace in patch 50.

Point...  How about
void d_make_discardable(struct dentry *dentry)
{
	spin_lock(&dentry->d_lock);
	/*
	 * By the end of the series we'll add 
	 * WARN_ON(!(dentry->d_flags & DCACHE_PERSISTENT);
	 * here, but while object removal is done by a few common helpers,
	 * object creation tends to be open-coded (if nothing else, new inode
	 * needs to be set up), so adding a warning from the very beginning 
	 * would make for much messier patch series.  
	 */
	dentry->d_flags &= ~DCACHE_PERSISTENT;
	dentry->d_lockref.count--;
	rcu_read_lock();  
	finish_dput(dentry);
}

at that point of the series, with comment replaced with WARN_ON() in
#50?

