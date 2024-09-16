Return-Path: <linux-fsdevel+bounces-29513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C281897A63D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 18:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C7301F2776B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 16:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C7E15DBAE;
	Mon, 16 Sep 2024 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Djk1CE1D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC1215B15D
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726505384; cv=none; b=fhBXmTyFPB+gd1zM7RCggblPS4WTIeSkqDmzt9n8IoLLw05siyTL42mN7MKMM2NcRQlka/y/8BZO3r5fmbXOVmdFDQu4gOeSWBWCuaMtEvCMVhomrAI6rR2/1Q+Y9UWJhoRnvQL2OOb9mI+1tiBZssxSP2eX7ewqkAj//7XrcHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726505384; c=relaxed/simple;
	bh=JqVxmwm6imXSZQvq0ATGpozaXZh1gx5CUVR2s7f8Des=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjcq8pYFqhtQXNIquNfZyJBW7+r9XxG7sIImD17CBqg1GzCQ54f/832viE0QzNpPwX33pMtFDI3Uggc/2O7llsj4/rA+4Pz01ihhplKy9ngdJ+gx/5125CUOCPnJ+oQwyNUBikImXz0nxvkkA+wmlnsSNQjxFAP7EH7LXIIgex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Djk1CE1D; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c4146c7d5dso4667550a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 09:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726505380; x=1727110180; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+b7ycIpbNYPDxRZFWGu5S2e+XILAOlCP4jNkvghsyI4=;
        b=Djk1CE1DDPFUPzbbDJrp/gMrFVkKLMS16s6+mH+u/dYeCQdaWioYtk4nkxyAOQSfsT
         Nq+UhZT99TKaALjNfqBRY6B6YrCcKRgZ9J3ffSHpip/FuQP5tRGJcOXcp21x4R8rNjdq
         ltyWcByxDLfNpnfmZZ3q7D6sMgHWBI99aNoHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726505380; x=1727110180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+b7ycIpbNYPDxRZFWGu5S2e+XILAOlCP4jNkvghsyI4=;
        b=qoWUHaQO31hGBiRCclsrexC3zqEhy2+rnGS//x9uHxi1vOaW53VV53W8bEu+8EGmIB
         /hwBl2M8CxXeHx1lU+UwsaNavN7dhkUSR4t2VrHYJn/PCdhzrfOqzQv9pekRX9venvXZ
         wivqJ2LqwxS/l1y0LIgCym24t5yF38hwSpfqHbTRLs9awnIbKcRmohZiVe+nSszNWtpa
         l6iiRjZ2v++d8WmwBOy7rN0tn2VWIZz0/nSDEGi/HwAMYYQ331olGGwrblDQTdt51+Um
         vNKRQx/dnPY0MbJe3EPd4xs4IpnMkBHg3fQBgNHehi1FhTPR7oTOkTlWEgs85+Nwjrxx
         iiNg==
X-Forwarded-Encrypted: i=1; AJvYcCXOMDIWHhftFXNW6rlxMawoHl9MN4Jhm63k/PtBgm/RvGhBxWq+BnLRpN2v5bohNqr5NNi/UwmfazfWu8XU@vger.kernel.org
X-Gm-Message-State: AOJu0Yyst/ZFPJUUlFgSjZM+YsQp6qjzMPW3CXqzaYiZW5z7zzh9kqNz
	xQk1yASfGLh3U93x+Eudps8Jj36WeJ0fcRbYJWREug9gTp9iKyPguMSgmLJ3OsRRP5Zm54B7+y8
	OKvc1gg==
X-Google-Smtp-Source: AGHT+IFl9y7HppBK72dDsbgpXav2jA2VJdQzWT2GaAn542Mri/f9JUF+vfsBjBbpiNvMte8mtL6ljg==
X-Received: by 2002:a05:6402:42c4:b0:5c4:135d:c4d6 with SMTP id 4fb4d7f45d1cf-5c41e1acbbdmr11166069a12.22.1726505379973;
        Mon, 16 Sep 2024 09:49:39 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bc890d7sm2874618a12.94.2024.09.16.09.49.39
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 09:49:39 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c26815e174so4788418a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 09:49:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHDDfTo4z0mOc2LlBSyCWqIMz2zCW3M4aoNba98/RF23QFqNFPcR+Ky2vXbIJQwv5zCQfbPJoq0PgKu0+L@vger.kernel.org
X-Received: by 2002:a05:6402:50c8:b0:5c4:1325:70a7 with SMTP id
 4fb4d7f45d1cf-5c41d5b8c30mr13446851a12.0.1726505379030; Mon, 16 Sep 2024
 09:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913-vfs-netfs-39ef6f974061@brauner> <CAHk-=wjr8fxk20-wx=63mZruW1LTvBvAKya1GQ1EhyzXb-okMA@mail.gmail.com>
 <1947793.1726494616@warthog.procyon.org.uk> <CAHk-=wiVC5Cgyz6QKXFu6fTaA6h4CjexDR-OV9kL6Vo5x9v8=A@mail.gmail.com>
 <2003346.1726500810@warthog.procyon.org.uk>
In-Reply-To: <2003346.1726500810@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Sep 2024 18:49:22 +0200
X-Gmail-Original-Message-ID: <CAHk-=wgZA6kgZSd_4rx=KsnxM8OU0+FOu3T9mJroBeHq2qVO=Q@mail.gmail.com>
Message-ID: <CAHk-=wgZA6kgZSd_4rx=KsnxM8OU0+FOu3T9mJroBeHq2qVO=Q@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix cifs readv callback merge resolution issue
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Sept 2024 at 17:33, David Howells <dhowells@redhat.com> wrote:
>
> It's probably a good idea, but there's also erofs, which also goes through
> cachefiles_read() with it's own async callback which complicates things a
> little.

So I was thinking that if cachefiles_read_complete() would just do the
->term_func() handling as a workqueue thing, that would make this all
go away...

           Linus

