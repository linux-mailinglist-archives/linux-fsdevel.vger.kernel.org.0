Return-Path: <linux-fsdevel+bounces-11246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 630F38521B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 23:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1782B1F22D48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 22:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A644E1D4;
	Mon, 12 Feb 2024 22:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="TTCtApiY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DA94E1B5
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 22:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707778083; cv=none; b=GZo2a8VP1qwZWiLH3cJdBmUC990LX298Mua0QZSRHwMfT04C8QjXrMU412LszU2ro6pk9cQMhSYIa8CiGoAkDb+DaIsSBze23t5vOoHgQotIgZbTA5i9QctDhYTdt4TQBIA9b5efXKaSwIeImc7y7OlxW62xy4IAL9FbnRs0Q8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707778083; c=relaxed/simple;
	bh=K1b3q4DCJkfzZWaD2YE4J3eFtLm65BGnvmVOUumr38c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzMHt5a1ZkFajdGs2rqHTZ+m0kym6dtczaxp4QQZJO1cDRw0KjDys6aoP5Fy9xyoH6GrFzwvvFmo1Tz+xLAH1CgQqlJ8zQOUon+x1qHF5qrA+CY0Wl1MHjSZtBLnSo+TXGTgekPJP1LlA2PRYOX4Lq096QXoKrlC23Aa/E8g39Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=TTCtApiY; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-68.bstnma.fios.verizon.net [173.48.116.68])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41CMlewn030373
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 17:47:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1707778062; bh=hLuV941+qZxZ2jHcWo5oaqvsH1WX/8coaLVLS570gwU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=TTCtApiYSJKKyhHvtZwLDzSiwb4V8OAqrccxz7UT6GgMhUtBAIOo0wGI63TWHAbuo
	 MOXjpScdHcQdCgsQ+Lrwdb5LsBXG9VB8RSEl4YkclWcW1HM8jL+XVYXrzQ+mMFXQIr
	 RSwcwyp9pWs3CXVYK+Nlt3uENAFs9qdcwYxPQDneR+53T1uGW76ntbqAwLYqgtX1w/
	 xW1+B8qDhCTFBvMqdw3Pa6U/5s2zBddA+gsG7FEToF2h7J4wxwF21e92xVADhDmMYT
	 ioAdUwAt66PyaFAMX5yO/NbIDTNK4ubR80nXp1frNFA9ARnYnlcOqrLeOb17xEiPMe
	 8gVtVA2ih5Swg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id C4A5C15C0336; Mon, 12 Feb 2024 17:47:40 -0500 (EST)
Date: Mon, 12 Feb 2024 17:47:40 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] filesystem visibililty ioctls
Message-ID: <20240212224740.GA394352@mit.edu>
References: <20240206201858.952303-1-kent.overstreet@linux.dev>
 <20240207174009.GF119530@mit.edu>
 <kq2mh37o6goojweon37kct4r3oitiwmrbjigurc566djrdu5hd@u56irarzd452>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kq2mh37o6goojweon37kct4r3oitiwmrbjigurc566djrdu5hd@u56irarzd452>

On Wed, Feb 07, 2024 at 03:26:55PM -0500, Kent Overstreet wrote:
> You've still got the ext4 version, we're not taking that away. But I
> don't think other filesystems will want to deal with the hassle of
> changing UUIDs at runtime, since that's effectively used for API access
> via sysfs and debugfs.

Thanks. I misunderstood the log.  I didn't realize this was just about
not hoisting the ioctl to the VFS level, and dropping the generic uuid
set.

I'm not convinced that we should be using the UUID for kernel API
access, if for no other reason that not all file systems have UUID's.
Sure, modern file systems have UUID's, and individual file systems
might have to have specific features that don't play well with UUID's
changing while the file system is mounted.  But I'm hoping that we
don't add any new interfaces that rely on using the UUID for API
access at the VFS layer.  After all, ext2 (not just ext3 and ext4) has
supported changing the UUID while the file system has been mounted for
*decades*.

     	       	    	       	    	    - Ted

