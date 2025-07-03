Return-Path: <linux-fsdevel+bounces-53788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DA7AF7299
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 13:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9033C1C845B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 11:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75322E3380;
	Thu,  3 Jul 2025 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PcWAM3Be"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A01B2D4B68
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 11:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542682; cv=none; b=cAVjWDN4o3hfwUB8ApFUQ8px8fq6wyVoyNBCf/VE2WE0YqXEZqitRCvtVAN27GIzOyZCI8HPZa5nAPdOFrFjlIUHd5tXVWHCQ9X47JysT8ol3ooxYxyi3jipxkt0HrCalLMA3cHNqw2+5vAsotjqDc5w8eu7OXqcX9yYUgnh1OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542682; c=relaxed/simple;
	bh=MkhGLruOucZARLsZikLDanvBS9WnavvoCIx5cJdjPfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XA7nDmlsb/R7Po4XQyjXiYgAJXRlxR+h+7y7qkeST7njpkyaJgIGuvsGx4hO4VilbzpZgFEwt6InkVMLczoIeH/ha1Q+jlEUCbdybk+GpM9nBlk70AdB9MsKawK97p/IqhTqTVQ+dFfEYYYLiJgF/WbUz3Y9QKU4CmkBQ5+Ri3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PcWAM3Be; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C45EC4CEE3;
	Thu,  3 Jul 2025 11:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751542681;
	bh=MkhGLruOucZARLsZikLDanvBS9WnavvoCIx5cJdjPfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PcWAM3Be2WoNu0WAmoGdLtqP6ompjjjZfeGtwPUQA4PnstwjjkdcWCF2GRgbmCUGl
	 hMUIUckg6g8/d+aXGWFglR0Yoj++ajBQ8KSDnvf6NAQ5n7PYctaWeVU/0ktDNhDrxa
	 1dhHaUVwWJEPBeT7fLD/cj2lFzJMl0c8MXA7YQ6U=
Date: Thu, 3 Jul 2025 13:37:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: (subset) [PATCH 01/11] zynqmp: don't bother with
 debugfs_file_{get,put}() in proxied fops
Message-ID: <2025070316-curled-villain-c282@gregkh>
References: <20250702211305.GE1880847@ZenIV>
 <20250702211408.GA3406663@ZenIV>
 <175149835231.467027.7368105747282893229.b4-ty@kernel.dk>
 <20250703002329.GF1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703002329.GF1880847@ZenIV>

On Thu, Jul 03, 2025 at 01:23:29AM +0100, Al Viro wrote:
> On Wed, Jul 02, 2025 at 05:19:12PM -0600, Jens Axboe wrote:
> > 
> > On Wed, 02 Jul 2025 22:14:08 +0100, Al Viro wrote:
> > > When debugfs file has been created by debugfs_create_file_unsafe(),
> > > we do need the file_operations methods to use debugfs_file_{get,put}()
> > > to prevent concurrent removal; for files created by debugfs_create_file()
> > > that is done in the wrappers that call underlying methods, so there's
> > > no point whatsoever duplicating that in the underlying methods themselves.
> > > 
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [10/11] blk-mq-debugfs: use debugfs_get_aux()
> >         commit: c25885fc939f29200cccb58ffdb920a91ec62647
> 
> Umm...  That sucker depends upon the previous commit - you'll
> need to cast debugfs_get_aux() result to void * without that...

Wait, what "previous commit" this is patch 01/11 of the series?

I'm all for you just taking this through your trees if it depends on
something else that is there, but that wasn't obvious, sorry.

greg k-h

