Return-Path: <linux-fsdevel+bounces-34477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 035129C5CBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 17:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4BB1F23B3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 16:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CC2205AAA;
	Tue, 12 Nov 2024 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtM8kyOU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F04E200CA8;
	Tue, 12 Nov 2024 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427165; cv=none; b=DJQfxJ2YIhAZjZRm9AbXimxm/atO9/IpHRJc5XzD5OjBazNj9RpurdcngRyNZWQ6AqfI/Q3Z9ijzKjDb7dQojLKXvsXWv9M4fFihwl97XCr5Ufwhy0pSjEFuT+QMiqIPV4aojbDSEmlMLIzYwADn4UM7fuXxu2FdaHisYpeRlxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427165; c=relaxed/simple;
	bh=wDbUcYyCAxSuDczfvbcumQ0r2fxBkz3WNOzotZNf3oI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=byUQPT0+cn3jmlpI24xZnV9bC7GyxEpFmsqD3Rvml10PHAHxcvPh0nn4qiuUfdMw+WK8tAELCoTHmhcs/dZsw4VmLytqxNlblzMg/YlsPbc6jHYqrdpwUeqA7A7SDP/VEyOxfkzy1eOZwUN+XYr/H6yUEVLzv8rZOQnl6HwGLBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtM8kyOU; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-460b2e4c50fso39920561cf.0;
        Tue, 12 Nov 2024 07:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731427163; x=1732031963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bat9/xJV7AvURdsz2iED2jNcpnDBIev/RoH/7ziy/gk=;
        b=KtM8kyOUU4R1C2E0ArEOL3x1dbdFd2OQXKHh47vRSTi/LbHvxPIR2s1CYkCYVw96EA
         Binjdozh7w331bEweLx75lBvglsadI7LfAXkUnym6sZoheT6Xf++y/cqe3pK9NCeH8Sa
         5GCzXv1tRCwJE7Hd1B8DLkSXSaqKRRf2AnF1jGngP2aGyOHa7TKAMO4DYsCmuiPFwTGC
         96XEyWm4NrFPRKjc6lu7NSNqvJZtWaGvSJoPc+kZ0k64iJc8iuxpmn09ldA0xHJE4lJe
         MrqPDvQEl0myVsWUGZAE+IgPka2NXMLZ4eS4yN9EV1WvBbcfUfYg7etZ0zKqwcNsMO2l
         qLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731427163; x=1732031963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bat9/xJV7AvURdsz2iED2jNcpnDBIev/RoH/7ziy/gk=;
        b=R97SommUHH88IUI+89RtXvpgLJwAXJlL4tfQxlR0mRVDyJRE512rFCkbNngsd/NOMw
         L0P08OPG+yYHtGWM13/g8XfRq+SYlmGWfXXbAIif2BBphGU1OqXChoUJYYlMvb323mT9
         QriTxBBz5fFSQeJRBfdYWHjFGxqmQ4JZJ+hiX8z6pF04VgD0hxzluK7b2G8jsn1pbPpH
         20Dv2dMtI9UC4dDgMZrW0SLY2xjUfy8DMPv9jxn9hoPpdL4S4JFL+m333X5uLTnQe9Ky
         VG6nNScTkQNT3wElGPd9jzWS1citRNYREfXYr7bku+XJk8Nrbooo7oPX61h7XCs9N69h
         hKzg==
X-Forwarded-Encrypted: i=1; AJvYcCWC+LXIazKIYK0U8mRbUPVFmPOTxURHWSHU4xwPa4BSmCZENLmLww0myDljzgRdNtidA7u+HfixkICiu0jy@vger.kernel.org
X-Gm-Message-State: AOJu0YzJAgdGXSPFCEPWeJul7d5CFFp0xx6bWdOmTpJIOkHTds7kcXZu
	ysxN4VhNTp3pz90rIGQPKDeD/V2mouN/tNHJEin7NfugjQ2uYcOhOrmLRZItzedoHwNsJu46rNm
	37Add/2g1G5QNeNzgH4rGndBTJTjo4q5IFKE=
X-Google-Smtp-Source: AGHT+IGGVds2Zk2FiqgWXrwtcM5CJcFo1xPRYV9kQCKS8z4jkc3dP2MdcyL4Gk6QnGgDlsU4XzZzBQcD70oSna/XVCI=
X-Received: by 2002:ac8:7f01:0:b0:45d:6320:3c4a with SMTP id
 d75a77b69052e-463094113c1mr241044151cf.42.1731427162946; Tue, 12 Nov 2024
 07:59:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101135452.19359-1-erin.shepherd@e43.eu> <20241101135452.19359-4-erin.shepherd@e43.eu>
In-Reply-To: <20241101135452.19359-4-erin.shepherd@e43.eu>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 12 Nov 2024 16:59:11 +0100
Message-ID: <CAOQ4uxjD6Xsi-RV90xj-M9RbncTB5vPu2r_HLF1Es5hYixonLg@mail.gmail.com>
Subject: Re: [PATCH 3/4] pid: introduce find_get_pid_ns
To: Erin Shepherd <erin.shepherd@e43.eu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	christian@brauner.io, paul@paul-moore.com, bluca@debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 2:56=E2=80=AFPM Erin Shepherd <erin.shepherd@e43.eu>=
 wrote:
>
> In some situations it is useful to be able to atomically get a PID
> from a specific PID namespace.
>
> Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  include/linux/pid.h |  1 +
>  kernel/pid.c        | 10 ++++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index a3aad9b4074c..965f8b3ff9a8 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -124,6 +124,7 @@ extern struct pid *find_vpid(int nr);
>  /*
>   * Lookup a PID in the hash table, and return with it's count elevated.
>   */
> +extern struct pid *find_get_pid_ns(int nr, struct pid_namespace *ns);
>  extern struct pid *find_get_pid(int nr);
>  extern struct pid *find_ge_pid(int nr, struct pid_namespace *);
>
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 2715afb77eab..2967f8a98330 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -470,16 +470,22 @@ struct task_struct *get_pid_task(struct pid *pid, e=
num pid_type type)
>  }
>  EXPORT_SYMBOL_GPL(get_pid_task);
>
> -struct pid *find_get_pid(pid_t nr)
> +struct pid *find_get_pid_ns(pid_t nr, struct pid_namespace *ns)
>  {
>         struct pid *pid;
>
>         rcu_read_lock();
> -       pid =3D get_pid(find_vpid(nr));
> +       pid =3D get_pid(find_pid_ns(nr, ns));
>         rcu_read_unlock();
>
>         return pid;
>  }
> +EXPORT_SYMBOL_GPL(find_get_pid_ns);
> +
> +struct pid *find_get_pid(pid_t nr)
> +{
> +       return find_get_pid_ns(nr, task_active_pid_ns(current));
> +}
>  EXPORT_SYMBOL_GPL(find_get_pid);
>
>  pid_t pid_nr_ns(struct pid *pid, struct pid_namespace *ns)
> --
> 2.46.1
>
>

