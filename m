Return-Path: <linux-fsdevel+bounces-27504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D481D961D1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 05:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3281F247BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 03:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C4F13E03A;
	Wed, 28 Aug 2024 03:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="NyjfLId7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7383C488
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 03:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724816717; cv=none; b=NQl6NSWyvJwI7YCTe2sRROglCtM/zMfagdAcng4lxm6sdlbE86zIUWb754bZSD3mLnkMEEmkQDhkxMiQ/jNQhkcIrvXfN2hqcIXW6TwQmD2VdGdhiA3CbiCQa6Ryq31sODm+J+XNEpULMcjtjLOftUn7UrWV3Qyr/Po8uGANv10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724816717; c=relaxed/simple;
	bh=olGyObC/pNWdjCOWjhvhkAzzCytLDWIL4PH/8OIefGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWJA8QwcYUs6gV9Xj/3M3+tim+mfjw/7geJ3CIhhoVXikVNnRTKZ/3+abp/xxlpBd7STJoFBRDpCMWwjTNMvYIS6rUn/SbOSCT2W8iTTzm7hmkZigx0depGbj+OAXO/SfJBErlRtJfT9f4mRUna3gqnF4MJ38hdh22Nwe88flws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=NyjfLId7; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-93.bstnma.fios.verizon.net [173.48.112.93])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47S3icJN013986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 23:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724816682; bh=fPLsyPvjLqRwSFvB9BZOO6c6tjlD9gjUehKmT9DuOnQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=NyjfLId7vqU22f9gjSHMfxsxs6/DT10NAIXYdf1ye9kJjtqE4CoDBaN3poS5NRkYm
	 pAm8qextppKJ7LFibtnDu6scAW51nlTMHqiXWXW6mfSdgN+r8NOTLiRT/x1PuBkUXn
	 auLhWuAngtEOEcVlyQPY4WMLcDORuz/KZzDLdPtBahxvBEloz++Pfam4dr1Ob1aQyq
	 7aXpO634uQ3YZwiY3bX+Y7Up0QPTNz0Wgwl8Y7LVAHKjXhjZ7yuz9Y+MyvZnSi4w7g
	 mu0l6+ObSmv4sv9+L48ZECWwK8/iChkz2wAHFAHfzL+ZGo1GNkGSX1Ibx7nyo6t4Rl
	 6VV7cFE061Fcg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 69DC815C02C1; Tue, 27 Aug 2024 23:44:38 -0400 (EDT)
Date: Tue, 27 Aug 2024 23:44:38 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Hongbo Li <lihongbo22@huawei.com>,
        jack@suse.cz, viro@zeniv.linux.org.uk, gnoack@google.com,
        mic@digikod.net, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: obtain the inode generation number from vfs
 directly
Message-ID: <20240828034438.GB9627@mit.edu>
References: <20240827014108.222719-1-lihongbo22@huawei.com>
 <20240827021300.GK6043@frogsfrogsfrogs>
 <1183f4ae-4157-4cda-9a56-141708c128fe@huawei.com>
 <20240827053712.GL6043@frogsfrogsfrogs>
 <20240827-abmelden-erbarmen-775c12ce2ae5@brauner>
 <20240827171148.GN6043@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827171148.GN6043@frogsfrogsfrogs>

On Tue, Aug 27, 2024 at 10:11:48AM -0700, Darrick J. Wong wrote:
> 
> But in seriousness, the usual four filesystems return i_generation.
> That is changed every time an inumber gets reused so that anyone with an
> old file handle cannot accidentally open the wrong file.  In theory one
> could use GETVERSION to construct file handles (if you do, UHLHAND!)
> instead of using name_to_handle_at, which is why it's dangerous to
> implement GETVERSION for everyone without checking if i_generation makes
> sense.

I believe the primary use case for {FS,EXT4}_IOC_GETVERSION was for
userspace NFS servers to construt file handles.

For file systems that don't store persistent i_generation numbers, I
think it would be absolutely wrong that FS_IOC_GETVERSION to return
zero, or some nonsense random number.  The right thing to do would be
to have it return an ENOTTY error if somene tries to call
FS_IOC_GETVERSION on a vfat file system.  Otherwise this could lead to
potential user data loss/corruption for users of userspace nfs servers.

	       	    		    	      	 - Ted

