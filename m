Return-Path: <linux-fsdevel+bounces-45500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797F9A78A37
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 10:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6479C3AF31C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 08:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826B12356B2;
	Wed,  2 Apr 2025 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvehnBjb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDC02356A7;
	Wed,  2 Apr 2025 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743583366; cv=none; b=AcW/4phRHvqqbA3vWwzS1QZlhjQUi4p2VvUM0RzJkb66cgVEEMZWp289lKLx8wWSCWk0JHpCltQRcQDYZP4aaYK9aHMj6qsytWkQCcymvTot5kQ5A4PBz0QrCuWKGBlnJEaTesC1EeMnE8yEirMfufiS5uhf+c2HtEX3p8MOkVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743583366; c=relaxed/simple;
	bh=DVwcISZS5xhVIQrAFTZKj0OmT2lqUmyK5yPbdCdC0Go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibr7Vh7MMybiYicLO2oOXIrEstDnHaw0CS8J2HgCOW98XZpq5KMPqr249eUOSUGU1hBZ08GjWqpYHKR1CAlT9odxkOBbKeQHTfq7JOnnfwcuesvwy2xdW6LAaJUSJjirhaAEYOrvtrJx+7zc9LAThWXxoXUP6MvmDzlqpYsGuU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvehnBjb; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4769aef457bso69610121cf.2;
        Wed, 02 Apr 2025 01:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743583363; x=1744188163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1I7NeXMNkcuNFfTBD581NZoOi50eOmbz4OoopGU528=;
        b=fvehnBjb+zKS3dYxalIo84xiS7znPDwJ28tx9tGtfYv53WeoVgLM3r7LZ8RMHErMfF
         2LT7v/kndf7nCzJOHTJDG2YLis+Mb3OJEQuU0WUeALqoAEgqa+mk1agk0RayLcX4Byn4
         VMeLUIAup4lIUSDEiFXOKNe1U4vYO/IbpGPG6hlGxNbCmnMV6KfRLkRJyWfqd3gXzdN5
         A22bJ4jOuOx1gdP/kJrfzvL5Hz73BN/RswwCLxjmxvL2y6xZiBae+LDCFGDz/bGE7HKl
         +ZSvabeuQhzZeUYmjeLm24bhvB7W0vuVcVDUHiyn0ogj5DQCkoixqtPwiAOTimL6Y/qc
         jauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743583363; x=1744188163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1I7NeXMNkcuNFfTBD581NZoOi50eOmbz4OoopGU528=;
        b=b2I7sBdJjR2jiE8uDqHvB9UnWv7H10jVDslJsfkBlD4cZZhCGzD3ovJ8utHBjVvLGf
         KuLtNoK76Tvrr9HUlWU1PVUXzAnRHlmWJjbVuRGn7AY64lo+Q7QQVpHR15HonqzI2mWJ
         GdRhl/XV76BirT/wkAUb3rDnpa/JgGYF9mwQdj/ngUrLAcnXGpdTDcsV/pjSikaPBrGD
         ry7gY7fxk98h16fTnh16jr8haMLUqQD7CcOW0isYQU+1Bwnug7CN4TAeOggJR+Sqm9ly
         xTfIOhZyAlhkLLMC54+RWn0f2Qqt/gR0VGUfY2hy81kITbC9zSOtSN3h/i/R1FalFZSl
         iaIA==
X-Forwarded-Encrypted: i=1; AJvYcCUnedrbLn1MguoB3pjlhO3w/nBI6YSQFGKO8g3PhwJhN9EcC0PPWeZuEJJDJ4Sg2kEptWFEgoa+c0kihSE+@vger.kernel.org, AJvYcCVk7KnWqKjONHOsSbe9lhVOQDDPVNC02G6pfNF/Kq6jIKYNR53+F7/hwdohH4nqrCpc+VDgGeNa3yyiYeWz@vger.kernel.org
X-Gm-Message-State: AOJu0YzFajp9NDx3XFuXH8evXDINlTk+sTqfnyWK+jh2HYp6GrPTZv6F
	Fp9sfIgMJdJ52AStrn7gUj+uFkI5ZQCnjjGEYo/PyaIUds0zzj3Ar/v9/Plfm0TcKO3abzd7nW3
	VuHUTc0yztVZ5Z0qtTpaViITFQoI=
