Return-Path: <linux-fsdevel+bounces-47883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B54AA68D0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 04:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14291BA6AC0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 02:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE0E17A2ED;
	Fri,  2 May 2025 02:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wWJocYSy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1913B4689;
	Fri,  2 May 2025 02:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746153300; cv=none; b=rRQnhAEA9bouCbfFiwEjafEAvn4eMegBslu2nZ+GHuI4ZRjt55mBGEFd3SzNs/+nanPpYUIYCf8RoBYJcDbzt0/Vi3Y3w+vj6XMV0Kvi1dRunI+2rVI7mD2Uc14WeDyUWUslXUuhqUnrv/CI6vWhbzbXJoIxV1CJTwZIv5qIk5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746153300; c=relaxed/simple;
	bh=f5h1Ie7dXSDU8i0YNIdrMw8K7HFjGkJ4NCJCiwAwALs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2C5J6D9rCYOLZBt5AtfhTtL6FU+jvhn9aAvdd4plSATn2ipkeQEf1DxuxisuKO+x1W9V01WAW+9b0Q6owFxtGdCY/PhflvdUJh2fWFl9ducBipUrGL8ISrpRDUuYkL3dI9F/IjNWVVhSwR9B54Aa+xuKj5+Slw7G6u1Yj8zIsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wWJocYSy; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P8bGVFcQNC8bUMcQFTsN63CjDxjXndvf41sHelhW6H0=; b=wWJocYSy4eEtn2ABOR4emJvlY/
	6Tnj9e1xzI+e33h7hXaotSUYbz4BhuLe5sco8BPyM2GklEjHS5hFpp3X8VFJpeN8zY854LaEaZzCE
	boOkWSUpK/cHocbZVJMuT+BPEcDeLOVFRajKMBmAvKWA5st1J60p0MTJnqaj7061jJqXaa27fP0RB
	DGHpsPoz6ZHW0aNdmaL0VLocXD8wngmT+TSv/c+IlsST2UPiZqavOodfz1zE6v/QPuo94hz66VDPz
	RHLZQOpmf7CPd2ztkj0h6V74x6S5r6LvzDUHcIDkvWwhcs4QN5vaY3hO979aB4Q5pvXp1Z+lJArx+
	1imCFZ0Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAgEh-0000000FDhl-3Vaf;
	Fri, 02 May 2025 02:34:47 +0000
Date: Fri, 2 May 2025 03:34:47 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Kees Cook <kees@kernel.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] drm/ttm: Silence randstruct warning about casting
 struct file
Message-ID: <20250502023447.GV2023217@ZenIV>
References: <20250502002437.it.851-kees@kernel.org>
 <aBQqOCQZrHBBbPbL@lstrano-desk.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBQqOCQZrHBBbPbL@lstrano-desk.jf.intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 01, 2025 at 07:13:12PM -0700, Matthew Brost wrote:
> On Thu, May 01, 2025 at 05:24:38PM -0700, Kees Cook wrote:
> > Casting through a "void *" isn't sufficient to convince the randstruct
> > GCC plugin that the result is intentional. Instead operate through an
> > explicit union to silence the warning:
> > 
> > drivers/gpu/drm/ttm/ttm_backup.c: In function 'ttm_file_to_backup':
> > drivers/gpu/drm/ttm/ttm_backup.c:21:16: note: randstruct: casting between randomized structure pointer types (ssa): 'struct ttm_backup' and 'struct file'
> >    21 |         return (void *)file;
> >       |                ^~~~~~~~~~~~
> > 
> > Suggested-by: Matthew Brost <matthew.brost@intel.com>
> 
> I forgot the policy if suggest-by but will add:
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> 
> Thomas was out today I suspect he will look at this tomorrow when he is
> back too.

[fsdevel and the rest of VFS maintainers Cc'd]

NAKed-by: Al Viro <viro@zeniv.linux.org.uk>

Reason: struct file should *NOT* be embedded into other objects without
the core VFS being very explicitly aware of those.  The only such case
is outright local to fs/file_table.c, and breeding more of those is
a really bad idea.

Don't do that.  Same goes for struct {dentry, super_block, mount}
in case anyone gets similar ideas.

