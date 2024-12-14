Return-Path: <linux-fsdevel+bounces-37426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEF99F202A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 18:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D45357A0756
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 17:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F6F195B37;
	Sat, 14 Dec 2024 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ED0aco91"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647B418BC1D
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Dec 2024 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734198597; cv=none; b=l0LIK4HivCTeBW9CxhV7FGu9f2hLO1XOcG+DFJipyGP/Q1o020FFsK7pyNNMIWrpIYKMVaxV/0mhQJD1Q/KOuFORkZUZRRgqgeiQPd8p6CQk+Ru4Ztj1RsS4Kc1BAjfAt2tQFK9jQ8flOERO5xdjON5xcFxuxOTqvI4w7DVNYhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734198597; c=relaxed/simple;
	bh=h1KgZxox183Q0lbdgbt83X4Auu0E8bahD7NxSItGbUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYWNpRBvdRkbkrHljp/Q6OHTufSok5y+xUs5fsmnE4bnBWUyI6kkGPNIk5ttmwts+cWYcBY+ZwJTHfVNIFt4QyfB2l1Uz8zmZaTitp3K6Y5PPWkllJWx8Eoj2j8SK3RrtMh4JgPRHoShAlAJuN8NS5ScWfHcZRDGfQCpq/oNxlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ED0aco91; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=5qJ6pG6YzsM9FaFvriP/CCcesATZyZIlxpd9+19kmAA=; b=ED0aco916p6UHV4RcY6M3wTRfQ
	lV6wiAj7T+iNMnKEHV0MW0wcXNgW9AJQr/dRo7Bed4tkmyyoLLD92bOpYc1sVyCPeIODTq7i2M02n
	MQazzoE/TIQEyGL2EUQ388KbzrCE9y5gekGl/6Mhs2cMiFCcg8vKe6bqeyzHlbxVzyvn5SHJvsGOl
	hg4CpCwLfrD1eVj0UFoZ4tUfkavHCL5ckDbDFEduN1W697Z9JYDvayeOr9mZjJc+sV6NWqRDZNwWH
	lF6poXLJcUz7yb9w25kZexGD/Syl2sl9Ed36JFCYFrgxRVhFGyk1qR+eMqbaC6BHLFEyh3mXXwojZ
	aP0MfwJg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tMWGz-00000008Ibq-1Zbp;
	Sat, 14 Dec 2024 17:49:49 +0000
Date: Sat, 14 Dec 2024 17:49:49 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Hugh Dickens <hughd@google.com>, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	yukuai3@huawei.com, yangerkun@huaweicloud.com
Subject: Re: [PATCH v4 5/5] libfs: Use d_children list to iterate
 simple_offset directories
Message-ID: <20241214174949.GA1977892@ZenIV>
References: <20241204155257.1110338-1-cel@kernel.org>
 <20241204155257.1110338-6-cel@kernel.org>
 <5eb7bbdb-0928-4c80-bf03-9de27d6f3f89@oracle.com>
 <8c716ca1-84f9-4644-95cf-9965e8a30284@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c716ca1-84f9-4644-95cf-9965e8a30284@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Dec 14, 2024 at 12:13:30PM -0500, Chuck Lever wrote:
> > > +/* Cf. find_next_child() */
> > > +static struct dentry *find_next_sibling_locked(struct dentry *parent,
> > > +                           struct dentry *dentry)
> > 
> > There might be a better name for this function.

There might be better calling conventions for it, TBH.
AFAICS, all callers are directly surrounded by grabbing/releasing
->d_lock on parent.  Why not fold that in, and to hell with any
mentionings of "locked" in the name...

