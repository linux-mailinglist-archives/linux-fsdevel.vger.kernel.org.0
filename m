Return-Path: <linux-fsdevel+bounces-26699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA2595B1B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 11:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4961C21166
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 09:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655A917C7C9;
	Thu, 22 Aug 2024 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFZxyCje"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3886175D51;
	Thu, 22 Aug 2024 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319105; cv=none; b=MVJXy6jTZj945ayCfuajr0R2TgaZqNLnqgKIcJ0/MH+V+73mC6ITsAz11tHextMxsn8Qw6A+JSFp4wXVjco8fdKM03rQ4Z2Bg0+5yGRhsl2LQ8l5+mHS+gAiRV3BF4/o+zyTPjXeX+ogY84vn92YIG6FPEjdSEdVUZp5K4iRxGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319105; c=relaxed/simple;
	bh=3x6waZzZjuxXbrx2LCK6ZgsqB/Sz+tWaR85KaEWKZro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMhUvMbMnsdR26FkI5ZbnTZF4XRq6GPDDdyNDcbb4d6Nd70b6MwxrP8ykamkEqvrIhav/zW4apOAnnzJDKHJ8Wbmp8GHCH0ad9EUpZzUt3sB8GVMSz/L7+2u1iImv0+yaMucwkyL0v9isLkZxLIy+dTkDwyc5GqK18BW2pYnC1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFZxyCje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C837C32782;
	Thu, 22 Aug 2024 09:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724319105;
	bh=3x6waZzZjuxXbrx2LCK6ZgsqB/Sz+tWaR85KaEWKZro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rFZxyCjeFHNi2ReXcYwrCRg0pl/S+TVgavLdAnEsNxO4OHONM8KFECwNth84fuFPa
	 LyNSG62sZp5tzLmUwrp3/lefGDcKAN+yEqsNFGNnX5MWCqnBgcazMxG1ds1RvDznte
	 ulm8mQ4Sc4ltWyfvPMBEUQ1RiT+VaHga5hDtA6ZuVK0C1B+5LSJmAZHM9l5FOmkdGz
	 Q4S+z30QNcdw/L7gMaiyrx6M2x063I5TkJCQyOzopDMOD8L6BFH0WOB/zQ083G/hQR
	 9dr1I23ogReegIs4aNs6n2Pul0mdiogBXJllkiXBrkl1WDLNoXPahLSbyf7Puta18g
	 FOevYGAnnmIUw==
Date: Thu, 22 Aug 2024 11:31:41 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Mateusz Guzik <mjguzik@gmail.com>, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] avoid extra path_get/path_put cycle in path_openat()
Message-ID: <20240822-notbremse-monitor-c8b88eb60fd2@brauner>
References: <20240807070552.GW5334@ZenIV>
 <CAGudoHGMF=nt=Dr+0UDVOsd4nfGRr4xC8=oeQqs=Av9s0tXXXA@mail.gmail.com>
 <20240807075218.GX5334@ZenIV>
 <CAGudoHE1dPb4m=FsTPeMBiqittNOmFrD-fJv9CmX8Nx8_=njcQ@mail.gmail.com>
 <CAGudoHFm07iqjhagt-SRFcWsnjqzOtVD4bQC86sKBFEFQRt3kA@mail.gmail.com>
 <20240807124348.GY5334@ZenIV>
 <20240807203814.GA5334@ZenIV>
 <CAGudoHHF-j5kLQpbkaFUUJYLKZiMcUUOFMW1sRtx9Y=O9WC4qw@mail.gmail.com>
 <20240822003359.GO504335@ZenIV>
 <20240822004149.GR504335@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240822004149.GR504335@ZenIV>

On Thu, Aug 22, 2024 at 01:41:49AM GMT, Al Viro wrote:
> Once we'd opened the file, nd->path and file->f_path have the
> same contents.  Rather than having both pinned and nd->path
> dropped by terminate_walk(), let's have them share the
> references from the moment when FMODE_OPENED is set and
> clear nd->path just before the terminate_walk() in such case.
> 
> To do that, we
> 	* add a variant of vfs_open() that does *not* do conditional
> path_get() (vfs_open_borrow()); use it in do_open().
> 	* don't grab f->f_path.mnt in finish_open() - only
> f->f_path.dentry.  Have atomic_open() drop the child dentry
> in FMODE_OPENED case and return f->path.dentry without grabbing it.
> 	* adjust vfs_tmpfile() for finish_open() change (it
> is called from ->tmpfile() instances).
> 	* make do_o_path() use vfs_open_borrow(), collapse path_put()
> there with the conditional path_get() we would've get in vfs_open().
> 	* in FMODE_OPENED case clear nd->path before calling
> terminate_walk().
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

