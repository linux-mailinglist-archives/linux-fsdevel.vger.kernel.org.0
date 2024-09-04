Return-Path: <linux-fsdevel+bounces-28560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C646096C03B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 16:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0532E1C250FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 14:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8973E1DC07E;
	Wed,  4 Sep 2024 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WRhMVlz2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7177A1DB53F
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459705; cv=none; b=a53q6NIsc3xdvuqai5p/kA2Awd40faJewRU2nAQgCjeZtCuaEG8X9sXaOm7f560+9bD2UI03p7uuYdiiTtF5fuFiqDJ8YkH08nhFV4VbKQwRjHWpRA9fTKp+WnRoEMFz8wHQGAjOIAVpFjl1/y9+DewVfBgnVqq29s90EZOeUWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459705; c=relaxed/simple;
	bh=Ee4vo7PZM3Zk3hQK1lgw3YXZiVApTWr43sJz+jlUqO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dn97J9K7xXGlCixHZTtwWRA4VuyDuFdizh/fYcLmvydw9OUysxvjWy0q4Kcxp9nlbLxE0QObm0AJ4GycLPwWGDRhP+ehzxf8/Fl8Gv8fVCgE1rbN59/xnHq2nEKyonIvC7I8ChyvPr6sU0EarzTf1OkYj+yCsCrJd9+5c1T+HE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WRhMVlz2; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7gk9ph82tBMzr0ozd/7pGq+2UgzGgtuUo8/UrCsf/NA=; b=WRhMVlz2qBa/XtyHxA4enVXKjF
	QqprPEqK9xj/khuOBDR/lDr6YwI0pBvryZxlIiVFrM8tb90edcce5SZCmXQq7A1z3lPPyfreqwHi6
	nVXGS4yUnycwZththKlD2oQ/POJc9B9l0Ur2p2EGE9/6j96Wfc26NmnTEAJ9q39dVtGbb3Ocwkal6
	FSE5pqnYQvrBbXv2sm9xTkOgR7XRgM8AR5/jN0umuBZ5EL9uUkUloumIBEfLzlp7LmwaR3nGhoyTw
	iE5UtU1ggD1Wrj2ctdbycXfsmFBpY+wgjNXtdq/i3PF4ZacEoT2M3GPtiKxXYE4rzy7SOe+EtgCxa
	BHxBJrJQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1slqtA-000000095ki-1EjE;
	Wed, 04 Sep 2024 14:21:40 +0000
Date: Wed, 4 Sep 2024 15:21:40 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 18/20] fs: add f_pipe
Message-ID: <20240904142140.GH1049718@ZenIV>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-18-6d3e4816aa7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-vfs-file-f_version-v1-18-6d3e4816aa7b@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Aug 30, 2024 at 03:04:59PM +0200, Christian Brauner wrote:
> Only regular files with FMODE_ATOMIC_POS and directories need
> f_pos_lock. Place a new f_pipe member in a union with f_pos_lock
> that they can use and make them stop abusing f_version in follow-up
> patches.

Not sure I like that - having lseek(2) use a separate primitive
instead of fdget_pos(), grabbing ->f_pos_lock for _everything_ that
has FMODE_LSEEK, directory or no directory, would simplify quite
a few things.  OTOH, that will affect only the explanation of validity -
pipes do *not* have FMODE_LSEEK, so it becomes "fdget_pos() and
fdget_seek() are the only things that might want ->f_pos_lock, and
neither touch it for pipes - fdget_pos() because FMODE_ATOMIC_POS
is not there and fdget_seek() because FMODE_LSEEK isn't".

Oh, well...

