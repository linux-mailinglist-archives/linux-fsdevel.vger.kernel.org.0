Return-Path: <linux-fsdevel+bounces-49924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C4CAC59E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 20:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0FD8A6ACD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 18:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9219B280A4C;
	Tue, 27 May 2025 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sYKdcmr0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F60280CD4
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748369296; cv=none; b=R2ka7BnP4bC2sDgydkqW2bhXZHHoepbdxKwu0N9BlyWk2vkTS4V5SNUH9fwQV4bO9EuyxuhGIVBC3phMvUeUvJXkzyVI/zEzynwBW2aV68kIHtAYIyXSsCphINqqIr90ek1oCit4wVXa2ocgckxTYWQ9ZFS3GLr6gDRVL0wUQ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748369296; c=relaxed/simple;
	bh=HbElYLoFkFt3bgE5hxTKRqIyGxalzkZDf2uQCmjqIEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGQJM+d7gpzIYh812g9hnnyvCbc2aFiYBl64YwUtpPfLJyyh3oCJUGErrSLgFiAjcBtBXLroJdzR0NaFiroQlpjADG9bm0Rb/a4u0HrTZnK9AHMi3S/PrWkCAp9sgv3a6+3G2dDooc3UxByD+7GDUQZraLOmOrG8EhhmNIIMHi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sYKdcmr0; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 May 2025 14:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748369281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8HeOozcGNaa2tPH1dR1aA8qPPlh+Dn6iJT+v2aaUGXs=;
	b=sYKdcmr0J3kp5BJBtqgzeTLg3Y8X5DulTvO/F2r6k+DESUh4YX0sTFJbA6W+nwoOmfEpi8
	QY1gMq3OPsFampzDZxzn1XfkxteHIhtPHzPnrLOhC18aXYctBQX8oT1a2yqqiqY2E/K/zW
	e8OYyW2enKmeom0IfpirEeWm7oRcZDA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/6] overlayfs + casefolding
Message-ID: <oa6rl677vm3x4gl3jym4bh6ul56d5d6olrkylqpjnsnjbjxf5p@4pxem7egakqe>
References: <CAOQ4uxg9sKC_8PLARkN6aB3E_U62_S3kfnBuRbAvho9BNzGAsQ@mail.gmail.com>
 <rkbkjp7xvefmtutkwtltyd6xch2pbw47x5czx6ctldemus2bvj@2ukfdmtfjjbw>
 <CAOQ4uxgOM83u1SOd4zxpDmWFsGvrgqErKRwea=85_drpF6WESA@mail.gmail.com>
 <q6o6jrgwpdt67xsztsqjmewt66kjv6btyayazk7zlk4zjoww4n@2zzowgibx5ka>
 <CAOQ4uxisCFNuHtSJoP19525BDdfeN2ukehj_-7PxepSTDOte9w@mail.gmail.com>
 <CAOQ4uxhnOMPTBd+k4UVPvAWYLhJWOdV4FbyKa_+a=cqK9Chr2A@mail.gmail.com>
 <ltzdzvmycohkgvmr3bd6f2ve4a4faxuvkav3d7wt2zoo5gkote@47o5yfse2mzn>
 <CAOQ4uxjHb4B1YL2hSMHxd2Y0mMmfpHMzgbHO5wLF3=rMVxsHyQ@mail.gmail.com>
 <yp4whk37id7s4za6fv3ifvqjupo6ikylu34wvgd3ytbyu3uz2c@t7h3ncg6pwtz>
 <CAOQ4uxg0-ZJYDMfMLNVm=YfA9CdjY2WaaXYdv+i8nWNgqPgpuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxg0-ZJYDMfMLNVm=YfA9CdjY2WaaXYdv+i8nWNgqPgpuw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, May 27, 2025 at 10:57:05AM +0200, Amir Goldstein wrote:
> On Sun, May 25, 2025 at 8:27 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Sat, May 24, 2025 at 03:01:44PM +0200, Amir Goldstein wrote:
> > > On Fri, May 23, 2025 at 11:10 PM Kent Overstreet
> > > <kent.overstreet@linux.dev> wrote:
> > > >
> > > > On Fri, May 23, 2025 at 10:30:16PM +0200, Amir Goldstein wrote:
> > > >
> > > > That makes fstests generic/631 pass.
> > >
> > > Yes, that is not very surprising.
> > > I meant if you could help test that:
> > >
> > > 1. mounting case folder upperdir/lowerdir fails
> > > 2. lookup a case folder subdir fails
> > > 3. lookup in a dir that was empty and became case folder while ovl was
> > > mounted fails
> > >
> > > For me, I do not have any setup with case folding subtrees
> > > so testing those use cases would take me time and
> > > I think that you must have tested all those scenarios with your patch set?
> > > and maybe already have some fstests for them?
> >
> > Unmount fauls after I test an overlayfs with a casefold subdir:
> >
> > Testing an overlayfs on a casefold fs with non-casefolded dirs
> > Test using casefolded dir - should fail
> > overlayfs: failed to resolve '/mnt/casefold': -2
> > mount: /mnt/merged: special device overlay does not exist.
> >        dmesg(1) may have more information after failed mount system call.
> 
> Test is using the wrong path:
> 
> 
> +    echo "Test using casefolded dir - should fail"
> +    ! mount -t overlay -o
> lowerdir=/mnt/lower,upperdir=/mnt/upper,workdir=/mnt/work overlay
> /mnt/merged
> +    ! mount -t overlay -o
> lowerdir=/mnt/casefold,upperdir=/mnt/casefold,workdir=/mnt/work
> overlay /mnt/merged
> 
> There is no "/mnt/casefold"

*nod*

> > Test using a dir with a casefold subdir - should mount
> > overlayfs: upperdir is in-use as upperdir/workdir of another mount, accessing files from both mounts will result in undefined behavior.
> > overlayfs: workdir is in-use as upperdir/workdir of another mount, accessing files from both mounts will result in undefined behavior.
> 
> Those warnings are because you have a stray mount command above:
> +    echo "Test using casefolded dir - should fail"
> +    ! mount -t overlay -o
> lowerdir=/mnt/lower,upperdir=/mnt/upper,workdir=/mnt/work overlay
> /mnt/merged
> 
> So a mount already exists. leftover?

*snort* - -ENOCAFFEINE, I presume.

The new warning doesn't fire after the last mount.

ls: cannot access '/mnt/merged/casefold': Object is remote

But nothing in dmesg. Adding a printk to ovl_mount_dir_check() shows
that it's never called for the 'ls /mnt/merged/casefold' call.

