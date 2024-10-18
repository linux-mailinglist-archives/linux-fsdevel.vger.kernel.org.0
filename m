Return-Path: <linux-fsdevel+bounces-32368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 030109A4593
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 20:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB521C218A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 18:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D01A204937;
	Fri, 18 Oct 2024 18:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHaBJOBQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5A3155312;
	Fri, 18 Oct 2024 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729275197; cv=none; b=IaqZHRjgcB8oDA2yfP6ubEE+Wt408foBr962iTkMCvmauLMwIcjTqTEius8fb0D/eOWi8tN/pV2KTJS+upF5DNv9Yq1CsMZDm4Hf05jbv/g4UivWd4krhunhA050gp4vC9vpKy6tA12H0vTw9G+/Ec3BN8eSVOiI6qR+G7a6Ll0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729275197; c=relaxed/simple;
	bh=V7cATR5PtC3+8+gKpg5fD+d51cdjsZ+kanX4EQ1Simc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PyjRdJg7eZol7nC0NiV4/zofgJzRyOP+/7NcqnsUB6T1XZ3+XMFEMKo6kQ4LDmO3VPuPTgFmFG5EwDc8tKjgH1E4A985Sf1+++4W+eaC61Tgcr19e2ACcDylvNgWPRMycpunLFUY18FEFrAnYY2SJdFpyaK6paDdV8UTgoxjIN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHaBJOBQ; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-460963d6233so14106811cf.2;
        Fri, 18 Oct 2024 11:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729275195; x=1729879995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B40RPIqnhSSJ85lZL+p2R/O2i15e5fShUZ74XjiPrcc=;
        b=LHaBJOBQepwJx/kdsEoTCPhYwgrObL1cn2in5lyTN93AxU+2fLLszGIItrVomqMfQL
         CeyN0GzhV6Wuwpp3nN9f884rVQS0xQL9SLHIYEeRL53mt6fhhEtdrQ/afhtQPVnJ3mTj
         aabXiUSXyZqoTS349kJhW8BO+T7B/67jgDYQZAY+ryGpGeZCbXM1ZxzX/ZUsRXFGeM7F
         gHwSSfqZ4IhyhGzPtGGmOge96k2HwAQDAxjCuguCavtJ18NhQtr2T/zMQNYPR8JcIx0C
         j7DV8GTDMXLG/kD080MusBCqpFrfFoK10lBsEcMQS2djiHBs5K2naAkdx7w8GyCkC4BU
         EEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729275195; x=1729879995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B40RPIqnhSSJ85lZL+p2R/O2i15e5fShUZ74XjiPrcc=;
        b=FjQC3FbaRFwm98Efc6ecfqV8RxVf2nSJGFIF/TLT5ALMyXnJTOFClJDdPJ6rBJYL9d
         q6oCXMo4OSnK2Q6g3uo5uI72QuDnSDa2Rn+gBHFrRkFAsy6KWt/2GtQL4ptjYu8GVyYo
         jmRlhzca1xeSgjOIySu5vYh83Max+exs9Nj+U8AXfWKj1Ddq/71X54gbo48iHBxC4wDS
         FPAva8P5iLckCsJ0R7gAwXRwUrsmkziOjtcNqKIKUGggF/sI6ATbttSsVKOfljj2MFxe
         ZT8a79UiUJGF4k81lCu7hKgcGSHlHQnJoOJHhpmH8VK6Opp/X5EQxJB57dz2392BUby6
         5EUw==
X-Forwarded-Encrypted: i=1; AJvYcCUpMO4P3GoU5H7q8LwpSwZW3YQ4DilINyZSs1hYcafHSl13DAh2rotBFSMoqhUQzVFoyi3Be/SjamnI/b54@vger.kernel.org, AJvYcCXo/qAEjXF2balSZ0KAHIv7YPvbQdbasa9GkzBFd7p4HjymCcQe6VuqPpf3e7l4uzFbM/3aeAzlniTKIfw7@vger.kernel.org
X-Gm-Message-State: AOJu0YxvTkf9v5uF3XLEwA3bcyGmD/45LGCsK7NFjmiGYcU4tmHyaduS
	MgRw/QMa5M/+r2MSb3fkO7mtPOWhlACUb100aZmcEUShijoG2S6cz06/1tX0M0KpswlEqb0PlhC
	daL81RryatFzZKg0uFhayAPtmK4U7QsGA
X-Google-Smtp-Source: AGHT+IHcTHSZdC0Z88gNxFh2UTs5vfM8SVLlU+v0plSU9lZArMDhkKDUcVgTkUkA+NHndi2JlHZpPZwlAOdCCkL4GoU=
X-Received: by 2002:a05:622a:34d:b0:460:908b:f1e8 with SMTP id
 d75a77b69052e-460aed4da18mr36943681cf.18.1729275194593; Fri, 18 Oct 2024
 11:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66fc4b74.050a0220.f28ec.04c8.GAE@google.com> <CAJnrk1ZrPcDsD_mmNjTHj51NkuVR83g5cgZOJTHez6CB6T31Ww@mail.gmail.com>
 <CAJnrk1ZSZVrMY=EeuLQ0EGonL-9n72aOCEvvbs4=dhQ=xWqZYw@mail.gmail.com> <CAJfpegu=U7sdWvw63ULkr=5T05cqVd3H9ytPOPrkLtwUwsy5Kw@mail.gmail.com>
In-Reply-To: <CAJfpegu=U7sdWvw63ULkr=5T05cqVd3H9ytPOPrkLtwUwsy5Kw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 18 Oct 2024 11:13:02 -0700
Message-ID: <CAJnrk1aQwfvb51wQ5rUSf9N8j1hArTFeSkHqC_3T-mU6_BCD=A@mail.gmail.com>
Subject: Re: [syzbot] [fuse?] WARNING in fuse_writepages
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: syzbot <syzbot+217a976dc26ef2fa8711@syzkaller.appspotmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 3:54=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Fri, 4 Oct 2024 at 21:04, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> > > The warning is complaining about this WARN_ON here
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/fs/fuse/file.c#n1989.
> > > I think this warning can get triggered if there's a race between a
> > > write() and a close() where the page is dirty in the cache after the
> > > release has happened. Then when writeback (eg fuse_writepages()) is
> > > triggered, we hit this warning. (this possibility has always existed,
> > > it was surfaced after this refactoring commit 4046d3adcca4: "move fus=
e
> > > file initialization to wpa allocation time" but the actual logic
> > > hasn't been changed).
> >
> > Actually, it's not clear how this WARN_ON is getting triggered.
> >
> > I will wait for syzbot to surface a repro first before taking further a=
ction.
>
> I think the issue is that fuse_writepages() might be called with no
> dirty pages after all writable opens were closed.  The exact mechanism
> is unclear, but it's pretty likely that this is the case.
>
> Commit 672c3b7457fc ("fuse: move initialization of fuse_file to
> fuse_writepages() instead of in callback") broke this case.
>
> Maybe reverting this is the simplest fix?

Reverting this sounds good to me.

I guess we don't run into this warning in the original code because if
there are no dirty pages, write_cache_pages() calls into
folio_prepare_writeback() which skips the folio if it's not dirty.

Thanks,
Joanne
>
> Thanks,
> Miklos

