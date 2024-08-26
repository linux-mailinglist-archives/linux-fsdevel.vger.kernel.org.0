Return-Path: <linux-fsdevel+bounces-27080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D9A95E6B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 04:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83411F21866
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 02:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9324DF60;
	Mon, 26 Aug 2024 02:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J33EkjvU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB6418E1A;
	Mon, 26 Aug 2024 02:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724639493; cv=none; b=ASXRj0F4TSHTpH1pE7pSrMBprV8wohUbQGbB0PvadvoHfgylawM+x4GfIldnNfmwURmifvG7tmyWNnJMd6FC2hc75vyd1ofjNzMzU6E6qAiOSK1qiUIrMOdFwXG7QN4uyyM8+5Vleuuq3MZzy+rslJvV8Zoha1GTxOE0Hn5XVMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724639493; c=relaxed/simple;
	bh=auvGWweHPionxG3Y2RIot08h1IaHqLUTT7XYr7Bux+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HkeGYKGCx+dCczcVMOOGo9ZWrNrzAf4lejUBYG1qD9BDQ1HtR6ESdgX4cp+LEGrJCGg3Rg45EGWz1AD3gMyXRr9s9t5c43HNJ3sIMZEyCGvvW7H/bYgsD4vnyXimllRwta5FHlXUOAlt5wf+5Bl3p6pDXMHJgHbjQxEjjPLu978=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J33EkjvU; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6bf784346b9so18220586d6.2;
        Sun, 25 Aug 2024 19:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724639490; x=1725244290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XScue1slDHBjUXVjmPax26pz/WL1rKHeatxMpCgrfI=;
        b=J33EkjvUneEAQ7IrY04ueDnx8p5tDlmKPlIa+IxlvcpTc214iqMgSCbNDrmrZgBNSG
         kKBTk7P6USq53BZHqkiu+KskQV4Jqv4MaUp17DkydRStK2+/rF7Mq7EihpRJc3768RUr
         cBCioSfjcZdqGiyb2rakf1LvaHUR2yIeWeAMpvZ/elEwBTtboSDip6PPWHyoj6QtEyBI
         LY4VoNXkoRrHwT/Da1/ojp7nFS6GfX3jrhKUKOnMIE6tdw96/679XDwHId07EBD0SbvO
         P9OyjS+dBdw9sYk6XP3NisNBeRL8JgNkJAGPFuNPq7Vma8caACa6VlBJFGhvH0tm/JVA
         FSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724639490; x=1725244290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XScue1slDHBjUXVjmPax26pz/WL1rKHeatxMpCgrfI=;
        b=RBOQNrVHQubUIRt/FxaVdir15QuETP9+0S5K7df+kpK+VUbXaBtG+nDzcqoeRwadif
         NMkn55Fe2zZOa6mXlCxQtaBn5ZM3n1YFyOC8D7xtu6fEfOJB9R1xrRuhRWZILxQCV+uy
         XZ/vBS5Uiwfk0bR4S6tAGSKEWIHOC2mKpJlQYjy+spuv9mTLzqMFbrW6w+L4gRDP2KwQ
         Ef6T/x/8++1hzpgAVv71zW9gL5zTYZcFuG2VH+EG7ToWLOfR4g/q/fDzI6oQo0ZfKyNo
         KIaDEcx5JHwg47TP0AJK+BQgUfBbjcZ1Pir3QgQGIxpRTQalnDhs2st7lAcGLQgxgzQh
         RmPg==
X-Forwarded-Encrypted: i=1; AJvYcCU+LLwmWF7SwxB4dhtHT73RfdD8s0GmnOkZ93FZNn7CYTInwiCupLKtiFwut6NsrmmX9kt+fSHT/A==@vger.kernel.org, AJvYcCU+Q2/qpK+CC3onhcQ7BwDX8R7kJCWIvu+enJ5zaRKoNJMWXX8lssgglf4CdzynpVesq+3okUkf0sbYibIO5r7fH9jo@vger.kernel.org, AJvYcCUfTuanryljPhtyo7jpioBGWFTefyUWB13kAqnHyFmFkHLpFPMmdabVjly+879hzf2+uSS9BvltB7w9EUd59A==@vger.kernel.org, AJvYcCVGs+GZ97iiVWrJbXD0ixBPqz30a5cBEefL8rgWKg/nlWF6+rRLy8Pd4ZoF7J7/wGSKNnBrcD8+s7SFlTPP1zHVbV8fxHdu@vger.kernel.org, AJvYcCVVgQWRNuPmfbgquVfn7PfcPR/1YFtC3SoPpM+4LTxn+fAvQR7b4Zu/LlsWj+HoWsHo48DheA==@vger.kernel.org, AJvYcCVwKBQ8X/SKwIzbn4/0wrGIsDmu20yZjWMKsKb09eyMQQt9IL5+o82XYenMVg1LFub5T3iw@vger.kernel.org, AJvYcCX72G27jpTwaedK8xNmFKpTSImxtiOn82cpZOjNhqzLfYYFSdqncKzFjl3vowXhoGJTdaRK529N@vger.kernel.org
X-Gm-Message-State: AOJu0YzNkPg/QJ2Usa76CXkYTozsNnc2VoxrIDmBk1Qj0N6H+C2u674W
	TYyfzLSd0rJ+xxQdJ9iSt5jA/wrt/cFTnqMj7OwXUnVQk14etHnJgd4W8HPOE1yC5XFuUTPDSfo
	bxqSC79ZxycwGNhaisyufaQMgYNU=
