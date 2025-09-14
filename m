Return-Path: <linux-fsdevel+bounces-61243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6451DB566FE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 07:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029983BC94E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 05:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4773E23FC41;
	Sun, 14 Sep 2025 05:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HqjxjLAz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F551FC0FC
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Sep 2025 05:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757829391; cv=none; b=bDpxgrnit3b8NrX7MsprPGIkWkyTsOfUf+MwEWvKspGVYbt9J9iOsXqLH4dME/2Dcv5DtqGSIwQYA3kWFi9aVT+iYIH84T2wOjR+2g/T+qyyQJVLZmcFbDcsM8ufvQt5q4Nm09X9bTA7UDNUqIk1z/Q9mHe/9fXRXGh7e3zd+CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757829391; c=relaxed/simple;
	bh=mF415XIcHjMQNW2/Pc9D73nhef6TDbIc6Ka/0LORq4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0trv/EbDd5v65rSDn8T02oN75wmJF2+kin2U3FZmX9ieEEyRJPiEivo0UcphwL84qC+k9ruysAEK15FIr/LTrPGOs4ZrYh6cD49SV4hE8T2kYFFL4cDoPuuYoZ32DyRmhynFSM4JwiPizrY7yufbNVkJTPmfdUsbMxrkrsMWEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HqjxjLAz; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bgZ99lIVDJ5M0xDP2i8dSdn8mM/QsWUJsnOzaEikQ04=; b=HqjxjLAzJLq4RwZIa8Hf1l+kod
	3VS8iISNmsXqZsmEpEqdLQPAjRJVLovJNexeQ0VhP/6cKuCeT4JLHki60BjQlc49fbLxPmlfcbKpE
	tORtGp5Byaf2wD3HKHHSQZO/DgX75yHl4Tg0drmHuvHL+EdZ4198pBliogY+ea4LuQKgIBKhAWLw4
	BTEnEhvabp6L7QIM54fBUO1j/TJhOdz7N365ZTnQHccQDlwEa66VHTgL5WCJQubLbXpijPfJE5w7R
	x8zmehjYfjsjCZmjxaWgjLn+oBjhI5V2/3uuWAOkT1njqNZNYl9lQ413e24yePuaN4lpJ5pxN2LO/
	7qBS84WA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxfis-00000006lqQ-0Bvj;
	Sun, 14 Sep 2025 05:56:26 +0000
Date: Sun, 14 Sep 2025 06:56:26 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Trond Myklebust <trondmy@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [RFC] a possible way of reducing the PITA of ->d_name audits
Message-ID: <20250914055626.GG39973@ZenIV>
References: <>
 <20250908051951.GI31600@ZenIV>
 <175731272688.2850467.5386978241813293277@noble.neil.brown.name>
 <20250908090557.GJ31600@ZenIV>
 <20250913212815.GE39973@ZenIV>
 <175781190836.1696783.10753790171717564249@noble.neil.brown.name>
 <20250914013730.GF39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914013730.GF39973@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Sep 14, 2025 at 02:37:30AM +0100, Al Viro wrote:

> AFAICS, it can happen if you are there from nfs4_file_open(), hit
> _nfs4_opendata_to_nfs4_state(opendata), find ->rpc_done to be true
> in there, hit nfs4_opendata_find_nfs4_state(), have it call
> nfs4_opendata_get_inode() and run into a server without
> NFS_CAP_ATOMIC_OPEN_V1.  Then you get ->o_arg.claim set to
> NFS4_OPEN_CLAIM_NULL and hit this:
>                 inode = nfs_fhget(data->dir->d_sb, &data->o_res.fh,
>                                 &data->f_attr);
> finding not the same inode as your dentry has attached to it.
> 
> So the test might end up not being true, at least from my reading of
> that code.
> 
> What I don't understand is the reasons for not failing immediately
> with EOPENSTALE in that case.
> 
> TBH, I would be a lot more comfortable if the "attach inode to dentry"
> logics in there had been taken several levels up the call chains - analysis
> would be much easier that way...
 
BTW, that's one place where your scheme with locking dentry might cause
latency problems - two opens on the same cached dentry could be sent
in parallel, but if you hold it against renames, etc., you might end up
with those two roundtrips serialized against each other...

