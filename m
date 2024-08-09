Return-Path: <linux-fsdevel+bounces-25527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8260494D1C0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 16:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385321F22ACE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 14:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0213197A6B;
	Fri,  9 Aug 2024 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcXLEqsx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF5D197556
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723212082; cv=none; b=tkHCPQK9vmL8y/JdsiJBZJaj7kwjFFNlCDt645BdeRraZkcPV2+ZZqO/gRVSBJAa4IM0QUAezGTZ+Y8v27xYCW6i0HRtt7LcBAuHLePdF3X6GPGvLCt0VRbO0BPf1X6hf0KeoTRrKV9LlDujTIBSyXPy1u7itUMDwaT0joAH9ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723212082; c=relaxed/simple;
	bh=SLvVfUhTgJPSIy5piWgUXzQZF9qDlIZhZnOEWDwoLZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHbFw6xcB5zUehzy0gbQruyYPAA+Pwf2gUCbuY2dBkgziiScbhVmYUH7I/Tc46eUzsOPR6O2/HjOGpS0cAO44LqaFRzq7l3oh7TmwlvohSRS+qTABsfqpTrcdPdXyDQeKpKABcs1aQIcdhkuZyxPszK8cxoV9OPEhonC8u45S8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dcXLEqsx; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso12265a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Aug 2024 07:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723212079; x=1723816879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ybf1WG84h42H572TtPv2LZmVlcjwNEKQd+fCxEmYBk0=;
        b=dcXLEqsx+Xjpd3WHsZy0bZB1VzNRLpAj2c2NlDMbdu2j0Oqg/c468WiWWxVALk60by
         aOM3BaW8dL3RGyqeGCdOxkirAH6bpqEguPF+NTiZ/wdmrYWzl4pYGlHPhmO+eXko4QLf
         21jvVSUdp3HnMIgJojkh4L/EgKtsj7XHCF+EZW+NjNYIPF+8/bLkWHxTBEZiE9cXICPN
         vYotZjtjHZnxvvFKWj2QY82T1r5rLr42xa5nXZviyOoGa5DyPaH5rAX+Sq8Jxg4iQ4zx
         vJyvge11laqZcA7yvdc88/3kwQ0RYBSdSaFE1L6QSrsf1cg2wj54eAZLN0pME3ln9Jh1
         mlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723212079; x=1723816879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ybf1WG84h42H572TtPv2LZmVlcjwNEKQd+fCxEmYBk0=;
        b=j2JqZSMgG3iRaDamwIaZ9gRg4z+maV8nKxruUZNzySJ2N789u1RUBE/VVletEAc8WC
         XokzOLLosksvw6eUGKVp5heZhVbB9ZncLNliJnK7BWaKmlRcnLfg7tBn87H1Nj6LHPkZ
         sopNZ9Lw8j3tEIReEYE4O2xw4HT/yeGzkN7QKbpU2PiK5+5BfzIjV+0AsKlCEITBK5YT
         AdVPzbXZDegHU2ahGDjzGxWYbcGxcw1cns/UWmZdChrdGuSMAePaDSpgqMWtTA18MNXd
         g4paTpBwff+17SGv1M5cnb4lrpoW3u02RKI//HC4GTMpopdKLvOn9fXyl9XoxnK2zQmE
         im7A==
X-Forwarded-Encrypted: i=1; AJvYcCVAEXkbb4Z94Trfib6Hbk5L35S66FQM3ayTuDf35coJlzsiWsC9OdAnIdRBygTCizgUFkzQNlyaueqCLen7N1GgOgmrLt1PuBckezCa7A==
X-Gm-Message-State: AOJu0YzegXIvhhOh+P1ToAEfIZceIAKuQRtQF1FzzpILR9pDMbRl92Rg
	wWEacFMqrYtVtOwOQVRbiYIt2A0tzEh3uZ0UYl4ChHRppE2YYd2Xtlb9T4GD71l7u1zj9R7ArEw
	S3xAl4OwiozxiPu2jR3oJCEcBEKNtBD7hPPwB
