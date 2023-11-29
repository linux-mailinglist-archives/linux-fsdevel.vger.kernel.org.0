Return-Path: <linux-fsdevel+bounces-4205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 070307FDD35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 17:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04EB1F20F2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29918374DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="G1+EBO0I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B70AD71
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 06:41:37 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54af4f2838dso7459189a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 06:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1701268895; x=1701873695; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ashHbLgjB5VwyZxWlyhUbauOEA+rSvNdvJ02T1Z5CVU=;
        b=G1+EBO0IT8s03uAys6Itp6BiIALUoQmxSOgJI5Ug8DNOji9KUgMvHZd84E9FIfoZLc
         JdIHWwZnnqFZ6m58mNBXOI+igjughr33rXPy4ncXvyMma//G50E1R1QAJPtn7XG77SU1
         O7mNmH/qQx5x5GY8kYC+Awcnt48W5LLpytaTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701268895; x=1701873695;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ashHbLgjB5VwyZxWlyhUbauOEA+rSvNdvJ02T1Z5CVU=;
        b=DkVmEq0ioMvMj843iPzm0R8vGjPJk8MzYSlLTJGI1RGcRdwWUMGmGLqUajd9EjhkwQ
         ru7UCAkdkQ46RfDOXf3INc1cG/VPM64qaErNd6L97p5YC2bXT8Zy95RiiCL7QxU4t6mB
         /KFK8LRE28nUyYR/bljEKj+XiKc0TW0YebdlZpXiSe2HJlrWD5SslHkmsD415FJQ1ML3
         Zi3OFqjelr4KSMeQ928QrfCPtBeoBzDTDIAQZVT2B4rxl30L2Dtr96MSlhDTrGZH3TrI
         3IVPDio/wMccdVci7ZTJ5VWxOB2n+B0H4aOyqB6hu4IjY6iQ7uOeZqL2hpkUSiFl0MEP
         O2MA==
X-Gm-Message-State: AOJu0Yw9Hmgp7ydeYz1dgX10z1s6iv4draHnemYuWkcA+6lHKcw2BVaM
	jdIRQru32TLfHjOLAhelOpz+xZy9YxgXuOxoiJ/fQpDaZYxGIviK
X-Google-Smtp-Source: AGHT+IEiRN9ZbNNb7SSogtcORsnPx0u5jGStWANmL5M3P+SmilVbX47A4REPRxt9xuT7sbyBZSS3YwG81jxxv5KsXCc=
X-Received: by 2002:a17:906:eb01:b0:9ff:64d2:6b28 with SMTP id
 mb1-20020a170906eb0100b009ff64d26b28mr11422138ejb.55.1701268895155; Wed, 29
 Nov 2023 06:41:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129094317.453025-1-winters.zc@antgroup.com> <20231129094317.453025-2-winters.zc@antgroup.com>
In-Reply-To: <20231129094317.453025-2-winters.zc@antgroup.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 29 Nov 2023 15:41:23 +0100
Message-ID: <CAJfpegscW2xFSNd-EFhD2OzAyDt0r4OffKKuS_uwUx09O+hcvg@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 1/2] fuse: Introduce sysfs API for resend
 pending reque
To: Zhao Chen <winters.zc@antgroup.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Nov 2023 at 10:43, Zhao Chen <winters.zc@antgroup.com> wrote:
>
> From: Peng Tao <bergwolf@antgroup.com>
>
> When a FUSE daemon panic and failover, we aim to minimize the impact on
> applications by reusing the existing FUSE connection. During this
> process, another daemon is employed to preserve the FUSE connection's file
> descriptor.
>
> However, it is possible for some inflight requests to be lost and never
> returned. As a result, applications awaiting replies would become stuck
> forever. To address this, we can resend these pending requests to the
> FUSE daemon, which is done by fuse_resend_pqueue(), ensuring they are
> properly processed again.
>
> Signed-off-by: Peng Tao <bergwolf@antgroup.com>
> Signed-off-by: Zhao Chen <winters.zc@antgroup.com>
> ---
>  fs/fuse/control.c | 20 ++++++++++++++++
>  fs/fuse/dev.c     | 59 +++++++++++++++++++++++++++++++++++++++++++++++
>  fs/fuse/fuse_i.h  |  5 +++-
>  3 files changed, 83 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> index 284a35006462..fd2258d701dd 100644
> --- a/fs/fuse/control.c
> +++ b/fs/fuse/control.c
> @@ -44,6 +44,18 @@ static ssize_t fuse_conn_abort_write(struct file *file, const char __user *buf,
>         return count;
>  }
>
> +static ssize_t fuse_conn_resend_write(struct file *file, const char __user *buf,
> +                                     size_t count, loff_t *ppos)
> +{
> +       struct fuse_conn *fc = fuse_ctl_file_conn_get(file);
> +
> +       if (fc) {
> +               fuse_resend_pqueue(fc);
> +               fuse_conn_put(fc);
> +       }
> +       return count;
> +}
> +

How about triggering this with a notification (FUSE_NOTIFY_RESEND)?

Thanks,
Miklos

