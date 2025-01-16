Return-Path: <linux-fsdevel+bounces-39410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FC3A13C85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 15:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6159B168E91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 14:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F104C22B5AC;
	Thu, 16 Jan 2025 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jhms5UYO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC90F19ABD1;
	Thu, 16 Jan 2025 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038539; cv=none; b=AwupsgL5La7yV1jilopJxR57qUNRS4GRBrid4kF0OJPCl8QTkTkhz49LDGJZK7vhKRbjnqhBFjakXxQKz+2YJ4bHhS4Ci3xGmDhbADczUR9lnTZ1kMdG8uiXNLbO93xGKTOpdgr5sgTqiGBPnkbl4acbu9JdMO5QBZztVk9uRvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038539; c=relaxed/simple;
	bh=fXIjs2fvk8qz6+fo6WWkET+DJjYL96uRj8F5rSxBoAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+0Om5Z3Qh/pKkwOOwFqQI4zfAaff7IZ6nYeBt0lJbKQlHK6BJEA805zCmZsHexZdvtC8qVGmDuVbqxSCx9kOqBOegtEtEA94/0y0RKE8l6yMKwgHeAldqm2xa6crx8gvUmhLUPPF70KjSwQmwSgObGPCss+rzeRnJbOj4oafOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jhms5UYO; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d9f06f8cf2so1978985a12.3;
        Thu, 16 Jan 2025 06:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737038536; x=1737643336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXIjs2fvk8qz6+fo6WWkET+DJjYL96uRj8F5rSxBoAI=;
        b=Jhms5UYO17Cjjz4ntNVhMl32jDreTJ8ppRRIFFT3SUn9txKhHdYJQAenrsSpbHHJLg
         9cIocPAGqGV/64mxQzaVYcBi38YFHiWcHlIV1Tq0QjyYwko+3efKNLelIsxwA6SofCB3
         GHs1JFR6ZbDhvR4JVgUaD8TaVcK/8QqMCBwb43g2CDv65KLy/Wc7GA21ldcIjbXxnla3
         QALbNxUZdXZdGFWVvqVRra5ZyM+epHDwL5jgbKw6ql/YRMzCnIE3K+KXYS6azQBVC8nj
         Rcdyp/ed0KHLyeNkBFR4OZDzU01MUGtYJk6vuoWXPRM9fhqb+fdYBRtBmhVK6/vQMAtq
         v4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737038536; x=1737643336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXIjs2fvk8qz6+fo6WWkET+DJjYL96uRj8F5rSxBoAI=;
        b=QHR9pubHnm86ySYuYu3VGJK1ChKjBJdd81FUQwot1XequGaoV7gDbzLyiqVfduNgab
         5UG6IIt5uyUcRBdJusAbgoedd1BTlmlc9blWOcJCaAoZzht8ARKRQ4snrQok0F9skEu3
         AptBiYdwcHfAONIN5J7DCNQTWLqserdTkQRJD2oUdS5ykWRnwVtmTQwwziirmuiyedrt
         NF/d91ZJvjGZs8Tl+hHN+HiCbUUwXuDKGxTSF1PiuN9vjN0f5B7EHNhwza11tgUAXhIH
         vL5IQCbDrFYOuksn4xoPqfrp8naEowirewUNIXfjy6hpFs+0fnqhNe+nNQ5JofZepVwB
         YT2A==
X-Forwarded-Encrypted: i=1; AJvYcCUqtEX5iDD0HqaQZZcA/dEj8ejs0ciPysj7b6DhWotKnncGkW/GgcnCEACkULoNyMfbpyap6Idt3Yl3Zl+vQw==@vger.kernel.org, AJvYcCWTtEJxRnliXce4RmRrSs33kGKWGvRnIHC+N7YTupxyeiviw5MhcC3gRYK7vKxnKgXP3YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKLkX+pvr/V89oKQQEd1dPcx3iRuUg6nOVQvKtCt8LHxvXBCf4
	pTalmfpzvHG1twgCwJvdhDnJT6za27lfZc3+dQ10xC9OuwaItWRDnmTeVlifWQW7SQ//eQUQTJj
	WMv2PIpukDM/DbLxcc33YAB6o2wgwnv2j
