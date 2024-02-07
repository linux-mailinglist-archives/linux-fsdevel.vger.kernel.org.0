Return-Path: <linux-fsdevel+bounces-10683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DD484D5C0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 23:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A3D28543C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 22:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1CB149DF3;
	Wed,  7 Feb 2024 22:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gKN7KGCY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9A31CFA9
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 22:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707344574; cv=none; b=jesvl7NwuX3UHubZuxHfdqC4R05imzPPNXb4/BXALLGFlE2pVcuSGmdyHdfVbOLIB+DWB+vE/Y/Bs4yCt6zxbUe35Dwf4D3ddQhs6aQWhPwk5iO49D3NZle4Zng9nu5+ujAZWPDTXJacR2pTmD3xmIaGpbE7CKhiWeF/lQ2IAlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707344574; c=relaxed/simple;
	bh=Q1ZnclMUkWeKZLEbIuC4uq7gXp37yDU3MUx+Y70Hs2o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OwhmIU6qYjzXhzx2hYW6PQk/jb3cPrgu2e1a926DSdImnQWasOXJv10jYtJ0bafhBeGDFDp67WBcP448xsCX0iLypoNh1HZzZnn7xy9i4oYtUoL85NWFR/ff/3siZaQ1tskeIU/Z7gGjyaRHaD8QKrKFub4Bc6Uu7IRIMEdzBVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gKN7KGCY; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=96TPxCOQZwTkyLWVnLUX+mBG9RHYJgjY0f/4wjeTl7M=; b=gKN7KGCY3CSrB1pak7byljeOU8
	vufcpNYERL4ZjqGYSZE+rB4x1mRbLvyIOqH7e4qYn3L95ue5J8GPpByTV54JdEcWqyURQd7UNXsVW
	YfD898NzHAN3Vfi74BQcCHFZKSUFgjO2byr+91TaQYOLUzxPphoAQHRC2diecyj3JFRTG9yOrnJ1L
	skF6iR2vd1t7wqLWuM3pJ8R4LOfB8HOHizocMwZdMYWN7iz9m5IXmhAqSOFdnmvzgTcCETo+zc5eQ
	XKzMu50gGv28XqEHi4ashUL6OKCAryh/Wws+cTut6LRSLh/z0RbA0vKWEBXvsoTQE4o5oPYcrcKH9
	h3KizWHQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rXqJc-002zWH-2e;
	Wed, 07 Feb 2024 22:22:48 +0000
Date: Wed, 7 Feb 2024 22:22:48 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: [RFC] ->d_name accesses
Message-ID: <20240207222248.GB608142@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	There are very few places that legitimitely can do stores to
dentry->d_name.  Basically, it's dentry creation and d_move() guts.
Unforutunately, there is a _lot_ of places where we access ->d_name -
every ->lookup(), ->create(), ->unlink(), etc. instances has to do
just that - that's how the directory entry name is passed to those.

	Verifying that nobody is playing silly buggers with ->d_name
contents take, IME, several hours of code audit.  And that has to
be repeated every cycle.  Compiler is no help there - it's grep over
the tree, exclude the irrelevant hits (struct dirent has a field
with that name, so does e.g. UFS directory entry, etc.) and looking
through the 900-odd places that remain after that.  Not fun, to
put it politely.

	One way to do that would be to replace d_name with
	union {
		const struct qstr d_name;
		struct qstr __d_name;
	};
and let the the places that want to modify it use __d_name.
Tempting, but the thing that makes me rather nervous about this
approach is that such games with unions are straying into
the nasal demon country (C99 6.7.3[5]), inviting the optimizers
to play.  Matt Wilcox pointed out that mainline already has
i_nlink/__i_nlink pair, but...  there are fewer users of those
and the damage from miscompiles would be less sensitive.
Patch along those lines would be pretty simple, though.

	There's an alternative way to get rid of that headache
that ought to be safer:

* add an inlined helper,
static inline const struct qstr *d_name(const struct dentry *d)
{
	return &d->d_name;
}

* gradually convert the accesses to ->d_name to calls of that helper -
e.g.
	ret = udf_fiiter_find_entry(dir, &dentry->d_name, &iter);
becoming
	ret = udf_fiiter_find_entry(dir, d_name(dentry), &iter);
while
        err = msdos_find(dir, dentry->d_name.name, dentry->d_name.len, &sinfo);
becomes either
        err = msdos_find(dir, d_name(dentry)->name, d_name(dentry)->len, &sinfo);
or, if msdos_find() gets converted to passing const struct qstr *
instead of passing name and length as separate arguments,
        err = msdos_find(dir, d_name(dentry), &sinfo);
I am *NOT* suggesting doing that step in a single conversion - that
would cause too many conflicts, wouldn't be easy to automate and there's
a considerable pile of places that would be better off with conversion
like above and those should be decided on case-by-case basis.  However,
it's not hard to do as a patch series, with very few dependencies other
than "need to have that helper in place".  And it's not hard to keep
track of unconverted instances.  Some of the existing functions would
need struct qstr * argument constified - 4 of those in current mainline
(the same functions would need that treatment with anon union approach
as well; again, there are very few of them and it's not hard to do).

* once everything is converted (with the exception of several places in
fs/dcache.c and this d_name() inline itself), we can declared the use
of d_name() mandatory and rename the field to e.g. __d_name.

At that point audits become as easy as grep for new name of the field
and for casts to struct qstr * - compiler will take care of the rest.

That variant is longer, but it's not too large either.  And it feels
safer wrt optimizer behaviour...

Preferences, comments?

