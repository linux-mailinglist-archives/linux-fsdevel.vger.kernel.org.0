Return-Path: <linux-fsdevel+bounces-21806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AF490A89B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 10:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86D68B269E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 08:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6E6190495;
	Mon, 17 Jun 2024 08:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKoFe/lH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F3217F5;
	Mon, 17 Jun 2024 08:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718613369; cv=none; b=YsmbzaVkGOcIGNisltqZ26sS7p8GiM68RlupU9WpmBOib6KmAsyXCzK2XafGOriaV6xdCVAXDRESTwYME+WARJ7lMPkJHWyahgWD7Cw1iqXhfUBvkvipw5WWtSE2jaqBkrE9RdQO02vQTT2xsXxZ/x/gAgRzMLnqNvzpMKLaYzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718613369; c=relaxed/simple;
	bh=9jyWMGRWMj9G+mk7F+0rQr6uUQhCUnSicEx/ifXv5C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhSaZ9B3zLo661533CibQKleRI0IFKuFA5cV63RKl5ZaO3FPvj3IlFtRblYXYCuk/XUm/DmvoiFS4UmxiCGhKFd4hRAaZUk+IbFmaSbHdlDm30z1CUJuk047XXCbgLBjKQXtVu98tvrQJ9Un//awKNZUqb6O/976Wj7DD6edyFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKoFe/lH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F632C2BD10;
	Mon, 17 Jun 2024 08:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718613369;
	bh=9jyWMGRWMj9G+mk7F+0rQr6uUQhCUnSicEx/ifXv5C4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QKoFe/lH1k3aO8/8yl25uPsa8M8UZGdTu7knUGJ0GbtTGYamJB5G94J6fxGsEUoI+
	 pJ8g/sFxRPu5paUS4dUCERvREP5OKXxITuYnS6pwBe8v4z5mHd8LFKVH6yyvGJC6s2
	 POk9CnYcEMSGwX+w1fd33tPuMlmgJ9lboVpZ2/0OrF0KmaflYTmSoYu/r+jAjTJzxn
	 I2e0TI3ul5xKRMavw0cVYZ4PXyCS6yB/4S+q+Y23aYz8Wg7Fi/H5C5hJzNhmDOxq68
	 CaLat7T7uqYJcskWXFdGTU4r1jMxqrB/xRbRpkrtwyXqUipukzqApyMYFXcut3na+H
	 aqw5fV/JJJjnw==
Date: Mon, 17 Jun 2024 10:36:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Yu Ma <yu.ma@intel.com>, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, tim.c.chen@linux.intel.com, 
	tim.c.chen@intel.com, pan.deng@intel.com, tianyou.li@intel.com
Subject: Re: [PATCH 3/3] fs/file.c: move sanity_check from alloc_fd() to
 put_unused_fd()
Message-ID: <20240617-notieren-prolog-a4f95ec73f23@brauner>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240614163416.728752-4-yu.ma@intel.com>
 <fejwlhtbqifb5kvcmilqjqbojf3shfzoiwexc3ucmhhtgyfboy@dm4ddkwmpm5i>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fejwlhtbqifb5kvcmilqjqbojf3shfzoiwexc3ucmhhtgyfboy@dm4ddkwmpm5i>

On Sat, Jun 15, 2024 at 06:41:45AM GMT, Mateusz Guzik wrote:
> On Fri, Jun 14, 2024 at 12:34:16PM -0400, Yu Ma wrote:
> > alloc_fd() has a sanity check inside to make sure the FILE object mapping to the
> 
> Total nitpick: FILE is the libc thing, I would refer to it as 'struct
> file'. See below for the actual point.
> 
> > Combined with patch 1 and 2 in series, pts/blogbench-1.1.0 read improved by
> > 32%, write improved by 15% on Intel ICX 160 cores configuration with v6.8-rc6.
> > 
> > Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> > Signed-off-by: Yu Ma <yu.ma@intel.com>
> > ---
> >  fs/file.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/file.c b/fs/file.c
> > index a0e94a178c0b..59d62909e2e3 100644
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -548,13 +548,6 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
> >  	else
> >  		__clear_close_on_exec(fd, fdt);
> >  	error = fd;
> > -#if 1
> > -	/* Sanity check */
> > -	if (rcu_access_pointer(fdt->fd[fd]) != NULL) {
> > -		printk(KERN_WARNING "alloc_fd: slot %d not NULL!\n", fd);
> > -		rcu_assign_pointer(fdt->fd[fd], NULL);
> > -	}
> > -#endif
> >  
> 
> I was going to ask when was the last time anyone seen this fire and
> suggest getting rid of it if enough time(tm) passed. Turns out it does
> show up sometimes, latest result I found is 2017 vintage:
> https://groups.google.com/g/syzkaller-bugs/c/jfQ7upCDf9s/m/RQjhDrZ7AQAJ
> 
> So you are moving this to another locked area, but one which does not
> execute in the benchmark?
> 
> Patch 2/3 states 28% read and 14% write increase, this commit message
> claims it goes up to 32% and 15% respectively -- pretty big. I presume
> this has to do with bouncing a line containing the fd.
> 
> I would argue moving this check elsewhere is about as good as removing
> it altogether, but that's for the vfs overlords to decide.

This all dates back to 9d11a5176cc5 ("I just put a pre-90 on
ftp.kernel.org, and I'm happy to report that Davem")
which is pre-git. I think removing is fine.

