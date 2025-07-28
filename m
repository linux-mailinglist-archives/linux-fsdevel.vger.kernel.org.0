Return-Path: <linux-fsdevel+bounces-56151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB42CB141A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A7218C2F90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 18:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3334277CAC;
	Mon, 28 Jul 2025 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSgrDda7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB5F275AFF;
	Mon, 28 Jul 2025 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725356; cv=none; b=DSTLfw/q9sih1gzkc1/He2XN6qJpJIGCW7iPTe9l+onWt9Zci5XXPkGgpTZsT9WDplJZFQMvlKqtOz15ZNQaO2wZsIuVy1Qm4uKRmBXmxrhJpNCFiIF64bD6QPE4T3cCgoxUiDrS/7io/dlQcshGWB0h2wxt9fs/MP4x6vVtSvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725356; c=relaxed/simple;
	bh=xblCDj0RCsFTuq9WZK/qP7W0pwWR0kB14FpwE2VUBHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYvRTnLxcDm2GYCho7wIxIWDYbmi7G/A3EQ1EVYyFHB1HOPUWu1jdAj2eNWiJuuX177kHAKJ7E2gVxMDtgYIRTtYZhFUr2/jRjmCYJK0jWi5xxUcJ0sFHBlboi7UbbUbho4PGU57DFbUT1vxZpj5xmn1WVsqZzf64gHzoV9kKEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSgrDda7; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4aaaf1a63c1so33113691cf.3;
        Mon, 28 Jul 2025 10:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753725353; x=1754330153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aobxU+eSgbfZ9X4crn912/FDn8oN2UrA+EAoV9ASOEk=;
        b=OSgrDda7Zph7rvNaxi3UpJbaymgm6wGQwXJIJRJJFeCMcWi+rHxoJzXgUKvPsh130Z
         RHT9S3KGGpg5a5pGp8RMgMVc76qU2lMpgg9IL+UNL9ltPxD1KFLO646FzhKRn+jKvTV2
         VYD3oysNLXr4sUwUCkfJUHy/bAXkfxiAxmc+pWWQsoqFPc1v0PutWIqK+zSYfW6vIw4D
         feVE1mM8yY7CGNo44UoTs5MDB9KGoqQ5VFtPt5E2GonRxcemidc801Tw1eGocyaP/KcZ
         HaRH7MQIbf3VQt+94kv21Z0vjPxZIJ+nBMCvRaVGXt2Vu4MM/TTwZy51IqsbOGu6y+Gt
         oRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725353; x=1754330153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aobxU+eSgbfZ9X4crn912/FDn8oN2UrA+EAoV9ASOEk=;
        b=l+A2C6MvgcI6MNAU289JBSve8WLX3cO8PUVrlqMeGVdILnYRrRbDuFhVhIN+P2TpJi
         J+zCIsAm5EIgSUfGKNU+nF+ItY3c14ShqLGWXnDPC/Qy9PmwzB5aKbFC0/w/sPBMY3dl
         PrznFDo50W331xdPP8z/sDEtePmHmg09+Gs5KeXfoISF/9cs8YxoqtJT45IYr8FuKRtc
         iv4PxNm8UwcwHzzJKasVJ+iFmuYj9BuYRDuuZlB7AU6GtB4cjEYtKSizq1vBQv6xav8f
         Nh+wM39S1eiFTnjvKbWTfPSblUX9bDSsNtSmWQfBUIhTABJ8+eOajR6FAOPypC1OXRuM
         fDvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxPSIE/mBXwh0Kqca7dhavRigsTnAZRFNiOcp4xMHn6tanddqwuNS/T7ep4pw1WpqFHFZXJ0uSo07KSBZi@vger.kernel.org, AJvYcCVDNyERsC5JcUMx7DT1IxOGTJcN0qV9d4WyNIHSVL7E7VdS8YNENJpYKs6UuVaBgU78Ln3y4SreUk7c@vger.kernel.org, AJvYcCWzn0jFvQmH6obt4O6AjCflF8SL3gfDvnnAUuwerP1LCMOlM6dIWkN0rtcFhBwBx80aywD4FY3052IlSKyA@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7+PA6GG+JsCuBNrrugKRigRcDPyG0yqMza3+kdJV6qCj/Fbqg
	aed6wX5nJH1UnAPDUr63p4MDo1xMTK2xnww1SY0fRN6qB7fytBqsSJpwKkQ5XgMYEMAqGjdv/rk
	2j/Yxt2vcpeAm4x5OlxgbpJn4u6z4Z+E=
