Return-Path: <linux-fsdevel+bounces-37110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FD99EDA79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 23:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE282813E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 22:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9051F2382;
	Wed, 11 Dec 2024 22:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VrtgWFXf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537F5195;
	Wed, 11 Dec 2024 22:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733957708; cv=none; b=bB7GXalZFCC85azauN9L8WBkqfkuCFasphMYF1kml5poNrlyXJhehU/m/oAAOdgEanzyEDbQBlBtS1cEKRiCnVjy8w+ylIXI0E8X0vjBhCrL8N3Y/6//tGm5hb+cpTk7bQfoFwpjVvr0ESFvzKAxW5YWchHuxI2I2s8PTgEO5nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733957708; c=relaxed/simple;
	bh=qnUxwhAfYS+RMxLm+6NnfLRtf/G7InWbohQJsC12Kog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dm4pk14wD5HtN/RXH2BaqcPI4MkmUGw0wNDQaL4jqz5mbE3v75tbrKDim/2b/DSXamV7krOSkQX3R8OHriDb//IWClu++yDU1HJoAHnUglRYAb/eAQ+0fzpZiH16oFUJS+8wgJw2NdRF+aO7eFcmKb5kkc3falD/Vfat+K5D1Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VrtgWFXf; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wLSQMomPRMXyfjszmpA4ht39gCFf4uc3967U/zFycPw=; b=VrtgWFXfzcyrbdrF2pQHjgAYO3
	LSUn9mJzbNaEwCahXLxa41HhBaTVnJzKSngcc9S3Eu5+WO4BbOXqsITpTgtqJp559PLUiYRsrduj0
	zeHJKGMTadQvsJnGZKVB9XmeJTwVvOTzq6ubxxzuMr8nuj++8SVTVCu8JaFYwqOXRH9RKDZqFTY0E
	BQUlY7h3X3whyA/1l5JxnAkzCDq1IMUFTzN7ia+3Oi+dp1X6LtcKwXtLKN3rymurSsDJSOm9sn25r
	aObCiZ7do6EUhn391snpvCQaEMW0MFFNC7MSblPLtNdrpBnYyJvJHTdeamlQSM3vjfwTVYo5xweCp
	XjdciA5g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tLVbg-00000007N6B-1fyc;
	Wed, 11 Dec 2024 22:55:00 +0000
Date: Wed, 11 Dec 2024 22:55:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: asmadeus@codewreck.org, Leo Stone <leocstone@gmail.com>,
	syzbot+03fb58296859d8dbab4d@syzkaller.appspotmail.com,
	ericvh@gmail.com, ericvh@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com,
	lucho@ionkov.net, syzkaller-bugs@googlegroups.com,
	v9fs-developer@lists.sourceforge.net, v9fs@lists.linux.dev,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Seth Forshee <sforshee@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: Alloc cap limit for 9p xattrs (Was: WARNING in
 __alloc_frozen_pages_noprof)
Message-ID: <20241211225500.GH3387508@ZenIV>
References: <675963eb.050a0220.17f54a.0038.GAE@google.com>
 <20241211200240.103853-1-leocstone@gmail.com>
 <Z1n-Ue19Pa_AWVu0@codewreck.org>
 <CAHk-=wiH+FmLBGKk86ung9Qbrwd0S-7iAnEAbV9QDvX5vAjL7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiH+FmLBGKk86ung9Qbrwd0S-7iAnEAbV9QDvX5vAjL7A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 11, 2024 at 01:32:26PM -0800, Linus Torvalds wrote:
> On Wed, 11 Dec 2024 at 13:04, <asmadeus@codewreck.org> wrote:
> >
> > Christian Schoenebeck's suggestion was something like this -- I guess
> > that's good enough for now and won't break anything (e.g. ACLs bigger
> > than XATTR_SIZE_MAX), so shall we go with that instead?
> 
> Please use XATTR_SIZE_MAX. The KMALLOC_MAX_SIZE limit seems to make no
> sense in this context.
> 
> Afaik the VFS layer doesn't allow getting an xattr bigger than
> XATTR_SIZE_MAX anyway, and would return E2BIG for them later
> regardless, so returning anything bigger wouldn't work anyway, even if
> p9 tried to return such a thing up to some bigger limit.

E2BIG on attempt to set, quiet cap to XATTR_SIZE_MAX on attempt to get
(i.e. never asking more than that from fs) and if filesystem complains
about XATTR_SIZE_MAX not being enough, E2BIG it is (instead of ERANGE
normally expected on "your buffer is too small for that").