X-Google-Smtp-Source: AGHT+IEub+hoxVm4xWSuTOI3C11h8h/fX4KSqoaDWKa7V1e19RKutQ6uPrwA1941jQxEaXlNpwu8L2ZBgfRyxcIlx7Y=
X-Received: by 2002:a05:6402:35cc:b0:57c:c5e2:2c37 with SMTP id
 4fb4d7f45d1cf-5bc4b3fc8d7mr129304a12.3.1723212077931; Fri, 09 Aug 2024
 07:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <49557e48c1904d2966b8aa563215d2e1733dad95.1722966592.git.fahimitahera@gmail.com>
 <CAG48ez3o9fmqz5FkFh3YoJs_jMdtDq=Jjj-qMj7v=CxFROq+Ew@mail.gmail.com>
 <CAG48ez1jufy8iwP=+DDY662veqBdv9VbMxJ69Ohwt8Tns9afOw@mail.gmail.com>
 <20240807.Yee4al2lahCo@digikod.net> <ZrQE+d2b/FWxIPoA@tahera-OptiPlex-5000>
 <CAG48ez1q80onUxoDrFFvGmoWzOhjRaXzYpu+e8kNAHzPADvAAg@mail.gmail.com>
 <20240808.kaiyaeZoo1ha@digikod.net> <CAG48ez34C2pv7qugcYHeZgp5P=hOLyk4p5RRgKwhU5OA4Dcnuw@mail.gmail.com>
 <20240809.eejeekoo4Quo@digikod.net> <CAG48ez2Cd3sjzv5rKT1YcMi1AzBxwN8r-jTbWy0Lv89iik-Y4Q@mail.gmail.com>
 <20240809.se0ha8tiuJai@digikod.net>
In-Reply-To: <20240809.se0ha8tiuJai@digikod.net>
From: Jann Horn <jannh@google.com>
Date: Fri, 9 Aug 2024 16:00:41 +0200
Message-ID: <CAG48ez3HSE3WcvA6Yn9vZp_GzutLwAih-gyYM0QF5udRvefwxg@mail.gmail.com>
Subject: Re: f_modown and LSM inconsistency (was [PATCH v2 1/4] Landlock: Add
 signal control)
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, gnoack@google.com, jmorris@namei.org, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 3:18=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> Talking about f_modown() and security_file_set_fowner(), it looks like
> there are some issues:
>
> On Fri, Aug 09, 2024 at 02:44:06PM +0200, Jann Horn wrote:
> > On Fri, Aug 9, 2024 at 12:59=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
>
> [...]
>
> > > BTW, I don't understand why neither SELinux nor Smack use (explicit)
> > > atomic operations nor lock.
> >
> > Yeah, I think they're sloppy and kinda wrong - but it sorta works in
> > practice mostly because they don't have to do any refcounting around
> > this?
> >
> > > And it looks weird that
> > > security_file_set_fowner() isn't called by f_modown() with the same
> > > locking to avoid races.
> >
> > True. I imagine maybe the thought behind this design could have been
> > that LSMs should have their own locking, and that calling an LSM hook
> > with IRQs off is a little weird? But the way the LSMs actually use the
> > hook now, it might make sense to call the LSM with the lock held and
> > IRQs off...
> >
>
> Would it be OK (for VFS, SELinux, and Smack maintainers) to move the
> security_file_set_fowner() call into f_modown(), especially where
> UID/EUID are populated.  That would only call security_file_set_fowner()
> when the fown is actually set, which I think could also fix a bug for
> SELinux and Smack.
>
> Could we replace the uid and euid fields with a pointer to the current
> credentials?  This would enables LSMs to not copy the same kind of
> credential informations and save some memory, simplify credential
> management, and improve consistency.

To clarify: These two paragraphs are supposed to be two alternative
options, right? One option is to call security_file_set_fowner() with
the lock held, the other option is to completely rip out the
security_file_set_fowner() hook and instead let the VFS provide LSMs
with the creds they need for the file_send_sigiotask hook?

