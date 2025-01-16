Return-Path: <linux-fsdevel+bounces-39351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDF3A131EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 05:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7775618876E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 04:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E7F13D8B1;
	Thu, 16 Jan 2025 04:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VxOjddEH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FB278F30
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 04:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737000904; cv=none; b=o3IiNNOqrDvxhNfa3TPBHo8B30bVnyCo4EVyoKofb8Gqlo91Lnhik9fqRNBw6xIv9aL5zYJRLV9MzdMRWXHVRLcNrKxo6HPdfDWFvSs8F0k2YwX0Qw7GXs0HDrCdxAmRdFXdRrYXxEyOR2GbNQdK5VMwDiCO8cJ3H+I13A+lBIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737000904; c=relaxed/simple;
	bh=hdojBk179TkhJ40ltx22MEfrcVb3pbpyB9kcModb0t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIuEb3t2FWFjQcIxHLRfv7nJhzVAMbSMk8s1MqPNh3hp6IJsa+RAapLWoqKqVcier+FbHuOLe6d5J0nZhrZSigyvGUW/rqjuiRYyTD65VP7jECUz6sXRs+8aC4av44vJ+VDEWaCwQxDQTzKGoI1PiJVR+L/fAQd/YqUUep2uIhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VxOjddEH; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HVyBsPk7SGcJO9rbFT4YYY73ptq4vvgXLpzpisYTa6A=; b=VxOjddEHKpwjvUrMSj8QGjvlSD
	lM/Tn7TqusxTJgja/ctzbB8Pu3AzLgSqCaLatRAPEFOrTf2ZLwk8bC8fD7T4zzZ2/xRx1BRaKAy6a
	YwfnCCzPtBT5E7oEuc5dQ04iwJJ+nZFNMoHKr2H4Q+yPIHOn9auGqcMyqX3QFcgdRVaNwqMczeOop
	wONdo9y8RP72BBa5JT9fQQK2fERXBNTis2r+cbqBteJTONMQYYNXiFWMkkId0NddLp8xt/skuN2Dl
	9MdQR448HRzhXZUbYPJ7byil1EmgX7tug2eVPp3wNB1eZmDxAaf4fveFFzv9DTxDoVJkequjmtwt9
	uLjnBpfQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYHHX-00000001z7n-0RSx;
	Thu, 16 Jan 2025 04:14:59 +0000
Date: Thu, 16 Jan 2025 04:14:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Boris Burkov <boris@bur.io>
Cc: linux-fsdevel@vger.kernel.org, daan.j.demeyer@gmail.com
Subject: Re: Possible bug with open between unshare(CLONE_NEWNS) calls
Message-ID: <20250116041459.GC1977892@ZenIV>
References: <20250115185608.GA2223535@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115185608.GA2223535@zen.localdomain>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jan 15, 2025 at 10:56:08AM -0800, Boris Burkov wrote:
> Hello,
> 
> If we run the following C code:
> 
> unshare(CLONE_NEWNS);
> int fd = open("/dev/loop0", O_RDONLY)
> unshare(CLONE_NEWNS);
> 
> Then after the second unshare, the mount hierarchy created by the first
> unshare is fully dereferenced and gets torn down, leaving the file
> pointed to by fd with a broken dentry.

No, it does not.  dentry is just fine and so's mount - it is not
attached to anything, but it's alive and well.

> Specifically, subsequent calls to d_path on its path resolve to
> "/loop0".

> My question is:
> Is this expected behavior with respect to mount reference counts and
> namespace teardown?

Yes.  Again, mount is still alive; it is detached, but that's it.

> If I mount a filesystem and have a running program with an open file
> descriptor in that filesystem, I would expect unmounting that filesystem
> to fail with EBUSY, so it stands to reason that the automatic unmount
> that happens from tearing down the mount namespace of the first unshare
> should respect similar semantics and either return EBUSY or at least
> have the lazy umount behavior and not wreck the still referenced mount
> objects.

Lazy umount is precisely what is happening.  Referenced mount object is
there as long as it is referenced.

