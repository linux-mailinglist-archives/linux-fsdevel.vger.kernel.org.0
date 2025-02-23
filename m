Return-Path: <linux-fsdevel+bounces-42347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C73EA40C65
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 01:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE411189B4A3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 00:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DC7BE5E;
	Sun, 23 Feb 2025 00:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mdVI9b9N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B165FBA42
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2025 00:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740270505; cv=none; b=jp8jJMYRWm9PEicoiSOrqRwc2qJwmbEKCioAWfF/chDnPV3RvJIrTYwFrZMIqF63YpGXvWm0cshjprivKGXWfd4Q36tQ0t+dB3npOrlNZs40MN8QuuMaKMc4KZmkJm9QfRvsod3ek5nFsNLqXHhSSppKwNcfEmvWn3hdFbbPq2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740270505; c=relaxed/simple;
	bh=gUh5XueRhxo2oGXBZlZhMx+2L9nt2JOB9xKOxst/v2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRFBfw8wJUi2hbiBuLSXP0BHE2KWMmkz0X7fhiDDNW9DeMlnrxLV8F+42Zp34+KCVrgI6QMilbGKeoKJJvxlDL6TmaS0GFV/xGpzRp6XKowMldN30YUYeuytTctdna8q/xR1vOgrqHFrTaJoFxGIZzk1bjg7OkSCq/Sod8Nesls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mdVI9b9N; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IQqEOA+t5Ok1x3sSUep9G6VHHIacYQ/KZNCUciq9X5Y=; b=mdVI9b9NXdVHah0b8wbJyid3fr
	tXSDxxJBBT8ylDp/qcamG03emqTtUHp5jbNTJJNKkij+zKWm2Zs9pYwJVgkvdCIm/7mOD6i3AGTcj
	qHRX4Cc/k+i19U8EBxzktlhfrJ6v32c7rBHGr6L3DkIlnR6jYyhg9oR1/4jW03t4JyVPob/mN1rCG
	GkvL+GEsugbE4GujIANjAfEF2bxIePt6DoJza0cPqLWoyP0i6qUxTd72nlC/28g2jMeBHjD5sxcaB
	9SCp8beFSzn8lskD3S7qEWk6os7lVKmY1q2lkKCF6rOBiZnEGe9JfTrq5DvXgwiHeCRVLCcfhdAMh
	9U7kEHpg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tlzr3-00000005hms-1EHK;
	Sun, 23 Feb 2025 00:28:21 +0000
Date: Sun, 23 Feb 2025 00:28:21 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	Laura Promberger <laura.promberger@cern.ch>,
	Sam Lewis <samclewis@google.com>
Subject: Re: [PATCH] fuse: don't truncate cached, mutated symlink
Message-ID: <20250223002821.GR1977892@ZenIV>
References: <20250220100258.793363-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220100258.793363-1-mszeredi@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Feb 20, 2025 at 11:02:58AM +0100, Miklos Szeredi wrote:

> The solution is to just remove this truncation.  This can cause a
> regression in a filesystem that relies on supplying a symlink larger than
> the file size, but this is unlikely.  If that happens we'd need to make
> this behavior conditional.

Note, BTW, that page *contents* must not change at all, so truncation is
only safe if we have ->i_size guaranteed to be stable.

Core pathwalk really counts upon the string remaining immutable, and that
does include the string returned by ->get_link().

