Return-Path: <linux-fsdevel+bounces-36578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC569E60E7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 23:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFCEA1678A4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 22:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529091CD21C;
	Thu,  5 Dec 2024 22:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfQoiVRT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D86F1E522
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Dec 2024 22:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733439218; cv=none; b=W1e4AYA0dd4J+Iu2z1QAjt8TVPPevz/Fll2BNiosNk6KnzFRY0EKeXnrmlIvwBbP4nxpPrbCUDdblAWesiEKI7KOLlNL0E4APxB/bXj+Ol+Pvoe8u196Ds3XpUr4kqSQ9R2K50w6i01YCXGJyT4md5Kh42UYNHa+4S2j32qjaIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733439218; c=relaxed/simple;
	bh=0YsVcyeGS2G4nIlCLlFgYnnhlzUV5F4RipAMwi+Jgow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOa0+ACubJB86rjv/DL3of+2zBut3WQ728lO0Tdl1IHSvtxUhjBU5j6SWJIuj9EmLD1vaZAcF+KW5uTTzLMauTrfcHq+HFjn4b/qL3snWAUCWRqo2NEGhDYdzqhssers2asqWRxAZBWYxp/uQLzhojAPwyoDeD28zRgCkZLcKLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfQoiVRT; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4668d12b629so12722971cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2024 14:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733439216; x=1734044016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ae46hA0p8Cg4tuqeTx/mDvCXY17DCkqznqxSaLgOWNI=;
        b=jfQoiVRTg0bM7F4n1rKMDjPWqaI9XZzlecH9oe82fGeCeSxjUUeu4jg7twxTZvMr64
         RysdSrqHunhAj70QRGk+t/Aegc1wuC/gb4zckPgOJ1o1bUdBuLco9jcPrgohpWbRI/Gc
         k/LG/h5FHTKdTEuk3Sc9IKTFL7O35MBpsXKtQUTiXcOEwQVDAmmceG0DsSC4F3UqeFRt
         xCAGX3xxTk7hyN8z375EHC7RM9ddZFUqWEQABtTuwiCd9z5kz+zgkq068znRBGZdT5GT
         /ZhpK2KPHyurcHdLfrO39+M/JcBqYX4/AxLAl5CfWnRBh0+MgOqd7u8hiYE/3mnhSUQO
         2M9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733439216; x=1734044016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ae46hA0p8Cg4tuqeTx/mDvCXY17DCkqznqxSaLgOWNI=;
        b=EpsOt34lM6+NWFmdQDUQ3YkB9tpQL9jzXfpwRJPzUuquBRU/X3Pck4kVxbGGoyNH4n
         n6JImS0ykX0Txk24rNVSfuOUsbN3xssj6WCyyicbKlx+JdiYVUEG4gxh8TBaXY6LPmlX
         LHPveX9DIdS8UmvJMkzj4ooRmiQ/5m+dV/BEiKn4EbbQxONXY6KtYJMrtkffi2WQrs2E
         v4ilFdTQPs2c4k6mwGzQZa9LS7/PcaoE09B2vxzXiZVo4iyl4nLyAiRDQC3xUCizaq5E
         nM0fzPwC0UxTdGtBeRXe0U++ev07uiRY8nlZiSQIx/w72cAp2CJu9c+E2Uf6RCC3wwme
         ppRg==
X-Forwarded-Encrypted: i=1; AJvYcCVCQlLlbXTGXyv41GeiBGjKQLD30ebG8i37W8i4HC+CSRtGyjCtjuuqoyAR6cnkaSSPw+qW/3thnSpSiOA7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Txfo6Kd0lE0Ewj30CG+jnE82SrstnkRNecUL7gI4zX808tmZ
	FnM+jZpgc/NiedWnAGeYKOPceqru4TydPoZ8ylTw2Hm9CV/KLpsMe4+//sqKtuC4uTTd6F1kMTN
	7Qn95YPA5AnKGeJdYZTTEC2l03bU=
X-Gm-Gg: ASbGncuH1Xy83VlUIhd7phjdYoxo/ZJBXd8MQlVfEETpqtBX/FUVf5m9eCH24OkjEkw
	PPOGbOn8kOtG8txCQ1y77cHLtL6MNzDOiRp/lpoK4rlYzNvY=
