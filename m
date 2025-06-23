Return-Path: <linux-fsdevel+bounces-52540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF02AE3EC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 13:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70149188A00E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 11:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DD224468B;
	Mon, 23 Jun 2025 11:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3WMubZC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAD51ACEDE;
	Mon, 23 Jun 2025 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679891; cv=none; b=djJFhnef8P4XNLSOM6OAED3p/xDfcgMxjz7fcLELVuqMgeWO8ypJ7fDFwHVtRWAieS/dFm+tsUC2hkQqbFYbZBLgbS9MW7sK5ht3jQn5tXWxFxe5phnBLNIC/DNd9U1Ujv3bY03Hf3IbQQkZq3q1pOV2lLa7tFBX46v4pTIyz6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679891; c=relaxed/simple;
	bh=pFD0DezKGSXsvgAP72gbbLOCW/WgiHTtSC+b+7BAjCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8gr5eVKckeJyZerORQot2SMjhwTmMvREJkK4AvaQf3aq8j78EvBl9OFRKlBcki8F1qExg+FWvAzgXQL/VOG3qy4WDJpOFD8jdDsNsz45c14tkvBg1NmFZFOKgGHIWgz2MTKR1qSqQNJQgDKF8cDBm6lVpqfQaWekt2DWVvQ05I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3WMubZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF68C4CEEA;
	Mon, 23 Jun 2025 11:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750679891;
	bh=pFD0DezKGSXsvgAP72gbbLOCW/WgiHTtSC+b+7BAjCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m3WMubZCBjgMMGHX/TlW6nYTJoEJznbKJVFdJGCXzCgmVZGWp6D3CT0LuPAVBZWU+
	 cj4oY3JuPosRVkJ1HOTMjH++mL1Irjl8VCf52JqM2GnXRFbk52PvPuD5hzPd0nX11m
	 fe2sgo5MGtStiVWautwONLGJsLaKC9cQubl0/lQE5QeNoaCFrYNowCW0tKkSegJYPX
	 XzRc0vSCOooobla3IuQGKXZ5x+ExZAKG4/KcQbvJmb6IkV/M5B8+sbBNt3v+dGKcUx
	 RJMr8YxgnCgR6yOTMXd6YszYkkWZpkgDgcVQqg/anStw7EHgHHvTPOJbDO0ulqO2L6
	 FQdX6sb+ltrXw==
Date: Mon, 23 Jun 2025 13:58:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Amir Goldstein <amir73il@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 6/9] exportfs: add FILEID_PIDFS
Message-ID: <20250623-herzrasen-geblickt-9e2befc82298@brauner>
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
 <20250623-work-pidfs-fhandle-v1-6-75899d67555f@kernel.org>
 <y6yp3ldhmmtl6mzr2arwr5fggzrlffc2pzvqbr7jkabqm5zm3u@6pwl22ctaxkx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <y6yp3ldhmmtl6mzr2arwr5fggzrlffc2pzvqbr7jkabqm5zm3u@6pwl22ctaxkx>

On Mon, Jun 23, 2025 at 01:55:38PM +0200, Jan Kara wrote:
> On Mon 23-06-25 11:01:28, Christian Brauner wrote:
> > Introduce new pidfs file handle values.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  include/linux/exportfs.h | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > index 25c4a5afbd44..45b38a29643f 100644
> > --- a/include/linux/exportfs.h
> > +++ b/include/linux/exportfs.h
> > @@ -99,6 +99,11 @@ enum fid_type {
> >  	 */
> >  	FILEID_FAT_WITH_PARENT = 0x72,
> >  
> > +	/*
> > +	 * 64 bit inode number.
> > +	 */
> > +	FILEID_INO64 = 0x80,
> > +
> >  	/*
> >  	 * 64 bit inode number, 32 bit generation number.
> >  	 */
> > @@ -131,6 +136,12 @@ enum fid_type {
> >  	 * Filesystems must not use 0xff file ID.
> >  	 */
> >  	FILEID_INVALID = 0xff,
> > +
> > +	/* Internal kernel fid types */
> > +
> > +	/* pidfs fid types */
> > +	FILEID_PIDFS_FSTYPE = 0x100,
> > +	FILEID_PIDFS = FILEID_PIDFS_FSTYPE | FILEID_INO64,
> 
> What is the point behind having FILEID_INO64 and FILEID_PIDFS separately?
> Why not just allocate one value for FILEID_PIDFS and be done with it? Do
> you expect some future extensions for pidfs?

I wouldn't rule it out, yes. This was also one of Amir's suggestions.

