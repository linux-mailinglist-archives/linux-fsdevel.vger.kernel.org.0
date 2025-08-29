Return-Path: <linux-fsdevel+bounces-59626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12866B3B789
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 11:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B7918908A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 09:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1AE2FDC21;
	Fri, 29 Aug 2025 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzP1EoUB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2352264CA;
	Fri, 29 Aug 2025 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756459905; cv=none; b=a2OCOXD3jro286gz1Mz0HW6D1dc3uKAV1lqY1H3Q1z0ZFDjRwjguhsUhct3PtTIBCnBBP3VrZuiRayn2QqnqECuG43nsXH8qhvFtSXrB6KSEy2MGwS3qV68CpU2KAnQfQTdZUeTJfiL5xeJQSV+K+/yMntlmVnV7RrUWWmy9zJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756459905; c=relaxed/simple;
	bh=TFmpqrDuZzk1PfENqc6BHFvUgs39QSPGfIFjT0wJQyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aByyEfErEVP9uAaqrW3ycG2Tvcy/vvsrew6+4LYsK5AuZ1mlVB2cgYgo+ySfZR0KELPGnCQazsi/1hlq17WRvBS2atCTnSS9Y3KT/6OSZ2X65lWbWyTCXoiuVN+TPXN6jhagrxbaq306iiXNfYFlwtDO7lgjoH/2D3y/YKAoRDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzP1EoUB; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61cf0901a72so1851265a12.1;
        Fri, 29 Aug 2025 02:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756459902; x=1757064702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXubTchbwvZaUajIutsCKJWz5ri+uL4LtwyyfrFR0Fc=;
        b=IzP1EoUBDgpXkfJugwlRF8TMTSqQFkdEuidmPLmDY58E53wE2eWWAQgHyPNO8wW3N7
         L4L2lSUEsDuvjZCrctOSJeUo8XCn3fO0TbM/XZmIcdoZgMbQuA0dW/2W37PecLp8KNPG
         DzySQaer6+dIZ0zyhS2mBS7foqNh0mRxSuqR/3HW+InJjsEFKWVlmdwWz9N5w1ykgU8r
         vd/a09uVwdC4F8+XQA5OeTcrAt8p0MuXCB3iiPHGo3Z01EFvmi52hFS0Gne7/eBMp3OE
         FdTCGA3R1kB532JsGNqJqbOH7ZDjm3swTOyldVtDZnv++irdzCmeDQJtN0qX1LMY+ive
         5lOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756459902; x=1757064702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXubTchbwvZaUajIutsCKJWz5ri+uL4LtwyyfrFR0Fc=;
        b=khSBj7ncqqp0UBG0qEpqsFn0UowncB/A5R9JNGD0HYttCE8fknUvaLHpqcWx/Z5EEG
         P8f5/hmnn1t1jpkCewZIxNv72aeI73JUj0FW+GpjQmNZkkTfkrZwy5fp1U66lbtBVaQH
         lgnZKDTE/b2igJGz1rTKGF6CVNMSPOA8gU2CwVlKXic8EZfNCixheLgT21V1PdJ6/tCo
         fwicz9LBdheyoY7icz87fGNrt/LFxCTpb5rCtwsUEwys3HkKiaF4PNl7RBPB5XT5KUkQ
         nl+0a47BBKvJPBLO+5fCTYa7ELiGQqXK57+mLvWe5n3Vy36vRXIjACdUrWE9nt/opMQM
         4arQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOumb2nu0P9CYESBtrBKI7Onu0HQORgzFMi6YDu03qAO/jqxbsl/GlmMnsHPABsqhN6XoDKcH3AhxNDtDyAA==@vger.kernel.org, AJvYcCWpgNCahyVJEt1R/DvmA4z/FgSOJio+zuhX7VvCHanecIGRAnhfbRJ9WQwsRcAkQymSYw8KEmFEj30R8XsP@vger.kernel.org, AJvYcCXvnNjMz5yN7DTuNcfiu9hfJ5sZ7zfaWp9/2G4NJsR7gSVYg3CvdMJYNYR0M0WgPNC4q9lccqmaOQc6MqnE@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk4gvkRRJ8SdcfMnF/zd2Zj5g6Yenl5HySxkBE80V5Vm1cvrh8
	UhceD20H+GLr3SrvEIk6XdGOqtkH+30QTCDi5Wxsu/Ts73khy+6C6AV2SGona2GG3foSsol8N9/
	EDF1Vkk2ex4Z1y3G++egdMiQw71U6d8g=
