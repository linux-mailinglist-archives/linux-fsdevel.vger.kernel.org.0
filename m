Return-Path: <linux-fsdevel+bounces-41560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06734A31D3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 05:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86830165E7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 04:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90981E7C1E;
	Wed, 12 Feb 2025 04:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QzaGPaoC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA11271835;
	Wed, 12 Feb 2025 04:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739333176; cv=none; b=tEcP5/X2wwLkOZI55QumiQT+izxUUAwf0jQvpAzpNrJrOKfUXUJOSsK82gpa72y5JOzaJ7UL8WanOTbAXoxwWvXx9f4fvJKmTdPniFxE1TU6pSZkkhno79EfgtjV3p8oef382S76fE2p+MNVtFHj/bITsL4+rJMcGkAsdJIaKBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739333176; c=relaxed/simple;
	bh=JM+2RzpGGdzRlzi8GJA5nrKgglQ+6GKEyswii8T2dSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a37ctJzAsV0aiUh6719hkwSLVPzKO3iiA8z6eHuw9DXq0uPspUpi6up8Cd08XH3Fzz7NqBlyeBLxwikfadgpKrRYzC92M6AAU7HWeMNqOUcvwl3UoOBleslWnz4JMpXO7T2jIrULqut8yO5SWG75arq3tz/VfvO+QkRqkTG1oTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QzaGPaoC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IldAkdjpaY8wZ4UG2q04xBYFqlX/tW0s9PDLPfifNio=; b=QzaGPaoCqnsidp2hTQ4bF1QNhT
	/3aJ1NUZs5YtMjoiSzsJAhn1yC4tfcydwEe+aoTxge750jCH+igXb+emWxGt8xvb98R5tv6YFGUAb
	XtuRWoFJmPxeO89z+E1/DZcmgEzj9XTdIfBQ+ZlxDxan+ibCC/m51Ys+mLRBbuZgEytJuOdlcBb9Y
	4pSZodtkO3Zof7Lr+jG20UKC3rLz3thvw8OmlfTTEvIQaJ5sNoTt9Uf53wNfA5K/DOAv9+iLU7VGz
	BQnDq8JgcgHotOKUK9S+poWwxZK59FvIn33z4PRn2KMVVWskAyj9pf4aedvprsTk9OHhfrCuFhPA4
	6JAC1h4A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1ti40i-0000000BEOP-3YSN;
	Wed, 12 Feb 2025 04:06:04 +0000
Date: Wed, 12 Feb 2025 04:06:04 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <sfrench@samba.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>, Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>, linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	audit@vger.kernel.org
Subject: Re: [PATCH 2/2] VFS: add common error checks to
 lookup_one_qstr_excl()
Message-ID: <20250212040604.GN1977892@ZenIV>
References: <>
 <20250212032505.GM1977892@ZenIV>
 <173933190416.22054.5881139463496565922@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173933190416.22054.5881139463496565922@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Feb 12, 2025 at 02:45:04PM +1100, NeilBrown wrote:
> On Wed, 12 Feb 2025, Al Viro wrote:

> I do see some value in the simplicity of this approach, though maybe not
> as much value as you see.  But the above uses inode_lock_share(), rather
> than the nested version, so lockdep will complain.

IDGI...  It doesn't grab any ->i_rwsem inside that one, so what's there to
complain about?  And in that case it returns with no locks held, so...

