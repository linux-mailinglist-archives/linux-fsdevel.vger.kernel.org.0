Return-Path: <linux-fsdevel+bounces-42335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D87BA40843
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 13:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59BF3B4BD4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 12:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BEF20AF7A;
	Sat, 22 Feb 2025 12:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0+zcLGZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F28A20ADC0;
	Sat, 22 Feb 2025 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740226384; cv=none; b=CXRfU+bN2XNZF+kHAs/cg5rEOR3+T9wmQU23QRGT5czAc1Y8bf3reEZqVea+WN3t8tf6B+3uYiBYxTO+zvDTPbEeO1U1mvMuafT8FQZIwV/hvCUuKp3qgerIZcXtwoNcSiR4RNrZBRfzqIVctZ5gYV0WD3JAfVO4uIBqOL+guBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740226384; c=relaxed/simple;
	bh=UcCs92//+CGxlxHBIWo7ThWL5U5qDI/Ou+tv4w3OPwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DkXlKH4oPQ1PK8efeQTSj5RcFgJ5VIrvYIc9f5p0tnNNFTTu4pBO2iNIG7MNinZB/nrDJImRpLFP6yRcK8zDdBrJEHONlNS30uWrFkiWqg4BCJABTTDcc7kBinjRgnmVr/WGWqKGNDw8XNPC7jkrvOfFouXWoF3lx1j6GXDg8S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0+zcLGZ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so5277521a12.0;
        Sat, 22 Feb 2025 04:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740226381; x=1740831181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcCs92//+CGxlxHBIWo7ThWL5U5qDI/Ou+tv4w3OPwI=;
        b=S0+zcLGZkiASyxzyw/AHgAje8mz0+BnTP1DIhJrJvc4gcvIvlXwIdnPfCkcTEBLaUP
         fnVobN+pzOOgO09XevbBKw4SKrj4Ppuwc+bsElp0P0YrnJ+wh8IKGSawKlLJt9h9JRDx
         Ao6+LbG2dxGYTRG70cQQShN/Cdekac8h/+VhLYaw51gflH6VEhqpNNV0+Voxs2trui8c
         7OrUIFtkufGMpz4mstsrLPC93wbV6rFuBoURHAGh0+20GFJy1MZEfL0aSXeWVEN+u6RC
         sY+6aVs3/W/JsMU49VCEclTGQNFV8CDKJmSOIkND1UnhrQm5+Q6QhiXfPgDMA+Et8/Xh
         jfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740226381; x=1740831181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcCs92//+CGxlxHBIWo7ThWL5U5qDI/Ou+tv4w3OPwI=;
        b=nQfpa34Q1zIIWJ0Oqq1e8x/dFtoOQLvrfemJPPotVuWNMtN13v6dA7Y3Z5l2T3idpo
         MiMwUmR1LNoRqTGPmYYKE6IZjwFsI3suXcdvvm2/d5ccGhtGLSqeX4RzYnctLI0a4FCj
         MKuy9mR2oxsQbwQjoEgMXYoxCdlwqBNHVKNXuAdpHcGVUCdTfqqw7b7cGBweh4E/YBmj
         LWHCsL7LVJadfdmRgyuqOLpL+5mSutP+nsyFqw2gmmuVewzgU5QTdvGscjAJHLMeFg06
         Y7jukNcKq8l378tbf/NoGs9M2+GO7SmDjzzyOmMhGlyty8W/RwrJLmSduCr/PvVuVt2w
         jCBA==
X-Forwarded-Encrypted: i=1; AJvYcCUyh1NLsE+NjAIJv8BldjAqaPQL/LrY5x9MBH2H3lCKla220xxNw4/XnHrdOS89aCKRVMMSFCcYQytn8oBRvQcZ@vger.kernel.org, AJvYcCWi74tXedOlDqc2vOJQvf3E5/fCzvNU6UxfRjrqAv/gMzz0RrglJzaKSz97EBO2+jElq7RHdSNpq1JG/HAS@vger.kernel.org, AJvYcCXq4Ukwmo8Fq49L1pc6OVBGMYFkAT833C1YRPBVo12ZVX9XIAhJv1SZ6iCP0dqVfzF2LukCeuiIgTOIaeDw@vger.kernel.org
X-Gm-Message-State: AOJu0YxxrQkOpmxivwYfEpdrKO2etsK72DELm/8B16IPF8kltccp8plD
	9E9QrDgEarXTrghkYaKsViAKXL6pjPO7eBTtu5k4HYZPm+CWtgIOwvpsF9z4mJDmSR3pF80hxaQ
	60DRvUp2JlPjUQldngyPnPQOnXqwVuP3mdzg=
