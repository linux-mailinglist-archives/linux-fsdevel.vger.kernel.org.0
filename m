Return-Path: <linux-fsdevel+bounces-33636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D3F9BC094
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 23:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FBEB1F2138B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 22:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979681FDF89;
	Mon,  4 Nov 2024 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AFtM6yb7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEF41C4A0C
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Nov 2024 22:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757894; cv=none; b=TQqxqYeTej9zOCbjmtfdiDOAOjhpQdJ2XRO2vYmC4xhJL/bmvaLes6DDPxUFNEYWAnDsYLGtdpIv18q5KzsbWcSCLgA4gFepRE1hTsNiqZoW4cGRG0wlhwxv9Z2LybMPXnj2V4CivN+C+6XXHlnZAjVRpCpVashRggjV4OIKXWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757894; c=relaxed/simple;
	bh=j71TcGeaDO5X0uMRUP0MLrRPmTi3MmdQEyXOiGX99tE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClXfK9rXEYn+tLv+RmieWMI4Y6ecCjGLpc5D607WBHRDZRuf5M58lWAmk+BHRoNF2pkVsk5EtFh8m1JvrR4a41Skwjl/dWXCH+KMQJxccIMkO8cLrgMXNBobzeiRXkxHeT0N/LGIHIqd2cS9+vbDxVGucqnrGAuHhEC2ReinCPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AFtM6yb7; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-84fed1ff217so2984302241.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Nov 2024 14:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730757890; x=1731362690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cc0tCbkyMIi3MpKCwFn2JsVOi2X3ZT24UpFB4EpKLs=;
        b=AFtM6yb76GkJ0TKPtV84eqtVMuZiNpGP4GIDavVlV/g103mn5VcpVzD0BpEh93juHx
         Vgxb+0C6kMGrUu2G9e920n0l7cVcCFElt/bcUyJnb8gQZfJboLZJqn1lIYtndPRtLrMP
         c4nVnrjOqNWYFXeFCpDSiUhKaayF6Ydd0dgIHcJnfLOQ+v+zF5egHqdLYxFjW5oKzq8S
         yO+01Q348ZeHpCupjHDs000f7GwQ48z1ZaPtQPQvIGs+olpIMZjr80OefO8a5HvR6zkg
         bXq9TwfZ2GOQ0013KBnglAtNvusuqZ7MwpOEeZGOS8c/uj/SLOKmtm2dSfcXB88zviVC
         zoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730757890; x=1731362690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cc0tCbkyMIi3MpKCwFn2JsVOi2X3ZT24UpFB4EpKLs=;
        b=ZNG9zJ5rzSLwBmZwAFufF5C31YQ2/1Lw5adI/OM+HMLLST9NtZ9OFGEYdhJv6QbpIg
         3m1fVfnNUwzlyuUxH07Sp9XJma3qsX3b6nwHNQoHqaIxhao0xdYFbSs45+vcJv3mfINv
         p1g5Y2Hgq0C9fX2ovpqNGy3X1bRN4Xr77ZnmoLDh93GPIhcqOUKzQD8+k4DDgexFy+eB
         pMxWgpZ60pqHkSUehmi7yA9OkkbnTLPrvgJ4xoHQ3GlkDrnNHDZc/zh9thlup08jqhFF
         mrmhwoRpau0MNmxvoHwiI1cmYwDBVwMzzF0bnIl2RrSFXa+aAT2wDdIkNLSp1nYU3Mi7
         kb0A==
X-Forwarded-Encrypted: i=1; AJvYcCURv6yHRz9T3xBe3M3ZSdJZI7jl9vSZTdClXxOkideO7KPXhfLXI/WFpNuK+Ht+JbHVAhuLlReIUO/ReO+1@vger.kernel.org
X-Gm-Message-State: AOJu0YwP19WMIKn5DYwKeV8DAxOxZoshhwQpujJfXuAjmQsEUIDK1yHw
	4576iiTeq6F/w0RxLR7Z2cC1fd5qHzkgFkkxSp3GVuLKRGnsi6M7WkE9C0+JcosvpV3rJbWw7Jy
	rqtGjJ7Ye5fNMmpmlPle0mZtt4BhEC0P9Fpv6
X-Google-Smtp-Source: AGHT+IHFoZwB9UJQ/W7UPJWTT6Mwf1OXIt2PanaSLVRWyM98+DOHGoOSiH002T//dMssG37gkEwNVD1jyiUDrfB47Us=
X-Received: by 2002:a67:eada:0:b0:4a3:c32a:dfbf with SMTP id
 ada2fe7eead31-4a961b8080dmr9219748137.9.1730757889902; Mon, 04 Nov 2024
 14:04:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
 <20241025012304.2473312-6-shakeel.butt@linux.dev> <iwmabnye3nl4merealrawt3bdvfii2pwavwrddrqpraoveet7h@ezrsdhjwwej7>
 <CAOUHufZexpg-m5rqJXUvkCh5nS6RqJYcaS9b=xra--pVnHctPA@mail.gmail.com>
 <ZykEtcHrQRq-KrBC@google.com> <20241104133834.e0e138038a111c2b0d20bdde@linux-foundation.org>
In-Reply-To: <20241104133834.e0e138038a111c2b0d20bdde@linux-foundation.org>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 4 Nov 2024 15:04:13 -0700
Message-ID: <CAOUHufbA6GN=k3baYdvLN_xSQvX0UgA7OCeqT8TsWLEW7o=y9w@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] memcg-v1: no need for memcg locking for MGLRU
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 2:38=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Mon, 4 Nov 2024 10:30:29 -0700 Yu Zhao <yuzhao@google.com> wrote:
>
> > On Sat, Oct 26, 2024 at 09:26:04AM -0600, Yu Zhao wrote:
> > > On Sat, Oct 26, 2024 at 12:34=E2=80=AFAM Shakeel Butt <shakeel.butt@l=
inux.dev> wrote:
> > > >
> > > > On Thu, Oct 24, 2024 at 06:23:02PM GMT, Shakeel Butt wrote:
> > > > > While updating the generation of the folios, MGLRU requires that =
the
> > > > > folio's memcg association remains stable. With the charge migrati=
on
> > > > > deprecated, there is no need for MGLRU to acquire locks to keep t=
he
> > > > > folio and memcg association stable.
> > > > >
> > > > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > >
> > > > Andrew, can you please apply the following fix to this patch after =
your
> > > > unused fixup?
> > >
> > > Thanks!
> >
> > syzbot caught the following:
> >
> >   WARNING: CPU: 0 PID: 85 at mm/vmscan.c:3140 folio_update_gen+0x23d/0x=
250 mm/vmscan.c:3140
> >   ...
> >
> > Andrew, can you please fix this in place?
>
> OK, but...
>
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -3138,7 +3138,6 @@ static int folio_update_gen(struct folio *folio, =
int gen)
> >       unsigned long new_flags, old_flags =3D READ_ONCE(folio->flags);
> >
> >       VM_WARN_ON_ONCE(gen >=3D MAX_NR_GENS);
> > -     VM_WARN_ON_ONCE(!rcu_read_lock_held());
> >
> >       do {
> >               /* lru_gen_del_folio() has isolated this page? */
>
> it would be good to know why this assertion is considered incorrect?

The assertion was caused by the patch in this thread. It used to
assert that a folio must be protected from charge migration. Charge
migration is removed by this series, and as part of the effort, this
patch removes the RCU lock.

> And a link to the sysbot report?

https://syzkaller.appspot.com/bug?extid=3D24f45b8beab9788e467e

