Return-Path: <linux-fsdevel+bounces-48272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B12AACBC0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 19:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34511735B3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 16:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59192286D5B;
	Tue,  6 May 2025 16:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="W8FvXYTp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC91D2857E0
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550614; cv=none; b=WQwx1VejbKAXEq5SFvAeba987IW47+tmAbkfeBiQx4tVQaUE3QHCwcv9+ZagXM2B0/qfxbh58IRPaSuCBORoccJK5qAXyMJISySMXGdOcrNAG+sDBkt1GHoV/a08Wp5+osulpGXRCOJfENjsUGtBrEroMQd79i5fP5yc1s8vVhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550614; c=relaxed/simple;
	bh=UPskQvYkrxUpUKSU6eggRkM0kZhs49ZXn1vsmfjc6oI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VF6qQ4UiwgrkP33ES/EXLYZ90RKo3Lsp70udVcA2/c7UzAu0dpa4STDlSo7NzjaBDH7KP6qzPApwOMtyTVPbEgDtA4B6jVOyc7To6IfU7QKxXB2lNwRBbdohXjcQvu4Rlq9OIqNapF41tNOybeXKEqJlBs2g6odr+eKvlfd3kqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=W8FvXYTp; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-60219a77334so3092025eaf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 May 2025 09:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1746550612; x=1747155412; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5Q5nunoDVPugDexOGX8IwjfNJm1uYPE1x3M/IebA2LI=;
        b=W8FvXYTpaOdggLlNg6ugRATIcg3HPhSBk0x8h03zrrgVrkY5l0IlWovhzqzVyW5QwQ
         3biJroK3DYBTiXYFHujl7H8iIf6LpKAiOKzj3i1TfQ+xtn2BpKar0ia+E1CAtN9dZYU6
         foSzLfvLy9+cQMz/VTbOQhg/WX1iL3PDiUG30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746550612; x=1747155412;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Q5nunoDVPugDexOGX8IwjfNJm1uYPE1x3M/IebA2LI=;
        b=qCZ1iyzxXxbDerh31lpJtkduLuti6qf8fyi3IPmZ8K2hZxBQxXIJhuloshjHGSkNS5
         411SORaqKuicPGOJZWRhhQ4e+PEnDp1WHYUNjc7zp00/6JCgw/YIEOK0c4rUtJXpmxdY
         HExFnbWtmwxxE9NQU2VBRoakoAN3oq0/o7tyHNDHgTFz/oK30BxUVHG1HNq/5sB3EGnq
         qQBWeEEi3X06ceNSOkFMn3bY4s07gCBrRHxFpkAWkxRRe6nSL7htgzDgIcoF6HGW1F7D
         KfE0WXudnyZAlH6RHC5eLMP7oDutqcTppzsvz7CcIw06Kb1L7PCGKfuFfkUSV4cukaGZ
         IMeA==
X-Forwarded-Encrypted: i=1; AJvYcCWK/aTlhyoHXWB/e4qoWaPuU7ttdFJq6LDe9ows3kuOJMms1fYAKqG/yBTiXgC3tAKh3EHnTYtk/nMFmU+C@vger.kernel.org
X-Gm-Message-State: AOJu0YwRk5k6x2gPNYefjHr8vpo3eiLVEp/JnOKI+mqN1RMO1zqM1hIs
	/OgwKUqf5XodVNZa2psFtTMnuFrU5cPhb5sc3frn6aOg8WTxQrtT1u6G5hckoEOh+y4rBaGV9vX
	InUXDrUFzHpc+dUcqZdpoLV+2uBZiy7sqQCjSrx/oGijx+xp+
X-Gm-Gg: ASbGncvMRv6S8sEOIgLSuPqCyKI5A8U15tAvpht3mTjcSeWFmGnqTttLXgPtHlfyygM
	enK8vvXxbY2S+nAU221fDO6s7XQ9CdyIp3wRDHlf5mim1gQ+7jw/UqnLO/LlXlMI4bL3B77Dv8K
	u5AbpPInmh6EGwUPHSg6E=
X-Google-Smtp-Source: AGHT+IGJjJepn0gOwuwpfhMDAKJN4TqWIaIZ7UsEzwpTg1tX++SC/L4yjFUv3kDEAUslSG6hvBlXPYOAhZxrMKo+VF4=
X-Received: by 2002:ac8:7e96:0:b0:476:77ba:f7 with SMTP id d75a77b69052e-48e012633afmr162547871cf.34.1746550601068;
 Tue, 06 May 2025 09:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421013346.32530-1-john@groves.net> <20250421013346.32530-14-john@groves.net>
 <nedxmpb7fnovsgbp2nu6y3cpvduop775jw6leywmmervdrenbn@kp6xy2sm4gxr>
 <20250424143848.GN25700@frogsfrogsfrogs> <5rwwzsya6f7dkf4de2uje2b3f6fxewrcl4nv5ba6jh6chk36f3@ushxiwxojisf>
 <20250428190010.GB1035866@frogsfrogsfrogs>
In-Reply-To: <20250428190010.GB1035866@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 6 May 2025 18:56:29 +0200
X-Gm-Features: ATxdqUFT-fIsXKRHea9-EZCmnVWun07IHA8kCr4QDmzIP2kON1JGlU4dzmYDGDc
Message-ID: <CAJfpegtR28rH1VA-442kS_ZCjbHf-WDD+w_FgrAkWDBxvzmN_g@mail.gmail.com>
Subject: Re: [RFC PATCH 13/19] famfs_fuse: Create files with famfs fmaps
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Groves <John@groves.net>, Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Luis Henriques <luis@igalia.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Petr Vorel <pvorel@suse.cz>, Brian Foster <bfoster@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>, 0@groves.net
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Apr 2025 at 21:00, Darrick J. Wong <djwong@kernel.org> wrote:

> <nod> I don't know what Miklos' opinion is about having multiple
> fusecmds that do similar things -- on the one hand keeping yours and my
> efforts separate explodes the amount of userspace abi that everyone must
> maintain, but on the other hand it then doesn't couple our projects
> together, which might be a good thing if it turns out that our domain
> models are /really/ actually quite different.

Sharing the interface at least would definitely be worthwhile, as
there does not seem to be a great deal of difference between the
generic one and the famfs specific one.  Only implementing part of the
functionality that the generic one provides would be fine.

> (Especially because I suspect that interleaving is the norm for memory,
> whereas we try to avoid that for disk filesystems.)

So interleaved extents are just like normal ones except they repeat,
right?  What about adding a special "repeat last N extent
descriptions" type of extent?

> > But the current implementation does not contemplate partially cached fmaps.
> >
> > Adding notification could address revoking them post-haste (is that why
> > you're thinking about notifications? And if not can you elaborate on what
> > you're after there?).
>
> Yeah, invalidating the mapping cache at random places.  If, say, you
> implement a clustered filesystem with iomap, the metadata server could
> inform the fuse server on the local node that a certain range of inode X
> has been written to, at which point you need to revoke any local leases,
> invalidate the pagecache, and invalidate the iomapping cache to force
> the client to requery the server.
>
> Or if your fuse server wants to implement its own weird operations (e.g.
> XFS EXCHANGE-RANGE) this would make that possible without needing to
> add a bunch of code to fs/fuse/ for the benefit of a single fuse driver.

Wouldn't existing invalidation framework be sufficient?

Thanks,
Miklos

