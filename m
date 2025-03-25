Return-Path: <linux-fsdevel+bounces-45024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7C8A7037A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 15:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE88188D85C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6FE258CE3;
	Tue, 25 Mar 2025 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xob5GJY/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED75E25522B;
	Tue, 25 Mar 2025 14:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912123; cv=none; b=mlowtc5xo+C5jPLr/nMfD9l8IEeBf3vvLw2VKFew4EjSNlNhcUQNvqOjUcRrqkQHq1RclPZhzbmr/R3eqZF2XlPi4ICvVElWeB6lOD8YFQm3yH3pl+EWbC6ZNVyLMhRVb5LqARqSSQjD28nBCgCsNf4ZJtb4RVNgjCHL2/UvHHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912123; c=relaxed/simple;
	bh=ZMaNHZC6xbmIZfH1KZ7uFhl2JDUoKP3oGCElsgWSgIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KyJ9hBNxSWheQVYT+1XfZp8wTId9FmcIGsmKv7Sa0UUQiint/UEUqZCRrX+trk+QitGI8sOAnX8WIEkIU9qnCcoTgqERBup4OHu5Ntrnmww22dVGriVQglatewAKf4FuD8ppb6eio+aY/EYLQhyWhqF40LSjdVJC9FsP1bWfQb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xob5GJY/; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so10230916a12.1;
        Tue, 25 Mar 2025 07:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742912120; x=1743516920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMaNHZC6xbmIZfH1KZ7uFhl2JDUoKP3oGCElsgWSgIw=;
        b=Xob5GJY/JSC+XBU5GOgWFti7wzv5A7ApXFX6667Ph18jTYxXWzoxr7UrabL+A44sCk
         cimdWsTDipyas+vgjg4qE27wCsP/tT+pEOvpwd6Jn6C3Wl0TILAmOoDQgyL+JDV4WrgI
         JU9sWWKDOeC+KFIAK9/6pIex0YWIiVpBIfA+DezRWUV/PjCYOcTXtraISDk1DNBMP1H2
         Ibg9C4IVte4hGOMRe6pVRcE6Gg732KRL2lRiGMM6Kyuwjcol8ntbR/8qpROiqpyS2PfQ
         yxUkFGVZTk6oGs+KsSqIbF3Otd5RNHIiyEt6TvDboqbs8YNFRxer1PGAE5TTnZhDguWV
         RxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742912120; x=1743516920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMaNHZC6xbmIZfH1KZ7uFhl2JDUoKP3oGCElsgWSgIw=;
        b=Becc7DLGpkHiExhAY0PunoTA30iMt+B/0NMZ1zChBrJ3OjYR1UXLMQpL8ccYCckDF0
         A/ZvEEUeQfFFm1dtLOpWrJmKEowqrvavzaeP0IqGev/CiKYh1XWdENyZBI+zjZYV2W43
         JC9u884zvwfQXaleTH5FuVgoxf/2Cx7RcRe9mWZLULVRisXsoP4WFp/SgzEln14rXoZh
         slZRq+PY7xLOpiLvoZiXYHh6L6RE6jxFu+r6v+TN7dTbVocz/d9BPA3qhuubkpUQqgf6
         ItOxOknVDQAWtPk5aeOSpHTPDn6BPO7pxHBAjtANjdUtEINoMpgIKwjLWFqi5pasJR4q
         R3fQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+B5MgnpypyGa+aHXfuBeaWtN39pE+jsRm5axyPXgqwHJv/zuuT9CD8ADBvLRQy8/bYQAWuh7po675KcpI@vger.kernel.org, AJvYcCVfoTmh4b2918IAgMkylVGtaHatXE3bZeHf0QDNWPD1XEKk3KCaQsivkHbBQe+RHaQgBJmIH/YvVxv1D9cz@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8czkqEnWQ5xhAgkistgjx2Q9FoWij2RpV4g5tHeLFitewt4U8
	hp6oOs9LInykV7dEUQFEO4kSINNJ5xKy2QAXaNnVPaVEMfl25bbsmE8MEP6TwlY2TsdrsDjOrxp
	8IR8y+4JWqoy57JhRFWlWDR42XTA=
