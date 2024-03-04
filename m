Return-Path: <linux-fsdevel+bounces-13502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D7E8708A2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 18:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DB0BB22282
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 17:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A837A612F6;
	Mon,  4 Mar 2024 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HnsgOAU8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EF861668
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574682; cv=none; b=lqa9rIcfaQoz7TxmE3FWo6rIcBkeKJJCxY/t15h1c21FQYLDlWdDINsKKv/C92fwu9mIYufcUodS5RBWafe3f8gwW5eEjXqd/cVCRmNkTFWofHhPhWpdkmOY26tBKxoNfSx1YHAD/2TR4yIFi9HvsI5Ft/90EiWG9pdXG1k70lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574682; c=relaxed/simple;
	bh=G7yQjxL+Qcildw8s7MDaEayyCBUSfVd8gX5j/o7Dm/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZjzJZcKIsTPzOsHNfMYLEW99HwoLDxzW4w6lIx+XhbJrflMkdQw0NyWDV+KT45aUk8T9GO8qsLKk+VIvJNDqfVfP204dmVU9a72ePbiqp0rLQ+ZkmhdVG4aK7uofMYHZaSNSBLzPLvgdlHZs6eK9iikIUJ0S9uG0dqNN4l1KwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HnsgOAU8; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33d2b354c72so3595955f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 09:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709574679; x=1710179479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOCRP+fJrD0G9ssZRMbCTHT/LFXOIHP8hjgv3KWmrE0=;
        b=HnsgOAU80nDkJeLW8bbS9ARzansz6Dq7tWrQFfwPWy/EFhlTsUs0VQSYRs6LQjn+/I
         qaJ8jBFP+y3M4OF4ERfHlqeMkj+P4xgCGOBPTHMSAAw/sscRKtdRu88MY0RPbmSo0dNS
         ylZGYCRzuTlzXyJgKwHl3zqBWRAXuLlhIZEReE5OUCVgE1XihXeCFapPShcoOQBfrdri
         cSFUD0vqJDTVCU8l85b8NNc/a0vgAHU+w5DtDzEq9yj8o3xvqD7C3bQ7KIq+qWjTd71w
         ElxpQ/baGkicm7CfGaVkBL7nNYdCavaBf2FNi4M8aQAhLpSKT/OSfeSiTZHKKcfcUVIA
         Z7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709574679; x=1710179479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOCRP+fJrD0G9ssZRMbCTHT/LFXOIHP8hjgv3KWmrE0=;
        b=La7Erxi8z+t5iLYvWy01ktRLqMw4SR95qDfu3IFTYXYA+DW1X5ywt+TocgB6TPtJID
         VKquhg6qtdvGlwjJrtqx9kpQaCU+MJV45BJFfI69hj3ThokHsWoL9e4PofQ50gbsMPj1
         2ybFRQtny0Vvf2RgcYeJ312qJMLhO6yOFqotpz8GkFtdk+c9iREjRa2QKmv7qqvyMzux
         jrjJtpWbKNunSlf/m1RaeWJONUXnPDVsEP8YcUwhT+bEt3g0EFdkncjRDmG3am5dAkqp
         ivxYPmwAuSrewN28WLBUZ+vpsdaoqWZ/nhTOJgKhp0oMBa0wDlEhVBuMe0dOvyDcnuBM
         8O0g==
X-Forwarded-Encrypted: i=1; AJvYcCU7ZvWdl6uyeOlOC7g2s8KDvqxbVHaja8zGTU+ka5dX0QIHATrFxBzFLarXCfImkjUeClRmz0rHBorLbFQSpPsKK2pmk741PZtTF9vjjQ==
X-Gm-Message-State: AOJu0Yx0fIG/40VcH7jowFWj+zuVExH2frqKSf+KpMQfB7RNLVonEB+2
	qdDE7GUfdagKfvMzdtY6pauFlhFGUyJsOEMNaX9lxKk82VhIzWWKM7BYkEGFt60bVLCEAT3+Xm2
	tvZ0w+1BViXX2nJfkgc8ke05JrHDD/uKNTghm
X-Google-Smtp-Source: AGHT+IG8OcFIwLQ1ch8T5SiElzbSL6ZWVmZp/xgRrugYGmXZy323LCxt0wnKZMvqtlBTLXN8pHKQLJx3H1EW18EyW4Q=
X-Received: by 2002:a5d:4f07:0:b0:33e:11c3:7ebf with SMTP id
 c7-20020a5d4f07000000b0033e11c37ebfmr7001268wru.62.1709574678572; Mon, 04 Mar
 2024 09:51:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ab2a337d-c2dd-437d-9ab8-e3b837f1ff1a@I-love.SAKURA.ne.jp> <20240304035339.425857-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240304035339.425857-1-hsiangkao@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Mon, 4 Mar 2024 09:51:06 -0800
Message-ID: <CAB=BE-SJ_KoR0Gb+K2YNLYrP2q1b=WscMR-z9HLCdeTgHE8-qg@mail.gmail.com>
Subject: Re: [PATCH] erofs: fix uninitialized page cache reported by KMSAN
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, 
	syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, syzkaller-bugs@googlegroups.com, 
	LKML <linux-kernel@vger.kernel.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 7:54=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
>
> syzbot reports a KMSAN reproducer [1] which generates a crafted
> filesystem image and causes IMA to read uninitialized page cache.
>
> Later, (rq->outputsize > rq->inputsize) will be formally supported
> after either large uncompressed pclusters (> block size) or big
> lclusters are landed.  However, currently there is no way to generate
> such filesystems by using mkfs.erofs.
>
> Thus, let's mark this condition as unsupported for now.
>
> [1] https://lore.kernel.org/r/0000000000002be12a0611ca7ff8@google.com
>
> Reported-by: syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com
> Fixes: 1ca01520148a ("erofs: refine z_erofs_transform_plain() for sub-pag=
e block support")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/decompressor.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index d4cee95af14c..2ec9b2bb628d 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -323,7 +323,8 @@ static int z_erofs_transform_plain(struct z_erofs_dec=
ompress_req *rq,
>         unsigned int cur =3D 0, ni =3D 0, no, pi, po, insz, cnt;
>         u8 *kin;
>
> -       DBG_BUGON(rq->outputsize > rq->inputsize);
> +       if (rq->outputsize > rq->inputsize)
> +               return -EOPNOTSUPP;
>         if (rq->alg =3D=3D Z_EROFS_COMPRESSION_INTERLACED) {
>                 cur =3D bs - (rq->pageofs_out & (bs - 1));
>                 pi =3D (rq->pageofs_in + rq->inputsize - cur) & ~PAGE_MAS=
K;
> --
> 2.39.3
>
LGTM.
Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.