X-Gm-Gg: ASbGnctvkN/jM76to0qxS6aSxXjefAdT50p/uTYp+33UCs+ADmrbBdzAvMcc9fhHsoC
	MJ5jd6ckf1XHXOe4Dj7AI6Q2GWwLN6f9tjYJg3iRwg9IG/xn/QLSf8vv1OCX33vcUSFZFTw++J7
	RznG5G+w==
X-Google-Smtp-Source: AGHT+IGVFDoKMuSJlmbG3dDfeHZVI4UMPL3h12SNa7oIv7JVKBH7eWOsn2mydhYqH2cx8FkD/b6rPUf1AbJwjVPFnwU=
X-Received: by 2002:a05:6402:27cc:b0:5e0:752a:1c7c with SMTP id
 4fb4d7f45d1cf-5e0a11fff09mr10005828a12.1.1740226381108; Sat, 22 Feb 2025
 04:13:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231112095353.579855-1-debug.penguin32@gmail.com>
 <gfnn2owle4abn3bhhrmesubed5asqxdicuzypfrcvchz7wbwyv@bdyn7bkpwwut> <202502210936.8A4F1AB@keescook>
In-Reply-To: <202502210936.8A4F1AB@keescook>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 22 Feb 2025 13:12:47 +0100
X-Gm-Features: AWEUYZkrczdGvPossTY-laNaH0XG4wYU8BX1rt6xqTV7TvImEDyhx208Ptv2FVQ
Message-ID: <CAGudoHHB6CsVntmBTgXd_nP727eGg6xr_cPe2=p6FyAN=rTvzw@mail.gmail.com>
Subject: Re: [PATCH] qnx4: fix to avoid panic due to buffer overflow
To: Kees Cook <kees@kernel.org>
Cc: Ronald Monthero <debug.penguin32@gmail.com>, al@alarsen.net, gustavoars@kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 6:38=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Fri, Feb 21, 2025 at 03:51:23PM +0100, Mateusz Guzik wrote:
> > On Sun, Nov 12, 2023 at 07:53:53PM +1000, Ronald Monthero wrote:
> > > qnx4 dir name length can vary to be of maximum size
> > > QNX4_NAME_MAX or QNX4_SHORT_NAME_MAX depending on whether
> > > 'link info' entry is stored and the status byte is set.
> > > So to avoid buffer overflow check di_fname length
> > > fetched from (struct qnx4_inode_entry *)
> > > before use in strlen to avoid buffer overflow.
> > >
> >
> > Inspired by removals of reiserfs and sysv I decided to try to whack
> > qnx4.
>
> I have no strong opinion here beyond just pointing out that it appears
> that the qnx4 fs is still extant in the world. QNX itself is still alive
> and well and using this filesystem based on what I can find.
>

I'm aware.

However, we reached a point where should someone need to access a
now-removed filesystem, they can spin up a VM with an older system to
do it (including with one of the myriad Linux distro releases).
Suppose support disappears tomorrow. You still have something like
debian which will have a kernel with the module for several years. But
suppose you are years down the road and all the Linux distros which
had it are past EOL and you still need it. For the purpose of reading
the sucker, you can still use them.

So I don't believe this will cut anyone off of transferring data out
of a filesystem which got whacked upstream. That's concerning old
filesystems in general.

As for qnx4 in particular, should you git log on it, you will find the
support is read-only. And should you read between the commits (if you
will) I am not at all convinced even that was high quality to begin
with -- looks like an abandoned WIP.

General tune is not holding the codebase hostage to obsolete (and
probably not at all operational) components. If in doubt, prune it.

This reminded me of a funny remark made by someone else concerning
removal of drivers for stale hardware. It was in the lines of "if you
ask if anyone is still using it, someone will respond they have an old
machine in their garage which they were totally going to boot up this
weekend. if you just remove it, nobody will ever notice".

If it was not for the aforementioned bugfix, I would be sending a
removal instead.
--=20
Mateusz Guzik <mjguzik gmail.com>

