Return-Path: <linux-fsdevel+bounces-37428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB679F20A6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 20:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C781888207
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 19:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39CC1AE003;
	Sat, 14 Dec 2024 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VLxKKRYe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A11119D07C
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Dec 2024 19:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734206364; cv=none; b=a6Bf32LYZENBLkT6eIJFX+t/nQm1ZcOrhWrP5VAS1H9MouASiiqPgcqsxCW5+Ul1SHlGqH075BPYQB4DB11jgpRTdf8uoHWJ01kC2K0NZ8Nsg4UFhqfzcbVqBKl7nB2KehWuJx4A4LsfvNlkHR+x1Q6D8mEM2yunCNzLD7mpc+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734206364; c=relaxed/simple;
	bh=Bd6S0L5Hk65OkDIt7gl3Ja74UcedR/T4gcCKh3GsIH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaTmMqj2UKVeLQ/Ho9PdTMN7RBD6ID3vy14OCKkghwLbL1EW+rTvb1FJ5YScet292tuZNHYBqxboBVV10nRTk1XjZ9MxJTXJIkdD9Ax126MVSPv21KcgwSY0hhRVBNU6q7lhcorRdrZv3yhjfEdcclfPZ0hvRjJM/zbH2ovJ8h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VLxKKRYe; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=3A2mm7dIa+NUSpTRAKJq7wnU9GzP5+byLw5NhtUqJAk=; b=VLxKKRYexoPCOwSdgHRWDu/eiT
	wOUexwEvxnKdbVSDnMgYRX3bB7n2rhmVJnOX//RxsSRzXABGODIQsaDJK2OxHS/1wAp7S829B9Mfw
	xLF9HApEq9Pp0NMqvAcjDnFUWmSUQymcSRvrCXzyzpbC/bF9tJusl6djjCi22V6XsJc9JFcWx5lSH
	r+pjLBUyhYwubcEa8QnlD/qUPqZDoSNecXDD34pbrf51ycPxmGxD1DpYGQONzKgO4AqGcfi/kuBMV
	kj/feRdRextoFUr1NT0SqLv1GGwcrcKcHdnYzdeePIpo7fzVxg2bmgUCar/1ly2s2q9Dl8gQUZ75e
	+gaaIrzA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tMYIE-00000008Jth-00EN;
	Sat, 14 Dec 2024 19:59:14 +0000
Date: Sat, 14 Dec 2024 19:59:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Hugh Dickens <hughd@google.com>, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	yukuai3@huawei.com, yangerkun@huaweicloud.com
Subject: Re: [PATCH v4 5/5] libfs: Use d_children list to iterate
 simple_offset directories
Message-ID: <20241214195913.GB1977892@ZenIV>
References: <20241204155257.1110338-1-cel@kernel.org>
 <20241204155257.1110338-6-cel@kernel.org>
 <5eb7bbdb-0928-4c80-bf03-9de27d6f3f89@oracle.com>
 <8c716ca1-84f9-4644-95cf-9965e8a30284@oracle.com>
 <20241214174949.GA1977892@ZenIV>
 <99addf69-4757-4eb9-b6d1-e554a72070c3@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99addf69-4757-4eb9-b6d1-e554a72070c3@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Dec 14, 2024 at 02:22:41PM -0500, Chuck Lever wrote:
> On 12/14/24 12:49 PM, Al Viro wrote:
> > On Sat, Dec 14, 2024 at 12:13:30PM -0500, Chuck Lever wrote:
> > > > > +/* Cf. find_next_child() */
> > > > > +static struct dentry *find_next_sibling_locked(struct dentry *parent,
> > > > > +                           struct dentry *dentry)
> > > > 
> > > > There might be a better name for this function.
> > 
> > There might be better calling conventions for it, TBH.
> > AFAICS, all callers are directly surrounded by grabbing/releasing
> > ->d_lock on parent.  Why not fold that in, and to hell with any
> > mentionings of "locked" in the name...
> 
> I've tried it both ways, couldn't make up my mind. I'll try it again.

Single return there, so it's just a single spin_lock() on entry and
spin_unlock() on exit...  No idea if it'll make coverity any happier,
but it would be easier on human readers.

