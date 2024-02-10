Return-Path: <linux-fsdevel+bounces-11037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 128E6850288
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 05:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1351B2481D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 04:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA9C5684;
	Sat, 10 Feb 2024 04:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KA9FF85I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB1923B9
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Feb 2024 04:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707538995; cv=none; b=S/EggTLe/T80TC+UYs1cyPVe92iyCejqUBUv5Tb51ydAdP3ou4Y1/twhTM791KP+nBZMsiEp5KyPjIbUvFKsmU5gWKQYXtcQKAfOy9LsSplfKv29kVxpAuTYZK+6BWeI8rm/VfEnLsVCXwLi157zgG9DtMn+9m7D47tBtUo3aSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707538995; c=relaxed/simple;
	bh=j+2el+523u3pxi9+th9Ef9IcW5653uVfKukSPEg1Jx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sihJC10aEiftTusnan1A+JiiqbRSfrA4NLoVkW+S83/PqKTjnj+P5joJ5Gzg247MZ61k+t8hhnHzMia5P6/6ONLNeXI+bZRNwM7fi9poQ1fwSFBXFUjx5b286vIUmsY9uRRFjBJDlV4zAlxlvnfVINBK2W1cUhM85JXk6jt7+Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KA9FF85I; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GU+ma5Z/YTP9YWv1qIHlmA4u3GjUo9MFVKM50BS4Cmw=; b=KA9FF85I285h5P6MbaudS3DxN1
	zP1qg8ghQIU0DxP+WlsvxP79oKaEZg0R+Agf9VaFNgaLzfOKz6XRYUMGBTKlkcHIcLx9xx8X1toU/
	lVTNUQ/A5ImDa+ZcbCcruae3vIE6WRjj2/cr0pU41pKdEG6EaLFVjT9Aa67QoW/ZSEiQu454w1Oc5
	r19AOM5dwmpt4/6UOof20zfCsGLQb58U4QGru6vTR8oEmq3s6+u4M8RORuWjMfHd9B2RVzV0VYQS4
	WiX1akO5IEAZA0+3iRcs/QHqsPItAm+Gk1kLWBk95S9tkpZAlSUy1q2kNzK3n4caK0Co3r/munGT+
	v8FyOXJQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rYetP-004eqJ-1r;
	Sat, 10 Feb 2024 04:23:07 +0000
Date: Sat, 10 Feb 2024 04:23:07 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [RFC] ->d_name accesses
Message-ID: <20240210042307.GF608142@ZenIV>
References: <20240207222248.GB608142@ZenIV>
 <ZcQKYydYzCT04AyT@casper.infradead.org>
 <CAKwvOdmX20oymAbxJeKSOkqgxiOEJgXgx+wy998qUviTtxv0uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmX20oymAbxJeKSOkqgxiOEJgXgx+wy998qUviTtxv0uw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 09, 2024 at 11:10:10AM -0800, Nick Desaulniers wrote:

> I have 100% observed llvm throw out writes to objects declared as
> const where folks tried to write via "casting away the const" (since
> that's UB) which resulted in boot failures in the Linux kernel
> affecting android devices.  I can't find the commit in question at the
> moment, but seemed to have made some kind of note in it in 2020.
> https://android-review.git.corp.google.com/c/platform/prebuilts/clang/host/linux-x86/+/1201901/1/RELEASE_NOTES.md
> 
> That said, I just tried Al's union, and don't observe such optimizations.
> https://godbolt.org/z/zrj71E8W5

The really shitty part is not the missing stores; it's reordered loads.
If
	spin_lock(&dentry->d_lock);
	name = dentry->d_name.name;
	len = dentry->d_name.len;
	something(name, len);
	spin_unlock(&dentry->d_lock);
has the compiler go "->d_name is const, so I can bloody well move
the load before that spin_lock() call", we really have a problem.

Can it reorder the loads of const member wrt e.g. barrier()?  If
that's the case, this approach is no-go and accessor is the only
feasible alternative.

