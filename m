Return-Path: <linux-fsdevel+bounces-41252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5F2A2CD02
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 20:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93951888868
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 19:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE6419D884;
	Fri,  7 Feb 2025 19:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IFqA4PgJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2CD191F62;
	Fri,  7 Feb 2025 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957543; cv=none; b=CwGjc6XXas+cHt7piMtgbTblMtARSUJqHA+sBhvXw1uym+8J1RKAhwdzyYIf013tLvx01eS5VGK86vrv1zAse1ZbzEZgLc/tYh77Vv1dX2BhlyhZcPgZQj1d3auVIWjPz4iF6S0Nrn4iafDEHlEjUjE7y4nLQYFQ0c8U1FumT68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957543; c=relaxed/simple;
	bh=re2Xx8L76f0bfOSbQNwQrboCREf5c7kzwWsZzTkLMnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hnroi99kxvx7e4Q1d7UoZooopy5WVK2R+FmiPKB8jBgZGTVIyu5z4149Z6k4yt0aqgdHjEuLiji2GisNQQRoHBm9gO436eAkcXkf1ITqTGcquK3LaomhMT572lgxzJZY1aNL49nGNuH20XFGjj3MdfVOM48rPw3m1lD3OqXT4Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=IFqA4PgJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pArwD4kaCpFL4AWp/VR1Mvq2RmguTGRbUb7gZBFnx6w=; b=IFqA4PgJSMBONJN27qHkpN9XPZ
	7W+kP0oR2yjms31np2Jv87fJh/T5yHtwTG+wLcVKRS11FAQ8Iota1pGOVEar36LZTFf8HaD32rnso
	5DfO+1aueHDaWSfkd1jA8JaI2hGh7hjaQrdCHZnUXP/gtHkOMfOG/l2F3qPhHnpGJRmaQSoJafuFU
	u2KkmnjlwHM/uXRqy/DcnC/G+WO3ccHRSKRsj8aNrUJakXlAV6hy0nR6zurT2Atgd6jEBplRcwYSp
	yhaIRh7oKr3l3+dh6IlqQoMhBN2MHJNytnxwRGDsavx2HuLD//qL/Zq62dYkcE4SpnsCBjlWzBtDa
	HtDJ074w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgUIE-00000006W7p-3CDE;
	Fri, 07 Feb 2025 19:45:38 +0000
Date: Fri, 7 Feb 2025 19:45:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/19] VFS: introduce vfs_mkdir_return()
Message-ID: <20250207194538.GE1977892@ZenIV>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-2-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206054504.2950516-2-neilb@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Feb 06, 2025 at 04:42:38PM +1100, NeilBrown wrote:
> vfs_mkdir() does not guarantee to make the child dentry positive on
> success.  It may leave it negative and then the caller needs to perform a
> lookup to find the target dentry.
> 
> This patch introduced vfs_mkdir_return() which performs the lookup if
> needed so that this code is centralised.
> 
> This prepares for a new inode operation which will perform mkdir and
> returns the correct dentry.

* Calling conventions stink; make it _consume_ dentry reference and
return dentry reference or ERR_PTR().  Callers will be happier that way
(check it).

* Calling conventions should be documented in commit message *and* in
D/f/porting

* devpts, nfs4recover and xfs might as well convert (not going to hit
the "need a lookup" case anyway)

* that 
+                       /* Need a "const" pointer.  We know d_name is const
+                        * because we hold an exclusive lock on i_rwsem
+                        * in d_parent.
+                        */
+                       const struct qstr *d_name = (void*)&dentry->d_name;
+                       d = lookup_dcache(d_name, dentry->d_parent, 0);
+                       if (!d)
+                               d = __lookup_slow(d_name, dentry->d_parent, 0);
doesn't need a cast.  C is perfectly fine with
	T *x = foo();
	const T *y = x;

You are not allowed to _strip_ qualifiers; adding them is fine.
Same reason why you are allowed to pass char * to strlen() without
any casts whatsoever.

Comment re stability is fine; the cast is pure WTF material.

