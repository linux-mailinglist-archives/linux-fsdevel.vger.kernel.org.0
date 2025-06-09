Return-Path: <linux-fsdevel+bounces-50954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE74AD1664
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 02:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C113A7D42
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 00:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A92574059;
	Mon,  9 Jun 2025 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BCerGfG/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DF8323E;
	Mon,  9 Jun 2025 00:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749430223; cv=none; b=Uo5EFyE7rA2DnnpLxKTsWf5rBjV0CS4GxuW9ZW0kX13wtE3rFYyzvj6D3CUn6Mw2fdhsq3gaRtS/xFRVVRfYnolic6KiwHNWPp6IvwM1bwKa/VqU/91huomVucD7ePfr9Ptohf//4iZzwR01Q5DdyEQtYKEE4+BFbTEbhDr5tuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749430223; c=relaxed/simple;
	bh=+AHHggyZBEcEEMErS+Gtpy0ufYcQF85fKYdZ5jK/L98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUoWvwThVBMgOGQTYttuARs4E06tA5RrtpAW1uvBKX18EXk15Pe5xI9NlozZgicqeMklPGIOoukE0oeKaOkPpqJslgsprpRxprjiOHAQ5+m8iVHbViokOTGi/RqvVVrtzefLKr+UtA6jzAOvFMDBfG4gQHL9P0aOZ60DWg4YADI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BCerGfG/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m12yZClFLfVZgzwkAkP0PbBmZAZomHK6sN59s6Zq+Js=; b=BCerGfG/TETnXb1pBHyDSw9J43
	SItMVXL6Jo0eKq8/+GQwg3y2lqipzDlWqEPixlpzJrikZColJbRdihZzUVcE76D3TmPLlEtQUm7/c
	Uw6DbRmWpS5XZ11SVeqsfApdK7phZ2l+sQGQxNp+/PlvBUU9xCsgnOKWEUxOl7lMFJnxCWxQk+HCn
	W9gu1aYq7SL2007L8+Q8jgr/AoHC1UUuFGICFh8XXV2XlcF1+h5UU94Y2SwNIJBLRh4cU843UAxfg
	r1J+ofXM3c+yFQPypGOXWFXs4jLSAZ9rhuqdsb6HrfdWP9lRpePpWFO8X4RC+vdghzZQc1G+xTKJO
	xMEz9IkA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOQiH-00000006Gi5-1kLQ;
	Mon, 09 Jun 2025 00:50:09 +0000
Date: Mon, 9 Jun 2025 01:50:09 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Carlos Maiolino <cem@kernel.org>, linux-fsdevel@vger.kernel.org,
	coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
	linux-nfs@vger.kernel.org, netfs@lists.linux.dev,
	ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] Change vfs_mkdir() to unlock on failure.
Message-ID: <20250609005009.GB299672@ZenIV>
References: <20250608230952.20539-1-neil@brown.name>
 <20250608230952.20539-6-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250608230952.20539-6-neil@brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 09, 2025 at 09:09:37AM +1000, NeilBrown wrote:
> Proposed changes to directory-op locking will lock the dentry rather
> than the whole directory.  So the dentry will need to be unlocked.

Please, repost your current proposal _before_ that one goes anywhere.

