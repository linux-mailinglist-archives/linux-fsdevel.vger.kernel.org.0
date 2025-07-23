Return-Path: <linux-fsdevel+bounces-55907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C42B0FC1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 23:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C2D3AC94B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 21:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E781126CE39;
	Wed, 23 Jul 2025 21:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="An42eBv0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE17314A4F9;
	Wed, 23 Jul 2025 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753305918; cv=none; b=cE1YT5LZCZjZ85bhFHMwlF0B9rbT8Tcs3pbqFxhC2pNsIYi+LsxPXzTLirxRzgcsRIJt7if5NTMdlW+3obbcEb579HeR5t4D4ePy3+WA68pPiYk5SaqBhIl1HMQGutxuSNh+uPxgFH2QZfZBR1Q9VmkaXNN7EHX3Ol48gcKGcEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753305918; c=relaxed/simple;
	bh=zVctxYoLHPv6JSk7LEg3jS/TARaw/a7N58sj1SnGTeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxTukSqFsDyYTtyc+KqCh64HVCS9DmABrOEDKE4h4DHcYsVJn5qaTbpgQ7zUQTD7LhLv5LIJmha3q4ei+dEvU9I8HKj/WQpqQKcApfLYXM8//W5hkUsnAT4wplLBD7h+Fv+Rdg59rR+h1XrJjPAJrziOpUIkuG0mM5Kj2AZcWos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=An42eBv0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YcKa9zxhHHkTSiqRaxtCtu00HFAere42O4zaabyjgto=; b=An42eBv0WoFbA+MdRU+JZRbvsN
	fZClMN9xJ/2ODcnXUgTV97uEZSSORlNfFVPnjrrCze3xTtUTf7Q9o5aW8olgaAbceoZCgiGwJQJJp
	jqHZr94UKf8piBg6s9vaqsXjzFcmqTBukV+tPwx3VCz2D4QVBO4jISAMRvXp/br8M6CsLWRuhAaHV
	qUclRL93XM/JA4c1fnx8E1jLw7GhNsGgyu/ihfrJqWCEACXhPGvZoDAXBWTFmhAYGNXlEhBMmEIY0
	ADxjhl1He0FM4Eyyw2UWUjMUUHPAcgx0FJO+Eo4sTLSy9j5etAH+sQAg/wn/VEnVFI5ho2aFkb9ly
	FmIQmEzQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uegxb-0000000EjGr-1wMy;
	Wed, 23 Jul 2025 21:25:11 +0000
Date: Wed, 23 Jul 2025 22:25:11 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "frank.li@vivo.com" <frank.li@vivo.com>,
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] hfsplus: fix to update ctime after rename
Message-ID: <20250723212511.GQ2580412@ZenIV>
References: <20250722071347.1076367-1-frank.li@vivo.com>
 <20250723023233.GL2580412@ZenIV>
 <cce1a29f2f55baf679c3fe83269d9bceb3c4fd6c.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cce1a29f2f55baf679c3fe83269d9bceb3c4fd6c.camel@ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jul 23, 2025 at 05:58:01PM +0000, Viacheslav Dubeyko wrote:

> So, this line simply copies CNID from old_dentry->d_fsdata to
> new_dentry->d_fsdata during the rename operation. I assume that
> ->fs_data should be untouched by generic logic of dentries processing.

Yes, I understand that; what I do not understand is why.  Why would
the CNID of renamed object be slapped on dentry of removed target?
I'm trying to understand the logics with link(2) and unlink-of-opened
in that code...

Incidentally, what happens if you
	fd = creat("foo", 0666);
	write(fd, "foo", 3);
	link("foo", "bar");
	unlink("bar");
	close(fd);
The games with S_DEAD in there look odd...