X-Gm-Gg: ASbGnctDlqGyuGvePjQrK7NxaUedXHsn/myp6rmxKX8X7z9TKAMg3EINyAk3h1p7y5w
	FVgnBjmwT++ksA5IJEN5hnlC9/5KN0zfExHNa8A==
X-Google-Smtp-Source: AGHT+IHj4bUKW2ClYjlw3qwAtaA6dfc8GKmxx+VITnuz2C4XQnuxSOSOi/ox8x7TgSxjpBIe12vIuJ5oDTG5DdndgAc=
X-Received: by 2002:a05:6402:3217:b0:5cf:bcaf:98ec with SMTP id
 4fb4d7f45d1cf-5d972e48686mr29783475a12.26.1737038535445; Thu, 16 Jan 2025
 06:42:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW4psFtCVqHe2wK4RO2boCbcyPtfsGzHzzNU_1D0gsVoaA@mail.gmail.com>
 <itmqbpdn3zpsuz3epmwq3lhjmxkzsmjyw4obizuxy63uo6rofz@pckf7rtngzm7>
In-Reply-To: <itmqbpdn3zpsuz3epmwq3lhjmxkzsmjyw4obizuxy63uo6rofz@pckf7rtngzm7>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 16 Jan 2025 15:42:04 +0100
X-Gm-Features: AbW1kvbkcOXObx27UNnVjewYyaPbUI0Xc5u72p4Zzw4J_QnRO5Vbffrg_SgnO2U
Message-ID: <CAOQ4uxhgiUw3b2i7JYm5qZX1qPvYJshrCWy_i0BkPVtmzKo1AA@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] fanotify filter
To: Jan Kara <jack@suse.cz>
Cc: Song Liu <song@kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, lsf-pc@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 12:46=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Hi!
>
> On Tue 14-01-25 11:41:06, Song Liu via Lsf-pc wrote:
> > At LSF/MM/BPF 2025, I would like to continue the discussion on enabling
> > in-kernel fanotify filter, with kernel modules or BPF programs.There ar=
e a
> > few rounds of RFC/PATCH for this work:[1][2][3].
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Motivation =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Currently, fanotify sends all events to user space, which is expensive.=
 If the
> > in-kernel filter can handle some events, it will be a clear win.
> >
> > Tracing and LSM BPF programs are always global. For systems that use
> > different rules on different files/directories, the complexity and over=
head
> > of these tracing/LSM programs may grow linearly with the number of
> > rules. fanotify, on the other hand, only enters the actual handlers for
> > matching fanotify marks. Therefore, fanotify-bpf has the potential to b=
e a
> > more scalable alternative to tracing/LSM BPF programs.
> >
> > Monitoring of a sub-tree in the VFS has been a challenge for both fanot=
ify
> > [4] and BPF LSM [5]. One of the key motivations of this work is to prov=
ide a
> > more efficient solution for sub-tree monitoring.
> >
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Challenge =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > The latest proposal for sub-tree monitoring is to have a per filesystem
> > fanotify mark and use the filter function (in a kernel module or a BPF
> > program) to filter events for the target sub-tree. This approach is not
> > scalable for multiple rules within the same file system, and thus has
> > little benefit over existing tracing/LSM BPF programs. A better approac=
h
> > would be use per directory fanotify marks. However, it is not yet clear
> > how to manage these marks. A naive approach for this is to employ
> > some directory walking mechanism to populate the marks to all sub
> > directories in the sub-tree at the beginning; and then on mkdir, the
> > child directory needs to inherit marks from the parent directory. I hop=
e
> > we can discuss the best solution for this in LSF/MM/BPF.
>
> Obviously, I'm interested in this :). We'll see how many people are
> interested in this topic but I'll be happy to discuss this also in some
> break / over beer in a small circle.

Yeh, count me in :)

Thanks,
Amir.

