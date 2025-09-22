Return-Path: <linux-fsdevel+bounces-62408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB5DB91A94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 16:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD5A425DD8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 14:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95A2229B16;
	Mon, 22 Sep 2025 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZLipSDAc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACA41F4191
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551073; cv=none; b=NLEcMyxxxwQ0aVECpOkJFINjRst8V08yJsBt7+4Qs9TDX1mtg0+pcAzUfQrdMGLB84Xmu00p3m460rx8gc+ZVxKan+MZhlOxc6RYfMARQYqZ9OK+3cTO9SvyQWCngXcQqxKBtes886kxfVSWMZ/t/tRaLrVcvrPRxwch63kEGc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551073; c=relaxed/simple;
	bh=tIodmALtgU0h43V+zThPJbKkDeoLkKVkpb1ryXvTTAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UA0eAtz0h4mA/bTGUwfP90rx9k9SnGaIuKFI0l2cV34euf6bocRxXGf9SiB9Yhxurjd7T+03wUZT5LycLLHypk8flZVfZLwUzDOA0bYpkFCWCMQNW4lxl/cmMqgJde/lk92sHx2KToXorQFeQNt085McztymuWo6RL4ks/pPnNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZLipSDAc; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d60501806so35295957b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 07:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758551069; x=1759155869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7yrDBmGcLwBUNhv5B7OMCSppVEqCpOeSq4CRAMwig4=;
        b=ZLipSDAcu7AQUL8p4pbgcf4d1XywM9XA0E0VSoLwOiASZ61igrRldjqWO6UQDpkjG2
         njQOoqv0yJGws2IFZ9aKXq94GL12Sin1q6DghNV1O5+eCt9Ks2LWunyoy+yqkMZV/8te
         0H0ivgMvDJbVe/L8ynN28aPHgxEHb0O2WEHPiZygdPCwzHBPs429XThDLJAKXzWI1PLY
         cLHSchHQ3SOA2fVgE99SXg8fFxPHpar13y6vM7kPCk+8psQ0hyYDesKWPsXz1o2PuMwA
         fkqi+TDBt8wYzgdC+72wasnrfFtzR37hzEBPJdz8pTLoKaPyrC0L2ALQHJNgTfIIs2DI
         e99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758551069; x=1759155869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7yrDBmGcLwBUNhv5B7OMCSppVEqCpOeSq4CRAMwig4=;
        b=RMx3l/W8Rb4QGd9XHgre13/KxkesVCb54OnewpKA8yQDL/R3sZVhZ1G2NZElfQe71f
         mAJfOUNSCgdSp42VMBlEYb63yJD5Z0HtNlVq60GQC1nOKSWnVWaRYqrG5q5X5a/PFzsy
         kap1r9JpSlRSK097QkZdnVHPNXuIotD14LtFBwf5DyjciQzrU7QLahBPAMVEp/t0HGai
         k60ztVvUsFCYTHNteDo3V0Mc3v1Bs+m2FibeUO09qwsMOudfFCJkhp0fm80U6ecNelZv
         HTlavXVfMzq15jQ9I1jnX2mOstiiZPHJkVWVXbJk3e7rxHUmgrmwTO824Clil5+RqzZu
         tmkA==
X-Forwarded-Encrypted: i=1; AJvYcCWyQhLozB7QB/yq5Q1sAqnEZ1ug+H3hi/8iGZDpjc+KdDlrFXGiGkf36hYW4fCA9AQZfzR1gRDg3emLU6VR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx++nh4AOb6FbrvhHx8wvYU2pNOSdBIoAfnnDEzPZFTVRDHKvDz
	ldCwZuNuQbzndK6zMjRwZzXY1yCtfAoKW9b7zVjKooiRAIdp0O2OqkKh2iMb6NvVyVAYjDOa+t9
	cazOLxRdlRrzPPeM2mv9rmLnXLpHQSRcjGPKI6qnxCg==
X-Gm-Gg: ASbGncvl7DStFXwcpRAj+xUbYBoRabEzh2pN/5K0Dk7DH+9pXSv04XbOyNQfCkSW5Xh
	VFmlVMesG4YaUzoUM94TBSR1xo9fQGz4virUJ7ws5gMKOPzn/lDVVV5pSX5eGKFAkZyURK7Jcyx
	Sq021k/iziFQObnIRS994WIKIEVrAj5clHNYQPyBystRMbUXLWD6VvgMJahn3MluY+kdj0rePzs
	M1tnqQ/
X-Google-Smtp-Source: AGHT+IGBcMVyRsewumlZLmC3prV8ZwwgF65fYz70qrZREPVuSl5uJOzLQnYNnQfvfegufmU0BD2qqBSmnOVzV7yc8J4=
X-Received: by 2002:a05:690c:a9b:b0:723:b3d4:1cfd with SMTP id
 00721157ae682-73d40a0df19mr103989627b3.54.1758551068919; Mon, 22 Sep 2025
 07:24:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922094146.708272-1-sunjunchao@bytedance.com> <aNFJ_EKj4fnRDg1_@tiehlicka>
In-Reply-To: <aNFJ_EKj4fnRDg1_@tiehlicka>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Mon, 22 Sep 2025 22:24:25 +0800
X-Gm-Features: AS18NWBhTtll9HO09b_6_OXxEbw8QUzGP38paSkjP8dVvtMTsOUujBKUVKVKFT4
Message-ID: <CAHSKhtfuSTEo5NgCqOjq8ubs_U_TTo+KUatNhS-UVkhawkcFag@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 0/3] Suppress undesirable hung task warnings.
To: Michal Hocko <mhocko@suse.com>
Cc: cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	akpm@linux-foundation.org, lance.yang@linux.dev, mhiramat@kernel.org, 
	agruenba@redhat.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 9:07=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 22-09-25 17:41:43, Julian Sun wrote:
> > As suggested by Andrew Morton in [1], we need a general mechanism
>
> what is the reference?

Sorry, the link is:
https://lore.kernel.org/cgroups/20250917152155.5a8ddb3e4ff813289ea0b4c9@lin=
ux-foundation.org/
>
> > that allows the hung task detector to ignore unnecessary hung
> > tasks. This patch set implements this functionality.
> >
> > Patch 1 introduces a PF_DONT_HUNG flag. The hung task detector will
> > ignores all tasks that have the PF_DONT_HUNG flag set.
> >
> > Patch 2 introduces wait_event_no_hung() and wb_wait_for_completion_no_h=
ung(),
> > which enable the hung task detector to ignore hung tasks caused by thes=
e
> > wait events.
> >
> > Patch 3 uses wb_wait_for_completion_no_hung() in the final phase of mem=
cg
> > teardown to eliminate the hung task warning.
> >
> > Julian Sun (3):
> >   sched: Introduce a new flag PF_DONT_HUNG.
> >   writeback: Introduce wb_wait_for_completion_no_hung().
> >   memcg: Don't trigger hung task when memcg is releasing.
> >
> >  fs/fs-writeback.c           | 15 +++++++++++++++
> >  include/linux/backing-dev.h |  1 +
> >  include/linux/sched.h       | 12 +++++++++++-
> >  include/linux/wait.h        | 15 +++++++++++++++
> >  kernel/hung_task.c          |  6 ++++++
> >  mm/memcontrol.c             |  2 +-
> >  6 files changed, 49 insertions(+), 2 deletions(-)
> >
> > --
> > 2.39.5
>
> --
> Michal Hocko
> SUSE Labs


Thanks,
--=20
Julian Sun <sunjunchao@bytedance.com>

