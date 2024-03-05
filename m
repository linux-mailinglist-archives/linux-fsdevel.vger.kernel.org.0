Return-Path: <linux-fsdevel+bounces-13629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 242D88721B1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 15:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DF228251E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 14:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0F086AC6;
	Tue,  5 Mar 2024 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="mu8gjg6d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF2D5C604
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649538; cv=none; b=hBamis557kCQQPENuGxkeiMTLaW526rwk/9SsXhTK8qtbKIfaqabMtINuiRbF73GDd11mN8C3AhDyvjek33fuTgu4BlVUn/CWUxDc0SKTfQd0M2jaNEeyTlCBnTBTk5TdbPvib06uc9dLGA0PhSs3bEJ9onAf+k8Ul1+bn3gBaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649538; c=relaxed/simple;
	bh=oMoaD15Q4RZurtXz9m0mjYyGcE+cC4GEA1JD8WLd12w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTWwbgM34/eLnVisvoToOpj9AeOHjDyQMC0brqef+ShCyuDRdhYsH00MAD80VsfxheIHbocIxDBbj/3fuQw3JI7Xsej687OBTmbuN416B9Cb0ZKDz5oJ4EnfaItxOgJT2zf+G0U4spL0LGUcJb+CqFJOynL0Kmlea0P9CPDQmLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=mu8gjg6d; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51341a5aafbso2824422e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 06:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709649535; x=1710254335; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oMoaD15Q4RZurtXz9m0mjYyGcE+cC4GEA1JD8WLd12w=;
        b=mu8gjg6dD1CMKjtcrsSeXbJJa7zwEvW23eLM4jvo8l10xBWcPfceeKhHX44lN77+g7
         95+MI5qWAqJ8dBTqTYS2SB2A/OSbkyWadinyQcSMaIXZM4wgSU1FcjW1OiqcU+yH8J0o
         K/UhDa0w8cII223Jd4iqDgvpDmUov8LOuJ4TM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709649535; x=1710254335;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMoaD15Q4RZurtXz9m0mjYyGcE+cC4GEA1JD8WLd12w=;
        b=MnLK/5Wg5dQT6Hvwfvsyz/KHwyETpS9MgQeInJR/L6RohBi3br9U5ntzY0tUKmr+gS
         cunbbUlt94+fQyN84hOhR6hXts1XzU+3h9J8UHUDU9r2WL7uAYl3P8ZG1pqFDGRxUDBA
         HBv5v6tCSh/pPXye+VzTv7+5y5mV1ZCbhVFwhOuNytljQB4rZJRKpIKhO9R4f1vRsCk1
         bRVKOm+coOxZHr8sTQ/n4rqI6htALQEK+nyfux/k9uteMA0C+T2MPelOZ1dqPqmrZjXD
         xcg0NE087uvtRBCt60BWbJg6N5l11yU3vWEl0sFO3OPz49l6YsDoRks2vJRptNZvc3cs
         /DjA==
X-Forwarded-Encrypted: i=1; AJvYcCVPw3RYjxShG/P16k9vQi++U9Jc7YPMdk7deomwyU8p8+0OFGR2unYnJjwukgxIVPns5jeaI0ucqGAwUGeCTjeybAyRFtpgx8ZwAeZW3Q==
X-Gm-Message-State: AOJu0YzKB5oGxb6meeuq7P0uDJzUYPfovDgDN1XDCTAzY/E8AGg2fguD
	eHGEUIIkEJDrKoCoA1KR7lXD7k0xty14A9NJvwQEe9NhWzl4d6RWE5CNm50x1iIttU0oIc27JYf
	TI64MkiFY69UVcaXgPj5Zc/QRdRw3Ba+enshHAQ==
X-Google-Smtp-Source: AGHT+IHtd287Cim+U4qSt3a8db88CbzOFal6Gmy5OoASE9Fw7x+WgX5YbLauuKoFawGzS6YyLx5H0xL5YW8GyxOwFlc=
X-Received: by 2002:ac2:54a3:0:b0:511:674d:88c5 with SMTP id
 w3-20020ac254a3000000b00511674d88c5mr1505026lfk.13.1709649535128; Tue, 05 Mar
 2024 06:38:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com> <20240108120824.122178-3-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20240108120824.122178-3-aleksandr.mikhalitsyn@canonical.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 5 Mar 2024 15:38:43 +0100
Message-ID: <CAJfpegtixg+NRv=hUhvkjxFaLqb_Vhb6DSxmRNxXD-GHAGiHGg@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] fs/fuse: add FUSE_OWNER_UID_GID_EXT extension
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: mszeredi@redhat.com, brauner@kernel.org, stgraber@stgraber.org, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jan 2024 at 13:10, Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> To properly support vfs idmappings we need to provide
> a fuse daemon with the correct owner uid/gid for
> inode creation requests like mkdir, mknod, atomic_open,
> symlink.
>
> Right now, fuse daemons use req->in.h.uid/req->in.h.gid
> to set inode owner. These fields contain fsuid/fsgid of the
> syscall's caller. And that's perfectly fine, because inode
> owner have to be set to these values. But, for idmapped mounts
> it's not the case and caller fsuid/fsgid != inode owner, because
> idmapped mounts do nothing with the caller fsuid/fsgid, but
> affect inode owner uid/gid. It means that we can't apply vfsid
> mapping to caller fsuid/fsgid, but instead we have to introduce
> a new fields to store inode owner uid/gid which will be appropriately
> transformed.

Does fsuid/fsgid have any meaning to the server?

Shouldn't this just set in.h.uid/in.h.gid to the mapped ids?

Thanks,
Miklos

