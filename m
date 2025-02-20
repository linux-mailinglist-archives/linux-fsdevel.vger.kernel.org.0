Return-Path: <linux-fsdevel+bounces-42162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50292A3D89C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 12:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C2D17BAE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 11:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2656F1F3BB9;
	Thu, 20 Feb 2025 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="e1JpUowz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2371F3BBC
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 11:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050773; cv=none; b=TOSBRVdqUXxxP/N7yS84yCxZ+pANhqa4hqnkJoydPMWfZ/XARInKvo5yfZ0kkA8yMRt4eS3cYgjzO2h0RUPQSUkC8ZfndStmSJ1k6lEV9wJGeejgCMxW4pQTqVhlEhZX/u4A86lC2EkE6s7UMAQbY7IZKmvaLZF8DH4xvO9FaAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050773; c=relaxed/simple;
	bh=OqWxmG0X2zmiSbOcuJzgXWfv0gytiKlyeQYMLUwW7y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElBOLJpPO8slZ4oEnnnf1OAmzg5/JhW5DT7F8uPR4SL5QcRAWBTdj7N9mx/ZD6vpRslJnPQyDclpvUw/ttsm7CZZAiA8/QZnxscUPQ4lO0KG83yU3GMHYY8BBB450HBmKGTYdaYTIZVGt5Ud8sxHT2neyi1GlKx6LjJY7qKVSLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=e1JpUowz; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-471f16f4b73so6443131cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 03:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1740050770; x=1740655570; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7tn5uvF5vIdX/ny2QsORYRCD7GJpo0VnicZTBfCjVg8=;
        b=e1JpUowz6ZneVAZ6AIABhMO4+b/mrJDb6zvO2P0NBOTqgBLUWqienZOT/cNsHIFQXj
         /vcJOLCN3MItpPEZ3C9a9MZkEXJO2yIiTVZFGkMKiF/SLWgDvPQB3RxLERdO2sUdccNB
         tC+TJCQOZgQamyZ8t5l5upU9GVyee3otWlQHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740050770; x=1740655570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7tn5uvF5vIdX/ny2QsORYRCD7GJpo0VnicZTBfCjVg8=;
        b=j953VCr1GJUSSg1diJ05W0ifnLX69nvjMTubknh5rJf5Cd2s00jEGvvvROednuneci
         V2IcpUSH6BRPbXddZRJamjhAzMrwRbU/7Qx4Q9n80TytaFLUD88uidPUZs8/SLaIxudk
         3VVgjYreifRbaeEXgsAJ1Bw8bIYaA4BS94895wBPvtPIXMBofr3uaLgitSI+lxufUxdQ
         Wic86o8XpzkouUjg1UJQqB18BNRiueiHcHLFYx8McEGdB3P0UBbqaxHXkrEk/kHo8fUe
         zH0JfgYbyrswPbx4du5++dYmZYP3I3AZNfLxK4SA3kDjI6r6GYd1tmJckYMnr8oxWMmT
         0CXw==
X-Forwarded-Encrypted: i=1; AJvYcCUCsUvvu8lp2Z371PC2cgtTRmZRAWHvjubA5oen/i90wPY0xgMt73Vou5MKATlC4hxuKXmUKIwVlS0+AGwC@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm/mKXy9puqWYiLQdYPPSU83c4sJzB3iSAKzmtxZDNpqJrnMf4
	ITGlz42ire+36cyQ3bY6czhbPO2kIuu7UYlgOrs3F/jdt2vjWB46GiQGwbzhoKy2+J0Cj970fB3
	HfSx1K4+0vz71bP07ihxjddgvLiFIy6r0hxH4GA==
X-Gm-Gg: ASbGncvgABvTy6FHlfB1mnN6n877cYBR4/2/6xD/G5o5NAoT66k+wnUYnOQjh5toAth
	EIxDPqA3dGyFwfzM5b6PGl48ZlQOUk3O3ptJDGzjMD0qMNpr1Dy/drhFa103TBW23ft2iY9g=
X-Google-Smtp-Source: AGHT+IHvF6P4aO6ZDtZuWoXIRLKg2tXeGKPFOi4EbMc0JgwnaGVhObtiauHCdZFsgHzhxb8pMe5HIloumJ53UZj0Xag=
X-Received: by 2002:a05:622a:1a93:b0:471:c03d:cd6c with SMTP id
 d75a77b69052e-4720824ebb9mr100995291cf.19.1740050770314; Thu, 20 Feb 2025
 03:26:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210194512.417339-1-mszeredi@redhat.com> <20250210194512.417339-3-mszeredi@redhat.com>
 <CAOQ4uxiqis6kawuv4pa6jxHYgpQPc18izFP8e0TORfA_mVu_-w@mail.gmail.com>
 <CAJfpegt=PWs8ZDF11p3nOCWHbWescE5nwVtUt82f=B6B+S0Miw@mail.gmail.com>
 <CAOQ4uxiQQV_O1MJgTksKycBjJ6Bneqc=CQbUoghvXc=8KEEsMg@mail.gmail.com>
 <CAJfpegsuN+C4YiA9PAuY3+-BJ959aSAaXTYBwKNCjEnhXVw0pg@mail.gmail.com>
 <CAOQ4uxjkBQP=x6+2YPYw4pCfaNy0=x48McLCMPJdEJYEb85f-A@mail.gmail.com>
 <CAJfpegvUdaCeBcPPc_Qe6vK4ELz7NXWCxuDcVHLpbzZJazXsqA@mail.gmail.com> <87a5ahdjrd.fsf@redhat.com>
In-Reply-To: <87a5ahdjrd.fsf@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 20 Feb 2025 12:25:59 +0100
X-Gm-Features: AWEUYZlvOFaY4Lb7C5iOdE8ZcCG0ff_5CqjAz6UfL79twoY1TEll-kecVyj_OgU
Message-ID: <CAJfpeguv2+bRiatynX2wzJTjWpUYY5AS897-Tc4EBZZXq976qQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] ovl: make redirect/metacopy rejection consistent
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 10:54, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> writes:
>
> > On Tue, 11 Feb 2025 at 16:52, Amir Goldstein <amir73il@gmail.com> wrote:

> >> The short version - for lazy data lookup we store the lowerdata
> >> redirect absolute path in the ovl entry stack, but we do not store
> >> the verity digest, we just store OVL_HAS_DIGEST inode flag if there
> >> is a digest in metacopy xattr.
> >>
> >> If we store the digest from lookup time in ovl entry stack, your changes
> >> may be easier.
> >
> > Sorry, I can't wrap my head around this issue.  Cc-ing Giuseppe.

Giuseppe, can you describe what should happen when verity is enabled
and a file on a composefs setup is copied up?

> >> Right. So I guess we only need to disallow uppermetacopy from
> >> index when metacoy=off.
>
> is that be safe from a user namespace?

You mean disallowing uppermetacopy?  It's obviously safer than allowing it, no?

Thanks,
Miklos

