Return-Path: <linux-fsdevel+bounces-40194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793FEA2033D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 04:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 731FF7A4068
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 03:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FB5171658;
	Tue, 28 Jan 2025 03:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="S3k5tb7T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDD679D0;
	Tue, 28 Jan 2025 03:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738033652; cv=none; b=JQXNY2YG83Fuxq2g8VZy08/y7GH8sbIy37rBm4B/RoA/yFdfzwd3B453+UPKMFF5DYm8RYPEO1LZLFfM5myEQdksyYhYTLtHXkEuoMAAvVDyO+vg6Dp93mWtm7rowLpLdP5s92jUt6U+yx52o58/3UvJmkT9VBwfp4A019Nql5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738033652; c=relaxed/simple;
	bh=1XnMySzV3V3/Wl3zEmYuPWbrjzS0vj3TwNs/FGgGUVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uC8R8Gfp4rJVoMWw5Z6Wor6LVHK2NlMjLwUZqfH7L487VsqD67+YK9Rqp2hK9WcdOOPTX5FZKuxgV+9usAeH4AUgQj8DH6ZOKmtlzoExRK8hrgXixclY75j38bNgVOj+lE20j+bne5xi+C226mWh4UpIzI6GF0WT+y4i7lZose0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=S3k5tb7T; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MbuaY6XvLxlfLLl236lmUxpSJWGWV82QFfRKdy3fMjY=; b=S3k5tb7TPvM5IUFxHkCDLbd3qD
	0LN13s5cBiqTFvZVjY4u/zu/sTbAXOFBK1K+YtQith9ptMYEVIofLhhkUhDOXBL+E4PvGO6oICbLU
	x+GGq8zBpAbwiu7N6SShlSa0gLMCZtzexcVTcbedRZKI8yXk8WaIZEzCReXRqbIqP7nBIHssDXfav
	isIEemsYw8tUxtWSzBhQub26keOeqosCiv4OrUwyRx/C9ItStohRyWQN8MWI70jSstFy/Nqxnjsf6
	/+nr8KrQbTyMAOXqC4Ry1AlaoewUIprnQEMWCoJoebU1/Q6oMWm2oj+74KqjuBDR6pG1JYBB7PL+a
	UdHNZjiw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tcbwm-0000000DtjJ-1MiS;
	Tue, 28 Jan 2025 03:07:28 +0000
Date: Tue, 28 Jan 2025 03:07:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com,
	amarkuze@redhat.com, Slava.Dubeyko@ibm.com
Subject: Re: [PATCH] ceph: is_root_ceph_dentry() cleanup
Message-ID: <20250128030728.GN1977892@ZenIV>
References: <20250128011023.55012-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128011023.55012-1-slava@dubeyko.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jan 27, 2025 at 05:10:23PM -0800, Viacheslav Dubeyko wrote:
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> 
> This patch introduces CEPH_HIDDEN_DIR_NAME. It
> declares name of the hidden directory .ceph in
> the include/linux/ceph/ceph_fs.h instead of hiding
> it in dir.c file. Also hardcoded length of the name
> is changed on strlen(CEPH_HIDDEN_DIR_NAME).

Hmm...

Speaking of that area
	* how the hell could ceph_lookup() ever be called with dentry
that is *NOT* negative?  VFS certainly won't do that; I'm not sure about
ceph_handle_notrace_create(), but it doesn't look like that's possible
without server being malicious (if it's possible at all).

	* speaking of malicious servers, what happens if
it gets CEPH_MDS_OP_LOOKUP and it returns a normal reply to positive
lookup, but with cpu_to_le32(-ENOENT) shoved into head->result?
	AFAICS, ceph_handle_snapdir() will be called with dentry
that is already made positive; results will not be pretty...

