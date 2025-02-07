Return-Path: <linux-fsdevel+bounces-41256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A24AA2CDF6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 21:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C7B3A877D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 20:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097E91AB528;
	Fri,  7 Feb 2025 20:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NPNAFZJH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB8A19F11B;
	Fri,  7 Feb 2025 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738959254; cv=none; b=TZj/j3FwUznyuFWvxrHKYvWrLDcYebbbGfRbndg4ENHQzEdq3WvAlUUe6e6pQHVyQWyBZlTxeuax/aFDbsBfRAY7kNCsuu5LFV4X9kfD81ZN+eHxnFniIruR7w6BJgav0NM4wkQJwpZQmXjqPU4s0apDM0N31eQzqNfwX5AyPEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738959254; c=relaxed/simple;
	bh=nsw2/USmCHK8GbFQfcnGhMUXTYgJ0hKGEDmqvLlf4wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOOga8iMK3FwpUZkdJq3AvT/8Cd8cryW3O4+p6dM7Lpb45uHNucaFo4IEBfIlIx5BiSGP0sTf/RtUUhMm1GYGYuL/lGCx0G/t3dXxC1LF+qOc1kJ0SShSY7qUS3Oldesj65aJvGSBfW+Lln6eAek86yzrJ63kF8VeqGzBvifHvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NPNAFZJH; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7tgqXEQkX1GnelXikPDjL/gOjRVLQMbsv4YalypXr60=; b=NPNAFZJHyCiM/1Mx7ZPrMITO3D
	9W6voN0tFtoXwdSiyholt4Fif7Bln4sWaO83C8jfHS7NoWlMGdOsFkaJjDRPEw53dlhuV+udUD1Ak
	U6yQ6ZATH/Z6o+ztdLxgJT2VYf/jQrFEpfTxEXjD6suZkN3KCAmJGtmOCLXpGvt8X6U5rJwMS1ugL
	hkQMOUaXAFrb21DO1jw8B+6Q9xkgnwsjcMC94SL3YOt9yOJFpwjv+k1B0NoVvQXmtHOfaW+v6EBht
	jmUXkdZFN9NRXuES9BH6APOnLdjersCp8aweaIJ/+l+6ELtn0qtLCnYsHQsc/NxMmidQtrRYq3MwU
	lZju9Tng==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgUjp-00000006Xk2-1Wxh;
	Fri, 07 Feb 2025 20:14:09 +0000
Date: Fri, 7 Feb 2025 20:14:09 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/19] VFS: add common error checks to lookup_one_qstr()
Message-ID: <20250207201409.GG1977892@ZenIV>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-6-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206054504.2950516-6-neilb@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Feb 06, 2025 at 04:42:42PM +1100, NeilBrown wrote:

> Callers of lookup_one_qstr() often check if the result is negative or
> positive.
> These changes can easily be moved into lookup_one_qstr() by checking the
> lookup flags:
> LOOKUP_CREATE means it is NOT an error if the name doesn't exist.
> LOOKUP_EXCL means it IS an error if the name DOES exist.
> 
> This patch adds these checks, then removes error checks from callers,
> and ensures that appropriate flags are passed.
> 
> This subtly changes the meaning of LOOKUP_EXCL.  Previously it could
> only accompany LOOKUP_CREATE.  Now it can accompany LOOKUP_RENAME_TARGET
> as well.  A couple of small changes are needed to accommodate this.  The
> NFS is functionally a no-op but ensures nfs_is_exclusive_create() does
> exactly what the name says.

Where's D/f/porting chunk?  Mind you, this one needs _very_ careful
review and testing - you are touching codepaths that are convoluted
as hell and rarely tested.