X-Gm-Gg: ASbGncv3rblvX5a9bguwMtmQUejeLqNdQJldiMuKUimWOIqojtMfb0VBBI1GISGzrvS
	I9Le21uV9LPryNnKuxNQUSgUaqn/2cQKY04OW64lUvVZWOELx5k/F+gwwusuurRjvMgAkF/8Ruo
	XrWorySyXVj5XXMOi1PiSDEEScO8jBHcDW0VSH1XVlNCVlW/kX+N/NWPiXZq0+Z2xDZx1GjLS8j
	29RmA8=
X-Google-Smtp-Source: AGHT+IFeHGuxtySi7CtxaGpGpFO7wyl1QhTknE5mS9v2TjN9AvzGwL7VxfaXPQJETF58ke+oTluka4/SUlAIU2Zvi+s=
X-Received: by 2002:ac8:594e:0:b0:4ab:ab99:4de with SMTP id
 d75a77b69052e-4ae8f065189mr200798841cf.26.1753725353322; Mon, 28 Jul 2025
 10:55:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYs5AdVM-T2Tf3LciNCwLZEHetcnSkHsjZajVwwpM2HmJw@mail.gmail.com>
 <20250723144637.GW2672070@frogsfrogsfrogs> <CAJnrk1Z7wcB8uKWcrAuRAZ8B-f8SKnOuwtEr-=cHa+ApR_sgXQ@mail.gmail.com>
 <20250723212020.GY2672070@frogsfrogsfrogs> <CAJnrk1bFWRTGnpNhW_9MwSYZw3qPnPXZBeiwtPSrMhCvb9C3qg@mail.gmail.com>
 <CAJnrk1byTVJtuOyAyZSVYrusjhA-bW6pxBOQQopgHHbD3cDUHw@mail.gmail.com>
 <CAJnrk1ZYR=hM5k90H57tOv=fe6F-r8dO+f3wNuCT_w3j8YNYNQ@mail.gmail.com> <aIe0ouF9tsuIO58_@casper.infradead.org>
In-Reply-To: <aIe0ouF9tsuIO58_@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 28 Jul 2025 10:55:42 -0700
X-Gm-Features: Ac12FXyI95ILYrO-ngDWtex6vWFELuWEcDgcFbDIGZdP_N1ojOFhNj_bSwihkWo
Message-ID: <CAJnrk1aXvVf7jaK9_2PamK5X+1b+crT+kmn8vktv0nxqCtcW8g@mail.gmail.com>
Subject: Re: next-20250721 arm64 16K and 64K page size WARNING fs fuse file.c
 at fuse_iomap_writeback_range
To: Matthew Wilcox <willy@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	linux-xfs@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <liam.howlett@oracle.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 10:34=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Fri, Jul 25, 2025 at 06:16:15PM -0700, Joanne Koong wrote:
> > > > > > Also, I just noticed that apparently the blocksize can change
> > > > > > dynamically for an inode in fuse through getattr replies from t=
he
> > > > > > server (see fuse_change_attributes_common()). This is a problem=
 since
> > > > > > the iomap uses inode->i_blkbits for reading/writing to the bitm=
ap. I
> > > > > > think we will have to cache the inode blkbits in the iomap_foli=
o_state
> > > > > > struct unfortunately :( I'll think about this some more and sen=
d out a
> > > > > > patch for this.
>
> Does this actually happen in practice, once you've started _using_ the
> block device?  Rather than all this complicated stuff to invalidate the
> page cache based on the fuse server telling us something, maybe just
> declare the server to be misbehaving and shut the whole filesystem down?
>

I don't think this case is likely at all but I guess one scenario
where the server might want to change the block size midway through is
if they send the data to some network filesystem on the backend and if
that backend shuts down or is at full capacity for whatever reason and
they need to migrate to another backend that uses a different block
size then I guess this would be useful for that.

fuse currently does allow the block size to be changed dynamically so
I'm not sure if we can change that behavior without breaking backwards
compatibility.

