Return-Path: <linux-fsdevel+bounces-61215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ECCB56430
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 03:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28BA0421565
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 01:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D40422F75B;
	Sun, 14 Sep 2025 01:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hCCA0kMb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621E622D4DC
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Sep 2025 01:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757813856; cv=none; b=KthI6w7FC1CpDR2YDosrs20nJNMhhlz2jBuw02fcgKQyQpR643usE9ipk50liQCinRciZHoQiDBz4TmGFJlNOb0QRwfQSpDLL3kHOedG+ZkvcIWps/voFGmdp/tj5XCw3kbNqD6aY+r9e5U4BFXBK5Bf2cDYXeNudmMIGg9MatA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757813856; c=relaxed/simple;
	bh=1lY3Ap4ESq7+pJR+vgjKzRhxDNAslUiTrkab+flChcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiqoGPcFZ1XR4mtHfFWpFfV7khmU8+ATcJpUrhPL0JtDaFzHellslcl+JFrHdkjxBpDiP5NPkupGgsMKgPHgXoVo2hcNehZz/8QPfb8dDkK2g55SVj/+hHL2w+O2YO2Rdj8DWjXYRfpFaVsksYZdE+9HCQhpfQLOWlha6L8YP5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hCCA0kMb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6qrwVe7SeAJgtCARosLLj3a45ZxOZK1fUq3p0T3LyfM=; b=hCCA0kMbS6IYfpBF73cP557yAJ
	CwUpmYon0rUSzVCnV3SDbNUGuEN6hbfstGVxeZ6RnTw+LtTeYS4OyBaVaSEhmqeyq+ZV4wxn3IU1b
	SYMBpnBHyqNQWRpvWbAFrboTI/LcFWrdYqjXSAFBEO6BbB8B1bJwus0zvWoHZZQHd3NqNpWzQ6id+
	7dsksg1xax8e6tGYvzAkqJqymgvVHL1vsYKNeHPolGsCNbwHlCR69yz0C8BynZj4b91AU7GuhYiR3
	Bgz1uEwgxlWgCQykGbWYBXOEAHEIAQMAzzzWPTvkK8AdVtYhtIr7Qp2h1Qs+wQybbeEskrLsL77Xe
	rf8+SrbA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxbgI-00000003xSQ-272S;
	Sun, 14 Sep 2025 01:37:30 +0000
Date: Sun, 14 Sep 2025 02:37:30 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Trond Myklebust <trondmy@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [RFC] a possible way of reducing the PITA of ->d_name audits
Message-ID: <20250914013730.GF39973@ZenIV>
References: <>
 <20250908051951.GI31600@ZenIV>
 <175731272688.2850467.5386978241813293277@noble.neil.brown.name>
 <20250908090557.GJ31600@ZenIV>
 <20250913212815.GE39973@ZenIV>
 <175781190836.1696783.10753790171717564249@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175781190836.1696783.10753790171717564249@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Sep 14, 2025 at 11:05:08AM +1000, NeilBrown wrote:
> READDIR without establishing and "open" state.
> 
> Why do you think nfs4_opendata_access() expects the possibilty of a
> directory?

static int nfs4_opendata_access(const struct cred *cred,
			struct nfs4_opendata *opendata,
			struct nfs4_state *state, fmode_t fmode)
{
	struct nfs_access_entry cache;
	u32 mask, flags;

	/* access call failed or for some reason the server doesn't
	 * support any access modes -- defer access call until later */
	if (opendata->o_res.access_supported == 0)
		return 0;

	mask = 0;
	if (fmode & FMODE_EXEC) {
		/* ONLY check for exec rights */
		if (S_ISDIR(state->inode->i_mode))
		    ^^^^^^^
How else would you describe this?
			mask = NFS4_ACCESS_LOOKUP;
		else
			mask = NFS4_ACCESS_EXECUTE;

> >         if (d_inode(dentry) == state->inode)
> >                 nfs_inode_attach_open_context(ctx);
> > shortly afterwards (incidentally, what is that check about?  It can only
> > fail in case of nfs4_file_open(); should we have open(2) succeed in such
> > situation?)
> 
> I don't know what is going on here.
> Based on the commit that introduced this code
> 
> Commit: c45ffdd26961 ("NFSv4: Close another NFSv4 recovery race")
> 
> there is presumably some race that can cause the test to fail.
> Maybe Trond (cc:ed) could help explain.

AFAICS, it can happen if you are there from nfs4_file_open(), hit
_nfs4_opendata_to_nfs4_state(opendata), find ->rpc_done to be true
in there, hit nfs4_opendata_find_nfs4_state(), have it call
nfs4_opendata_get_inode() and run into a server without
NFS_CAP_ATOMIC_OPEN_V1.  Then you get ->o_arg.claim set to
NFS4_OPEN_CLAIM_NULL and hit this:
                inode = nfs_fhget(data->dir->d_sb, &data->o_res.fh,
                                &data->f_attr);
finding not the same inode as your dentry has attached to it.

So the test might end up not being true, at least from my reading of
that code.

What I don't understand is the reasons for not failing immediately
with EOPENSTALE in that case.

TBH, I would be a lot more comfortable if the "attach inode to dentry"
logics in there had been taken several levels up the call chains - analysis
would be much easier that way...

