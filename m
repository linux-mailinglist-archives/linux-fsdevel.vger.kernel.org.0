Return-Path: <linux-fsdevel+bounces-67916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B2BC4D892
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 12:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE2AD4F6281
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 11:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6399533CE91;
	Tue, 11 Nov 2025 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kedGt62l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381A128FFF6
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861668; cv=none; b=Gg0G8wKP2aamnVnL3S0lYuS/FRI6UwePL2nKM5yuO+klQDiTB3lzcZladcbaXHNylG1q8eB/WFkc7SbBxi4fin+skOqAa4p8Hu0Ou6QQGD9Fx51/6zMJvtFvoh/VaHnSSR3OtWZ0np648aGTbThYebWSpumkeSYsPLLVs4mHwUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861668; c=relaxed/simple;
	bh=jhqtP7s3J6aXUrsWY8SH4BcYvf5qE7GblQujzK699wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ka1L1WJXar9E0GCNADCTuYQv/R5J53bxjLzMGPK3i17Uw324AG7YbIx13EzCPQgLPz9zuz6ZHLYX1ZTwCWrGhVlZmz/nFzf9bpTaW0jWz3/yR+ODsWcguJqC9inG0Gv7EMc2iIZNT6bHN0w03dn2zGEW0a+imJ5FYoEFZgIuygo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kedGt62l; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640c6577120so7486280a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 03:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762861666; x=1763466466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8y/CoERQP/gGJ1rgb0QyOuyq2NoruU8Gd9wvvvICRo8=;
        b=kedGt62ldvN4v2vAxqdPzD0PeRYq+puEI1PlzsiE6hYiLMw7BiKre47WRdDZjc+/wc
         TO/RVIv8XdHBTLluK9aiRF3PMYl9B35gp92gifjk41QkKy3mr1ckJBGlEE98A/pyD2oT
         mHvN2Q2FFQyT137UkIAKRzR9VVVH/60840wCCH9mQtDRSRSBWr4V6T8iNqQT90mPzfZN
         E7REPmmsC97EUZ2mlHJPQCLkk/oUQNZfKAjQJAH0SgSTv1A2AZ5ATrbCU/Vexq/df4Jj
         4AnaZ1xKpMyfaaB1ILLYpyWffCHBH3B/lPgmDcdwq9fUseRoa4ElpZVhivvfEQFLthSO
         B2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762861666; x=1763466466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8y/CoERQP/gGJ1rgb0QyOuyq2NoruU8Gd9wvvvICRo8=;
        b=IzGeJZg7C75BA9jJFbnQ4f2QfSopcS/e+mBzJAmmclXfYrcmb0zXVF84NkDGgX/2v+
         KaPfCPiWDGIFcPJOku6DKdnNDKQUrla70n4Nc7TuRnUEPbaajA0kpKtCECtIrk5Coidf
         7zxRAz+7esbW87QmcSkrHA+obxst3MY1NYK0CIorXeLIR3EAOGxQfy043xfQGjjSw1HF
         w3uxQ1mNMh+DcFC7DRBsD/+zXV7vmp5EJ9u2hXsO8VAjmFVhHHC2vcpW5GGSIzoT5CzY
         ygGe1RHgspuIwQLi8ROJ2sbJnb5BOez/9YRaGVgEaAe8AuoznsPGcEeG32s8r/dybalb
         POiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPeRcjiiybns/SOU+prto1hCv2HclzANhu5/Iwb6blaE7IXn/Hi+HS+cfXXSztLk3E226KluyEpWIH3dbk@vger.kernel.org
X-Gm-Message-State: AOJu0YyStAg09+yhvkZgfOKoGHStgGuCp7snuHj28kYll93VYHdV3vAp
	Zkuh+cyMVtvJlhF4v7Gq+VskBqd2q+CDLf2W9mwZm2npHeSmby+0ROoxRTESEue/Dc4oJbqZTUc
	R29y77AhJNbKBDSiHvEPtzb90Unq1P3rHAtV3