X-Google-Smtp-Source: AGHT+IHolJjQISVOSEyrbnKT8sQrwmKtD8UvJAQmo1YzsWBQwgdfnCnbl46XgcXaUViqbcXKJA+4ycaXSq7u4KZWiLM=
X-Received: by 2002:a05:622a:199b:b0:466:a61f:9ead with SMTP id
 d75a77b69052e-46734f7d305mr16948021cf.36.1733439216038; Thu, 05 Dec 2024
 14:53:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204164316.219105-1-etmartin4313@gmail.com>
 <15ff89fd-f1b1-4dc2-9837-467de7ee2ba4@linux.alibaba.com> <CAMHPp_SwH_sq9vCHMyev6QJbtGFkNL5fpX3ZXSHLF4zz0T3_+w@mail.gmail.com>
In-Reply-To: <CAMHPp_SwH_sq9vCHMyev6QJbtGFkNL5fpX3ZXSHLF4zz0T3_+w@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 5 Dec 2024 14:53:25 -0800
Message-ID: <CAJnrk1YHOEBPZYzaMPQi4h6hPzMmK0w8beBvuOGbamwebYnKmA@mail.gmail.com>
Subject: Re: [PATCH] fuse: Prevent hung task warning if FUSE server gets stuck
To: Etienne <etmartin4313@gmail.com>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, 
	miklos@szeredi.hu, etmartin@cisco.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 9:10=E2=80=AFAM Etienne <etmartin4313@gmail.com> wro=
te:
>
> On Wed, Dec 4, 2024 at 8:51=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.=
com> wrote:
> >
> >
> >
> > On 12/5/24 12:43 AM, etmartin4313@gmail.com wrote:
> > > From: Etienne Martineau <etmartin4313@gmail.com>
> > >
> > > If hung task checking is enabled and FUSE server stops responding for=
 a
> > > long period of time, the hung task timer may fire towards the FUSE cl=
ients
> > > and trigger stack dumps that unnecessarily alarm the user.
> >
> > Isn't that expected that users shall be notified that there's something
> > wrong with the FUSE service (because of either buggy implementation or
> > malicious purpose)?  Or is it expected that the normal latency of
> > handling a FUSE request is more than 30 seconds?
>
> In one way you're right because seeing those stack dumps tells you
> right away that something is wrong with a FUSE service.
> Having said that, with many FUSE services running, those stack dumps
> are not helpful at pointing out which of the FUSE services is having
> issues.
>
> Maybe we should instead have proper debug in place to dump the FUSE
> connection so that user can abort via
> /sys/fs/fuse/connections/'nn'/abort
> Something like "pr_warn("Fuse connection %u not responding\n", fc->dev);"=
 maybe?

Having some identifying information about which connection is
unresponsive seems useful, but I don't see a straightforward way of
implementing this without adding additional per-request overhead.

>
> Also, now that you are pointing out a malicious implementation, I
> realized that on a system with 'hung_task_panic' set, a non-privileged
> user can easily trip the hung task timer and force a panic.
>
> I just tried the following sequence using FUSE sshfs and without this
> patch my system went down.
>
>  sudo bash -c 'echo 30 > /proc/sys/kernel/hung_task_timeout_secs'
>  sudo bash -c 'echo 1 > /proc/sys/kernel/hung_task_panic'
>  sshfs -o allow_other,default_permissions you@localhost:/home/you/test ./=
mnt
>  kill -STOP `pidof /usr/lib/openssh/sftp-server`
>  ls ./mnt/
>  ^C

I'm not sure if this addresses your particular use case, but there's a
patch upstream that adds request timeouts
https://lore.kernel.org/linux-fsdevel/20241114191332.669127-1-joannelkoong@=
gmail.com/

This can be set globally via sysctls (eg
"/proc/sys/fs/fuse/max_request_timeout") or on a per-server basis. If
the timeout elapses and the request has not been fulfilled (eg
malicious or buggy fuse server), the kernel will abort the connection
automatically.


Thanks,
Joanne

>
> thanks,
> Etienne
>

