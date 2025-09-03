Return-Path: <linux-fsdevel+bounces-60139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1552CB41AD6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 11:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7AAA1BA58A4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 09:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FED1DE3DC;
	Wed,  3 Sep 2025 09:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="a2SYyK/p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D1C267B00
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893340; cv=none; b=KEVupUOACztk9XSlod6xBCYdKmN472LNS4cm9Yb6lG6QBssfNxLC/K7dZtjhXEmVeHl1BFYpFSfQ167vGDb6XGpcZCE01hsM9MD4QOU67bE3arQxLKaEqgSSjBtw/MxXp1sqj5iubPNjOv0xz77Q4fEk4x5oYypGH6XkcnyTDSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893340; c=relaxed/simple;
	bh=i0hN3JTxGBQkH3VjckTsldIljnBC1Fl7UOBLKwhSOYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLZL9nxw4iQ0heGtJpsgS2+aY+8vGJ+TCevgInfFzjXHbQfn2t1WfSv8KFollglgnrRxvGn2nPltnkfiHxsAfl+ddy0ZGAv2jivPkBM0QmvpUimpwXKdBiWQTR6uTpjp07QEz4tRimvCC6UGp9A6kG1zVRA7G+7GaCtsOUJh3GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=a2SYyK/p; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b34a3a6f64so13425991cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 02:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756893336; x=1757498136; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i0hN3JTxGBQkH3VjckTsldIljnBC1Fl7UOBLKwhSOYE=;
        b=a2SYyK/pSf46i0VAsCzd0/1vf32Gtp0XyI66e27nvTvYax8R+JELHxo3ZNMQjRYLm3
         2lUGw7/sLS+OrookgH0uKFCgH4HPsbYX+mBcyRYvxXAWbOt0oxa6ltY14bvIIZmDMFl0
         oLzRJg2JkmfAK5519f4EKXM1XVCkIhLt3SNNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756893336; x=1757498136;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0hN3JTxGBQkH3VjckTsldIljnBC1Fl7UOBLKwhSOYE=;
        b=e8o2ZVK/LvLse5D6hqtgnZirs7wXfxYepAhETLVV+hAkonN8DddpAvhQQN3mDSJId7
         BJHBGY9LtzijfRtjd3o5gZtdNJSOz2tQ8u+FP05CjN0bvrfdFz5YR6RLfAgKJELlbcsp
         4Kx8eHQfiPoaPqjcd7jZI3y//fUZRfSvWu6L+JwZwqfxFYjMSLpJ4VGKIejZObPc58OM
         47XIEzXVZuGKq15qqDxMNubHjKTBRlsOfP/60yezWhmxQBoS7UGaMMbLghjkpBO/JfrL
         P4OVku4g3iMXLkjb64CWslWMZpLW9FpDm1/1KNBbyFyiHgD5BQujpUTWtriAUimpdaLG
         dJdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCbek9D+GITCPdCuWbJYkRP/sXEGAsPmpvprpZgY7nQ8p3F1TEOMQpoHT1UvNQjLsUlD+BQl3ofAeyJEbX@vger.kernel.org
X-Gm-Message-State: AOJu0YwwFIOtcWZS1z9ER7pnl8RrJiu3zRqCEjw7W+LfTxLcfWiw9mo3
	bkEQwXM8cmZUehe7eOW9x4Hm7OD74hAW0wvKQTyhX2IxIWWBlT+3Sj2qQZh0feg8mqOedBgEwh+
	1Y4g9fY56ZHoTSpJgQixOMeAz3V4FhvAaDxO2wAfN9w==
X-Gm-Gg: ASbGnctu1/HoKK0kc+8QNNjDaxMlU0UiPxoU3X5rQAewjLXMiCnWqAHA7z9igwZ2cSc
	YipqOWlRtF40fTb3Vk6wq35K5i1LSXkwH2AXvxcHMNleN44gh2opBVCV60z+tpLYiKHwFb49izm
	7OK+r5L0D/1i//M25Vz1/2wxK4kp10v0YVFhgw2lGxZNvqLxGrP8149mm5WhTi4kP3NkphKoXgd
	lkzSrHn/cdX9Nc9Gkuy
X-Google-Smtp-Source: AGHT+IFY0o814c/UFxGrM4ghR8U+5ROI2FYDVGN2QyD1xaQ+SRqGO18IVPX6GwijmfJp+9E1evSRUVC3zpIk3+5Fnjc=
X-Received: by 2002:a05:622a:5e0d:b0:4b4:8f03:9c43 with SMTP id
 d75a77b69052e-4b48f039e59mr13308791cf.29.1756893336548; Wed, 03 Sep 2025
 02:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708630.15537.1057407663556817922.stgit@frogsfrogsfrogs>
 <CAJfpegsp=6A7jMxSpQce6Xx72POGddWqtJFTWauM53u7_125vQ@mail.gmail.com>
 <20250829153938.GA8088@frogsfrogsfrogs> <CAJfpegs=2==Tx3kcFHoD-0Y98tm6USdX_NTNpmoCpAJSMZvDtw@mail.gmail.com>
 <20250902205736.GB1587915@frogsfrogsfrogs>
In-Reply-To: <20250902205736.GB1587915@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 3 Sep 2025 11:55:25 +0200
X-Gm-Features: Ac12FXy9ovoKtZPx52Va9FwtNBEEn8twm-ePM4GprUxOSwPyJ_1p2NS6zUuG9IQ
Message-ID: <CAJfpegskHg7ewo6p0Bn=3Otsm7zXcyRu=0drBdqWzMG+hegbSQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] fuse: implement file attributes mask for statx
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net, 
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Sept 2025 at 22:57, Darrick J. Wong <djwong@kernel.org> wrote:

> You can, kind of -- either send the server FS_IOC_FSGETXATTR or
> FS_IOC_GETFLAGS right after igetting an inode and set the VFS
> immutable/append flags from that; or we could add a couple of flag bits
> to fuse_attr::flags to avoid the extra upcall.

How about a new FUSE_LOOKUPX that uses fuse_statx instead of fuse_attr
to initialize the inode?

> The flag is very much needed for virtiofs/famfs (and any future
> fuse+iomap+fsdax combination), because that's how application programs
> are supposed to detect that they can use load/store to mmap file regions
> without needing fsync/msync.

Makes sense.

> > I also fell that all unknown flags should also be masked off, but
> > maybe that's too paranoid.
>
> That isn't a terrible idea.

So in conclusion, the following can be passed through from the fuse
server to the statx syscall (directly or cached):

COMPRESSED
NODUMP
ENCRYPTED
VERITY
WRITE_ATOMIC

The following should be set (cached) in the relevant inode flag:

IMMUTABLE
APPEND

The following should be ignored and the VFS flag be used instead:

AUTOMOUNT
MOUNT_ROOT
DAX

And other attributes should just be ignored.

Agree?

Thanks,
Miklos

