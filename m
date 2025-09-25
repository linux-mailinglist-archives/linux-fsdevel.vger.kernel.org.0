Return-Path: <linux-fsdevel+bounces-62808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F999BA1370
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 21:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8CF1C20856
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 19:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020BC31BCAA;
	Thu, 25 Sep 2025 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AMCRkmTu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367B92417C2
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758829012; cv=none; b=etUhJArIXUmgHDgEqJhVm5QT3fIPIgCfR6w1jY0vXHdFQauB+0mwXuh2QmNFVRnZ9uQ3LXRGeXwlsJ61Id0jysoxMgN5mhkrB9lWscQOFNvhj4z4I2xqUklReuCwd+ni0KMMtLVnLOPPudZeN6JvbRAIk8R00wNUI2fLC4LurJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758829012; c=relaxed/simple;
	bh=3pzairPCih+UfXg7ZunPwQh3bdtScoXbQLlxt+GZ6DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfWTwr9ewwShWxMD1WDd2lJZWutAqI3bfb7jQi2fo+8i99DMdczyo1aFt/WcPkscIjYYINs5YDP/KMng+bQxnTXVP8QFq2zFgQyQWY32txFLvzd8o+ycHQX5XGHDimudl4gexlm7GIYbxO4HVa3s6DbNMZO5HBhpnUdlLYAA4DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AMCRkmTu; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cxnUeSB95VsfDGjMYSgtHwTqGmNyo7b1sjz2XleZ9pM=; b=AMCRkmTunXv9DXDMl7v1apwj9C
	saFA/klfy2exDOwSIrqK/ZrQjV1nHuf5LzI+HD5Kt/IgaOGu+js0kb9mSO0eIeFguquqmu05Orwei
	dUctMCppkpaDn6VNV0FnHy0ovAxVvsI13a6FErQXCXnafZ3EY+ifgUAH+PYBT6L6Hj/ZrAhhyM+KK
	EZpAJzcCDsRQma4KxuQ9weYfwOK9ct6OUIlV5MAen+SnM9dWBOvmxPbd4f4ioY7Rl3d2kcOKwczQQ
	b3ZvhGvf3CBAXNngky7PhFw8pIGrZj4oIhGnG2nDjecKrSBs1/CSNgLFG2t6ijh1b0rkunCy54G25
	aBVc5ipw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1rln-0000000AN8e-1FxA;
	Thu, 25 Sep 2025 19:36:47 +0000
Date: Thu, 25 Sep 2025 20:36:47 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	John Johansen <john@apparmor.net>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] kernel/acct.c: saner struct file treatment
Message-ID: <20250925193647.GB39973@ZenIV>
References: <20250906090738.GA31600@ZenIV>
 <20250906091339.GB31600@ZenIV>
 <4892af80-8e0b-4ee5-98ac-1cce7e252b6a@sirena.org.uk>
 <klzgui6d2jo2tng5py776uku2xnwzcwi4jt5qf5iulszdtoqxo@q6o2zmvvxcuz>
 <20250925185630.GZ39973@ZenIV>
 <20250925190944.GA39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925190944.GA39973@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Sep 25, 2025 at 08:09:44PM +0100, Al Viro wrote:

> Something like this for incremental (completely untested at that point):

BTW, that got me wondering - how about adding
	if (IS_ERR(pathname))
		return PTR_ERR(pathname);
in the very beginning of do_filp_open()?

As the result, e.g. do_open_execat() will automatically DTRT when passed
ERR_PTR(...) for name, reducing open_exec() to
struct file *open_exec(const char *name)
{
        struct filename *filename __free(putname) = getname_kernel(name);
	return do_open_execat(AT_FDCWD, filename, 0);
}

with similar effects for alloc_bprm(), etc.  The same goes for
file_open_name(), with simplified filp_open() and quite a few other
places...

Note that filename_parentat()/filename_lookupat()/etc. have the same logics
in them - do_filp_open() is the only caller of set_nameidata() that leaves
that check to its callers.

Oh, well - next cycle fodder, at that point...

