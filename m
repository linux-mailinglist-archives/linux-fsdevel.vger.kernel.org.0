Return-Path: <linux-fsdevel+bounces-69712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5243AC824E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 20:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 75BA9349958
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 19:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12922D7805;
	Mon, 24 Nov 2025 19:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dvkEvOoF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADD02D6E68
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 19:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764012513; cv=none; b=q1WpuxtWJVInDy1TPaWnRXo9bjh77FLAcmbPxdOwnZvHjVjS5Jxo6PcydmN6Gw9pSbCQ2KxUomhL8VyV77OZr9GGK+eYAnY5n8LVTu4SeHQXd+Hb88X74r93Y4ljQc4BKkc/E+jGxn3cvE4mJaUVz2RhiNd717aCq4xYg4cZW14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764012513; c=relaxed/simple;
	bh=sDew0t9fu0jnEVo8dKYpXLQpMRfJPGurqD+BiO4AuRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evf3P3ydR6guRs085yTPUZThIwK1ISmEvvylXFwc64uEbvNK0STkhmcGPa7XK45nOuUVkGqq/R6nB4BeaAu353tY8pgSoG4wtLol8PBdxsp+weTGRbpTdUCUWZL8ZFHIdGam/YQdsYufSxlyy+KcqQfZEiYHTx3BRXduMAl3zFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dvkEvOoF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2980343d9d1so23135ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 11:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764012511; x=1764617311; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LWH9q/hl3rNSInlsbdja3rL4CO9dd/czAGlikc5ijjE=;
        b=dvkEvOoFE8dvN7Re6CCRsmwKt/+71rk1QV/BAepaErKPBDzxKj+nXIvOvf+gDzD2S9
         mpyZ3hT9n4P4WoNBdIXWZcGQVavNu2WhY1FKD9x4xeDvamUrIEBhE3S41ZqNSytOHbvh
         ceGH7NMYumjukBbBC3TphuqOjhQizfBI24zFSedyhlQynq4e+eo6HDLjHI4v++0BORFf
         MxsCun/KzcYzLDWiZDp5YBWX0Iviu6sHkSDdCZqsDdeRdFMOTTJ8fHLBZw9oi7gYtydw
         +Z0VVzHjz0Dy4Qbh3CmpPHK862vsUvgRTHWU08ih2/NTXIZdJ+eUo/vGQ/RLwPEdUuKN
         8mZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764012511; x=1764617311;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LWH9q/hl3rNSInlsbdja3rL4CO9dd/czAGlikc5ijjE=;
        b=i+2o5naAzxVQmG3Y7D/GS0o9n1x2meTtmpJfZMT4av3w8rDK5WpcAfJtt70j/fVboS
         bI33ejyf8W9khb9f2ktq4e2Mggt0lKOrzsVK7XSRTAOyZjJA0xNqfzTXrcs5y9tjv/nW
         ExPDfK6Fym+KWrV70guswoCBa03h9NWbpNxT2kekMM9CnzlTlT0E929o7jW20c5s2nlO
         fPCvgHAzbNN9a1Q7lgM1eHlYKqUcxjuRnak1tSyoGrKwCM+xUPeG/t8HU5ZqFZvpIWhu
         GeUF+yczBG2ktdJzvjgJ8dye1M0OweIMLixwdvuggCB+PvrHqKyfGGoViNC2mPSrUHMW
         dMqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJKLC2/E1+IQTHbL4CUo5yw0QiTtvM3OgIw+0RrxCZmSO0ZZGvu7OHOxJ6ftgK406usx6fXUJF3vo+cwcT@vger.kernel.org
X-Gm-Message-State: AOJu0YzENps5yoc/rzsOPVuUTs2jZLnQiYzHxal7iANPWwrqpf0Vq0C0
	u00TdEkg4YvE+riNmL/0e0zLRa0zAuqqgE4JSIzeICHK4f7IoWY7IoNbDBCgA0YroQ==
