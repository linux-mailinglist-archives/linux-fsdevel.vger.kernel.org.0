Return-Path: <linux-fsdevel+bounces-44947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D571EA6EE5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48EF716E3B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 11:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2553825523D;
	Tue, 25 Mar 2025 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0WikFTV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0983A1DBB13;
	Tue, 25 Mar 2025 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742900526; cv=none; b=q8wuXiveKCfD5/eM5+6KPcjd1PD+f9KxwDuQbGVZVMS6VELPue2wtdg7GZ8hgolWRkBcQJAmQkw1DQ0awLyH7OG4XRUzR/uKO5F7fDDtd7sZemeGntkTQk8+NUnkG4FgKXILPbucNrk2dAeU/6SS6lIKt+7iMTZLeRHk/BS5Njk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742900526; c=relaxed/simple;
	bh=d9cJHqgdTihL3x/ENZcpztbun5BBaD+cuvBq0dxZnOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpSbVwRaUmDI2mUk4G+LCe3rJHEhI7s+HN6bnCo2PoAiobLbUS7x8wJaMMhVeOgTbrs29N0937G5ltMPe6HsMkAUAOOIe7hBnYA5qBbwU6GZ7C00lUxL+a7h+BWEEVNUEUDst47YjQLrxVhBRaDeoe49hTT982odO9yV710pXZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0WikFTV; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5ec9d24acfbso3957226a12.0;
        Tue, 25 Mar 2025 04:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742900523; x=1743505323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9cJHqgdTihL3x/ENZcpztbun5BBaD+cuvBq0dxZnOU=;
        b=T0WikFTVOkpAml5aiE+M4i88TH8N2jSCRAKakiRvjCYztWsDUcm389FmqUx8JNsIue
         LjcDyPW2Jvq8drkTnis3DMdH8cOp9OdI2siCah9TZfO3VzSXKrhp2F3x7bcUXCzl2C9m
         B8QylHfur4Qw/fTaNAWzuZSgMiSLW/k7mshoyQyE+TTYYqnD+CBshWsSgs2EJjr4Zq20
         TPA1va71TKqSOKNA9uYhIr/KDwrL1aeeR+e8Bnh1SS7rFVGrnZt+88PIQ4tvZ8zlicSL
         I/OD9oLNAMNleGdatvJpzTWdcjVxFrC7AiImg5eSQoGNViJ7mnNI45S+mq/535QDzhP/
         dBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742900523; x=1743505323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9cJHqgdTihL3x/ENZcpztbun5BBaD+cuvBq0dxZnOU=;
        b=Ks9GmP6xzN/87D8hCMrdTKdQz4bxmEKtCBx3FLm8bveBhzC3k2JbN/V/kCyPbS9srY
         yC3R5214Bc40kDVD7bpyKQ2Y0tj8fqY6fJ4PUZglpmmZps8BuLbAFo6U8yynlWr6MCe2
         lSOQ4UUZRZDIUwLvFN7svuFnldYgQKxNRLAarXk1+kLSMT2y3nzbr2ojiuXHAWYKZqfV
         EEyQ6SY3ohljxKXmurKqKs5n+e9f1Jb7v1MeYXi/FM/wBXMV/qLLaJSuvZSnZGKYqq5D
         mjPf9H87hUTwTFfMW9CFXcGR7NqrqonrC8n5kDMflLKF4P4tetQsM4UmKPfDF2GAQjki
         pb/A==
X-Forwarded-Encrypted: i=1; AJvYcCUFMXtpfVYvDNUzCD0SW8UEArcbwYbK6pwC/KvShsqYbfqejpr/R2bTH1wETM6H9qrwnfUD28ZeHI2Y1goi@vger.kernel.org, AJvYcCWqkC25dIUDypyAcCX+C+FEMdle7xC9EtPavmgDfgiDMrH6bPbFJmAHGMJnUByLctWz9K92tcGvtAyiVcFg@vger.kernel.org
X-Gm-Message-State: AOJu0Yyluq0q/SscEr/k3iuXBHN3xsVqOVDQALWsYyqevK5tWFumvoGH
	ffvND+MaEg/tzwgKwBKaXAUmuiUFmRR6TF5CsJEkWELOkbPcJ6FEWjudiYdzZLcKWpmfi2WgXbN
	Sfku0FQsARWmAZtznA8FXAN1KDuA=
X-Gm-Gg: ASbGncvhvJ533F59gvMxQCfpUPLOn4Edbe714zGQblhW27jbYN07rMIkUaRxQgT4iOH
	+5kGHZ/6ZM58uNYZ9U5nyHZ3CDRrzorGQ6p8OeuvtZJgCh8cqAmOX2bVgKB26TLKLKqnQ+K2zzp
	GqrXIWi2f5LqAt2afEx6kgAKGldA==
X-Google-Smtp-Source: AGHT+IFf9rx3WECjEtLq0ZqViTHfUFRFGehddqyhnNTT7jlnRQnvfLKXkrgWtM1qJqSBXUtHqRaIXigkjTorXFYAqao=
X-Received: by 2002:a17:907:7fa8:b0:ac3:25ea:822 with SMTP id
 a640c23a62f3a-ac3cdb2ab93mr1976495266b.4.1742900522951; Tue, 25 Mar 2025
 04:02:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com> <20250324160003.GA8878@redhat.com>
 <CAGudoHHuZEc4AbxXUyBQ3n28+fzF9VPjMv8W=gmmbu+Yx5ixkg@mail.gmail.com>
 <20250324182722.GA29185@redhat.com> <CAGudoHE8AKKxvtw+e4KpOV5DuVcVdtTwO0XjaYSaFir+09gWhQ@mail.gmail.com>
 <20250325100936.GC29185@redhat.com>
In-Reply-To: <20250325100936.GC29185@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 25 Mar 2025 12:01:48 +0100
X-Gm-Features: AQ5f1JpTONFO0gbZ_zxBvlJ_8LU60QgkNDlC1LnIvICNvskd11D8aTb39EJsvyQ
Message-ID: <CAGudoHFSzw7KJ-E9qZzfgHs3uoye08po0KJ_cGN_Kumu7ajaBw@mail.gmail.com>
Subject: Re: [PATCH] exec: fix the racy usage of fs_struct->in_exec
To: Oleg Nesterov <oleg@redhat.com>
Cc: syzbot <syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com>, 
	brauner@kernel.org, kees@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 11:10=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wr=
ote:
>
> On 03/24, Mateusz Guzik wrote:
> >
> > On Mon, Mar 24, 2025 at 7:28=E2=80=AFPM Oleg Nesterov <oleg@redhat.com>=
 wrote:
> > >
> > > So to me it would be better to have the trivial fix for stable,
> > > exactly because it is trivially backportable. Then cleanup/simplify
> > > this logic on top of it.
> >
> > So I got myself a crap testcase with a CLONE_FS'ed task which can
> > execve and sanity-checked that suid is indeed not honored as expected.
>
> So you mean my patch can't fix the problem?

No, I think the patch works.

I am saying the current scheme is avoidably hard to reason about.

>
> > Anyhow, the plan would be to serialize on the bit, synchronized with
> > the current spin lock. copy_fs would call a helper to wait for it to
> > clear, would still bump ->users under the spin lock.
> >
> > This would decouple the handling from cred_mutex and avoid weirdness
> > like clearing the ->in_exec flag when we never set it.
>
> I don't really understand the idea, but as I said I won't argue with
> another solution.
>

I'll try to ship later today so that there will be something concrete
to comment on.

--=20
Mateusz Guzik <mjguzik gmail.com>

