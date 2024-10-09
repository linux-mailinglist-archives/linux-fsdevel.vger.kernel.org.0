Return-Path: <linux-fsdevel+bounces-31457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB86996FC7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 17:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F98E1C2031E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 15:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECAF1E230B;
	Wed,  9 Oct 2024 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BMLgjSLS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27641199230
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2024 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487457; cv=none; b=B0TC7zR4zgcIWJMMmAfNODWkmhNGNcTpZzasktpLqcbl0XzV9NgrFYQAeTiwG5Hbje41uNJpWhO9KPqUzDd6dzmVKOT8Z7UuE4bDI480fXdRIBbU1gaEEPfLtnYSQLFB1F2hJFDWGlTgW01K4ZhoFZHXOOYdKgIyhmHb9M9TYRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487457; c=relaxed/simple;
	bh=jfKFZ7W/PKRaIDsY8INaQjIrMdby4e2VHsv7AgTrq0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVlRjaqP//ll5nAaRAS259HTVw/HPnXLA9vn98gToLUEIo65rHKJ6DkZxSoLQli4zUcBGTYmVF5i69dX9cUGKMfSFV0t/co1hPG2KTStd8WNoVxwyg8gipadJIbw3HbxqwK2lZW9cfOmViTKUKjrgw9WwvDD2HF5jgeSKJpJJw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BMLgjSLS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k1kjK3m9q6CrgbzyR/PDRsOOLU8Syyz6JWa0kIr259A=; b=BMLgjSLSgXd14nc2u7hFD9snJg
	+zuRoSaH5sPFRwhaOFE7uF0ywaTlmfZflUilsYFf1KCGjAmPO0cxXqhd4fycpb5+OhvZoGEbQfO6d
	9dfkg/vSQ4gI5ZX1jPxoGxbw5eXmitKZr68TsCO1m+3Xix2y+Y4bo0wyt72BT+2lCUyn7N5lF5XbR
	Dql3lrUZzmds51cP8Iol0cWGLn+BlkTdzbzL/GUJL1H+5h6HStwlnLQEj48KKdOwfJcChhN5obICV
	RGTvc+nMe6W7ZdsmJx040QRa3zblLxGlAo3WIUNzk0Hc7bT+4r0+fCnVu0DTOYOHvSa53gL0cxszP
	cml2ngNw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1syYXr-00000002BS1-2iQl;
	Wed, 09 Oct 2024 15:24:11 +0000
Date: Wed, 9 Oct 2024 16:24:11 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Steven Price <steven.price@arm.com>, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: [PATCH v3 10/11] make __set_open_fd() set cloexec state as well
Message-ID: <20241009152411.GZ4017910@ZenIV>
References: <20241007173912.GR4017910@ZenIV>
 <20241007174358.396114-1-viro@zeniv.linux.org.uk>
 <20241007174358.396114-10-viro@zeniv.linux.org.uk>
 <f042b2db-df1f-4dcb-8eab-44583d0da0f6@arm.com>
 <20241009-unsachlich-otter-d17f60a780ba@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009-unsachlich-otter-d17f60a780ba@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Oct 09, 2024 at 04:19:47PM +0200, Christian Brauner wrote:
> On Wed, Oct 09, 2024 at 11:50:36AM GMT, Steven Price wrote:
> > On 07/10/2024 18:43, Al Viro wrote:
> > > ->close_on_exec[] state is maintained only for opened descriptors;
> > > as the result, anything that marks a descriptor opened has to
> > > set its cloexec state explicitly.
> > > 
> > > As the result, all calls of __set_open_fd() are followed by
> > > __set_close_on_exec(); might as well fold it into __set_open_fd()
> > > so that cloexec state is defined as soon as the descriptor is
> > > marked opened.
> > > 
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > ---
> > >  fs/file.c | 9 ++++-----
> > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/fs/file.c b/fs/file.c
> > > index d8fccd4796a9..b63294ed85ec 100644
> > > --- a/fs/file.c
> > > +++ b/fs/file.c
> > > @@ -248,12 +248,13 @@ static inline void __set_close_on_exec(unsigned int fd, struct fdtable *fdt,
> > >  	}
> > >  }
> > >  
> > > -static inline void __set_open_fd(unsigned int fd, struct fdtable *fdt)
> > > +static inline void __set_open_fd(unsigned int fd, struct fdtable *fdt, bool set)
> > >  {
> > >  	__set_bit(fd, fdt->open_fds);
> > >  	fd /= BITS_PER_LONG;
> > 
> > Here fd is being modified...
> > 
> > >  	if (!~fdt->open_fds[fd])
> > >  		__set_bit(fd, fdt->full_fds_bits);
> > > +	__set_close_on_exec(fd, fdt, set);
> > 
> > ... which means fd here isn't the same as the passed in value. So this
> > call to __set_close_on_exec affects a different fd to the expected one.

ACK.

> Good spot. Al, I folded the below fix so from my end you don't have to
> do anything unless you want to nitpick how to fix it. Local variable
> looked ugly to me.

Wait, folded it _where_?  And how did it end up pushed to -next in the
first place?

<checks vfs/vfs.git>

FWIW, I do have a problem with your variant.  My preferred incremental would be
simply to deal with close_on_exec bitmap between updating open_fds and full_fds_bits:

diff --git a/fs/file.c b/fs/file.c
index 70cd6d8c6257..7251d215048d 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -249,10 +249,10 @@ static inline void __set_close_on_exec(unsigned int fd, struct fdtable *fdt,
 static inline void __set_open_fd(unsigned int fd, struct fdtable *fdt, bool set)
 {
 	__set_bit(fd, fdt->open_fds);
+	__set_close_on_exec(fd, fdt, set);
 	fd /= BITS_PER_LONG;
 	if (!~fdt->open_fds[fd])
 		__set_bit(fd, fdt->full_fds_bits);
-	__set_close_on_exec(fd, fdt, set);
 }
 
 static inline void __clear_open_fd(unsigned int fd, struct fdtable *fdt)

