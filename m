Return-Path: <linux-fsdevel+bounces-51530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A368AD7EBE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 01:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24B6177D93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 23:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E812D322D;
	Thu, 12 Jun 2025 23:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idltBRA5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B8418CC1D;
	Thu, 12 Jun 2025 23:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749769896; cv=none; b=Y+bETtzr0zYpSU6soRwJwHjHKKOEGO23diWE0LpqFQMFiijR5uubUAiZlmIVz+QR2Su6bL6YoOwvFJDSKl4dvUONiRhVgIfRIZYLNgkaxH7SJ5O9JkQ3pXpmnIn/cv0ptq2HdKWoZnxAETwR3d19UUNNjRwA1j7jih8USb8bu2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749769896; c=relaxed/simple;
	bh=aWtS2/zyRzaqXE0lEuxVrNP94efCrIrWSEqc8gI2HRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYnUyuhx5/6rEgTdt/pH8Hu5xDhtHqc3+PKP4nOYq4gWSDIdu0dMoR2lbFOCPBJJSuT75KniArL+eY3NstHQ+BsKDIFdwS8QajC6gvsa2SOzGPQvc2ZuxD/MfPlHFco07F5wfghl+ICfW5m31PxIW2Ue8jTI4grU6euf5W69wSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idltBRA5; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748435ce7cdso1455172b3a.1;
        Thu, 12 Jun 2025 16:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749769894; x=1750374694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meX0r21mZhk7RATaCVFLmRROZ1HswJh+HA5LxtdHd30=;
        b=idltBRA5ezLYwCUOVdYEWkWSAGdG7OF59ZTxE1Xy0e10fqBlmRvsPPMxXrAFyTDez6
         eKIypkGE7a8lFoyoslVXmbp460AvetDfTVZtSFA9LOR5ZXVmv1MJNWs1HyKQqjjKaq++
         QuCBrhXbBjI/3nt+p688uPukF1o1Oi/S8ruvENvHWHByMmfI2cAb9kU+Ca2QOiDVOHvS
         oM9irAitJMZ101s1KPErdgiPrB6Vqc5BgfznMB8mQOSdfEHXmKm5yVuah3j+fhekeHb5
         IUkBFQyzzwYJG8ZpWMwWJCqscNxhiHfiegD3wMq4m+a+/1B9XeqqeBnRcFOmeADhPjIH
         8mTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749769894; x=1750374694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meX0r21mZhk7RATaCVFLmRROZ1HswJh+HA5LxtdHd30=;
        b=cbZjpQYxr6XET7ddNJqbVXFvEQ+URfUSopgfCZ/93iUPWjtOAppeXgOoOw3B8XgaMz
         SWn0N62SgUp/lKs5o7TySxeUzbGhPt6it7bgEvOQPoZFVpqjNmps4K0Kh9Bv8k2NmX4f
         k5XkqhF9JI9aFMQY8FHGZKSCgZwkvlnSfmb0wpv0Gay5SwE0B5srSsyBnS1Eu1ldVhH7
         FPXX1yhxdDc1vtri+gyfb5ghjM7cDimlr+ICBmfi1EDaSyQhW2PcF29LoFSsIr4JdqkG
         Sc8A0gsqtzRzLosXTKg/yK8UTyW0P/TkEmwztAcb+/UeDpdMZ31NdDpwbT4DF0q/0uBk
         RbzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3hDwAjvVep2X41EJq9Wz9Jgszm1vM2WLh9EOeG2G51AeDTDmjGJfjZyKv4Lae7mKOp8jPkxiSXq9tGZLS@vger.kernel.org, AJvYcCVOb9+VT498g4VZvKcD422+VbhYTX7zr48Yk3WItfAV35nFWyy1v1KCvKw2K7sa19MRJrhc5Ma/gHUgo8Zv@vger.kernel.org, AJvYcCXsJpQJzKk1v/tLZ1jnJ2jlZLv/u72uMCsam+kjmNGCHpbqRAzH4shodCZok3v09yiDlzOU9qP0HmajxPvYGOB5Y9079mK1@vger.kernel.org
X-Gm-Message-State: AOJu0YzD7Xf3oDcAxM5M+zvsoNIkSeXBj7Tou9D2s/XE2Z8j0XJKZ+U2
	tdyNF8oofmreD/fplDh23cQAQBmiqPVp5pOMDGiSmLwyUIS4OnMHyhv09yxOmp7/OPg+TQFF+6P
	BzWQ5aiB7waWl77k26As9mGkX6upXs4g=
X-Gm-Gg: ASbGncvWg37B4cB/101dKNDi3fqRvTss4DTjLVW12ASknp4tn1Kb03W0xP0B2ScTh5c
	updsuD3cDF8KLtFdvdBtdCvSwfb0V+DYUDSEbTQfiF31dmAB63yRuvXAdGdOoeD1Mq7rZSNBX+v
	dHuHLXWO5EmyfKmB/V5Vr75eqL4aZOEBNDVqAk32Vlbag51PRZMIDrKE7Ii4A=
X-Google-Smtp-Source: AGHT+IHfsipTBOrBmtFT7GZG6UDzG0vVw2z0woqGf3/bEZJlCMAuL+AJu9aIgY3I/btbmFrBU8zH1+gqRarQvd1X8rQ=
X-Received: by 2002:a05:6a21:328e:b0:21a:de8e:44a9 with SMTP id
 adf61e73a8af0-21fad099a62mr1146499637.37.1749769894244; Thu, 12 Jun 2025
 16:11:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611220220.3681382-1-song@kernel.org> <20250611220220.3681382-4-song@kernel.org>
In-Reply-To: <20250611220220.3681382-4-song@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Jun 2025 16:11:22 -0700
X-Gm-Features: AX0GCFsPrb9-9kAS6rfe7a4HatiSBxVB2VjpncLT3MoqwhOc4qx-mzIY4ikCyS0
Message-ID: <CAEf4Bzbmed8PVCb=1BVxgi2XoEmdoDOD276kTbbKOwwqXhv+Jg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/5] bpf: Introduce path iterator
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org, 
	mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com, 
	jlayton@kernel.org, josef@toxicpanda.com, mic@digikod.net, gnoack@google.com, 
	m@maowtm.org, neil@brown.name
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 3:02=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> Introduce a path iterator, which walks a struct path toward the root.
> This path iterator is based on path_walk_parent. A fixed zero'ed root
> is passed to path_walk_parent(). Therefore, unless the user terminates
> it earlier, the iterator will terminate at the real root.
>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  fs/bpf_fs_kfuncs.c    | 72 +++++++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c |  5 +++
>  2 files changed, 77 insertions(+)
>

LGTM from BPF and open-coded contract POV.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