X-Gm-Gg: ASbGncufjgX84KDYB9fOsKOdnEC6baaHuEOy1pLOMDdiDAqbfSwuak7N1/RgmbSNrz0
	Uuziun8wTfDcB8QFGJpBLlkJ23z7orN13sqyjjGm8gu86vjRXb1UF9S0M12k0pWUWGZRNz39rhv
	lBRSpdbUhQTdsbvfJ1fkOIoOTqW5wlB3ZH9p/dIc9+xNDZbNe0aKxdsiac+C86cvS4bP7LcUzEZ
	5Z83qTBqR9vawyIyKLDfT7SprDQCactalZ+/ajHx9LdHoMbhDyHJ9k4lXUkgrCf2HXn57fFEhnl
	Mwm/ZT9gZBage9bdB/JjxISCNg==
X-Google-Smtp-Source: AGHT+IHPgX7/cQUS/SIkRBOM8pcz3hJsiOAlFjo0Fb0yGdPgC0U7mQuUxEs+ewdADJ8NOEpX3yO5a/UCUe9UhwbXEp8=
X-Received: by 2002:a05:6402:27d0:b0:640:c8b8:d55 with SMTP id
 4fb4d7f45d1cf-6415dbf4b40mr10417786a12.3.1762861665470; Tue, 11 Nov 2025
 03:47:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107142149.989998-1-mjguzik@gmail.com> <20251107142149.989998-2-mjguzik@gmail.com>
 <20251111-zeitablauf-plagen-8b0406abbdc6@brauner> <CAGudoHEXQb0yYG8K10HfLdwKF4s7jKpdYHJxsASDAvkrTjd0bw@mail.gmail.com>
In-Reply-To: <CAGudoHEXQb0yYG8K10HfLdwKF4s7jKpdYHJxsASDAvkrTjd0bw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 11 Nov 2025 12:47:33 +0100
X-Gm-Features: AWmQ_bmVl00-gq76dJA6KDpo9yPluWXIzE9z1CQp_8ryN3rR25PxN1oBL_2n39I
Message-ID: <CAGudoHHGvXsks+V2Gd0dr66idZdM9bJFriHrqzx5z_vfA9CA0g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] fs: speed up path lookup with cheaper handling of MAY_EXEC
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	torvalds@linux-foundation.org, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 11:51=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
>
> On Tue, Nov 11, 2025 at 10:41=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> >
> > On Fri, Nov 07, 2025 at 03:21:47PM +0100, Mateusz Guzik wrote:
> > > +     if (unlikely(((inode->i_mode & 0111) !=3D 0111) || !no_acl_inod=
e(inode)))
> >
> > Can you send a follow-up where 0111 is a constant with some descriptive
> > name, please? Can be local to the file. I hate these raw-coded
> > permission masks with a passion.
> >
>
> #define UNIX_PERM_ALL_X 0111?
>
> I have no opinion about hardcoding this vs using a macro, but don't
> have a good name for that one either.

Apart from usage added by me here there is:

fs/coredump.c:          if
((READ_ONCE(file_inode(vma->vm_file)->i_mode) & 0111) !=3D 0)
fs/namei.c:      *  - multiplying by 0111 spreads them out to all of ugo
fs/namei.c:     if (!((mask & 7) * 0111 & ~mode)) {

That's ignoring other spots which definitely want 0111 spelled out in
per-fs code.

I would argue the other 2 in namei.c want this spelled out numerically as w=
ell:

          =E2=94=82*  - 'mask&7' is the requested permission bit set
          =E2=94=82*  - multiplying by 0111 spreads them out to all of ugo
          =E2=94=82*  - '& ~mode' looks for missing inode permission bits
          =E2=94=82*  - the '!' is for "no missing permissions"
[snip]
          if (!((mask & 7) * 0111 & ~mode)) {

But then it may make sense to keep this numerical in the new code as
well so that anyone looking at lookup_inode_permission_may_exec() and
inode_permission()->generic_permission()->acl_permission_check() can
see it's the same thing.

I figured maybe a comment would do the trick above the 0111 usage, but
the commentary added at the top of the func imo covers it:
   * Since majority of real-world traversal happens on inodes which
grant it for
   * everyone, we check it upfront and only resort to more expensive
work if it
   * fails.

All that said, now that I look at it, I think the code is best left
off with spelled out 0111 in place so I wont be submitting a patch to
change that.

Given that hiding it behind some name or adding a comment is a trivial
edit, I don't think it's much of a burden for you to do it should you
chose to make such a change anyway.

