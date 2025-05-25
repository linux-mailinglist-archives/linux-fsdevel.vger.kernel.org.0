Return-Path: <linux-fsdevel+bounces-49824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 638CAAC363B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 20:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F318B1890579
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 18:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F5B24A058;
	Sun, 25 May 2025 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VTNeKpGh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2E62AD0F
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 May 2025 18:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748197652; cv=none; b=guOaIynNOoG+cS+uLRddyWIVuRDPnzBGvhRx4eXvokmA+A1fZo0EcLW2rUmTB0d4ucHw6l3+Cd6hLtUOCj5ZZGp8N+w/65tYwLw8XkFMWhvREJqlV24O94Uq47wa9CBKPKDWWhBkZIbgvc8AwLxfZvvrQbn+/5z0tPxYYU5XLmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748197652; c=relaxed/simple;
	bh=TBhcQpxz7HNWq/7nVSc0J8oZeSxGOWx2e0bMvNvC1HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBlnBTSlx+Jk0ovDVXDDIjocJz29d85kNS725RSKCpKMoUktm0zWGeayrIey7gyuc/PKkWHERZp39Tq4Oe8wXlZxXip0DObbw3BjvIo0obFCoxlmceRaKBLvOd+auRQs7wCFAqWVUQ0/9Z2M6BlB1AgYeIlVaPLBXRPXByOFW9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VTNeKpGh; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 25 May 2025 14:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748197647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DaNkSQWN9L/rebLJrHsK3RAWcKyWAZuOCXXaHlmCli0=;
	b=VTNeKpGh5eZO4me4KEGZzpIp8ytJoyo6F5H4MqwexcUq02SKnpJUElSU/3u7zgzQQ5hkBZ
	fC82w0rkkTiFsomzKAlzTJNheLV3DKuF66JEobgeJAXDINsq7iq3RfOP549KTp/1pQK2e9
	W0IErYHlmCIIoHzW2msPGdx8hIwBJ0E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/6] overlayfs + casefolding
Message-ID: <yp4whk37id7s4za6fv3ifvqjupo6ikylu34wvgd3ytbyu3uz2c@t7h3ncg6pwtz>
References: <CAOQ4uxjUC=1MinjDCOfY5t89N3ga6msLmpVXL1p23qdQax6fSg@mail.gmail.com>
 <gdvg6zswvq4zjzo6vntggoacrgxxh33zmejo72yusp7aqkqzic@kaibexik7lvh>
 <CAOQ4uxg9sKC_8PLARkN6aB3E_U62_S3kfnBuRbAvho9BNzGAsQ@mail.gmail.com>
 <rkbkjp7xvefmtutkwtltyd6xch2pbw47x5czx6ctldemus2bvj@2ukfdmtfjjbw>
 <CAOQ4uxgOM83u1SOd4zxpDmWFsGvrgqErKRwea=85_drpF6WESA@mail.gmail.com>
 <q6o6jrgwpdt67xsztsqjmewt66kjv6btyayazk7zlk4zjoww4n@2zzowgibx5ka>
 <CAOQ4uxisCFNuHtSJoP19525BDdfeN2ukehj_-7PxepSTDOte9w@mail.gmail.com>
 <CAOQ4uxhnOMPTBd+k4UVPvAWYLhJWOdV4FbyKa_+a=cqK9Chr2A@mail.gmail.com>
 <ltzdzvmycohkgvmr3bd6f2ve4a4faxuvkav3d7wt2zoo5gkote@47o5yfse2mzn>
 <CAOQ4uxjHb4B1YL2hSMHxd2Y0mMmfpHMzgbHO5wLF3=rMVxsHyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjHb4B1YL2hSMHxd2Y0mMmfpHMzgbHO5wLF3=rMVxsHyQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, May 24, 2025 at 03:01:44PM +0200, Amir Goldstein wrote:
> On Fri, May 23, 2025 at 11:10 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Fri, May 23, 2025 at 10:30:16PM +0200, Amir Goldstein wrote:
> >
> > That makes fstests generic/631 pass.
> 
> Yes, that is not very surprising.
> I meant if you could help test that:
> 
> 1. mounting case folder upperdir/lowerdir fails
> 2. lookup a case folder subdir fails
> 3. lookup in a dir that was empty and became case folder while ovl was
> mounted fails
> 
> For me, I do not have any setup with case folding subtrees
> so testing those use cases would take me time and
> I think that you must have tested all those scenarios with your patch set?
> and maybe already have some fstests for them?

Unmount fauls after I test an overlayfs with a casefold subdir:

Testing an overlayfs on a casefold fs with non-casefolded dirs
Test using casefolded dir - should fail
overlayfs: failed to resolve '/mnt/casefold': -2
mount: /mnt/merged: special device overlay does not exist.
       dmesg(1) may have more information after failed mount system call.
Test using a dir with a casefold subdir - should mount
overlayfs: upperdir is in-use as upperdir/workdir of another mount, accessing files from both mounts will result in undefined behavior.
overlayfs: workdir is in-use as upperdir/workdir of another mount, accessing files from both mounts will result in undefined behavior.
ls: cannot access '/mnt/merged/dir/casefold': No such file or directory
umount: /mnt: target is busy.

https://evilpiepirate.org/git/ktest.git/commit/?id=47d1f2a04d79bc4cbc843f81e71eb7d821fb8384