X-Google-Smtp-Source: AGHT+IGarR35eqB+ZCiektfid3NknQ5udphouR14HCsBw/jqFbYUFfZCBajx/1hzRrP8EuX3DNE+IOmZVcAYGIL4Z2k=
X-Received: by 2002:a05:6214:318d:b0:6bb:84d9:8f91 with SMTP id
 6a1803df08f44-6c16dc2615cmr95291406d6.6.1724639490512; Sun, 25 Aug 2024
 19:31:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817025624.13157-1-laoar.shao@gmail.com>
In-Reply-To: <20240817025624.13157-1-laoar.shao@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 26 Aug 2024 10:30:54 +0800
Message-ID: <CALOAHbA7VW3_gYzqzb+Pp2T3BqWb5x2sWPmUj2N+SzbYchEBBA@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Improve the copy of task comm
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org, alx@kernel.org, justinstitt@google.com, 
	ebiederm@xmission.com, alexei.starovoitov@gmail.com, rostedt@goodmis.org, 
	catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 10:56=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> Using {memcpy,strncpy,strcpy,kstrdup} to copy the task comm relies on the
> length of task comm. Changes in the task comm could result in a destinati=
on
> string that is overflow. Therefore, we should explicitly ensure the
> destination string is always NUL-terminated, regardless of the task comm.
> This approach will facilitate future extensions to the task comm.
>
> As suggested by Linus [0], we can identify all relevant code with the
> following git grep command:
>
>   git grep 'memcpy.*->comm\>'
>   git grep 'kstrdup.*->comm\>'
>   git grep 'strncpy.*->comm\>'
>   git grep 'strcpy.*->comm\>'
>
> PATCH #2~#4:   memcpy
> PATCH #5~#6:   kstrdup
> PATCH #7~#8:   strcpy
>
> Please note that strncpy() is not included in this series as it is being
> tracked by another effort. [1]
>
> In this series, we have removed __get_task_comm() because the task_lock()
> and BUILD_BUG_ON() within it are unnecessary.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/all/CAHk-=3DwjAmmHUg6vho1KjzQi2=3DpsR30+Cog=
Fd4aXrThr2gsiS4g@mail.gmail.com/ [0]
>
> Changes:
> v6->v7:
> - Improve the comment (Alejandro)
> - Drop strncpy as it is being tracked by another effort (Justin)
>   https://github.com/KSPP/linux/issues/90 [1]
>
> v5->v6: https://lore.kernel.org/linux-mm/20240812022933.69850-1-laoar.sha=
o@gmail.com/
> - Get rid of __get_task_comm() (Linus)
> - Use ARRAY_SIZE() in get_task_comm() (Alejandro)
>
> v4->v5: https://lore.kernel.org/all/20240804075619.20804-1-laoar.shao@gma=
il.com/
> - Drop changes in the mm/kmemleak.c as it was fixed by
>   commit 0b84780134fb ("mm/kmemleak: replace strncpy() with strscpy()")
> - Drop changes in kernel/tsacct.c as it was fixed by
>   commmit 0fe2356434e ("tsacct: replace strncpy() with strscpy()")
>
> v3->v4: https://lore.kernel.org/linux-mm/20240729023719.1933-1-laoar.shao=
@gmail.com/
> - Rename __kstrndup() to __kmemdup_nul() and define it inside mm/util.c
>   (Matthew)
> - Remove unused local varaible (Simon)
>
> v2->v3: https://lore.kernel.org/all/20240621022959.9124-1-laoar.shao@gmai=
l.com/
> - Deduplicate code around kstrdup (Andrew)
> - Add commit log for dropping task_lock (Catalin)
>
> v1->v2: https://lore.kernel.org/bpf/20240613023044.45873-1-laoar.shao@gma=
il.com/
> - Add comment for dropping task_lock() in __get_task_comm() (Alexei)
> - Drop changes in trace event (Steven)
> - Fix comment on task comm (Matus)
>
> v1: https://lore.kernel.org/all/20240602023754.25443-1-laoar.shao@gmail.c=
om/
>
> Yafang Shao (8):
>   Get rid of __get_task_comm()
>   auditsc: Replace memcpy() with strscpy()
>   security: Replace memcpy() with get_task_comm()
>   bpftool: Ensure task comm is always NUL-terminated
>   mm/util: Fix possible race condition in kstrdup()
>   mm/util: Deduplicate code in {kstrdup,kstrndup,kmemdup_nul}
>   net: Replace strcpy() with strscpy()
>   drm: Replace strcpy() with strscpy()
>
>  drivers/gpu/drm/drm_framebuffer.c     |  2 +-
>  drivers/gpu/drm/i915/i915_gpu_error.c |  2 +-
>  fs/exec.c                             | 10 -----
>  fs/proc/array.c                       |  2 +-
>  include/linux/sched.h                 | 32 +++++++++++---
>  kernel/auditsc.c                      |  6 +--
>  kernel/kthread.c                      |  2 +-
>  mm/util.c                             | 61 ++++++++++++---------------
>  net/ipv6/ndisc.c                      |  2 +-
>  security/lsm_audit.c                  |  4 +-
>  security/selinux/selinuxfs.c          |  2 +-
>  tools/bpf/bpftool/pids.c              |  2 +
>  12 files changed, 65 insertions(+), 62 deletions(-)
>
> --
> 2.43.5
>

Hello Andrew,

Could you please apply this series to the mm tree ?

--=20
Regards
Yafang

