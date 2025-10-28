Return-Path: <linux-fsdevel+bounces-65869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AED37C128F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 02:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BB7B4F9C6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 01:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6113B23D7C8;
	Tue, 28 Oct 2025 01:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iSLxKvvt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13F023535E;
	Tue, 28 Oct 2025 01:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761615216; cv=none; b=Mw6gJTxmL5mwzf5m5T3lmWsJtaJYkuOk411Qj6afS4vrsFTawpa27uU8aBAn4kXbPERPtxRISpD3gMHvBHi4q+M7Th131QltcI4Bqh2mK5IO0NNai+/ZpYhVIInSrMJpBfEpEeNyQSyuhUp7Yo8uBamWNaneJLobRSP7Uz9+kz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761615216; c=relaxed/simple;
	bh=BCyY6ntS+Xh1tv8vqQoy2I0GepPXqctWlUIMavTkYDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i33BLen+1oUgwxLCExZiHVreKitJIZI/SnQXgyZbwJ954AaK/VS1gk9uFPISRtMEuHe7RE9xapf3lwtIQ8Pf2QtbHYxXBmkASQB8+ZRyQUB8OG/S1NiFkVeX03Vl6ay6zoWkmBOTLtSg3HtutXgAf3OJTqBJjBKSjJgv0xTTO60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iSLxKvvt; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6EhTcx4XVYoBHVkNibUDLjnZaviM/uEjsjdvqBMDQHg=; b=iSLxKvvtuhp7vyTm2gF1EkkIBc
	VueY3k/5kNwOCT60HJvudYt/pn3+nmuXN8BlmSieBlAk9P1lFjbnXfWWohkokyPBzwL6mC3YK0ypj
	sW84+IvdJ1yjbhOgc0P0eftHSrMDFpdFWkNpDO9jxNZQH/EQU+717GyU1YjNSY8UPlXoOVYqQCNUm
	L1/m2fq5epG+ZpDNUkQvsZfuwbXAFt2ERX3bKTejVx1aC8c4ns34fe3bXqhBWWrfvJuyhBA1jOWFs
	o+wjASO+eBBtE0L3jWo+tNcmc1JNpVF+OC3oqVXlZd+U3SoLopqjWLJ5T8ciF4EV4rkTBl4haONpo
	JNpPWnYA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDYaW-00000002gKs-2u1f;
	Tue, 28 Oct 2025 01:33:28 +0000
Date: Tue, 28 Oct 2025 01:33:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: bot+bpf-ci@kernel.org
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	brauner@kernel.org, jack@suse.cz, raven@themaw.net,
	miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org,
	linux-mm@kvack.org, linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
	selinux@vger.kernel.org, borntraeger@linux.ibm.com,
	bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v2 23/50] convert spufs
Message-ID: <20251028013328.GL2441659@ZenIV>
References: <20251028004614.393374-24-viro@zeniv.linux.org.uk>
 <022fbcc8127b3bcf15731de7956ca892619da224487161febb9ef1ed4c71597a@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <022fbcc8127b3bcf15731de7956ca892619da224487161febb9ef1ed4c71597a@mail.kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Oct 28, 2025 at 01:15:38AM +0000, bot+bpf-ci@kernel.org wrote:

> >
> > -	d_instantiate(dentry, inode);
> > -	dget(dentry);
> >  	inc_nlink(dir);
> >  	inc_nlink(d_inode(dentry));
> > +	d_make_persistent(dentry, inode);
> >  	return ret;
> 
> In spufs_mkgang(), can this call inc_nlink(d_inode(dentry)) before
> d_make_persistent() instantiates the dentry? The dentry is not
> instantiated until d_make_persistent() is called, so d_inode(dentry)
> returns NULL here.

Screwed-up editing - that should've been inc_nlink(inode), of course.
Fixed...

