Return-Path: <linux-fsdevel+bounces-13283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 552A986E290
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 14:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2871F24435
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 13:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6C573182;
	Fri,  1 Mar 2024 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Xa/y+QI5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D988572915
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709300550; cv=none; b=dj2KiJfIwXn6vItch9h9RNM/n/dkXPJmAk3hRyg9rO0ytmS/UhShwkh0kA5fjsM43VSV6EdX8qwvkEJOM22KLBc1YDuQhbXSrj1uCEGWJA4ZDQ5TRYUl1qrl5VgHsWSnOLsRO22moHyHTFkdj96ASysse4bi3mGZmq9PL1tXQX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709300550; c=relaxed/simple;
	bh=uvKCAXMT8sNauk5+VTMaEUp0n/5PMKoLqFnsKI5EKpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gsht2vjimFBedHbHOlxewh57oWsj1+r91OPyZqJ5clKLxwCBTEjJDeU9snmlhgzdVoSAhT9QBJkQEzl8uINmD08OpoqrL9iKdZmlGbghJ6b0cYwhOBkbw+zLJglN8jNdFLpIS2qEgfDPj+f6o6XquP8ouzhgWncCFGyCKI6+O6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Xa/y+QI5; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a443d2b78caso290856266b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Mar 2024 05:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709300546; x=1709905346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uvKCAXMT8sNauk5+VTMaEUp0n/5PMKoLqFnsKI5EKpM=;
        b=Xa/y+QI5FgV+MlBdZq7FhfCRHkgJUwVA5XNu6hfTkLueDlioJdD5p5xQnpcdrbOdxS
         LhXk6D5C2G1yKoGH+TgTKRiIz1/Dttso3gqX3a5xTjUrXF1/w/E5WDWcbEn+4MzabFbr
         HT1q6hOMVkm0iOYmW7kFFH4JtSwohPDdX4M6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709300546; x=1709905346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvKCAXMT8sNauk5+VTMaEUp0n/5PMKoLqFnsKI5EKpM=;
        b=vKjOYIMBUg9i7kHHrtxF4fZIF8M1k2/i86P3kQOY/Yo8R9DpF1Y1Dr6rfk/eu3ubZ2
         t2mhea3hC8fDtiv8zA5ZK/QVR7REuIJzEmb9JHlXnRBdu9jzHJ9M2i43+FD4gp5ftLTl
         bT91vJIiansc3o5ak1k4VTlWkczsKSst58rCjzOON0h3YwOvgJNfTZlhhhekzv9iclqI
         Y80tZwhvrkcsZrocuBqgQH24gLUgVHH28PqrUaUbQNMRiXY0+3joNyXppQecm5MoJ6AG
         RiaIvijik9JYyB5jXRFKGVZimijIv8PPK40cSAKARXerrveLskDz3M4bfKUKRxadhsnv
         aHSg==
X-Gm-Message-State: AOJu0YypE0VvifedabPomFksq3a7u/UWdF9cPKcmoZdlkalhSTg2VBuc
	HEYg3jViYQZOUoBbQqO9i/xIBoSqJ3dAkNniJREmdKrDsHTFIly4FRStZKWpHKISZwsGUDakSXh
	dXLqSfZvSzHdBiPLzmB6OzqNzM6OiQumz+87evg==
X-Google-Smtp-Source: AGHT+IFKyHCJjugXaVuo0TxhU2eqFIxuWNNPqdDj2p82dGOLUVGFGenBabw1NVs94YGP7ZFDeiyjxuD5xd7aKXazFdw=
X-Received: by 2002:a17:906:b347:b0:a43:f170:aa44 with SMTP id
 cd7-20020a170906b34700b00a43f170aa44mr1504212ejb.47.1709300546044; Fri, 01
 Mar 2024 05:42:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228144126.2864064-1-houtao@huaweicloud.com> <20240228144126.2864064-2-houtao@huaweicloud.com>
In-Reply-To: <20240228144126.2864064-2-houtao@huaweicloud.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 1 Mar 2024 14:42:14 +0100
Message-ID: <CAJfpegtMhkKG-Hk5vQ5gi6bSqwb=eMG9_TzcW7b08AtXBmnQXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] fuse: limit the length of ITER_KVEC dio by max_pages
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Benjamin Coddington <bcodding@redhat.com>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 15:40, Hou Tao <houtao@huaweicloud.com> wrote:

> So instead of limiting both the values of max_read and max_write in
> kernel, capping the maximal length of kvec iter IO by using max_pages in
> fuse_direct_io() just like it does for ubuf/iovec iter IO. Now the max
> value for max_pages is 256, so on host with 4KB page size, the maximal
> size passed to kmalloc() in copy_args_to_argbuf() is about 1MB+40B. The
> allocation of 2MB of physically contiguous memory will still incur
> significant stress on the memory subsystem, but the warning is fixed.
> Additionally, the requirement for huge physically contiguous memory will
> be removed in the following patch.

So the issue will be fixed properly by following patches?

In that case this patch could be omitted, right?

Thanks,
Miklos

