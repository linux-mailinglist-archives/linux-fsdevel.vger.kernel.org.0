Return-Path: <linux-fsdevel+bounces-22138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70325912C6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 19:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C211286DA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 17:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B98F161306;
	Fri, 21 Jun 2024 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ujsUDzi/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D4240856
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2024 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718990836; cv=none; b=V9GB1yUkXV3Gz3aPNIvrOH01r+lBUz0xrsH1ofwhweAhMYOMpaksLkiB9BVxZq41L5VcjS1MtC5gxT8z/eNnR+sGJAm+JcMhW+ozay8fu0kYr4ofFO64qKllZBBUq2bqYpmvsZE1z2PhJKriovf9oy6i9qg+g+334gkU0o8aDy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718990836; c=relaxed/simple;
	bh=wiGpqyGq0pz+671ybpoV6GcrH0nBUI9hmsIPKIpFk80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msL545m4fwfFdx8+zcKufRpbojHVHcxgDkHVOpEZ7HviAKpSPwtOygjFTN4OuPnwS2psyXhmnjUbDct5FlBfR9ErtyMF74Ijujw3uCJDZfn/c+lz3dF9VMTdUNSVTlmqIcw79Buvngx9sSURKFcx9h9UqnVCopqJbz8mn/t37HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ujsUDzi/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57d16251a07so21769a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2024 10:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718990832; x=1719595632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZEECrhQjBIpDFBsE7AD3QeFYzB3SERdZGpooJJm1Aw=;
        b=ujsUDzi/HwvcPF9/soVwA1ZwTO9rrjQovweXrA1bI6bylpMtysyAJjbHaaoOjdA8XB
         kaLrbhq5iESUHzUkouXVZdHweK1fTH4ITk8bldzbCIL26TfqJK4Mh/Q3ROzYe0xRdp4S
         7MfbSo5nns01rrxxGzBPD6RnfNcmNPoof6tSHqCU73rLFBzGuUGqVQ0hoNa/vq4xUTyi
         7V1dembfL3fa/hZcMEI4CRI8S71Ap9+P4boZaxKXtEgYS6OrfSvPn6Or5hLwrVOQv0hY
         3tlZK36UjP4lubBKEaeUNf2nGD2V5RVyjm96fQgsh0rUHL3E8ceH0g9RxeJlMbc6aLAW
         Rzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718990832; x=1719595632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZEECrhQjBIpDFBsE7AD3QeFYzB3SERdZGpooJJm1Aw=;
        b=JL7627qeeDUn0ppGvX9jtqk0xSC2OlpZ+q2bzb1UHZXEzRC1aJ7iHmJCpssv9ad0yY
         K+89YiqwVLX80vN3qIGUvgaJ3XeRMtE/g2ETjQKAdDj3OGFE8aiai7doSOWr7IMnXNp1
         UbGXqXZaKkYob9YHDhqcB5HYjD/6QELiZjC0vQC7rKF1v77dxGr+lwO1xTp94e7Yor6c
         0vfBNe01++lMF/w1NGqP2cgINakcvJrrlvAaXlZGhkr0NLJNz01G11roxtvDocrJId0M
         zxLbxx9KEWg7OK46XEmoKVYgyyplcQnt1rP1nvuh48jB6JXw/HyMsR4b/MGtMKng8p/M
         uIFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAmuRvjkMsVgcEDGCv7rXohNdjpISTW6g2q4Sw6qn22jfPJ+G0gUG6563uQ6CHDmoeJM/E+2XF+Va833/0qRzO4GSbXlwafpKbnUiWmQ==
X-Gm-Message-State: AOJu0YzILjTIvtoz/F8l4qCP64joNCJEyicA3I5OGqvLfiFCkZfL2aks
	mTc363mgtI7jY6Gyf/Y6V2sBizPKjgSfM0zMFGcpht7hannteUiZmz0HrIMi6I27DhsybAMrht8
	4y/TSp2O2lpTGnVp/M4hmjkvkY84osOq9YFWk97HGHTeLyCX0/w==
X-Google-Smtp-Source: AGHT+IF6tEiRT/9KGWlVNCP+9uwkKC3MsFDZH8IrIH6duITWkOQqgznDYKPEamEZ2wZ//k6/c8eXxVE1ENPTGHesQ7Q=
X-Received: by 2002:a05:6402:35c1:b0:57c:fb0f:1355 with SMTP id
 4fb4d7f45d1cf-57d3f1db8b5mr34243a12.0.1718990831973; Fri, 21 Jun 2024
 10:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621144017.30993-1-jack@suse.cz> <20240621144246.11148-1-jack@suse.cz>
In-Reply-To: <20240621144246.11148-1-jack@suse.cz>
From: "Zach O'Keefe" <zokeefe@google.com>
Date: Fri, 21 Jun 2024 10:26:34 -0700
Message-ID: <CAAa6QmRdzoMuf3PyLcYP1X_uQAWj9_1mB0oD5dYpPT4hJqFHBw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "mm/writeback: fix possible divide-by-zero in
 wb_dirty_limits(), again"
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 7:42=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> This reverts commit 9319b647902cbd5cc884ac08a8a6d54ce111fc78.
>
> The commit is broken in several ways. Firstly, the removed (u64) cast
> from the multiplication will introduce a multiplication overflow on
> 32-bit archs if wb_thresh * bg_thresh >=3D 1<<32 (which is actually commo=
n
> - the default settings with 4GB of RAM will trigger this). Secondly, the
>   div64_u64() is unnecessarily expensive on 32-bit archs. We have
> div64_ul() in case we want to be safe & cheap. Thirdly, if dirty
> thresholds are larger than 1<<32 pages, then dirty balancing is
> going to blow up in many other spectacular ways anyway so trying to fix
> one possible overflow is just moot.
>
> CC: stable@vger.kernel.org
> Fixes: 9319b647902c ("mm/writeback: fix possible divide-by-zero in wb_dir=
ty_limits(), again")
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  mm/page-writeback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 12c9297ed4a7..2573e2d504af 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -1660,7 +1660,7 @@ static inline void wb_dirty_limits(struct dirty_thr=
ottle_control *dtc)
>          */
>         dtc->wb_thresh =3D __wb_calc_thresh(dtc, dtc->thresh);
>         dtc->wb_bg_thresh =3D dtc->thresh ?
> -               div64_u64(dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) :=
 0;
> +               div_u64((u64)dtc->wb_thresh * dtc->bg_thresh, dtc->thresh=
) : 0;
>
>         /*
>          * In order to avoid the stacked BDI deadlock we need
> --
> 2.35.3
>
>

Thanks Jan,

Reviewed-By: Zach O'Keefe <zokeefe@google.com>

