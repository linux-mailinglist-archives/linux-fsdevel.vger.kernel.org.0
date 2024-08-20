Return-Path: <linux-fsdevel+bounces-26341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 745CC957E15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 08:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72591C23BC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 06:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B73616CD00;
	Tue, 20 Aug 2024 06:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KXAOVG4G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D0D16B723;
	Tue, 20 Aug 2024 06:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135369; cv=none; b=Tz5W/DLZ8MAHu10PF/aovLDW4RGT0Y7X6Lz5jQ47kh7NJe0HhYKD4012WYr0OLPSA+Dim1DmIjW6QAxOt4anQxjcOLQiK7HjNLjL0MvyLqq3kipfl3tUK3tATv78u0NQKxc3IIFpityEtseYcfHqUVt0Ncbo4i5ayA0RYYawx7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135369; c=relaxed/simple;
	bh=G82YABrxIy3ymNPql9ONoNsdRdjsTTguzbQc8oGr6NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qhn9fzrlrwXCfU5spabjO91ve7golZcs9l3vZelC2GFzPSuxbCvniUo3BSWKA3UNtdWwEb12rP69HSpsYBL/lBVdV8HOIyBAdnNO2vRvMW5690l/uJB/p5wzwvc1LP3WpeMMwGBQrJO3wOAWLtrt7uFMmBov/Ys3CVDfsSUQRog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KXAOVG4G; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YnZWlbhcbike8X1nXSaQ/pwmdD6FhwYUsisfNGkSYaA=; b=KXAOVG4GXjyPAVtjZIF2+1jGS3
	/V1GZ51DWST366w+0GculGnphKMcHu2ZQtkiE5sbSFOQpLSFBNeOlzV++U1ThDiJmaEenCLHOM7ka
	gZyQx31YzVMeJe+AlelJyn6dkQR4J6ENHPuOXQdwdhQdgFv74HlusEc4vgv6HBR6v3j7ep6H8cQYY
	me3xz1mdS5s+8EZcbyESjUt+w2ajCWP42fwJR/YPNinpVH/URbOXoPe6nNXGXs41strHLPG5NUltj
	yspSVz/p+wifWq0hwv35nPuFFNq8cL625TIZhGMzilWAlSMevu//BQ8j42ftEI6LqH7DF2/3q8B1d
	N6QBrTew==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sgIMs-00000003OAK-3RJR;
	Tue, 20 Aug 2024 06:29:22 +0000
Date: Tue, 20 Aug 2024 07:29:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Song Liu <songliubraving@meta.com>
Cc: Christian Brauner <brauner@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Team <kernel-team@meta.com>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>,
	"ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>,
	"jack@suse.cz" <jack@suse.cz>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>,
	"mattbobrowski@google.com" <mattbobrowski@google.com>,
	Liam Wisehart <liamwisehart@meta.com>, Liang Tang <lltang@meta.com>,
	Shankaran Gnanashanmugam <shankaran@meta.com>,
	LSM List <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for
 bpf_get_dentry_xattr
Message-ID: <20240820062922.GJ504335@ZenIV>
References: <20240729-zollfrei-verteidigen-cf359eb36601@brauner>
 <8DFC3BD2-84DC-4A0C-A997-AA9F57771D92@fb.com>
 <20240819-keilen-urlaub-2875ef909760@brauner>
 <DB8E8B09-094E-4C32-9D3F-29C88822751A@fb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB8E8B09-094E-4C32-9D3F-29C88822751A@fb.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 19, 2024 at 08:25:38PM +0000, Song Liu wrote:

> int bpf_get_parent_path(struct path *p) {
> again:
>     if (p->dentry == p->mnt.mnt_root) {
>         follow_up(p);
>         goto again;
>     }
>     if (unlikely(IS_ROOT(p->dentry))) {
>         return PARENT_WALK_DONE;  
>     }
>     parent_dentry = dget_parent(p->dentry);
>     dput(p->dentry);
>     p->dentry = parent_dentry;
>     return PARENT_WALK_NEXT; 
> }
> 
> This will handle the mount. However, we cannot guarantee deny-by-default
> policies like LandLock does, because this is just a building block of 
> some security policies. 

You do realize that above is racy as hell, right?

Filesystem objects do get moved around.  You can, theoretically, play with
rename_lock, but that is highly antisocial.

What's more, _mounts_ can get moved around.  That is to say, there is no
such thing as stable canonical pathname of a file.

