Return-Path: <linux-fsdevel+bounces-35357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0F29D42AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 20:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A25ECB24DFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 19:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD901BD9FC;
	Wed, 20 Nov 2024 19:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVVchycV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B35F13C80D;
	Wed, 20 Nov 2024 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732132086; cv=none; b=SEut/mMMBJeTh8ehbMx9wOGAzEWzaQtfJOHhBjkqO0CAC/RYSNDeZW2IoYav1fpF/7BuUrQxELlSBkv+JZ3VZ/gCzZ+WjjDHAHuecEirTBpqd+Qwnu7z2j3dkSDXpX5kPGUNVHIowR0nWeiaBRCPAgTbcBJSnTx1VAa/SEVxroY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732132086; c=relaxed/simple;
	bh=0Lo/kZvQNQE+R2Vx1FWC1P/Kjp3Xt+Dk8cqzo4Z7ln8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KlXS/uGaYuv+ZMQS+x+dvNaq7ll7N8s6ifTDrbtnRc7qaCD9ObVuNHCaXXFSuVCPIE38qyBTnOxw1WwoY4mw6Kk6D3MtIKomBorZptrj1JSnDNh6qkXpwnPPx2UlzfpsWMU6fGa1CWFePVH9ATjGFmcfGqTcs72Yzzk3Q0QHeNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVVchycV; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb587d0436so1679721fa.2;
        Wed, 20 Nov 2024 11:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732132082; x=1732736882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Lo/kZvQNQE+R2Vx1FWC1P/Kjp3Xt+Dk8cqzo4Z7ln8=;
        b=FVVchycVszuMZEM2TF4ezHlGL3pukipQo60hdsBaor8AHwnrgWrPqyUpg2FHooD7VB
         wX2mgpK2BhrpeC7JOmX88Lhmj8BtQ1tPKGTEude1tMkZo4lt34tlmfbmYXqrGClIFimC
         bHiOzVfazYqTjXXTo5P1alIC9yRJ+BqEtLcsy3QrfQtUHAWqq3y845fLvDc5Jev0mTr5
         G+TikZ5VMy62aScDV6CRFEW/9JuewTmuy9L2ZC7B/Sv7K7km7gDKKL54Cc3uREBNp4jP
         gNhU7zS8pytP9eT92UpUSzeh5gX+8COjYKGs7O3eLGE0Uo60aojxuruVzDrMP4Z9IheH
         N+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732132082; x=1732736882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Lo/kZvQNQE+R2Vx1FWC1P/Kjp3Xt+Dk8cqzo4Z7ln8=;
        b=AYT3dYe57eQlXOQ7O7N0pPGf6ObIUi5c0VGTsoNjRE7Z7u/7mTVGP3obt377XIbAMs
         a4azh2J2dzCk7aaQ6Os1ebmWDeLMmUyDVFoyayG6jEnkU24sfw+DvZEH98PJqza4wX4e
         /FH0YyMa1YpUoaH+mzhIYi0hKtjHJP9bPcojuV83MLKbiVMWOY+jxVm4uRjpiZCIH+nH
         YbsvsJcLTfs4NyKT7Us0KPwOflmFvGBnJdYKbqLWLgdONeAZ/rpe+im/8G/ZaWQGRjHt
         U7gnyGoQhpH7pT1lQ+K/KHgBWfRzcvn7nkV59DDqaByD5L6TZuA9hiAW68z1Xqtgd/D5
         u42w==
X-Forwarded-Encrypted: i=1; AJvYcCVzY3P2vaXBNrsNEZ8SKulgjLW3YW5mSFUALTywLTghoUgpgIUCngtUsPv5SmJ5h6ylOyiKpSQ3H0EYXXPM@vger.kernel.org, AJvYcCWAZyx9L9QwoF24D3F05lok7tGMhk/APRuJEwvOhyyEIriYwgvoEugASYmnq4uTUO2QaCW3kGJytQU4Nx/WgQ==@vger.kernel.org, AJvYcCX7HmiFdHgaQvqmzoTR6xMKZeNK1d3G2abrvVlQQoo7H1355eKUbTVpAXNbDvV3G3nSijKALjeVH9fQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9MrPwP0/UibSp9rotcC/Ldkk825fDrHg61V5rWgN/8Y2ey/5N
	aBAWBGkArloWdU7G/sPqSKzPIJZB+UXkbIKenoad2ZvfDGBb07smmCydYLMPWXosg17pbvdMFfW
	Y4nKKmNgTl5o/5BN6yWflYJft2gDTEo61
X-Google-Smtp-Source: AGHT+IGTfArAZ13mpiOO2SvdLo5EAkhf22bPd0jLhEBjn43o+OJhGiIsD49VHIWNLOW5OIe+ZoDj5eU36oniMb2Gv4A=
X-Received: by 2002:a2e:a58c:0:b0:2fb:34dc:7beb with SMTP id
 38308e7fff4ca-2ff8dbcc0bemr23118331fa.12.1732132082284; Wed, 20 Nov 2024
 11:48:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119094555.660666-1-mjguzik@gmail.com> <20241120-werden-reptil-85a16457b708@brauner>
 <CAGudoHGOC6to4_nJX9vhWV8HnF19U2xmmZY3Nc0ZbZnyTtGyxw@mail.gmail.com> <20241120-eisbahn-frost-824303fa16d9@brauner>
In-Reply-To: <20241120-eisbahn-frost-824303fa16d9@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 20 Nov 2024 20:47:50 +0100
Message-ID: <CAGudoHH-asEyPj7CUNF+ApVhRoG1C4tmQYuko1SLNQ0o-LXaaw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] symlink length caching
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, hughd@google.com, linux-ext4@vger.kernel.org, 
	tytso@mit.edu, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 12:13=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Wed, Nov 20, 2024 at 11:42:33AM +0100, Mateusz Guzik wrote:
> > Interestingly even __read_seqcount_begin (used *twice* in path_init())
> > is missing one. I sent a patch to fix it long time ago but the
> > recipient did not respond
>
> I snatched it.

Thanks.

But I have to say having *two* counters to check for each lookup is
bothering me and making me wonder if they could be unified (or another
counter added to cover for either of those?)? No clue about
feasibility, is there a known showstopper?

Both are defined like so:
__cacheline_aligned_in_smp DEFINE_SEQLOCK(mount_lock);
__cacheline_aligned_in_smp DEFINE_SEQLOCK(rename_lock);

Suppose nothing can be done to only look at one counter on lookup.

In that case how about combining the suckers into one cacheline at
least? Sure, this will result in new bounces for threads modifying
these, but this is relatively infrequent compared to how often lookups
performed and with these slapped together there will be only one line
spent on it, instead of two.

Just RFC'ing it here.
--=20
Mateusz Guzik <mjguzik gmail.com>