X-Gm-Gg: ASbGncsyrqSzkQnirsONmxl0zKeChvfo9wn2orW5gxknK62KvaeKZJyh2QgvXVZv9m+
	0myYvYXv3wXu+Aj+YRWnhF/KObFXkRWTCtLS2onaH/mcEYmA7KTcYv96yMd0S+uUKBLLSh3Gffa
	3Jbt+c7gZ7Sv/Y9e2+D/xI5A4t1AqwO57DYxChNqwSIbvQYwVBd9S/5EAvA/Ec0j7L+Lu6Fb77G
	AlBNl204G7MS+cpOw==
X-Google-Smtp-Source: AGHT+IEW56i3uuLsjGQiYtEQTu3jJWGM5XY6MhFx8dSCG2ClW4Hg6swCYE/xgcVP5dLk5jPgz3dG8IAKo4D+VljZbFs=
X-Received: by 2002:a05:6402:278d:b0:61c:e86b:8e3b with SMTP id
 4fb4d7f45d1cf-61ce86b91e7mr4358538a12.23.1756459902081; Fri, 29 Aug 2025
 02:31:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxhJfFgpUKHy0c23i0dsvxZoRuGxMVXbasEn3zf3s0ORYg@mail.gmail.com>
 <175643072654.2234665.6159276626818244997@noble.neil.brown.name>
In-Reply-To: <175643072654.2234665.6159276626818244997@noble.neil.brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 29 Aug 2025 11:31:30 +0200
X-Gm-Features: Ac12FXyFDId4PisLZWHYgIvi5BD8hYRBeEN948zp6qMmMuRPOygZuJneTqW6DiA
Message-ID: <CAOQ4uxj8mncxy_LOYejGWtokh=C2WpDcGFqj+-k+imVtEk-84A@mail.gmail.com>
Subject: Re: [PATCH v6 9/9] ovl: Support mounting case-insensitive enabled layers
To: NeilBrown <neil@brown.name>
Cc: Gabriel Krisman Bertazi <gabriel@krisman.be>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 3:25=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> On Thu, 28 Aug 2025, Amir Goldstein wrote:
> >
> > Neil,
> >
> > FYI, if your future work for vfs assumes that fs will alway have the
> > dentry hashed after create, you may want to look at:
> >
> > static int ovl_instantiate(struct dentry *dentry, struct inode *inode,
> > ...
> >         /* Force lookup of new upper hardlink to find its lower */
> >         if (hardlink)
> >                 d_drop(dentry);
> >
> >         return 0;
> > }
> >
> > If your assumption is not true for overlayfs, it may not be true for ot=
her fs
> > as well. How could you verify that it is correct?
>
> I don't need the dentry to be hashed after the create has completed (or
> failed).
> I only need it to be hashed when the create starts, and ideally for the
> duration of the creation process.
> Several filesystems d_drop() a newly created dentry so as to trigger a
> lookup - overlayfs is not unique.
>
> >
> > I really hope that you have some opt-in strategy in mind, so those new
> > dirops assumptions would not have to include all possible filesystems.
>
> Filesystems will need to opt-in to not having the parent locked.  If
> a fs still has the parent locked across operations it doesn't really
> matter when the d_drop() happens.  However I want to move all the
> d_drop()s to the end (which is where ovl has it) to ensure there are no
> structural issues that mean an early d_drop() is needed.  e.g. Some
> filesystems d_drop() and then d_splice_alias() and I want to add a new
> d_splice_alias() variant that doesn't require the d_drop().
>

Do you mean revert c971e6a006175 kill d_instantiate_no_diralias()?

In any case, I hope that in the end the semantics of state of dentry after
lookup/create will be more clear than they are now...

Thanks,
Amir.

