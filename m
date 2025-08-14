Return-Path: <linux-fsdevel+bounces-57922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA39B26CE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 18:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35EB45C5C5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 16:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951251F30BB;
	Thu, 14 Aug 2025 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcfcYLbh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B601E8342
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755189941; cv=none; b=rPDDOjKI5ggTyaRFwneea19eA7fLeBC+PWhMfFd8veFMLA1f05PjUab+9ZAYafMG5pvK8D6XUL2+Am29HCbeDF9C5tolXXK6WSSpgkkIUPSgci9uh1T3bbvIwPHJ9ugqiP4gB9x0aFxFgUYEhhODrb+ZFzQJ6PfYS0G+zPE3vOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755189941; c=relaxed/simple;
	bh=qcfsNL9EP4ykYBBjQ1yXIkkr3YpvHskW39setDCrx18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TREv6Oh+n8eTgKsCNqzDf8xjk/tVdzZMPVeKYKx7QWMPgT+w+6I4iwQYO80+MXx6zCSX32pOKxulJvsgdWDJFHAGDlBE2v/4a/t/ZFrGkAOqHn10qxWpyB2FkQP6D+MlCMCTHgDStpKmnLnmLfQlHxhdbCEdBwwG/JYz/8UBKao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcfcYLbh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9C6C4CEED;
	Thu, 14 Aug 2025 16:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755189940;
	bh=qcfsNL9EP4ykYBBjQ1yXIkkr3YpvHskW39setDCrx18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OcfcYLbhmUSTWmfynTfHA+r5Ua0r01jayryvDk96t0hfZbHhXEblczAyrEm44lnOQ
	 DLGigqFlb7dMdAbYS2AhaqD8+oe3/TGDtPZ5J625T32MOkpv/0FXajSOERtY+RytJH
	 B9TYs8JYPt4ztOv/RvTfmk1lLexvwfb+MOBQFG+j28AIO7oCWYQaiPeGLMDh6Z6qbb
	 17P6VEfrSWNeGZA+2ph0nNFkdNC8BT/z507neSHB37tfluYUXpSqRGtWvL7OyG9IoV
	 SG9Prt1v1CmXqONpH4X9srxxhmfwESJ1oOPO0YPLvvCTgIvN1u7UeP4ljTOVpZh71o
	 NkhMjVSBzmTjg==
Date: Thu, 14 Aug 2025 09:45:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2] fuse: keep inode->i_blkbits constant
Message-ID: <20250814164539.GP7942@frogsfrogsfrogs>
References: <20250807175015.515192-1-joannelkoong@gmail.com>
 <CAJfpeguCOxeVX88_zPd1hqziB_C+tmfuDhZP5qO2nKmnb-dTUA@mail.gmail.com>
 <20250812195922.GL7942@frogsfrogsfrogs>
 <CAJnrk1Zt9XoD2sPYGzFQwKsCHo_ityZ-4XzU_2Vii3g=w89bQg@mail.gmail.com>
 <CAJfpeguN_Be4q0jxoS28zpd4Y8Ye6kqMhspAvJ=tuba97dPVVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguN_Be4q0jxoS28zpd4Y8Ye6kqMhspAvJ=tuba97dPVVg@mail.gmail.com>

On Wed, Aug 13, 2025 at 10:24:36AM +0200, Miklos Szeredi wrote:
> On Tue, 12 Aug 2025 at 22:44, Joanne Koong <joannelkoong@gmail.com> wrote:
> 
> > My understanding is that it's because in that path it uses cached stat
> > values instead of fetching with another statx call to the server so it
> > has to reflect the blocksize the server previously set. It took me a
> > while to realize that the blocksize the server reports to the client
> > is unrelated to whatever blocksize the kernel internally uses for the
> > inode since the kernel doesn't do any block i/o for fuse; the commit
> > message in commit 0e9663ee452ff ("fuse: add blksize field to
> > fuse_attr") says the blocksize attribute is if "the filesystem might
> > want to give a hint to the app about the optimal I/O size".
> 
> Right, that's what POSIX says:
> 
>   st_blksize A file system-specific preferred I/O block size for
>                        this object. In some file system types, this may
>                        vary from file to file.

Ahahaha yes, I forgot about that.  Regular filesystems can set i_blkbits
to whatever granularity they want and it persists until eviction, and if
they want to trick userspace they set st_blksize to something else.
Kind of like how XFS rounds that up to PAGE_SIZE for 1k fsblock
filesystems.

Now I see what Joanne meant about it taking a while to wrap her head
around i_blkbits vs. st_blksize.  Thanks for pointing that out. :)

--D

> Thanks,
> Miklos
> 