X-Gm-Gg: ASbGncslny5/Lfj48PTDX2JfkVzyR4AknfJqv3if6tTujXk2QEhmCi5TcgwSzH+XAMx
	zygXOLHKZDqpiN5dN2g1hWHztdGPRzJ+JZ2hzgh43WYC/UUYnAmzRXSW0GKDIxJKX5ic8w9nn7N
	0X2aXCkkJ2EWHtrKXXDqun9SWHraa1Y5pgn6lbGez4TdQvyQ5x+SJJEkbQdzeK7lGinm8GaWZWQ
	XAuaCx+QfN0NOERN5BqaKGgbUk2zpaYVW0xOHK4DA/tpKCM/LWFGfJ5JXDIPZKY3tjRltfcfz4c
	L8oG/OB4oV3cN+y/kO42BnA80/78wmr6ifMlk9b8hMsEwqNsFJFFlJGVXZCfPqTdeR11qq+NIoR
	DPlHMko/Jc8P4P9rXto3Q0dnse+UQK1h5FNAV2OpPqHyFlmsfBvVFs5XjtB/WsDF8vFr12PfD55
	/zK8qYlGclXqIeTqeFOKM3e5rbOem94oFW0ZkZMKBZk7ekMumKzjuy9jSRvtxq7KDDJhk4lQWig
	/XDuzgZkwZCZtJTUXfLYDAWs7tCdoHwlwRK
X-Google-Smtp-Source: AGHT+IFLRduFAIQy3YMAggJqo/rYWmJVJJ8UtSIVVJnP/AlGBxO6wqy+SVrby3o/Ep3mplNi6XKu2w==
X-Received: by 2002:a17:902:dac8:b0:299:c368:6b1e with SMTP id d9443c01a7336-29b7b2cba85mr4907175ad.17.1764012510779;
        Mon, 24 Nov 2025 11:28:30 -0800 (PST)
Received: from google.com (116.241.118.34.bc.googleusercontent.com. [34.118.241.116])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f095c237sm15674809b3a.45.2025.11.24.11.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 11:28:30 -0800 (PST)
Date: Mon, 24 Nov 2025 19:28:25 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Andrei Vagin <avagin@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Andrei Vagin <avagin@google.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Andrea Cervesato <andrea.cervesato@suse.com>
Subject: Re: [PATCH] fs/namespace: correctly handle errors returned by
 grab_requested_mnt_ns
Message-ID: <aSSx2YDHAbcOhgZ0@google.com>
References: <20251111062815.2546189-1-avagin@google.com>
 <aSMDTEAih_QgdLBg@sirena.co.uk>
 <CANaxB-wmgGt3Mt+B3LJc4ajVUdTZEQBUaDPcJnDGStgSD0gtbQ@mail.gmail.com>
 <d689e03e-0f20-4a33-bd74-6cf342f92485@sirena.org.uk>
 <CANaxB-z2hJ3xT7ViA1ERkgFQMaHThgriK_+goMyoNeDtrFBpcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANaxB-z2hJ3xT7ViA1ERkgFQMaHThgriK_+goMyoNeDtrFBpcQ@mail.gmail.com>

On Mon, Nov 24, 2025 at 11:14:46AM -0800, Andrei Vagin wrote:
> On Mon, Nov 24, 2025 at 3:23 AM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Sun, Nov 23, 2025 at 07:15:16AM -0800, Andrei Vagin wrote:
> > > On Sun, Nov 23, 2025 at 4:51 AM Mark Brown <broonie@kernel.org> wrote:
> >
> > > > listmount04.c:128: TFAIL: invalid mnt_id_req.spare expected EINVAL: EBADF (9)
> >
> > > The merged patch is slightly different from what you can see on the
> > > mailing list, so it's better to look at commit 78f0e33cd6c93
> > > ("fs/namespace: correctly handle errors returned by
> > > grab_requested_mnt_ns") to understand what is going on here.
> >
> > > With this patch, the spare field can be used as the `mnt_ns_fd`. EINVAL
> > > is returned if both mnt_ns_fd and mnt_ns_id are set. A non-zero
> > > mnt_ns_fd (the old spare) is interpreted as a namespace file descriptor.
> >
> > I can see what's happening - the question is if the test failure it
> > triggers is a problem in the kernel or in the test.
> 
> This is a test problem. The test has to be modified to check cases when
> the target mount namespace is specified by mnt_fs_fd.

Cc: Andrea Cervesato <andrea.cervesato@suse.com>

Loop in Andrea (test owner) to possibly make the corresponding updates.

Thanks,
Carlos Llamas

