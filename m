Return-Path: <linux-fsdevel+bounces-56530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAB9B187C7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 21:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504FAAA30AC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 19:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E36528DEF0;
	Fri,  1 Aug 2025 19:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HHK+K7Cu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2635B1FBC92
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 19:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754076661; cv=none; b=uDzyH8oYT4NHAhSm1MelR4Fey3BqLIMdm6jUL8R/tHN0pGKQ/BveFwW5EomoOMw9ndwhovHtoElIyU/TH6tU91kLmb7N0/rvy/jfWf3yDLc0lqBcryPnMbou8Gu3BfoHZXeG2aFB2cYJm/jWqd/dCmArcLgZmu9zK2KeVft8WX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754076661; c=relaxed/simple;
	bh=Tn75XQYhjJo+TWDkRdCfnZdS3TGmeZchqZWPBeig22E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUyqj5xKvIh8joQlqyiR4mdg5oNpCaCy/8ihfFw6ldeIMgdhi6+stHHOA7MzWeIzcx960dq+OoZWWEVh9Th/qaGfXjtohQG1NBlaad364Yihv29JOqfzSt2MAP71ktmbP4rDp7IZxeP75vgu5LclVIgis/gI01XtzIWk4OoLoUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HHK+K7Cu; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso72391cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Aug 2025 12:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754076658; x=1754681458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tn75XQYhjJo+TWDkRdCfnZdS3TGmeZchqZWPBeig22E=;
        b=HHK+K7Cuj+m86DT7fUiStpyZ5py/pKWNDGFBifxgli2bNVoJWs1jedmfpSPP6MweDs
         HrCWqp1qkNrSd0KFHsGjvZF7fBmHRqRpYB9qW1a2MIfk/UD9OMHEmNAot7lTteF2D4Z0
         LlEqa1PrSneOGuWDrMxVAi3bLwPxyLyrbkYnWfwWqoeQpTEQjb/HsnwBfzdK1ixotYRq
         jBfmFcWCdSjCpAgdXK6jtOWDDV8my+k3LyupzBXF33zpIHvasID6uGGFqeZFLDBOnl1k
         6x1xt7RDB79GNnjDJPQ4cSYXGKWImXJXWouM9SQ2aAkMu/vOu749Q10gg5Foi6aMk4ur
         9Q5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754076658; x=1754681458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tn75XQYhjJo+TWDkRdCfnZdS3TGmeZchqZWPBeig22E=;
        b=cK3M0Hk6wf7/JFXZUa+6PhmsNEHPMCx+rtffyEnNwERa2SLaNoaTTpa2LtE2D3oCp5
         jsJ20T9EDT1B+3Thzujd/YCbxyp1XqUbXzv3RqGEg0xDM3YpV410LqwZSSObA4xMhUT6
         NNCMYRMqUlbXAYSIGyCsU6BZCiMEXkjyk01qKVo7C4foGeaxUv5Emsqm+g22QZk1/lOF
         PiHpfn2sFCRS96HIzCK5OlyRYEjFm1BVmMzWp/OeSFLCWgqxG1crLna9BsIoEQ1p7rQN
         Bvh8+YJSThIn2uHgTBMTAhou5pdy6ncuxFfdvu3b1nfOCnAaY9dVmNWpTE0chjt61fKX
         7z2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGoZmnAMx9leXmM9t7iPv/+6lmZ8WFaxhwxjVwBeED7wjGaH5gCXfX2QOv7rIiTVUNWFCFjiZdB2fG661t@vger.kernel.org
X-Gm-Message-State: AOJu0YxQomE+iSMT3XMiDt+EN/MqYLXNcyKxFvIglADVwtiZQCWjZYCp
	5zL2lrn+QrJqRb6aevb2CC5U1ZuQiew/Qok9f8fmAR/68txHtHgnTJd8JjDfOhfQLNVWQLKfmT0
	7qUGsYbN00TJozOuNGc4t91KmFUrez7Qg5YzQAfce
X-Gm-Gg: ASbGncvWGgOovDNUyxkM4rtRDExvnRviIdz1c5xhftqd7Tmb+GoIkVegOXOG5p/h/zV
	lQwrgLhZWXnZTZPdHnzvUBfCqgW9icj7CdMMnF+8gyJ9FbuRtfaqxGm/vJIMbtRaUtUUEipUEyu
	mxwe1K/MLA6eDs/4+HzDOrcAl1ITzvvw1pxxEeJfvJFX1hJnOwyYGOMKwb3V0x7SQJ+nKW3UEUI
	6RWwCUqvWgMuIMejyF/ynGe2ZglM8sj2dE=
X-Google-Smtp-Source: AGHT+IH0mW5f/qmqu9jwFpseJ5sBEGT+3smSxDV4uopSaI0KwsbmE/+dq3CsqpUFK06gNcNwwYnxKt51RS3MEF3u6D0=
X-Received: by 2002:a05:622a:1984:b0:4a7:1743:106b with SMTP id
 d75a77b69052e-4af12de2691mr759991cf.6.1754076657499; Fri, 01 Aug 2025
 12:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731220024.702621-2-surenb@google.com> <20250801183833.30370-1-sj@kernel.org>
In-Reply-To: <20250801183833.30370-1-sj@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 1 Aug 2025 19:30:45 +0000
X-Gm-Features: Ac12FXxvF4QVnElqOuim-YcXYx27wMsfO8zYCFlPV8Iub6EM4IPZ7MZ5jF-KLug
Message-ID: <CAJuCfpH+bXgm0RK=CRxD_evnwkdeqg=-hrf5dtejCMXhxg5cpg@mail.gmail.com>
Subject: Re: [PATCH 1/3] selftests/proc: test PROCMAP_QUERY ioctl while vma is
 concurrently modified
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, vbabka@suse.cz, 
	peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 6:38=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote:
>
> On Thu, 31 Jul 2025 15:00:22 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > Extend /proc/pid/maps tearing tests to verify PROCMAP_QUERY ioctl opera=
tion
> > correctness while the vma is being concurrently modified.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Acked-by: SeongJae Park <sj@kernel.org>
> Tested-by: SeongJae Park <sj@kernel.org>

Thanks SJ! I'll include this in my next respin.

>
>
> Thanks,
> SJ
>
> [...]

