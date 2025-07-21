Return-Path: <linux-fsdevel+bounces-55609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 532A2B0C81E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 17:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978AD544498
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 15:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0812D2E11D5;
	Mon, 21 Jul 2025 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqzH6sQ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF772E0902;
	Mon, 21 Jul 2025 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113097; cv=none; b=V1TNmaWBW+MdUWTkW0PFGl7pCrKcjy889ak1yaSjr/SV4jIw+K4wuE5735le7GMKUtMBr2MAhaJj0hEW0PQO5FeJ3NmJ87m2vX3jCm4DLdY5J4VGvAZwNdsURI0MzYWB7gxf4xYKfrGj/A08akfimum63Os8kZHPa4v+4XowVmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113097; c=relaxed/simple;
	bh=5XMysMMXpehjqqR2u+P47tGjPv3TyoZWsI8PZ5C8ZUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/CEJY0jnzdpJGOd5Xu7iFnFkwijMDv4hr4VsHQfOUvjQByZYP6vM9Wzbn9nCDc1nerYXFtH8KBNK+sp1iWQ43zFDTsBbr718pXUxjvZdw/uowvLyemFuugCMYfdsCnyQz+7f8hKzzDvW5E8O4BMRJHu2zevBt9Q6AdwgaheHPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqzH6sQ2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso4357337f8f.3;
        Mon, 21 Jul 2025 08:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753113094; x=1753717894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XMysMMXpehjqqR2u+P47tGjPv3TyoZWsI8PZ5C8ZUI=;
        b=LqzH6sQ2OKozdN92/fL2hZbkaXql8qt44wonHGcA+SfEnQCDJqGgnY7Oo/VFCRkXtA
         RP/bclD9HcYhQt11Rei2K6jw/z3uQRn/T88DA3FRBP0BAHtMbnUdyz319uNPWcC/xqod
         UyIBFJ1w6ubnPYfh/1oW+mfdh4gu6Y0kkf/cBoRa+sBK/bb3u6o4Kdlv3d6qCuBMXLKM
         El8DCxJVnoi6tZM02+L48c0nl2MFXzzrmTxZ9YktLcF2bCMyWDDE32THWlaooaROzCDp
         Vxq147KnAc03SxJmUFaUukyOQ/p5egPkn/2xW87/x8Xb0I+AqtT/Cb0HeNs4os5Or1P2
         3Wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753113094; x=1753717894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XMysMMXpehjqqR2u+P47tGjPv3TyoZWsI8PZ5C8ZUI=;
        b=LtthrEvI6Jl0eQHdDB0LlhRyur1wrErVD1Q/a8qkEbqnWaYzVaWdj9mfHyhUT2TesD
         uKpYtQrYrfWZduWSr9HLZZYlSWu1yohzNGruAqOPiwJ46J25nG3CTBDMixKVyVm+QAXa
         9Bogq5RONM6Y/eBKwVMtq0mFBmcY8Vc/geqrPwjgj6mIYIN64X43/THZzevc4vusoxlw
         MvCdsLbnd9zAAuQmss7INsAh7+GFtmXgUFhP3G7r91VD8pXR3wfSHS0c7F8X2gGWSoYr
         dnoUl/+EfxyKkyhzAqg3OEYXtcg0V7d2iqzm0JFDykbq719g6s1eWQum0eqTxKEUvlYv
         YBjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZPgSOwkqBBrxK7cT1fWan8G1wxcEU3uQVqNW4BS+9X2LSmd9Yuhj08S01GtYfX7Q0Vq1SVDspRFpGlngY@vger.kernel.org, AJvYcCUavz6s4dRXEM/HlWVXS4GlC9QfbDWNAXvCxw5cGMRAveHebYc4hXYp26V73IsW5oDlPR4=@vger.kernel.org, AJvYcCVZYD0HsPR0dmopw/WnF5eMSS2Dfbim6QG1ynck1gZ/kxWcs28DtnsijiRBfm/pTEJw/MNvB2eN63m109l4/g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6GpW+94P3lIDCMevoxY/ieR2cWZnq5gnSVZsqKh16al6zBP9U
	Sei/Yyh0pcaTRcFjizdtJ4RR+IEGFdzxk8g+n9L+FzhBUFhZFCJTr8BghpCP58YEPxLvsmTiA7G
	W+KzoWlUPithVXHoeM/QmIiAj3eE2uaM=
X-Gm-Gg: ASbGnctvEhMfpnnmZ2/o/Tvwd6ztbSNgVeHVkOKPSO5G+Z8SfhDEDfQkGLONWVIHxUC
	4toh0duv0bhbex+Vr/44pwhFTfgG9qjtLFQWUGLnXtCPdlkWG84B1m7BqFGhn7llZ4MgotGOnID
	KM3vqrAXDJKdJcg67TAdiPIf2OYR/0r4DC5AbyBKIAUETySOF4KB8rdMNYAJ4Y0JRBtJp3/NDfj
	peeX6/Xig==
X-Google-Smtp-Source: AGHT+IHrHhq+dYpMaz3nCXiO4FUHfaZDPUxmqax+tKgZZloikFKERJtZ7/w6CC7wfkOD7JkR7v4iIZZBavPwHPC2fT4=
X-Received: by 2002:a05:6000:43c8:b0:3b6:936:976c with SMTP id
 ffacd0b85a97d-3b60dd4fademr14004586f8f.17.1753113093864; Mon, 21 Jul 2025
 08:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721-remove-usermode-driver-v1-0-0d0083334382@linutronix.de> <20250721-remove-usermode-driver-v1-2-0d0083334382@linutronix.de>
In-Reply-To: <20250721-remove-usermode-driver-v1-2-0d0083334382@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 21 Jul 2025 08:51:22 -0700
X-Gm-Features: Ac12FXxaIv2U_gNudEqMNsu5lhlwi5shFVshXODMjX2h-Ud3NFFOOpUhlz28tK4
Message-ID: <CAADnVQ+Mw=bG-HZ5KMMDWzr_JqcCwWNQNf-JRvRsTLZ6P7-tUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] umd: Remove usermode driver framework
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Christoph Hellwig <hch@lst.de>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 2:05=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> The code is unused since commit 98e20e5e13d2 ("bpfilter: remove bpfilter"=
),
> remove it.

Correct, but we have plans to use it.
Since it's not causing any problems we prefer to keep it
to avoid reverting the removal later.

