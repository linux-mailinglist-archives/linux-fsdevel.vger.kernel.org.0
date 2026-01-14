Return-Path: <linux-fsdevel+bounces-73768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C81B8D1FE4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 16:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA8523054433
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2E73A0B20;
	Wed, 14 Jan 2026 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ZnP9NGnC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F9F38A720
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405408; cv=none; b=DDCM2C8l14t2nLtRoKUwXez+bTpVbhCdMETVRg+WQ3RzZX5zafs6r0W+9bihClerfTIQIj9CezVkC0hlA1WUW9eFmuPNGlez9+qZp56CZ5eX9GKuS+qldbS8nmkDfPLiAH1RzJcL7dV3ZBGTuwo3yY4gW59AgTBKUq2HpB5JpNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405408; c=relaxed/simple;
	bh=9vjdYRzontEziyETItkt1hZ+LIQI1WQmdclF3BXSgd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgMghLOQ4KxBK1ZDwh8+RMn3/or5Od2NrK02WqFBufyGrKlUNNQKYe9clYaG6mlW+GRZHi62lvBOZwSrajaLB2jvkP4kfyRANI240ST0EpFkSApCsdf8elR6zltEBsIrDhewc9rp0EnpdnBwtRZ91L8lgMc7NK7iu8cq4Zabhzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ZnP9NGnC; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ffbea7fdf1so48073541cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 07:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1768405406; x=1769010206; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gpNyknj42YKTWpQ+ysEFa+36qVDkcEveraGbiuWhtJ0=;
        b=ZnP9NGnCuYDmFbpnP8DkGrK+1D2lvJqDvkhuPSBqDaLtWvtAgTF1AS6mm4U+4zd9uU
         BDeZJzIpu0bLYlOXE1vUBQrF5S29T8jo1h+9QiSo4nrImnajQF50CeT23ssZHM71kM8V
         F9uhpYdPL/EMd6Eq3qY1WZEhAdpykal6y4//c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768405406; x=1769010206;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpNyknj42YKTWpQ+ysEFa+36qVDkcEveraGbiuWhtJ0=;
        b=HjsJ6cqIzHFSaKsYuLasmBs6DcK12qqEXUq7NyrLa6gd+z1gvmpdYLG0qYGPX+1C2q
         +5A6GVYXCSx+K4qSim5C7bQn0karrw7zCnxcY3ciG70iO2PsvqdCXhY+V+UEYre38NrU
         q3fxNYDsQTIpikysOuTScM5g9eI4VW+UvjofWw2WAbBJJub7Br1mDlcac5vksb149oCn
         +6947eticN4ZLxmck2dQq4Y+yjN5vQ+G7nYb+RbM4rAgtoIgsmYd5Gz93kwVliz5Vy1G
         p46myBv83AnhHl55mHwxFHBYBgO+fCuILFfhkxYs5QlfkGVtobZ2JdQiQwNe5yqY2LxL
         XUFw==
X-Forwarded-Encrypted: i=1; AJvYcCWZ+5GZL4iNkskGgH4XirhEw/ekXFYGgd2QRUUhqw6BAMdVu5qgll1CDz96Pkpn4HEw+Sg7U8UBbsk4yXOr@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg3Tj8mZOPUBE+kIHF3LYE7uUBdPTsNkZ3iXJFHD8j0jM6+5To
	jQz+aw5rlCrV4RtN4QiQ40hG//0gNkCRK7YPexltciJY+V1nzntcRpZtUZhGClCPzAuboeA73mI
	w+uEtamSeoDRpi82Q8MYwe28D11las+T8HUfcW45Blw==
X-Gm-Gg: AY/fxX5vW6dUM729ByKnaPlAhpWJncM7k0tySqs7wzORYMoNSWsE3t+dxk9Hx+QEh0H
	AjcEOM+S1oN4xzn2/O5jJTPFfax9ygBg3cj/rkKaxnUfx6DXfE6h2+s8y11Y4oXdwf9SwbUYC63
	d9qvlgrrHVVDTQQdi0d+XqxlAYQXnDxYU9/baQvpHD0LY5oZqrhcpSku3GyF5vvOGvTBtcc3OJL
	HTa37D6TElhnhK7+xvvsBBcGn3+pRSGizDhptrDLuE4yEbMi+yz0Q+3M82Peab6c6VwlT0=
X-Received: by 2002:ac8:5e4e:0:b0:4ff:b231:eea8 with SMTP id
 d75a77b69052e-501481f0f31mr38405011cf.14.1768405406292; Wed, 14 Jan 2026
 07:43:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114145344.468856-1-mszeredi@redhat.com> <20260114-frohnatur-umwegen-8e4ce0e3fc4b@brauner>
In-Reply-To: <20260114-frohnatur-umwegen-8e4ce0e3fc4b@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 14 Jan 2026 16:43:14 +0100
X-Gm-Features: AZwV_QiBHqzX6cSgOiDMInbK59Ku1HMFzDw1qrqeS_Jol61lGhG6AXwLPOF6Nd8
Message-ID: <CAJfpeguq9Kq+8D9e2Ph0-T6xrwBD42V7a2hhP7NkOapcRNZq4Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] fuse: fixes and cleanups for expired dentry eviction
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Luis Henriques <luis@igalia.com>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Jan 2026 at 16:37, Christian Brauner <brauner@kernel.org> wrote:
>
> On Wed, Jan 14, 2026 at 03:53:37PM +0100, Miklos Szeredi wrote:
> > This mini series fixes issues with the stale dentry cleanup patches added
> > in this cycle.  In particular commit ab84ad597386 ("fuse: new work queue to
> > periodically invalidate expired dentries") allowed a race resulting in UAF.
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
>
> Do you want me to route those via vfs.fixes?

Yes, please.

> Btw, the Link: you provided in the first patch points to nothing on lore.

It works for me.  How can that happen?

Thanks,
Miklos

