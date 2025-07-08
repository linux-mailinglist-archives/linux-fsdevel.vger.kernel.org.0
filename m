Return-Path: <linux-fsdevel+bounces-54225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D05AFC439
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 09:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35278171517
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 07:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD253298CCD;
	Tue,  8 Jul 2025 07:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZwL65+u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323D721A428;
	Tue,  8 Jul 2025 07:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960294; cv=none; b=HsFCVe3sZNn1zTqMLEUXZ9tU7dO+VmKXTy8um7ZAHH4BCw/suaDsodM25ueNHML0HyhHSxPgXUr/XKUMpX11u1rosAHpBD/aYTInZS1mBYq/J8D47wV3vJcyl6DyKKQK0Ld1/8gnGjRoCDhD9fZPoHe3DY6finaaaA2nf4Xl6R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960294; c=relaxed/simple;
	bh=UYi0NzDcV9SBdoEkVAoH+UjBMnrLDiE5bGNgW1hW058=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0D5BK7zYgfc8Fcj8oris/qvor7hOvomL0IQGOogeNMT7t6ZNgypGTFA8UFTLvyK+rfOWfImYj8J+7z+NVZ3rhdqNr4W+MIc5xnm0jkD9Qgrm9EH+MBdOJHr+a16pt9K9hCRVRdb9b72oYuGJdnOyFen5fwyw9cQeSYGw0epv2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZwL65+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1FAC4CEED;
	Tue,  8 Jul 2025 07:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751960293;
	bh=UYi0NzDcV9SBdoEkVAoH+UjBMnrLDiE5bGNgW1hW058=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LZwL65+uxin3bwR7v/pHJGQjKLQhEqdy4PkxqedaENuEFFiVy5caUb1SKHGPdC4nD
	 5fdT0D0BAVU5ETH4EgELBbndk71dF8h1fuNLmDgLMPNl3HdbGAMNUnKMYy4eHYv3La
	 /jJVVwnp+jusmnFenLTJkhvzzQH3Ze5PT5mDaOOhDaLCqdqCHFZNDr2MmGvOPAxpfq
	 FGi13nYdblnSk9pB3EXPpvmJUTfQvnUE3BrI19QNnoei5o6DwF5b1UFaeirBff6Wcr
	 bEXwZHa015BVN05eYpysXcYFIAQcKk7YFyncU09qsdGrPdJfsmrBzG6p2JkDzDD2gv
	 5T248/fdleu9g==
Date: Tue, 8 Jul 2025 09:38:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>, 
	syzbot <syzbot+3de83a9efcca3f0412ee@syzkaller.appspotmail.com>, jack@suse.cz, kees@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, 
	Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] secretmem: use SB_I_NOEXEC
Message-ID: <20250708-wegrand-jungpflanze-a5940464908f@brauner>
References: <20250707-tusche-umlaufen-6e96566552d6@brauner>
 <20250707-heimlaufen-hebamme-d6164bdc5f30@brauner>
 <20250707171735.GE1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250707171735.GE1880847@ZenIV>

On Mon, Jul 07, 2025 at 06:17:35PM +0100, Al Viro wrote:
> On Mon, Jul 07, 2025 at 02:10:36PM +0200, Christian Brauner wrote:
> 
> >  static int secretmem_init_fs_context(struct fs_context *fc)
> >  {
> > -	return init_pseudo(fc, SECRETMEM_MAGIC) ? 0 : -ENOMEM;
> > +	struct pseudo_fs_context *ctx;
> > +
> > +	ctx = init_pseudo(fc, SECRETMEM_MAGIC);
> > +	if (!ctx)
> > +		return -ENOMEM;
> > +
> > +	fc->s_iflags |= SB_I_NOEXEC;
> > +	fc->s_iflags |= SB_I_NODEV;
> > +	return 0;
> >  }
> 
> What's the point of doing that *after* init_pseudo()?  IOW, why not simply
> 
> static int secretmem_init_fs_context(struct fs_context *fc)
> {
> 	fc->s_iflags |= SB_I_NOEXEC;
> 	fc->s_iflags |= SB_I_NODEV;
> 	return init_pseudo(fc, SECRETMEM_MAGIC) ? 0 : -ENOMEM;
> }
> 
> seeing that init_pseudo() won't undo those?

Seemed cleaner to do it the other way around and get rid of the ? while
at it. I don't think it matters either way.

