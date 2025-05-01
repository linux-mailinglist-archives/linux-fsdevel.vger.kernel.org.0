Return-Path: <linux-fsdevel+bounces-47833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 734FFAA6156
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 18:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43D94C4E84
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 16:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73596212B18;
	Thu,  1 May 2025 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNvxHBb6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68B51DC1AB;
	Thu,  1 May 2025 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746116589; cv=none; b=P8naj61wi2qiU8RDTpXVAq2gN0CAQwj/EXk18dgNQMzvSZg7pNPxqv1yO2s1wzzRVNpZgU8SOkPXO9O1cDPs6/GhCB/U67mVFtMSKO6XY9NZf2qXFHoUyeRALCjpzxfVr9As7i/YAU8GFVsjM2eHJxwC7vc49BPFFnCe5LgtHwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746116589; c=relaxed/simple;
	bh=XrJZW4y7kWD+SksF1XEGU2csTqcBgQ0lzQdMz6fX5JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnpIwgOgEdfxzGb1kg3yLyhIQRk5tDemflLVBdhB8kemjpeS/CWxT+KC2HgvijQwyk3j9wVYZQzT9CMj39YmA2pJw7TegzrSYRaRwKHZD8anrrUP9h1gbxJDw/Qkhkf+rxR321qoA4hffzTFPrUD4dImB/AwEx4jNs+AG86weak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNvxHBb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815CEC4CEE3;
	Thu,  1 May 2025 16:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746116589;
	bh=XrJZW4y7kWD+SksF1XEGU2csTqcBgQ0lzQdMz6fX5JU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uNvxHBb6N3wOOCmY7gMiTycteZjg5d6f5SF2+1c5UlRyngreOzG5ybNaIqEik0xMF
	 CrbGsQlNilm/rLt5ssixx4OzOQUFhoOZxCPTrEqOj5NEMlAUx+KucUra2mNrV4MpiS
	 ZBpbpjoosOOSw7EVejbtBV3/l0GEf1SzIq0YbOMS7CgJK5NDDGBNpE11UrRA8Zo1CV
	 8+0jPTVv+UQ2dyaRBrAqtHDW5hqV6Ip+oVYyRPSGm8WCVAcAC/mTUmG09OUFLTTEt3
	 uaFsO9HzJI0BtkVoZqvkVL+dwvEOn8F+c37rgUGkkk+OPAZ7Lp1GsiNLxbSWrc4ArH
	 UOWXOjKc3PswQ==
Date: Thu, 1 May 2025 09:23:08 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v9 13/15] xfs: add xfs_compute_atomic_write_unit_max()
Message-ID: <20250501162308.GC25675@frogsfrogsfrogs>
References: <20250425164504.3263637-1-john.g.garry@oracle.com>
 <20250425164504.3263637-14-john.g.garry@oracle.com>
 <a8ef548a-b83e-4910-9178-7b3fd35bca14@oracle.com>
 <20250501043053.GD1035866@frogsfrogsfrogs>
 <01f9a1df-859b-4117-8e12-cb06edee9f17@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01f9a1df-859b-4117-8e12-cb06edee9f17@oracle.com>

On Thu, May 01, 2025 at 06:00:12AM +0100, John Garry wrote:
> On 01/05/2025 05:30, Darrick J. Wong wrote:
> > On Wed, Apr 30, 2025 at 08:52:00AM +0100, John Garry wrote:
> > > On 25/04/2025 17:45, John Garry wrote:
> > > > +static inline xfs_extlen_t xfs_calc_perag_awu_max(struct xfs_mount *mp)
> > > > +{
> > > > +	if (mp->m_ddev_targp->bt_bdev_awu_min > 0)
> > > > +		return max_pow_of_two_factor(mp->m_sb.sb_agblocks);
> > > > +	return mp->m_ag_max_usable;
> > > I think that this should be rounddown_pow_of_two(mp->m_ag_max_usable)
> > > 
> > > ditto for rt
> > > 
> > > I will fix (unless disagree).
> > I don't think this needs fixing.  If there's no hardware support on the
> > device, then we can do any size of atomic write that we want.
> 
> Check man pages for statx:
> 
> stx_atomic_write_unit_min
> stx_atomic_write_unit_max
>               ... These values are each guaranteed to be
>               a power-of-2.
> 
> Same is enforced for size for RWF_ATOMIC.

Ok then.

--D

