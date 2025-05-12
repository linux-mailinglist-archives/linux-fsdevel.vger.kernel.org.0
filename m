Return-Path: <linux-fsdevel+bounces-48718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A502AB32E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 11:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19DE73B4321
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 09:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0346B25B1FE;
	Mon, 12 May 2025 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFzoTjAp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60193134AC;
	Mon, 12 May 2025 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041450; cv=none; b=mN+8oor7HXSRcXJzbbxEZyvGwPjO09FkruP95DkS1qkS0YfnrjAicR6+vzEW2/WaFWgEgRL9NEndAeEQkUuK6LMQQqVHw8eKMP/tCyzt8elVgUinWmTir3KOaQipCVMNNQ1xkYYlnK4JUk+E8BE60H+Z82ACSkQLqqfFh0AWLSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041450; c=relaxed/simple;
	bh=tKpkfqx6qRN5Wcr5HBpyc6XUw8BanQZYdJPgy/M4NyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZtRlgf4RBDIBXe2eBqyPKaBYTE8mK88ii47itCELsGBwsgwVEtUEi5U5sqlAoj8zoLeNmyN3aaHu5VMfMtzmkvEKk4kz+u+a7CjMkVXLZVUNxEHsyoeO51OEfgxQBa5dP+wuF2rHkE6v4uHVyCWxNt/xfBV2J85drsX/mzzj1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFzoTjAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3561C4CEE7;
	Mon, 12 May 2025 09:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747041450;
	bh=tKpkfqx6qRN5Wcr5HBpyc6XUw8BanQZYdJPgy/M4NyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oFzoTjApCxzaGhQR1OWV25KiMaXERC+LZIQ/gSdvKX+Zoej28KxaD4ttZeKvOdoQ0
	 Zqe8aT5UVWOt6UIDP0sM0K2Zj/msAPrM+6HNYSI2eOLX75yuTRKffHHSpNXngGYByi
	 EKGQ6LCpl6rPhYrYpyREhHWfXJY5FKz8VHKVE66uo/Licee5dihIUs8AmAP/dgFwIb
	 sXLHWC52eHleaGBlzhDvfLvuFKarh9E0mP++/ASDd89+BbDTMD0I+JnWjysjV2nVMH
	 mkfKXqKM2HKaO4ADYe1UBo6Ra4jPrX7Q9G9NiwdIPg6w7eMBQ44H6dE5xmMbsDN5ZV
	 ZlIkAme/QZJeg==
Date: Mon, 12 May 2025 11:17:26 +0200
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] fs: fuse: add backing_files control file
Message-ID: <20250512-opern-fachrichtung-43a999b903f6@brauner>
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
 <20250509-fusectl-backing-files-v3-2-393761f9b683@uniontech.com>
 <CAJfpegvhZ8Pts5EJDU0efcdHRZk39mcHxmVCNGvKXTZBG63k6g@mail.gmail.com>
 <CAC1kPDPeQbvnZnsqeYc5igT3cX=CjLGFCda1VJE2DYPaTULMFg@mail.gmail.com>
 <CAJfpegsTfUQ53hmnm7192-4ywLmXDLLwjV01tjCK7PVEqtE=yw@mail.gmail.com>
 <CAC1kPDPWag5oaZH62YbF8c=g7dK2_AbFfYMK7EzgcegDHL829Q@mail.gmail.com>
 <CAJfpegu59imrvXSbkPYOSkn0k_FrE6nAK1JYWO2Gg==Ozk9KSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegu59imrvXSbkPYOSkn0k_FrE6nAK1JYWO2Gg==Ozk9KSg@mail.gmail.com>

On Mon, May 12, 2025 at 10:27:19AM +0200, Miklos Szeredi wrote:
> On Sun, 11 May 2025 at 11:56, Chen Linxuan <chenlinxuan@uniontech.com> wrote:
> 
> > I noticed that the current extended attribute names already use the
> > namespace.value format.
> > Perhaps we could reuse this naming scheme and extend it to support
> > features like nested namespaces.
> 
> Right.  Here's a link to an old and long thread about this:
> 
>    https://lore.kernel.org/all/YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com/#r
> 
> >
> > For instance, in a situation like this:
> >
> > A fixed file 0 in an io_uring is a FUSE fd.
> > This FUSE fd belongs to FUSE connection 64.
> > This FUSE fd has a backing file.
> > This backing file is actually provided by mnt_id=36.
> >
> > Running getfattr -m '-' /proc/path/to/the/io_uring/fd could return
> > something like:
> >
> > io_uring.fixed_files.0.fuse.conn="64"
> > io_uring.fixed_files.0.fuse.backing_file.mnt_id="36"
> > io_uring.fixed_files.0.fuse.backing_file.path="/path/to/real/file"
> 
> Yeah, except listxattr wouldn't be able to properly work in such
> cases: it lacks support for hierarchy.
> 
> The proposed solution was something like making getxattr on the
> "directory" return a listing of child object names.
> 
> I.e. getxattr("/proc/123/fd/12", "io_uring.fixed_files.") would return
> the list of instantiated fixed file slots, etc...

Sorry, I'm still very much opposed to using the xattr interface for
this. It is as ugly as it can get and it is outright broken in various
ways. And I don't want it used for more stuff in the future especially
for VFS related information such as this.