X-Gm-Gg: ASbGncsgpWRpZVAzRspIuIQcfLFFcGMT9d4EzKhuhXRUq5iC/5VztJXgfbASwjxX+Qf
	d3z6G4TIEeQHNi82uRK4PBVmXbCTsAoTMX7nquBa2qYj+WytphQ4YUgnhg/nG2PGmttIeLrbQVn
	H5OW2n/EJUgS+8Rbqp+Kv/rBfLRQEHobYJ3OC2
X-Google-Smtp-Source: AGHT+IGCXq0i5sPbB6D+egYNTkN8t7fqQ46d/BSo5o0rsWhypxWST0TCfi0Il6K80MobV/2JX8on8SPeqOHSZWZg/k4=
X-Received: by 2002:a05:6402:2712:b0:5e5:9c04:777 with SMTP id
 4fb4d7f45d1cf-5eb9972ae95mr19756146a12.6.1742912119870; Tue, 25 Mar 2025
 07:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com> <20250324160003.GA8878@redhat.com>
 <CAGudoHHuZEc4AbxXUyBQ3n28+fzF9VPjMv8W=gmmbu+Yx5ixkg@mail.gmail.com>
 <20250324182722.GA29185@redhat.com> <CAGudoHE8AKKxvtw+e4KpOV5DuVcVdtTwO0XjaYSaFir+09gWhQ@mail.gmail.com>
 <20250325100936.GC29185@redhat.com> <CAGudoHFSzw7KJ-E9qZzfgHs3uoye08po0KJ_cGN_Kumu7ajaBw@mail.gmail.com>
 <20250325132136.GB7904@redhat.com> <20250325-bretter-anfahren-39ee9eedf048@brauner>
In-Reply-To: <20250325-bretter-anfahren-39ee9eedf048@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 25 Mar 2025 15:15:06 +0100
X-Gm-Features: AQ5f1Jr8oXwwdmvGSBUITgwEGjTjEUXxS32Qqv2Kn_lvnq3BY7I5kPchOqLOEt8
Message-ID: <CAGudoHFGcTergsO2Pg_v9J4aj94dWnCn_KrE1wpGd+x=g8_f1Q@mail.gmail.com>
Subject: Re: [PATCH] exec: fix the racy usage of fs_struct->in_exec
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, 
	syzbot <syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com>, kees@kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 2:30=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Mar 25, 2025 at 02:21:36PM +0100, Oleg Nesterov wrote:
> > On 03/25, Mateusz Guzik wrote:
> > >
> > > On Tue, Mar 25, 2025 at 11:10=E2=80=AFAM Oleg Nesterov <oleg@redhat.c=
om> wrote:
> > > >
> > > > On 03/24, Mateusz Guzik wrote:
> > > > >
> > > > > On Mon, Mar 24, 2025 at 7:28=E2=80=AFPM Oleg Nesterov <oleg@redha=
t.com> wrote:
> > > > > >
> > > > > > So to me it would be better to have the trivial fix for stable,
> > > > > > exactly because it is trivially backportable. Then cleanup/simp=
lify
> > > > > > this logic on top of it.
> > > > >
> > > > > So I got myself a crap testcase with a CLONE_FS'ed task which can
> > > > > execve and sanity-checked that suid is indeed not honored as expe=
cted.
> > > >
> > > > So you mean my patch can't fix the problem?
> > >
> > > No, I think the patch works.
> > >
> > > I am saying the current scheme is avoidably hard to reason about.
> >
> > Ah, OK, thanks. Then I still think it makes more sense to do the
> > cleanups you propose on top of this fix.
>
> I agree. We should go with Oleg's fix that in the old scheme and use
> that. And then @Mateusz your cleanup should please go on top!

Ok, in that case I'm gonna ship when I'm gonna ship(tm), maybe later this w=
eek.

--=20
Mateusz Guzik <mjguzik gmail.com>

