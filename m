Return-Path: <linux-fsdevel+bounces-41378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F3FA2E6AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 09:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62FD316259B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 08:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB1E1C07CB;
	Mon, 10 Feb 2025 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FUrJMMO9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBD51BBBDD;
	Mon, 10 Feb 2025 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739176976; cv=none; b=bXHKBaZ0lMOm6GvEPN1ySlZ8PZk08vVCIvo3O9kE1o0LXMS8S1JwloIhnyCnO0bNGzGI9ngeD4y/w+fRdhy8vhRed8C05+7s75szAXJ/768sCmkUvbe+sjmNA6bt9o90oBhxY4/QzV90E1j7rOki2LWiNLF2mm+SjvVBjtkY++Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739176976; c=relaxed/simple;
	bh=mNgX1iYqxDHBgC2uGf3mhkuchKDpCf8NBQJYzpCXqps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5ko2L6sME2mRD29eDc4iFpRlnF6rbuXU8CIKBS4Me+XnSh5pADWQOUxZINM5WVLleayxdJqch+d2H/TDkF9gZx0tC7EyHlVzDmwt5maWKTekiR9fGuvpRjdix3K05NSG3hMb6fsbAQVqe9qQS9g3xGgbw1bjQAJec7MKWVDyxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FUrJMMO9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=si/4sD8rt6Ey/ETwk2Qn/a8OV63DDmK4e+2V0x7IILY=; b=FUrJMMO9Y8bEXN5VfbBb+AJ/zK
	xIoy9bz0hulili+1WBDrd8jTrDAiwHkp8TNfy1Q3n6xaJVQ7f9ZgpYoRw/KGVmpEd4b1nZAtHEAoz
	HmRt7wh9rLbRIYDCd9GP47Cs/HdSmyNim1Xl+/aASWb3Sio4cUHxQfFgvEgk3B5SpCTGlQ6p9v2Ct
	NfnBv/PsH3nSY7MQ6uyC2PKLETyCMLRxkYuvQxp6pAEhDFG7f/JaK0Y/I87oovg9ic1JrRUMwAdFM
	07oXfS1e4wtx/NmX+zu/Nq6WqbbMk3qs8zaMnucf50zIpALIksxBqAIyPnA+IbLWgxuHpBY+vUJB9
	OV4GYmrA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thPNO-00000009CpM-0hkC;
	Mon, 10 Feb 2025 08:42:46 +0000
Date: Mon, 10 Feb 2025 08:42:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neilb@suse.de>,
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
	audit@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/2] VFS: minor improvements to a couple of interfaces
Message-ID: <20250210084246.GB1977892@ZenIV>
References: <20250207034040.3402438-1-neilb@suse.de>
 <20250210-enten-aufkochen-ffecc8b4d829@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210-enten-aufkochen-ffecc8b4d829@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Feb 10, 2025 at 09:25:26AM +0100, Christian Brauner wrote:
> On Fri, 07 Feb 2025 14:36:46 +1100, NeilBrown wrote:
> >  I found these opportunities for simplification as part of my work to
> >  enhance filesystem directory operations to not require an exclusive
> >  lock on the directory.
> >  There are quite a collection of users of these interfaces incluing NFS,
> >  smb/server, bcachefs, devtmpfs, and audit.  Hence the long Cc line.
> > 
> > NeilBrown
> > 
> > [...]
> 
> I've taken your first cleanup. Thanks for splitting those out of the
> other series.
> 
> ---
> 
> Applied to the vfs-6.15.misc branch of the vfs/vfs.git tree.
> Patches in the vfs-6.15.misc branch should appear in linux-next soon.

Might be better to put it into a separate branch, so that further
work in that direction wouldn't be mixed with other stuff...

