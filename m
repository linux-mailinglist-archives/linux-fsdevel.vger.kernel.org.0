Return-Path: <linux-fsdevel+bounces-68216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE30CC57866
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D295E3A1469
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 12:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC661350A0F;
	Thu, 13 Nov 2025 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hbrP0trb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BA43502AE
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038679; cv=none; b=TJrANxO2QKmXeG9bdhmyWgHlzSmsDdWShxKHb8Bfg9cj9c2JdZQwgR5EXBXoTJ7HWnm2FX/jNUrw8yMSkmfYS84r39U/4s/ANQAfrbgetBFjHmSxdCG89aStAacK/oJTu7vQ3NRJVHKQL+Vgevhx7xcBrAztqk/yceie0kOWp2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038679; c=relaxed/simple;
	bh=UuykYNghY8cjdLXcnioQh+q4Y/0JQBN6iWveDbD24zI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMTimp4QxJ4pI/yy7egU125gNlbB5hLlSDP1i8YcmcKkNasdVn0PFAjqGqtFUkCEwhfR0tOSfJB95aU7j6VqCsuIlwtPlZ+kVSgRLXAOXDrr2kwBf9MRpC6aHJx/ip7IWkC5joIWoXS1M89WRGJbjf1Rx0ILYs/+//jzKufIL5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=hbrP0trb; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ed82ee9e57so10293811cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 04:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1763038676; x=1763643476; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JV5AC59Od/LO61Xrf+sQtKn+a1SsnrSa/ocpfU5ZRqI=;
        b=hbrP0trbCDmGZiPiO2Rpn1GduWgFvDpGS7fw1GuLKY9JcD6wKGPusAzWhzbQGk2mn6
         7bvAjXbgLqUqO/aMfKrwUNw4nKqL56+Ey+3ognO8NIPCI1gAsEG67RNqN3IkXDKQBLr6
         QgczD1q3fBdWJUA68BlsPIe5s5D0AIKVkugEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763038676; x=1763643476;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JV5AC59Od/LO61Xrf+sQtKn+a1SsnrSa/ocpfU5ZRqI=;
        b=dlidYdu6GWm6FU/J38XdmhbPGdKD0Y63Sm2NvCVg8Ozp2R9qxgBRkGZgVL3quPAf8a
         qwIiE0E0NwJnT+oiIxMDykHOhhTUXwVqMZQNXb+zgVSwWqG+LEno5Rec0fTJuLOIBvAv
         pyXTLHU/+dIluOoftsmlljgFbHxw6kDEYX+yP6EnoJ5cni1BG4gIGTMYcSWXkfU/Hgzk
         Y6pKErlLjr9O2ngSygiy+t06VI76BpK60yhCN+bSp3kWc8xwX3ftMTFjFGTX8lrQSb3t
         JfE554JS0t58drcQX1PR79nlKmzYk4kJSQMxfPxgRr2D0k/oEbKVHzz9xhVG3ZIG3Pqa
         xgMA==
X-Forwarded-Encrypted: i=1; AJvYcCUyBLd1Y2MfGNznkMAE4wJeAxlImKD5tz2Su0uD9tvKLJCxKEQJE8MF0L8oyeelLsk7yB8ismRlAmbjcsgc@vger.kernel.org
X-Gm-Message-State: AOJu0YzvFaaKz7MMFMZdai0FqrVEjeZWzTpL+a64HoYm6saUmX3bTREW
	gnAO1rACNbi7hImyns75ClmrW0BHmQXnGvl/0xtldBg5sho5y6DZgXMLPRY9FOatYJybeMdtxP6
	PGztS/mtPNyuel4U3T2qP/i0L5ihaSYvo0TtnPlGNcg==
X-Gm-Gg: ASbGncuAa0nyeeWRgS+8ttQevrVTpCSf4u9Suvf/6RIXnjA3HHkvjuTsGSBKZ2DBm9p
	RO/zPT5RGBkMiDaToY+Q+mkJwZIqgMACVR8rXWbtgwyRHw5utEP8nzF8R14wMz7Yuh3sO3XzCm3
	EVPE7a+8j2ShjTxT2yyPHvxm+Rkbf410bNrqsy1ALytg4KsT1NAlzDNDlFooMXamVRr5EZlTsXp
	tjEbf+d92t33nKbbbJZSi/Mwutuu5leuOq9jRGlO1hDojDnKOjbOSizrvDG
X-Google-Smtp-Source: AGHT+IEkue0vILCzJ3nMj3uJJ/DyMAkFMn6fvJWDL0szaRfV89d1DYt6jZ9Jd9WTAdCQBL3Kef0VAnEQq9umHAMQkt8=
X-Received: by 2002:a05:622a:1a20:b0:4ed:aa2b:169c with SMTP id
 d75a77b69052e-4eddbdd69femr93851171cf.71.1763038675839; Thu, 13 Nov 2025
 04:57:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109053921.1320977-2-b.sachdev1904@gmail.com>
