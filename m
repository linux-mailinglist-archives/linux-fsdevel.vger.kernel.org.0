Return-Path: <linux-fsdevel+bounces-39549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDC0A157BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 20:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3BEE188965F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 19:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB4E1A83F5;
	Fri, 17 Jan 2025 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BHJiX/F1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE5013632B;
	Fri, 17 Jan 2025 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737140445; cv=none; b=YX5TK/zLh1A9MrehTPPTovC9lFnzhqLu05FyUuvXdjsT5FWHUfg3s3x/ps1SR6GtqE8CsE+j+rY0ijEkWU1D9Xm2giMoJ9sgTDV7z6Zo1mKOS1cHlGwV/g4Lgf81sePB8Z7xVw3DfE7264ai12D5Ndz9YQQUWxUlrcQobsAlCDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737140445; c=relaxed/simple;
	bh=N+BHvuXT3nkb9j48CANo8tURmrGJ8NRvfkGl+xV7WDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CF08X1rD+rWfTXPP19S1oSIqxMJ303dqKmTLsO4M7G0o+MxQy8YjXLWZ9MYtxZPoWKRCHvfjtam3D5nFV0fba3rfa/AnslddrFYVkMfCnS6sbvmY96cKgl42WSeLNHBWSFkQP/NQzh6D1MstuROb+rRvQKORiJi1/lloN7AzeTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BHJiX/F1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z1pVqpnV1EAXTw2YYWKgyCOk8xmRiA3ZgTEOj6st9+o=; b=BHJiX/F1Yu7mw34DINukqXN/de
	VYMLUVoMjwrShdcEAp08fIk6QDiTIQK/cuzJF6u5XeIgYom9nA4hT6s0IsjE0Vb82FTu+f1Mn7dSo
	XooVvayAqZZCTZi2bnnDdvThMeX8CVizV8DOPOkfZ3uV6eQVUTekpeXIgeUeKEpppt4Ho1AQ86PrA
	TetIsrSEaHU4bs9NSaHOkgK/uGlJ6NhHISiNaQU1IVkDiVJnv3t2lTmETHDa53gP32VOatTBV7FBk
	db35PK4W+7ekmzxEJNRGFHD6MQ34GFEB+gBwLSFmuVP/3ixu1WULOHN99u96okJ44ZkgNXn12qmFy
	EhDY4oyw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYraB-00000003Vhc-1pSu;
	Fri, 17 Jan 2025 19:00:39 +0000
Date: Fri, 17 Jan 2025 19:00:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, agruenba@redhat.com, amir73il@gmail.com,
	brauner@kernel.org, ceph-devel@vger.kernel.org, dhowells@redhat.com,
	hubcap@omnibond.com, jack@suse.cz, krisman@kernel.org,
	linux-nfs@vger.kernel.org, miklos@szeredi.hu,
	torvalds@linux-foundation.org
Subject: Re: [PATCH v2 07/20] Pass parent directory inode and expected name
 to ->d_revalidate()
Message-ID: <20250117190039.GR1977892@ZenIV>
References: <20250116052103.GF1977892@ZenIV>
 <20250116052317.485356-1-viro@zeniv.linux.org.uk>
 <20250116052317.485356-7-viro@zeniv.linux.org.uk>
 <a345eacd1ec75dd5931b145e32f65e6725a26bf7.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a345eacd1ec75dd5931b145e32f65e6725a26bf7.camel@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jan 17, 2025 at 01:55:01PM -0500, Jeff Layton wrote:
> > +static inline int d_revalidate(struct inode *dir, const struct qstr *name,
> > +			       struct dentry *dentry, unsigned int flags)
> >  {
> >  	if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE))
> > -		return dentry->d_op->d_revalidate(dentry, flags);
> > +		return dentry->d_op->d_revalidate(dir, name, dentry, flags);
> 
> I know I sent a R-b for this, but one question:
> 
> Suppose we get back a positive result (dentry is still good), but the
> name and dentry->d_name no longer match. Do we need to do any special
> handling in that case?

Not really - it's the same situation we'd have if it got renamed right
after we'd concluded that everything's fine, after all.  We can't spin
there indefinitely, rechecking the name for changes ;-)

In RCU mode ->d_seq mismatch guaranteed to catch that, in non-RCU...
well, there's really nothing we could do - rename could've bloody
well happened just as we'd completed pathname resolution.

