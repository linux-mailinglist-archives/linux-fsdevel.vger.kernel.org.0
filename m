Return-Path: <linux-fsdevel+bounces-31046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC3C9913CA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 03:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FD65B21741
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 01:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BCD101EE;
	Sat,  5 Oct 2024 01:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="c8X5wINp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BC67482;
	Sat,  5 Oct 2024 01:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728092126; cv=none; b=rcP9gWyOk6ero6j9JkHCeUnd0Lv5nH9LcWEpdqg62SeqJQC6N0Ws0brAYzj2VQo+7E4VONTZZBrAovQ8dqvz8UJw95v8+pEmxRhucA53uIHHyLExHqmgm7WspNE0PPCa0cEhQhDA7hAi5Lm9tmsyck5jna875W3ZSZGHCKwCvk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728092126; c=relaxed/simple;
	bh=EHdWcm8PClN0u3WMfScJEzmG8AU+I1qQWoUwfyl1+yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJyyx3cG9dNzVJZhdxN2gkRfgCPMHczqHKvPiJjODZAbKFFd9l+BTu8epJM9WVfet6QtlhkeflKX1m/YSIJSonWTQFuAYVpFCOUGwLcWmd9UjBOCRA5ZYk3IdnZpFpETP6c5hkkr8IFHf0JXQOZ7Hnuc0WjnuS91/PJYd3bJLwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=c8X5wINp; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KFWcWe3gm12vm93LlQ/j4L01EqcwwfGrdZkEdcQ1eqo=; b=c8X5wINppLTtEjO+mrssiKfIJC
	Lurp42gcPoBAh3Ho+qaAaICV8h7vqI2S33maDTRDGUhvobmLlNQj9IyybqV1IRY/qxnvgLcdeWdu1
	kYlBVtZXBqpwbR3USJTm+d6BHzb2P4peC5XE9MlRaUr+/llE7q1VhVKRpZ1xeQOcoCKW+2+/5REHs
	8ydd9zFIukKH2AYzBfikaBVr3xsGwhFCTEW2+Iu7bCudUOge3X/rRdlVdDJzbRwZoXu066EEH5+5x
	t3Gqhx6TfzDGSOhIolmRZv3YIHb3IeIQYvg4qe+gxIsIGhwUT6QqEEz0JKuXwQg12443qV3Bp4UxZ
	Yx9XxfYw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swthZ-00000000wEO-0nJt;
	Sat, 05 Oct 2024 01:35:21 +0000
Date: Sat, 5 Oct 2024 02:35:21 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 1/4] ovl: do not open non-data lower file for fsync
Message-ID: <20241005013521.GV4017910@ZenIV>
References: <20241004102342.179434-1-amir73il@gmail.com>
 <20241004102342.179434-2-amir73il@gmail.com>
 <20241004221625.GR4017910@ZenIV>
 <20241004222811.GU4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004222811.GU4017910@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Oct 04, 2024 at 11:28:11PM +0100, Al Viro wrote:
> >         /*
> >          * Overlay file f_pos is the master copy that is preserved
> >          * through copy up and modified on read/write, but only real
> >          * fs knows how to SEEK_HOLE/SEEK_DATA and real fs may impose
> >          * limitations that are more strict than ->s_maxbytes for specific
> >          * files, so we use the real file to perform seeks.
> >          */
> >         ovl_inode_lock(inode);
> >         fd_file(real)->f_pos = file->f_pos;
> > in ovl_llseek()?  Get ovl_real_fdget_meta() called by ovl_real_fdget() and
> > have it return 0 with NULL in fd_file(real), and you've got an oops right
> > there, don't you?
> 
> I see... so you rely upon that thing never happening when the last argument of
> ovl_real_fdget_meta() is false, including the call from ovl_real_fdget().
> 
> I still don't like the calling conventions, TBH.  Let me think a bit...

Sorry, I'm afraid I'll have to leave that until tomorrow - over 38C after the sodding
shingles shot really screws the ability to dig through the code ;-/  My apologies...

