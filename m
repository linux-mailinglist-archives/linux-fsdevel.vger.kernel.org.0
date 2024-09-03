Return-Path: <linux-fsdevel+bounces-28323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15BA969423
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 08:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41921C22E7D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 06:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8E51D67AF;
	Tue,  3 Sep 2024 06:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RS62UGoE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0481D61A6;
	Tue,  3 Sep 2024 06:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725346186; cv=none; b=ei1GrxWUwlOSQiYaUbNvqUY3VNo4g7XrUGiZ4Se8Yt+m96wcmtPKgP0IDCiZBDFIB9pH5kHwyW0dTF4ifPWDpyUMhxWtaFrblrNKaZ+H//bEtvByfmBIGpdNAAoUF5cxiid/6keZ1hl3Umw7TiZMJVZDRAlAdQod1NMcXZGnW/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725346186; c=relaxed/simple;
	bh=r6cxBevIDpBm4tvmRIUZoK81w/uMXlM7aBkxassD7EQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAjdqM7MD+PeHiHQFBrqlSZgNDGLW5rddA8u4SxkFU66gzTBrpK1nKSMnrfj6opYjKGLh3AGovYu/ZOs1OcSPH+u/tN6EKZxOsEqliqFZcSw6sIctk50YUWdJTZCT6bXmLOmIHRZEzVEdSiG3GhCLgOD9fCGS78oSqIqD6qpaOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RS62UGoE; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4fcfcdcb4acso1653348e0c.0;
        Mon, 02 Sep 2024 23:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725346183; x=1725950983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jABLFheZ43ik7Qd1Q4D+4/nbyOp1VA6ToPIDpMFWTe4=;
        b=RS62UGoESXHAsx3qPHUiNKLecfMdiEuuJaJqm2FfETCK3bgAEgVNwRnLt82fKBPGQQ
         PSGjc+dPojRCmo5T4MiBSTSMTgMjraN1L2kcwLHQBzYhhEkh3bYR93r0G8baRFBbU1uW
         TZw3GeVFKsz+CYNFmqK1oqTYM8nwSLNios1/ujE1g1tRuPPa7ZPpEGeXao8AmfpFZSwQ
         t10vrrNhQ0K/32phY8G3dzjV/Rq9SymADJqfQQo675jsifJsZPP0iwFRGarFT8qety2g
         1rfrzXg1FPC49ytnoh4qmwxGO0bNgGaxcNmVxPCqCZz6U4AIvIOpQAOF5L+LiIRM0fiO
         +aVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725346183; x=1725950983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jABLFheZ43ik7Qd1Q4D+4/nbyOp1VA6ToPIDpMFWTe4=;
        b=BG5c88LD7uT7Uqn9CmDgpd+wN9+SR0fCaRX8skGElMjFLtCQPDpUGM8Vb8zaSOpxy4
         8VU2gH68o+NEehU5Pq2zgDYaiC6LEM4Si82d05W9IfDUp6iQXO7tRdFuGuoMm98LL+Zr
         55MuROBzlOaDAez+KhWdsnYHRnvfKJ9facaqEhx+Fdrfed7RcA19TfQqmdaAFPSOLgl0
         sf6ie6chC4EcKWoonjcCc04sOIvoR54bVjwHK5TBBU/BVY/RUrIfQp07o0MC+0dyajsp
         FiWbLbM+BRH5RvWdYnvjHIS/zAVqkY+4zY5FaaJlOCwOK/mO5y8IHkG68C2G5PwxZmkg
         jk6w==
X-Forwarded-Encrypted: i=1; AJvYcCUrVXxannH5La292SOcEwpbLgmu8CEYqEQP+xZgNRjES+iuSQJStwHCE1vmQTTbw9kq0UyYN7gw8rvtYEYY/YFKGg==@vger.kernel.org, AJvYcCV7tOHn/AOqJ28V+iBfZRq4ZYhrdfUh+xoCnjv5rygVy6lZv+A9FP8VOe87DQ3oLRx+4ANB6wXOpiKB@vger.kernel.org, AJvYcCW2BI1oCo2dw5CgGlfJhK8cxFDCibAKETTAkZCmRMbUd5Q2nec+Gz7zNUAbLtJCMbMOaimLkvYuMJc4sE26@vger.kernel.org, AJvYcCX4Nhds8cLH7OI88xDzy344ONyIOYeorwdquw1aBawt3fPIKLD7s/CeqW/cF2VBP0jzFQ43PwcsGBc=@vger.kernel.org, AJvYcCXSINubhNmrRtqt86LZjygV+Xwby77PZBugR3LWZ7O3Lgdklf0JFIpvBHHg7G9m5S9FHUXfhxe5CxoF6wQZhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrrbhU1PzVuRoJSpFz6JQSm+/xOAIE1rcE7bgX1Yu3x73/HT5B
	p4m0PNUl4Y63JZ43jsbvLubV3Pq389uYPzqkkpvohICeaIHw97UDosNmUOABWtdciSwGgLR6fSv
	gjWq5w97eA06R9HHg6DFRjDWlEvM=
X-Google-Smtp-Source: AGHT+IEjSi1Nhm40ZmIKTSGp1qO/Ql+telosUq7bdIzgliWrGKdPuR061Ro5l4hZctY1PB+wjGgyCzdZ7coDdylCNvM=
X-Received: by 2002:a05:6122:2218:b0:4fd:762:8649 with SMTP id
 71dfb90a1353d-500de453969mr1158684e0c.12.1725346183294; Mon, 02 Sep 2024
 23:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com> <20240902164554.928371-1-cyphar@cyphar.com>
In-Reply-To: <20240902164554.928371-1-cyphar@cyphar.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Sep 2024 08:49:32 +0200
Message-ID: <CAOQ4uxhw+WMUQtaBZ1v863p-DGLbkip7p59_DM54BB=DCjJ-Gg@mail.gmail.com>
Subject: Re: [PATCH xfstests v2 1/2] statx: update headers to include newer
 statx fields
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: fstests@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Alexander Aring <alex.aring@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Christoph Hellwig <hch@infradead.org>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 6:46=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> wro=
te:
>
> These come from Linux v6.11-rc5.
>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  src/open_by_handle.c |  4 +++-
>  src/statx.h          | 22 ++++++++++++++++++++--
>  2 files changed, 23 insertions(+), 3 deletions(-)
>

This patch conflicts with commit
873e36c9 - statx.h: update to latest kernel UAPI
already in for-next branch (this is the branch to base patches on)

> diff --git a/src/open_by_handle.c b/src/open_by_handle.c
> index 0f74ed08b1f0..d9c802ca9bd1 100644
> --- a/src/open_by_handle.c
> +++ b/src/open_by_handle.c
> @@ -82,12 +82,14 @@ Examples:
>  #include <string.h>
>  #include <fcntl.h>
>  #include <unistd.h>
> -#include <sys/stat.h>
>  #include <sys/types.h>
>  #include <errno.h>
>  #include <linux/limits.h>
>  #include <libgen.h>
>
> +#include <sys/stat.h>
> +#include "statx.h"
> +

So probably best to squash this one liner into the 2nd patch.
I guess Zorro can do it on commit if needed.

Thanks,
Amir.

