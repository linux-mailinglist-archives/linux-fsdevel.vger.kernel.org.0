Return-Path: <linux-fsdevel+bounces-35303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B20D9D388F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 11:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5ECA1F23DFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 10:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC6C19E99B;
	Wed, 20 Nov 2024 10:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtJ5isa9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986A719D8A0;
	Wed, 20 Nov 2024 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732099371; cv=none; b=ChuJoxHJGgcnTpUpaJ7kxisecmh9hblibfWHPMWqKHOf2S5vkX+1iyhETZ87Qw0N6ubcHXT3Xz2qQqUVucc/g950JKrywMAIVo215J5qryJaeiupKtDXWKHAzJ9LZQT1dA9gsPQOb/7XYNSTV+xH2IgdG8GivTZ8wgMIf6OxhMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732099371; c=relaxed/simple;
	bh=8CdhlOiWSgPSc0I2TJV4p5BcnUvFnL+U8Uc7hVG1hS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/2iRy6g8AD+4D0uZBCBuUY5M0L61/BhY9evjtTVQv8AOeIIJz24MvFb/bbZHts9H4/0RN6/hXEeW/xv9XtdTGJqQ7olKY2sx39GraA1qNr/WNrO6QkDkQoHWLNb4Q4gSU16q9hk53edOP3CPuFjCp8o8pQx/fU00CbrxO3MzZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtJ5isa9; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cffb4d7d9dso371670a12.0;
        Wed, 20 Nov 2024 02:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732099368; x=1732704168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1Fye+w9f2/wqLsR/K13urMmL0eynzt5Fyy+QvQyjT8=;
        b=XtJ5isa9R325PsuOhDtxspq/vNK9PSfzXFlJk5vuiHECEdeUjUNbePgNVOwgMAgFDn
         PD5RivreQlws7cEAf98hGosvuuljpbXkSBLZ5eopXXjuRoMa/6mDgEAhAw8vvtWk5U2+
         TDpqH/yGGHgjkq+TzYpuFdfxtU95YN/lBhklTSa+JrNcKVLNtniaZ573YDKhycvTZRrz
         AclAVJIo/l7Ug7DZ72Wfu2epTO1ljsELJCij7SKFpuKiovGBwFYofxO5o+IeB2/PevOm
         U2o5y24kjVzL8WiL0m6tU0OtXOPu+vuRBKdbcVX8hA3+TymF7SQiV2/y8W3gZbMYsBqU
         LsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732099368; x=1732704168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1Fye+w9f2/wqLsR/K13urMmL0eynzt5Fyy+QvQyjT8=;
        b=GZ+kQccde3B512j6ZPhKWFLRO2boGbbb+j0uIhLmoasGsKAc0H5sSBWSyMnh2aJ69x
         D9j5Cq4VdrVlnBAJaVILfvaXmCiI/W++UsRzRjHDtiI6y8dFS0/gAGLCqty95WLkw7sn
         qpo+EOiRKcjHs/hhdX6cjJtOuOfbK4n4HxyHu0rF6k7LvTuM4yd5eu5ciATLLELD2X+j
         UFyBcSLOTxNeHhua8wDt7Sxz1WtO27SFETtErqkcYXgn1A6vMzTO5JI9vNvD2N8HOla+
         D8R0XPb+CjRMTcm2k7UtqU8QnqIf/llPqUS4mXCRuC5YKNqs9T1ZNogaYJs4+OolUerw
         utCw==
X-Forwarded-Encrypted: i=1; AJvYcCVxVyStikzOY7og898bzS3KTPtNTgtu1IEa3Kle35HrNyXc3xHSQcq+kvU74d72c3BilyE163tdSEyT3OQGrA==@vger.kernel.org, AJvYcCXi+WUZW7LxOazlOAZbnxoaX+c0Il7MiU/MgGCbq+BD0zGqZpQcxIRhkNqzj2XB2fxNzoIYcifeJ45n@vger.kernel.org, AJvYcCXvlJd9LGNQAsJhB7H1QIIme5ANP1T+mj56h+CmFa1ZdTKCMe3tbkB6TRUu7FlExsA74F9RIWzsFmhoYj2m@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+grZYVaasNUwZ4+UAbmy4YD5nme8BkfpYcoGwQS88nBeeedpr
	lYz7oGcDyIObcL6WldlWUbG0s0//c0bA/roTnr7FTW9SB8h2tFRsfjPWzwK5ch1txqwHHxWmvk5
	IzX4/MEmClSPzJ/bsdX9Yo11RIEg=
X-Google-Smtp-Source: AGHT+IHvQxdoP+pAvWn1yN9/vfpnNgFvtu0z7BICfkNMmGGOWDcXwtOpUgaA6XYGwsQAvynctV9szk8UEj3jV6Hqhts=
X-Received: by 2002:a17:906:6a04:b0:a9e:d539:86c4 with SMTP id
 a640c23a62f3a-aa4dd5481d0mr159817966b.9.1732099367707; Wed, 20 Nov 2024
 02:42:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119094555.660666-1-mjguzik@gmail.com> <20241120-werden-reptil-85a16457b708@brauner>
In-Reply-To: <20241120-werden-reptil-85a16457b708@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 20 Nov 2024 11:42:33 +0100
Message-ID: <CAGudoHGOC6to4_nJX9vhWV8HnF19U2xmmZY3Nc0ZbZnyTtGyxw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] symlink length caching
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, hughd@google.com, linux-ext4@vger.kernel.org, 
	tytso@mit.edu, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 11:33=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Tue, Nov 19, 2024 at 10:45:52AM +0100, Mateusz Guzik wrote:
> > quote:
> >     When utilized it dodges strlen() in vfs_readlink(), giving about 1.=
5%
> >     speed up when issuing readlink on /initrd.img on ext4.
> >
> > Benchmark code at the bottom.
> >
> > ext4 and tmpfs are patched, other filesystems can also get there with
> > some more work.
> >
> > Arguably the current get_link API should be patched to let the fs retur=
n
> > the size, but that's not a churn I'm interested into diving in.
> >
> > On my v1 Jan remarked 1.5% is not a particularly high win questioning
> > whether doing this makes sense. I noted the value is only this small
> > because of other slowdowns.
>
> The thing is that you're stealing one of the holes I just put into struct
> inode a cycle ago or so. The general idea has been to shrink struct
> inode if we can and I'm not sure that caching the link length is
> actually worth losing that hole. Otherwise I wouldn't object.
>

Per the patch description this can be a union with something not used
for symlinks. I'll find a nice field.

> > All that aside there is also quite a bit of branching and func calling
> > which does not need to be there (example: make vfsuid/vfsgid, could be
> > combined into one routine etc.).
>
> They should probably also be made inline functions and likely/unlikely
> sprinkled in there.

someone(tm) should at least do a sweep through in-vfs code. for
example LOOKUP_IS_SCOPED is sometimes marked as unlikely and other
times has no annotations whatsoever, even though ultimately it all
executes in the same setting

Interestingly even __read_seqcount_begin (used *twice* in path_init())
is missing one. I sent a patch to fix it long time ago but the
recipient did not respond, maybe I should resend with more people in
cc (who though?), see:
https://lore.kernel.org/all/20230727180355.813995-1-mjguzik@gmail.com/

--=20
Mateusz Guzik <mjguzik gmail.com>

