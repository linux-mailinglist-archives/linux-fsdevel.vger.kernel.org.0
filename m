Return-Path: <linux-fsdevel+bounces-48883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4536BAB5395
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 13:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF0719E3608
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 11:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1463728CF43;
	Tue, 13 May 2025 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="T0hv+Kb2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7723728C87D
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747134855; cv=none; b=VOzy/QamUwGKmKEKFjShtBOonPbkcJMfv1OU07pbGXrN0IcPMB+uQj/n4Wrl6zMChqjyWmQyvJCo6zZ0NuIFa7Uv5V4UL61afI95H13YEl5/oedhtkmtMqVqnaAUBvUFIP5oo+Im1+SIln7AaBC3dPGlxpJhxUK7SC35P9Zsfro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747134855; c=relaxed/simple;
	bh=rUXlR7l7NZ3Gr1ZMImu25qy4YdxBqvXbnK3pa/SYTXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFa+Q0yyaDiyzsGSDmM9NBQ+zDMZ4GvIE42SQWeCSOxn0q5d1u42EbOS4A98VjXcxAcUDBWc5B4d/XK6LdIRanDXkkiYCJhmJpy6wiUnADEUFttk7eaxD5QdXUXdl5pMyJpRPnKKvAGiHaCyoQr+quNbFPNTaMyxw42WloU4wNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=T0hv+Kb2; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4775ce8a4b0so96386541cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 04:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747134852; x=1747739652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NK/DLLKFigYxUewQVvVcwyWhFIKm0Rtoic2X1Pep40g=;
        b=T0hv+Kb2EjfedjEz4RkPtxNOAyZPkWpz7UShRO7qkXMBgO9EreHUeF6WuTDL7U3fLC
         6c+vP2umaAbRHybHbDUQY9cqmPQ6U8AItcBWHguUHDqe3u4ls7yijPLwt1xxbcdL4/Ls
         r79S7aD8UIhD3pdOjFow4oadiw/67e8zvUmdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747134852; x=1747739652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NK/DLLKFigYxUewQVvVcwyWhFIKm0Rtoic2X1Pep40g=;
        b=MtZ0oVDrlMKSuD4NlDvbgkPVBNsBglkP6PGLcv7JwODHzOAFI62zTx8D/kSgH5IXPk
         bqYh5Qkg2vevYjwur/ey6fTf/WWAjYttFMLTEi7ByIpMU9J2skU/KFMWBU/DHoiHfaJe
         +UG6hqsoBtkd1ZhFv9KPpWtKg854tl0IC9yXmbq0tx6a/LAt3NZ7AobvfJcqV0rPRlPz
         da8CqOlBku/gQ7k9nwbIKtsGO5m5I2GwSRUW9V3FI2YcFUgucJyX1zRrlTA97gFO+7nn
         ELdG3+P92UQ5s10TDjWaL7TUnRyVHdsMRSkvoPpNcEbjZNyP1Hg35AKIna0/ASIspfzp
         pRjg==
X-Forwarded-Encrypted: i=1; AJvYcCWX5oqfzZMmXuJIOT3aetjwzRrvCyMC4ErlAfx2drzjZqgikYoV4kLls+21ZA3/OjjWKNIkOac7OkQd+RJd@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt0rroPs93hYCw5fVK7TS9+R9CWFfhewVn6QSBOlIwgAQydI2R
	FTkAUl3IW2IiWzD8+/r6M6ab9FtG7Y40WbK+pgOvUkw/mf8MqBY7ZoDqt37LTy6ZHuZqL2POeqe
	fNCKdrvbI/G4KEdKbPA5gYdT9v6K3icO8elocevEUoohlk94h4Xs=
X-Gm-Gg: ASbGncv0mLi5n/I8in6NcINmY3akNDw/NfCWxiqd53DioAow3UJOiZXgfV/PtT8ihDs
	H0SFB399HED53tqBb6v3kcQG4DW69VaaKTy+C8hA+0LC0RUVCyMQ7k0P0sD/mHdqNnASnEQ8+cx
	Lu7wUCpGQXLF3gnJS7zNR7TuCwq9mIeg57o92UuSQ7Ew==
X-Google-Smtp-Source: AGHT+IH/3Au6LvFUpjxFul9qBZRWwv0r1ZDdcphJzSGPko9Zn4fS8QHxXwSr0VYWPwAseKHOcE3Edop8HozRfby5tmM=
X-Received: by 2002:a05:622a:190e:b0:47a:eade:95ec with SMTP id
 d75a77b69052e-494527defc8mr284584481cf.38.1747134841696; Tue, 13 May 2025
 04:14:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416090728.923460-1-mszeredi@redhat.com> <aa9a34f7-8e95-42c4-a23a-116738aa7f97@bsbernd.com>
In-Reply-To: <aa9a34f7-8e95-42c4-a23a-116738aa7f97@bsbernd.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 13 May 2025 13:13:48 +0200
X-Gm-Features: AX0GCFvJoLC47QFq98ZHFaHl1fdfZlAyXKRVLDjA6IwsyNeuh96z4uHqLEuhtRs
Message-ID: <CAJfpegt78zb0o4NuKREqg395TRqiAQJUvqj74QOds=_gNs_vNA@mail.gmail.com>
Subject: Re: [RFC PATCH] fuse: don't allow signals to interrupt getdents copying
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Apr 2025 at 12:10, Bernd Schubert <bernd@bsbernd.com> wrote:

> This is the part that might be confusing - it is in another
> file than DT_MAX / S_DT_MASK - it might be hard to know about
> FILLDIR_FLAG_NOINTR and possible other future flags?
> But then it is certainly not a file type, having it in fs.h
> makes sense from that point of view.

Added " BUILD_BUG_ON(FILLDIR_FLAG_NOINTR & S_DT_MASK)" above "d_type
&= S_DT_MASK" in filldir functions to verify that  FILLDIR_FLAG_NOINTR
doesn't conflict with d_type.

Thanks,
Miklos

