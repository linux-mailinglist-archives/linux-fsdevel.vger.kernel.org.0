Return-Path: <linux-fsdevel+bounces-50846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5438FAD0387
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 15:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9892C3A26DD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 13:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4CB28935D;
	Fri,  6 Jun 2025 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="iW+9G5bR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560E9288C23
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749218116; cv=none; b=FJFq7v1pA031AtysLAtcCkHPbhtV7Bda5Zgj6S1nuLUVfYEqDLeJEk+rIieoMmV0yDDOEDAIGa1hdffriz9gpyruSDTa7lUL4TKR1ztVPZcirmtkXc0kqbAhwqnVRTMaitOYU2Di7hIBMPsy+a6mqGu84eAalPduXBhIebbrlYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749218116; c=relaxed/simple;
	bh=BiBKkugoiM16l4QTDZj/vftTkuVh94Dm/j4qISoefgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUvjvrX5TDIISsvB2BweahUdfaw+DJBKe5+qfMT0PoYdjFTOaRqEuBMEjbyY0HFEzGfEQXr/FIcasd1Z9S4NiCBWoIgUsX625x/eFcTvYR+BBskGs1r/E48845ZChhqUz27086TOEYiF2CX5T4xSs8zsr9zmpGS1fRCO5NkRcTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=iW+9G5bR; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fafd3cc8f9so34684226d6.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jun 2025 06:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1749218113; x=1749822913; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E7/mZixpkg0lei16mzPlvTFGBUK0AxMB+9TgdpByP7g=;
        b=iW+9G5bRnupvjbHI5nFzA601KlsAtY4/tj5XemYFRrljRsbbn9YR4wXf+X4Mrmp8gw
         7kYkQgoVn+K20NtaCNlTxAn4D21NzGZojjvb/AqB7gosya25aaMdWkBv/DhU5hcZga0O
         YtQrg+1OHMDEAj0dtXSZezTmQVFFlZjT6fYMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749218113; x=1749822913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E7/mZixpkg0lei16mzPlvTFGBUK0AxMB+9TgdpByP7g=;
        b=TDswaHkqOPRaID65lwEEdBJjDZehSGWk7tXKgbA/WyUON4EfD83W+xtGZkJBM2BuPp
         JPAZOfC9AlXEMtygC64fZt6mMpZPzHInwE5jqvib7CgwRQyp+80pRoW5GXJKI3eat/HC
         PQv6iDPo94Rv8jdpA5a8nt6VelV8Hk9bH3nmfx1Yc9vz/jASiwZXknRbHyQgQ8VK88Jt
         FDjhgDRqSlh5kMVVGZNw50RSNJY1XRfcGjade8e1AI02g1IoTj5+gEbbsFZt9yjOXxe6
         7bhgSK8q/nbvW9okS+StOYiJnPeJ2g/Ws6M4zTxinE6xjp/IGS4gVe47zioMQVjH9Z88
         HuNw==
X-Gm-Message-State: AOJu0Yw787aSU2mnoB56vVtEmbeX8uro4b/UmJmrWLX0hub7iJHuxQPl
	URhEix6h1zZc7sZ0FndSKDIX4tVOde5WRjVNWVp1K3Effy2voACi5Hf2m++3ApL3bBDXtdJmfne
	yZGVuHV0ReIPb0Btxj5gHFPUjZKbJm1ycqITX36Zzm6uTG1YeYo7o
X-Gm-Gg: ASbGncuUMHcTovm4v44aQTUOSPbYR/B93kZ9trQZqGNnPfLa38WUlYhugtSbfINGnal
	SgTzEpyWlVDrGeeEusrWUsVBQjZuJtj6EDb+RJPOOCIqLdCw1PPUC4zqSEplk84GH3EYiqawyvA
	CPfJ4+r61NrJC2gOwVuk9gFIO4JsfCgUsKttP47KA23g==
X-Google-Smtp-Source: AGHT+IHQlrI/OtlIWS2a2vIz47wRFPm1D8aQZ4bBhcElMWjypsbw77Uu87VP2HAYTCSIjvehXsNall5j9ttNQcsenUM=
X-Received: by 2002:a05:622a:4c10:b0:476:91f1:9e5 with SMTP id
 d75a77b69052e-4a5b9dbb8f0mr63968261cf.50.1749218101624; Fri, 06 Jun 2025
 06:55:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174787195502.1483178.17485675069927796174.stgit@frogsfrogsfrogs>
 <174787195588.1483178.6811285839793085547.stgit@frogsfrogsfrogs>
 <CAJfpegsn2eBjy27rncxYBQ1heoiA1tme8oExF-d_C9DoFq34ow@mail.gmail.com> <20250531010844.GF8328@frogsfrogsfrogs>
In-Reply-To: <20250531010844.GF8328@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 6 Jun 2025 15:54:50 +0200
X-Gm-Features: AX0GCFt8wqjlMocidJZkmGlImqJ8eqE9iJOCP1TCcDw9PeehwnM-2y0bS2wSaQc
Message-ID: <CAJfpegvwXqL_N0POa95KgPJT5mMXS2xxCojbGWABhFCZy8An+g@mail.gmail.com>
Subject: Re: [PATCH 01/11] fuse: fix livelock in synchronous file put from
 fuseblk workers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, 
	linux-xfs@vger.kernel.org, bernd@bsbernd.com, John@groves.net
Content-Type: text/plain; charset="UTF-8"

On Sat, 31 May 2025 at 03:08, Darrick J. Wong <djwong@kernel.org> wrote:

> The best reason that I can think of is that normally the process that
> owns the fd (and hence is releasing it) should be made to wait for
> the release, because normally we want processes that generate file
> activity to pay those costs.

That argument seems to apply to all fuse variants.  But fuse does get
away with async release and I don't see why fuseblk would be different
in this respect.

Trying to hack around the problems of sync release with a task flag
that servers might or might not have set does not feel a very robust
solution.

> Also: is it a bug that the kernel only sends FUSE_DESTROY on umount for
> fuseblk filesystems?  I'd have thought that you'd want to make umount
> block until the fuse server is totally done.  OTOH I guess I could see
> an argument for not waiting for potentially hung servers, etc.

It's a potential DoS.  With allow_root we could arguably enable
FUSE_DESTROY, since the mounter is explicitly acknowledging this DoS
possibilty.

Thanks,
Miklos