X-Gm-Gg: ASbGncuHcA9gHVorv7YEREDSHvV4yzWnZVIwezw1sxvhH1qDZXZY5VFZliDyl/PXAjj
	3AImNWipKvaTpfIw78zSeII85yJIykeMqJdKfdFTD8BTTYwDD1ZhgRIa0SDmfKVr5haaUfJgRLd
	tjCL/JbwRLZG7/FTw1EDMBPnVYzfKm7Yv2Dwp7Tw==
X-Google-Smtp-Source: AGHT+IFYItNwpA/Wk64fkLYr+wxWGKsPgs8JlMhSDN7+WlRwbB7s+zxhsfXmxj67a145bRcVX0Ifs2rteI5yjKCiItA=
X-Received: by 2002:a05:6214:268f:b0:6ec:f51f:30e9 with SMTP id
 6a1803df08f44-6eed607395emr207393826d6.4.1743583363170; Wed, 02 Apr 2025
 01:42:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401073046.51121-1-laoar.shao@gmail.com> <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org>
 <Z-y50vEs_9MbjQhi@harry>
In-Reply-To: <Z-y50vEs_9MbjQhi@harry>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 2 Apr 2025 16:42:06 +0800
X-Gm-Features: AQ5f1Jp1Gg98RRdYNOuPRGyWDo5u7etjGkFPUh0Mpr13QaH-ygBKif10moy_dUc
Message-ID: <CALOAHbBSvMuZnKF_vy3kGGNOCg5N2CgomLhxMxjn8RNwMTrw7A@mail.gmail.com>
Subject: Re: [PATCH] proc: Avoid costly high-order page allocations when
 reading proc files
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Kees Cook <kees@kernel.org>, joel.granados@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 12:15=E2=80=AFPM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Tue, Apr 01, 2025 at 07:01:04AM -0700, Kees Cook wrote:
> >
> >
> > On April 1, 2025 12:30:46 AM PDT, Yafang Shao <laoar.shao@gmail.com> wr=
ote:
> > >While investigating a kcompactd 100% CPU utilization issue in producti=
on, I
> > >observed frequent costly high-order (order-6) page allocations trigger=
ed by
> > >proc file reads from monitoring tools. This can be reproduced with a s=
imple
> > >test case:
> > >
> > >  fd =3D open(PROC_FILE, O_RDONLY);
> > >  size =3D read(fd, buff, 256KB);
> > >  close(fd);
> > >
> > >Although we should modify the monitoring tools to use smaller buffer s=
izes,
> > >we should also enhance the kernel to prevent these expensive high-orde=
r
> > >allocations.
> > >
> > >Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > >Cc: Josef Bacik <josef@toxicpanda.com>
> > >---
> > > fs/proc/proc_sysctl.c | 10 +++++++++-
> > > 1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > >diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> > >index cc9d74a06ff0..c53ba733bda5 100644
> > >--- a/fs/proc/proc_sysctl.c
> > >+++ b/fs/proc/proc_sysctl.c
> > >@@ -581,7 +581,15 @@ static ssize_t proc_sys_call_handler(struct kiocb=
 *iocb, struct iov_iter *iter,
> > >     error =3D -ENOMEM;
> > >     if (count >=3D KMALLOC_MAX_SIZE)
> > >             goto out;
> > >-    kbuf =3D kvzalloc(count + 1, GFP_KERNEL);
> > >+
> > >+    /*
> > >+     * Use vmalloc if the count is too large to avoid costly high-ord=
er page
> > >+     * allocations.
> > >+     */
> > >+    if (count < (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
> > >+            kbuf =3D kvzalloc(count + 1, GFP_KERNEL);
> >
> > Why not move this check into kvmalloc family?
>
> Hmm should this check really be in kvmalloc family?

Modifying the existing kvmalloc functions risks performance regressions.
Could we instead introduce a new variant like vkmalloc() (favoring
vmalloc over kmalloc) or kvmalloc_costless()?

>
> I don't think users would expect kvmalloc() to implictly decide on using
> vmalloc() without trying kmalloc() first, just because it's a high-order
> allocation.
>

--=20
Regards
Yafang

