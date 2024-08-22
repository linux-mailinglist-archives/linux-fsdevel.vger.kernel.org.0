Return-Path: <linux-fsdevel+bounces-26827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EDA95BDE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 20:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C05128598B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 18:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16E71CF29C;
	Thu, 22 Aug 2024 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCIOFkH0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5A618D64F
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724349757; cv=none; b=OLZMovMewvlKRUellKw2wvHNQwemvUJfTlNm0f1/Cumwa5C2s1bwENBlZNx+pFnZHkGfTQ1yrmO1h0Vv2QitlGKvhyo/3LTBkXIoijPCy2n/AexheIzvrugJ9BXHwDk/rf/RpEG2MHZe5TwrX94IZoxggVBAEDqgLW2m+P7jpcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724349757; c=relaxed/simple;
	bh=jgfisQ3+N7Es7o3Kq9xKQvGnJnxP7b7vuVOjdQUhWgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ku8PUr5lnQ+H313wBgWkfKad4RvdwwJLlH4s+RbPuRrQgC9HMwxaS8XaOW2hF9KV7R2DwEfUlINz4CtM7OviWwl1R3QW8Srn4eVyi4DU6yzQlJgPfQrMdQ4WSjVeCm+Od3rVqlcTOKhAqhTgsGeoQ3SAjSbvnGJe+JPFmmk5n4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCIOFkH0; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d3bc9405c2so165094a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 11:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724349755; x=1724954555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIdZwGKc3DhnmIOea7vq7EzG3jsdVTSM3r+4Llh1m8c=;
        b=bCIOFkH0yZm/XXeB5UwLAVXQuYEErRHxJa5CC8fg4Nu46ePsWfV1Sd/3YxbRVkyqvG
         OVhXf6UuYk+hU0S5wh2lsfERO4tC5ACUOw1W4Am0tiL1Kk+OUfsGSwyBDaTudXwXc1A9
         ubSPkn6jshiME9lT3QmWulvIfOp0zQ1OrTPAXzpPySCLgyNASBP4I5uysCrG9JzjURCy
         C366I6iVnYm1Pn5f8gbfI/YUw49fbyxNaQtYtInCEjtxQwW+0DbhQuvJeYOLsbMXdQwi
         kIUfEjnFvpcoWpyoNSazpKOz7dgZb5Gp6CnS8kas/Mhfp+RcOIVvFs5a1lCgzt2HEOUH
         qTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724349755; x=1724954555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIdZwGKc3DhnmIOea7vq7EzG3jsdVTSM3r+4Llh1m8c=;
        b=jS/fVdjG6LZS6RdWYWJlTEGI7reL+dzrC6xca7aslJCQ/IaDXQaB7MKS4Lrwxh7o1o
         bkil7kTXf2yEKGWsEeaH6O9m87EuiPsNX0KYuS+TCFeMdjY43bYFtWkFeRLrRuj30zuq
         T8PsaXOU4MrFFEPSrkntVphqJxZlMx+DmF7IZlMvcN+2Rl9TSbDMME0vJVBum5M8qdYC
         bVOqtg27JwYyvNm4p1/p52Q66OYTf2O/MU8e8dNv+UFHES5Rx0qpx3FZGBNLMRYgD4xB
         kc0zMqzl32AKBEVzBAwpuSUjdUfGM58T1/9XijfJL+O+Dea0UaSTYyK0AD4B/da91aP8
         m8cw==
X-Forwarded-Encrypted: i=1; AJvYcCWhrcbfMfJUDcVmSeJbs8vxdVwaUSV4N/Vjxlpfa7cBsjmIlXVapcf4f7Lu0gXc6Gc9GkCnbbCREV9C2kr5@vger.kernel.org
X-Gm-Message-State: AOJu0YycAJFEy4CIuHlZemoceNs7YupPNME1RTuZMfh54gn+6pb7FK+s
	xAG6STuOoOYhwJzNKjqj/pawV/jSW7okERZ4pvKs/wbnABWl3+YNZH41A/oKrR3Pko2y6WAgkO4
	OS4201SBWvh6Rw5IY9vpa6VmR6iQtyg==
X-Google-Smtp-Source: AGHT+IGH8BiORy07so3jtmFCtA+lbgj7e2tJludQJn6knBzrwm1xGtFWt4cjBsQ2Q4UHBBCaeVtia+r9dkZgl4i8HAo=
X-Received: by 2002:a17:902:c409:b0:1fc:6d15:478e with SMTP id
 d9443c01a7336-20367af2ea4mr42545405ad.1.1724349755001; Thu, 22 Aug 2024
 11:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812065656.GI13701@ZenIV> <20240812065906.241398-1-viro@zeniv.linux.org.uk>
 <20240812065906.241398-2-viro@zeniv.linux.org.uk> <09a1d083-0960-4de7-ab66-527099076ee4@amd.com>
 <20240822002921.GN504335@ZenIV>
In-Reply-To: <20240822002921.GN504335@ZenIV>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Aug 2024 14:02:23 -0400
Message-ID: <CADnq5_PfNy3-zK6XDa31LUAcMH5m-CkV1TtL_jtOqmdaQjcLMQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] amdgpu: fix a race in kfd_mem_export_dmabuf()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 8:29=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Wed, Aug 14, 2024 at 06:15:46PM -0400, Felix Kuehling wrote:
> >
> > On 2024-08-12 02:59, Al Viro wrote:
> > > Using drm_gem_prime_handle_to_fd() to set dmabuf up and insert it int=
o
> > > descriptor table, only to have it looked up by file descriptor and
> > > remove it from descriptor table is not just too convoluted - it's
> > > racy; another thread might have modified the descriptor table while
> > > we'd been going through that song and dance.
> > >
> > > Switch kfd_mem_export_dmabuf() to using drm_gem_prime_handle_to_dmabu=
f()
> > > and leave the descriptor table alone...
> > >
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> >
> > This patch is
> >
> > Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
>
> Umm...  So which tree should that series go through?
>
> I can put it through vfs.git, or send a pull request to drm folks, or...
>
> Preferences?

I'm happy to take these via the amdgpu tree once the other patches get revi=
ewed.

Alex

