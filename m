Return-Path: <linux-fsdevel+bounces-25926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B377951ECE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 17:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069DA285156
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 15:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BF81B5806;
	Wed, 14 Aug 2024 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mCva1+EO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72CC1B3F20;
	Wed, 14 Aug 2024 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650177; cv=none; b=AFI5vBiJ7Gv5D0uYs3Y5aqlDoaSTfSmNYJOdFYMSZyMuZNgjAyLm9nuO7tONIoFkauMEkUbGo2wshc+KPGG0L8cNPruRXS8A9z0pBHvoIYr3vVBVOVW9ovXVPVC4eSCFbCRvtw6fhEXGg9JUpt4kHddNpcNzrqgtuawACpWJpKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650177; c=relaxed/simple;
	bh=7RUzND1DLdEoCAJ5FFp3P1D0SDw92Cz7O9CEHfu5DUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdpR/yWUSSwuo9WmndoopSyh7C0D6d7AhweBleWPSHzZEPeG8wnyMs//Gee5+x3YrNb+IwkzUz6wghczN4dEviTyztwfijw6Cx+fBG7jpJ4cuNf3HzNyyrbzIG/7/6QW96P67GwugE21rba5KD9RhWims++92+F8/46Ne3XHIEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mCva1+EO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EtQ5iKWt7WqAkiS1w27yiZFTNzhmDZvtoNK9l95Y9BU=; b=mCva1+EORSdXjcJw1S6MAR5/Rh
	DOwD0PNSZvFVS0NevxHZaKmEF5JqpYIehY4XbvP4XmhPfbPHZL1ZWxauWnOJxtuoZnnafYGCA7MGj
	wyLs3UCMa+2IqPKxeSlfOQJk0fhLjY5yV6IDRsIxwkQY9AjnbF6fxh24kgkLxPONfNhgCxBOC96w4
	aR2PBXinjUp81PzyMH7UnFqFsKa4GnF8uGPv/JNkWjDzaRFlGmWetPpQGW6qw/MvN1kMFGhlabAQB
	eX+TxPBb6GIOMQ9uq34nrsU3buASYCICZm0E7PN1rwn96LbrFpEBD+hwcum1LZBZQL+BpYCxw2nr9
	lNfnRRdA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1seG9C-00000001eS8-15NV;
	Wed, 14 Aug 2024 15:42:50 +0000
Date: Wed, 14 Aug 2024 16:42:50 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
Message-ID: <20240814154250.GS13701@ZenIV>
References: <20240806-openfast-v2-1-42da45981811@kernel.org>
 <6e5bfb627a91f308a8c10a343fe918d511a2a1c1.camel@kernel.org>
 <20240814021817.GO13701@ZenIV>
 <20240814024057.GP13701@ZenIV>
 <df9ee1d9d34b07b9d72a3d8ee8d11c40cf07d193.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df9ee1d9d34b07b9d72a3d8ee8d11c40cf07d193.camel@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 14, 2024 at 07:48:17AM -0400, Jeff Layton wrote:
> On Wed, 2024-08-14 at 03:40 +0100, Al Viro wrote:
> > On Wed, Aug 14, 2024 at 03:18:17AM +0100, Al Viro wrote:
> > 
> > > That's not the only problem; your "is it negative" test is inherently
> > > racy in RCU mode.  IOW, what is positive at the time you get here can
> > > bloody well go negative immediately afterwards.  Hit that with
> > > O_CREAT and you've got a bogus ENOENT...
> > 
> > Hmm...  OTOH, in that case you end up in step_into(), which will do the
> > right thing...
> > 
> > 	How well does that series survive NFS client regression tests?
> > That's where I'd expect potentially subtle shite, what with short-circuited
> > ->d_revalidate() on the final pathwalk step in open()...
> 
> Christian took in my v3 patch which is a bit different from this one.
> It seems to be doing fine in testing with NFS and otherwise.
> 
> I don't think we short-circuit the d_revalidate though, do we? That
> version calls lookup_fast on the last component which should
> d_revalidate the last dentry before returning it.

It's not about a skipped call of ->d_revalidate(); it's about the NFS
(especially NFS4) dances inside ->d_revalidate(), where it tries to
cut down on roundtrips where possible.  The interplay with ->atomic_open()
and ->open() is subtle and I'm not sure that we do not depend upon the
details of ->i_rwsem locking by fs/namei.c in there - proof of correctness
used to be rather convoluted there, especially wrt the unhashing and
rehashing aliases.

I'm not saying that your changes break things in there, but that's one
area where I would look for trouble.  NFS has fairly extensive regression
tests, and it would be a good idea to beat that patchset with those.

