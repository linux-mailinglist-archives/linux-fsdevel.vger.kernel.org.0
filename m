Return-Path: <linux-fsdevel+bounces-38157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F549FD19F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 08:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869611881AB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 07:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2FB14C59C;
	Fri, 27 Dec 2024 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqNXCaDc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9871F13BAEE;
	Fri, 27 Dec 2024 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286024; cv=none; b=no9YXYKY/O7jHCSMFSmXAUKCEFnOL31VvADH8JlnKrBhVJIcq283O4/y3bBygEtW9/drpfD7DNIA8loP2PvjcXnrBkLr2ga73uRlFLrwCVBa79l/aapwKUjbZDIA7kfqTT/vDI+Aqrw6SaqlOLo87RyPtVmVp52Da1RsdDZ4hFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286024; c=relaxed/simple;
	bh=x0nFkOoOBz2ukVI2xPXMDWQvT/LzpSsjOGJHbkobsCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=XlcjCined2HBfscrDR63fYt7yLzQnH947XRnfKDbYsDSmnfq2gJQ1QUs0COYGsQplUprOvntAFob13J1mWfHv4Aq/KFhj6AxVInSb4hO3M6ZpJ8bQepqCT62NCekDdn+w9WxVKNPTLhYiHZmAcQljL7MBBAlah0O1wL6qqN1Kng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqNXCaDc; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso12373088a12.1;
        Thu, 26 Dec 2024 23:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735286020; x=1735890820; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KLhKix/P0wr3bxa7rW/L2B7kqtz6IfdfelkFzyBcfIc=;
        b=OqNXCaDcdivdXuNE3rXZVDen1IzxwGRLozwor5DlBc7N9I5I+xD86lriEA52CPpZxr
         xsHvNjRB4JrTdX5pzSe3dlFx6EslgpZjhtDd54LzFMJlbkjGNB0p71G4T7GM09KYZhhd
         ns+LcXuPfXby11LfS4+EdIn7KO8gdEAYwAiMgm+HMmtBvvqnbRYXUtGaqP1nXdaC5DYq
         3zRcfWRM2DZvT0z1YDs1UPIxy4lkAs4SvqiDQjIa/6R0iARNiqur8mMUgZKjsIiRtTCA
         FeOdxmoigSQ6zPA/CqQKwRc5ZjFCEbubu8y/jqcNmoOf2M/mfB4apvA6frcIi3lOgqDo
         SJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735286020; x=1735890820;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KLhKix/P0wr3bxa7rW/L2B7kqtz6IfdfelkFzyBcfIc=;
        b=jl3yltCXC61D8J2Rn+HB1Vb7fuZZVZ/tw6TiYTqZ0hT3xt+Zt5zmlU6iILI9N3qTgE
         ZuuXjvpX4KMJ6df5qV6o6Nj2tcblalkFxWGkWxnrn1ykcWrshHL6JOqrKFSDSGC6jGMi
         ghlqSUEj2+0enxJJzZ6SHSdDTLecHB0RP9CRi5A5KAqV8jhbwYKzUKfBY4/H3E/3jIXc
         ItGdViHzALBp6Bxyps8yLCKYAO8CcTVraCax0xJgVnol2FNkcGOQprSj0ec3qt4Qfy66
         zcrbfb9bHM8N+j8RBX34SonqmOp1Zf+aGrbRzDb7rKI3eFvDN4/KrCz9JEeWGV2toMr5
         ve6w==
X-Forwarded-Encrypted: i=1; AJvYcCU2esm3RY8mQxj5v++25lJmZS0uv6I1QMbtSvk4BYD26+riRg4mLln6oehexap7TvrnfxSjyb/DIOBb@vger.kernel.org, AJvYcCUKSry+xwS9yyWsc/kykd6QjAVMso5o8TXnSweVRgBm6QhH4J4RsDPzvOeht8Nq/XdxBp+PdlKjK9ikpPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrHW/O4pIYOxpmXQwklD8wmuHydL5Y5j7kB9V1TIDBkNMhNsA+
	RqCqvWg/kFPr+QNyWMCaAhLzScnccDmKhBGR3WqNeOLhrOmDuvzuKHIcbQ1UZdnpTlj7wOXR6gF
	03lr2LJVkpxzwOHqnN1xG4XAi9VeDvQ==
X-Gm-Gg: ASbGncvdicSF3wI3FfCUHloXjC1uHfXO51M9Nf7TNHR7XgVkJeylkKt5AP/3YiZU/6o
	IywP1d0YE/KcqOc+O24abSDrxjRvzHZ7rR2xoTL4=
X-Google-Smtp-Source: AGHT+IFiGwXYo6biQ0B7K9mlRX51bCQVmkrG8PQZe+6tsH2qNQ0CaRxDtxNdMDVpyxxE1B79GURabrQ9jF6c31OQdwE=
X-Received: by 2002:a05:6402:2801:b0:5d3:cd9a:d05e with SMTP id
 4fb4d7f45d1cf-5d8023a11c2mr24592523a12.9.1735286020081; Thu, 26 Dec 2024
 23:53:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905-delstid-v4-0-d3e5fd34d107@kernel.org> <20240905-delstid-v4-1-d3e5fd34d107@kernel.org>
In-Reply-To: <20240905-delstid-v4-1-d3e5fd34d107@kernel.org>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Fri, 27 Dec 2024 08:53:00 +0100
Message-ID: <CALXu0Ue5f2XKSSYEo8N73DRJWVNJbesO_17eRgbSbAhXVS6v2w@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] nfsd: fix initial getattr on write delegation
To: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Sept 2024 at 14:42, Jeff Layton <jlayton@kernel.org> wrote:
>
> At this point in compound processing, currentfh refers to the parent of
> the file, not the file itself. Get the correct dentry from the delegation
> stateid instead.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4state.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index df69dc6af467..db90677fc016 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c

Is this commit going to be backported to Linux 6.6 LTS?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

