Return-Path: <linux-fsdevel+bounces-59436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F6BB38A7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 21:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 884617A44B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 19:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714362D97A1;
	Wed, 27 Aug 2025 19:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="X4xOPh6n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1182641E3
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 19:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756324279; cv=none; b=EHmMfoP4XDJc/RMLuyOL00liBsfQdtCoTvEptiAiEQrdK9AwKRcNMDgvleicqLqjcW21h3LR+aJhCl4w9MLOGBmw/E5aRhft2jwm0p19355y2/TGahGbC1LF6U5H5a82wTmYmUIQIS4ihKcUdFYKXlHg71fShIbptHGDLwODvMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756324279; c=relaxed/simple;
	bh=FSds+HmpCH5AZqkuoiL28uTmwWmOi7GvZ1EH0NK53Ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWSVWwmWmxpD1jKr0I2ugiE62Lw7svbLsBdsjNhfoEPYEEWmeznpWXjNzjc9glTZdf7imAzRu8vT20gePAUGEHqFcYxRTvMPEB4rjvnL6bKQGP4kFReqOvKwvHlZqg8MQErt8i+uEDmIhLaVs+sU/YXUp2i93QhjP7D23dqA48o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=X4xOPh6n; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b109c58e29so3276861cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 12:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756324276; x=1756929076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pJl+Jp2a/80tiGTd1NLEXXRgBCLjcjlpQHFO/xNTbKU=;
        b=X4xOPh6nHYD5mNahoVjobXlMSphbS1wzgYz+1wUvPN6uGccu+uK/LG1ytU/sasfFjM
         I/eFljoQ9MBafN+McQvoH6BXh/zeou3uwKpuz0Ngmz4S//AshNPgjsJX5EvTZP3gg+kF
         /DbFyf7xdgXeM8kRXHt2DG4Qygy8LCdC23MjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756324276; x=1756929076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJl+Jp2a/80tiGTd1NLEXXRgBCLjcjlpQHFO/xNTbKU=;
        b=pI+1q5rgctvl+hZyN8M30uvyjnAyf4U7lNgmfqV8ULkpKpxHHppiwMu7RlelWyr3IS
         U8L/QJClmycaSt/UrYKS2P149sUs9Py3iheHWCL2mn/ybz/JNmkSZvOGXZOZaRaD386B
         lfbqkVI/gZKAJd0MstE5q/Ybwnk3ysTWmrULPaXp/9Nz59h8r9Yr1SLWF5MtD2lW/zcx
         eDgvHWx6ix0EcZdgFz91aLZp6aBq7mDUNtkMRPOT02uZp9H63d5xqu1r5xj5oWP37jNo
         VwdlCnOJl2uCuavQiSD4QbxPLvXiBPM+8RXaUgBm3pvdbQsn+B83pNg1ixQ0gB7zoe4S
         /tfw==
X-Forwarded-Encrypted: i=1; AJvYcCU5VM/jijUg9VYw6e3qhCi+LkGmTtu9ei+acTqdIceC8zEuYf7pgFA5WJeQrPN3+OeCmo+Sh7NJzRyAJruX@vger.kernel.org
X-Gm-Message-State: AOJu0YxtqAHAIeWyn3aW3bArthdyJ0ghRbGj7NvvO1HUThf0c8q5xVrc
	UQ2dRT+pxssT878r312wn19Z8QDXIKFvD5YZvTF/n9Smy7kDE7+ujnn1Y6NXsw//++Xe6uMtPMM
	O1xBHfHLnt4JHN2BE185ATsXTH8iveeagNJjlG+bm7A==
X-Gm-Gg: ASbGncsZbS8lSqoM+p3KCXr4N/znyYm8x0wYsnpbGRFjXz89pF3E7nyOlWEdqMTwOWR
	UFmGdGqN6olSqUpW3lYRZks1g3w5Q6ut1MP/XjtdO6ZJDqbTniNYxNr2Y4X6oyHkRSNUxsCcjea
	JfWWZLKk7PCSuYBlzI0EXVAgVlGOf/VrZbavIyPaAcoynFhn41VzxXcRRLDAvYkfkzJzR3gCsrH
	Vp7D1cjwA==
X-Google-Smtp-Source: AGHT+IH/RMsWQco1a8s5tRnZv5WLYAfbL4/wGrTmGCSQU5T/gmolbb7ISb9R1wkLyvfdScj1ZSDSM5AddowXbkcWHjI=
X-Received: by 2002:ac8:5c8a:0:b0:4a4:41c0:b256 with SMTP id
 d75a77b69052e-4b2aaa8002emr267154991cf.11.1756324275994; Wed, 27 Aug 2025
 12:51:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827110004.584582-1-mszeredi@redhat.com> <20250827190215.GB8117@frogsfrogsfrogs>
In-Reply-To: <20250827190215.GB8117@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 27 Aug 2025 21:51:04 +0200
X-Gm-Features: Ac12FXx3P5lz2MKEEyKOYc4FePHNmeHtWNz_SJeuCx_JU_WJuRFLNMNtnsugF_U
Message-ID: <CAJfpegsuWpexXDZF7Fqw71c36nMSpUwXXpcru7GmYDjXSuZx8w@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: allow synchronous FUSE_INIT
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Joanne Koong <joannelkoong@gmail.com>, John Groves <John@groves.net>, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Aug 2025 at 21:02, Darrick J. Wong <djwong@kernel.org> wrote:

> IOWs, would you be willing to rename this to FUSE_DEV_IOC_SET_FEATURE
> and take a u32 code?  Then programs with an open /dev/fuse fd can
> incrementally add pieces as required.  The first one would be
> FUSE_DEV_SYNC_INIT, the second one would be FUSE_DEV_ADD_IOMAP, etc.

Okay, so this is not a mask, and individual features would need to be
set with separate ioctl calls, right?

That would allow negotiating features.

> > +     return (typeof(fud)) ((unsigned long) fud & FUSE_DEV_PTR_MASK);
>
> s/unsigned long/uintptr_t/ here ?

Okay.

> If process_init_reply hits the ok==false case and clears fc->conn_init,
> should this return an error here to abort the mount?

Yes, fixed.

Thanks,
Miklos