In-Reply-To: <20251109053921.1320977-2-b.sachdev1904@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 13 Nov 2025 13:57:44 +0100
X-Gm-Features: AWmQ_bltIenYvXBn-XTkyay6sGpGShW4dw_IBjKv2NYTfBsQfpdOMLqKp6YJUwM
Message-ID: <CAJfpeguX8syNaGZahMeOD8cE4ZaQEropPTBMyCXLvgkHgGVjqg@mail.gmail.com>
Subject: Re: [PATCH v5] statmount: accept fd as a parameter
To: Bhavik Sachdev <b.sachdev1904@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	criu@lists.linux.dev, Aleksa Sarai <cyphar@cyphar.com>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Jan Kara <jack@suse.cz>, 
	John Garry <john.g.garry@oracle.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Andrei Vagin <avagin@gmail.com>, Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Nov 2025 at 06:40, Bhavik Sachdev <b.sachdev1904@gmail.com> wrote:

> diff --git a/fs/namespace.c b/fs/namespace.c
> index d82910f33dc4..153c0ea85386 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5207,6 +5207,12 @@ static int statmount_mnt_root(struct kstatmount *s, struct seq_file *seq)
>         return 0;
>  }
>
> +static int statmount_mnt_point_unmounted(struct kstatmount *s, struct seq_file *seq)
> +{
> +       seq_puts(seq, "[unmounted]");

Please no, There's statmount.mask for this purpose exactly.

>  static int statmount_mnt_point(struct kstatmount *s, struct seq_file *seq)
>  {
>         struct vfsmount *mnt = s->mnt;
> @@ -5262,7 +5268,10 @@ static int statmount_sb_source(struct kstatmount *s, struct seq_file *seq)
>  static void statmount_mnt_ns_id(struct kstatmount *s, struct mnt_namespace *ns)
>  {
>         s->sm.mask |= STATMOUNT_MNT_NS_ID;
> -       s->sm.mnt_ns_id = ns->ns.ns_id;
> +       if (ns)
> +               s->sm.mnt_ns_id = ns->ns.ns_id;
> +       else
> +               s->sm.mnt_ns_id = 0;

Same here.  Please clear mask if the requested field cannot be meaningfully set.

>  /* locks: namespace_shared */
>  static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
> -                       struct mnt_namespace *ns)
> +                       struct mnt_namespace *ns, unsigned int flags)
>  {
>         struct mount *m;
>         int err;
>
>         /* Has the namespace already been emptied? */
> -       if (mnt_ns_id && mnt_ns_empty(ns))
> +       if (!(flags & STATMOUNT_BY_FD) && mnt_ns_id && mnt_ns_empty(ns))
>                 return -ENOENT;

This check does not make sense without the lookup_mnt_in_ns(), so
please move it right before the lookup.

>
> -       s->mnt = lookup_mnt_in_ns(mnt_id, ns);
> -       if (!s->mnt)
> -               return -ENOENT;
> +       if (!(flags & STATMOUNT_BY_FD)) {
> +               s->mnt = lookup_mnt_in_ns(mnt_id, ns);

A comment would be nice about s->mnt being set in caller for the
STATMOUNT_BY_FD case.

> -       ns = grab_requested_mnt_ns(&kreq);
> -       if (!ns)
> -               return -ENOENT;
> +       if (flags & STATMOUNT_BY_FD) {
> +               file_from_fd = fget_raw(kreq.fd);
> +               if (!file_from_fd)
> +                       return -EBADF;
> +
> +               fd_mnt = file_from_fd->f_path.mnt;
> +               ns = real_mount(fd_mnt)->mnt_ns;
> +               if (ns)
> +                       refcount_inc(&ns->passive);
> +               else
> +                       if (!capable(CAP_SYS_ADMIN))
> +                               return -ENOENT;

Why is this not EPERM?

I think this check belongs together with the  ns_capable_noaudit() check below.

> +       } else {
> +               ns = grab_requested_mnt_ns(&kreq, flags);
> +               if (!ns)
> +                       return -ENOENT;
> +       }
>
> -       if (kreq.mnt_ns_id && (ns != current->nsproxy->mnt_ns) &&
> +       if (ns && (ns != current->nsproxy->mnt_ns) &&
>             !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
>                 return -ENOENT;

(This should also be EPERM?  Searate patch, though).

Something like this:

        if (ns) {
                if ((ns != current->nsproxy->mnt_ns) &&
                    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
                        return -ENOENT;
        } else if (!capable(CAP_SYS_ADMIN))
                return -EPERM;
        }

Thanks,
Miklos

