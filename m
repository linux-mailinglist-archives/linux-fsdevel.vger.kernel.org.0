Return-Path: <linux-fsdevel+bounces-41259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0747DA2CE33
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 21:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266AA188E0B5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 20:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6C61AA1D5;
	Fri,  7 Feb 2025 20:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aRoiBMZD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9A81A5B83;
	Fri,  7 Feb 2025 20:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738960550; cv=none; b=Aa6tmhvt747tDrESTolMA4Bt7DAwdjp9/wsPUNhSPkO39YjvZEjQeZx0Mz0GnXA63+1SSZVnqhfiZzk5C9qytsTD2pNaOo30N570X3fg7C/LeMhXMxwlPmI3aciG7AkhSzIzKGd0EKiRD8K+bfP4aM+peN0lihBmyjKfpAX7uTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738960550; c=relaxed/simple;
	bh=mo+imipptx01s01rZNm6rhTdY69IR/eBZ2I9W+Wnu+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guNluZGESfY8AUBsFlrNXoBX857D7N5b2214aZmjxQoRRzGWzx1Uv4wyi6CbxaaY3p9yxfTY6qYQeH8oSirvIotMVanQu6pO3foDUJ1UhdYWP/CSqnTul7hGF8yyPksoU16KCORcD6b6CH8LVZtMq0McRSFp1Gt47W513GVNslI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aRoiBMZD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ktcsS1mIRmn+/53h/4If0SZ0KchgYx1oJMs+EwIN8po=; b=aRoiBMZD7EMP3Gl7L526OJ+g3q
	H9RRZwxu1/Jh9SxEfHcMbCJPYzHDxircIezp3LN7dLgza7NnmqcfWuKfGdfCB4xuPRc8n7ExIrWI0
	3mVv2HIm42cWmmOqJXeffgEg4j/PC+l7le13fzCnhUCEBO6f+8mVGc6El8gl+//DMAaH3lhfjWKw6
	m8hlu1uHKJGPATLOF/CDnS/NYKLpLO4yDAxiTS5St5FSHVKuo426omXlzi2VER6F0ahM5QGCxfI2Y
	/Wed6d76Z68c2nIFrBoDqujqWzxnCGZsBIDlhr3vgeVI7FnKvMXCrpsEQECitWcpj3ckzAj/HxYdi
	5ASRcV5g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgV4k-00000006Z9j-1Der;
	Fri, 07 Feb 2025 20:35:46 +0000
Date: Fri, 7 Feb 2025 20:35:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/19] VFS: lock dentry for ->revalidate to avoid races
 with rename etc
Message-ID: <20250207203546.GJ1977892@ZenIV>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-14-neilb@suse.de>
 <20250207202839.GI1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207202839.GI1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 07, 2025 at 08:28:39PM +0000, Al Viro wrote:
> On Thu, Feb 06, 2025 at 04:42:50PM +1100, NeilBrown wrote:
> 
> > +	if (dentry->d_flags & LOOKUP_RCU) {
> 
> Really?

That aside, you are *NOT* passing the parent's name here - if you
look at the callers, all of them have 'name' and 'last' arguments
identicaly.  What is going on here?

