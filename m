Return-Path: <linux-fsdevel+bounces-27085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B48FE95E74B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 05:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7218B280EA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 03:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6651556B72;
	Mon, 26 Aug 2024 03:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMWRL2Ws"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DFA6FB0;
	Mon, 26 Aug 2024 03:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724642908; cv=none; b=QwFcaNGscqJuYRth1+Sy6MLlfrRBm3ppzB1MnBO3S8mD2YpHlJZCvolFJ8CHjx59H65BCD8wDNSBvf5UVdkudbOco41LUH9wgI+o6jSEqT7neq4TjOipmJjvbJVUGymBWNvNfZbCP7GqBuSKjJjl+VtT8UkTI6pAb8ORJJHuqDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724642908; c=relaxed/simple;
	bh=t/F/aCByt/+vLfPIQoKq7QigO6bue/7EYmxaBhSfRVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dB/ux6BTHurf3js8YkNYfCLw9X6p7a2OI9NKoxnc13sjGupw2YaAe46cepx8IfvDCJ5TFtM2JMj74/uvS8F/KPpo5Bn2gvC0g0DUabgfUiHlIFvnt1GSX+dp5haTvFTLhhiaHldYnUhVt8xPZuoAPodGgUtVA5zNYWmrZluQiz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMWRL2Ws; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7cd8d2731d1so2474240a12.3;
        Sun, 25 Aug 2024 20:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724642907; x=1725247707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwF+G59zpDQUV1LMkNWg0wx6pA43KdE7uc78AuQZoS8=;
        b=MMWRL2Wsrs6K+UWSpTkTYxuQVhcB1V+zcprNqwqT86/+7MzqMQbxWHCUAo5T0nseJB
         kcAgaUl6heDvm1X73cl76L+bzKv4sq6T9G0a0tX5ee/uWL8Z/zrVLDad3DJnrVpXREt2
         LHfYeJKrwE49rieuadpo6fuKw6nrURM8mM4sHJZDK/Eod991+hd36NLF/5lgxt9o/2uk
         RNCTjfWsNk3eN9YNQtQ+vK12RocozY0Fr2hEdEEPTncQxdMqQ8LS5DXFpTd0cpl2Nvdw
         Neevlton8f9/sMw7khMX2DgNQvRJNzPvYHksLdJzzysIIsqe+foZErpi7rVdij7YIuU/
         vc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724642907; x=1725247707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwF+G59zpDQUV1LMkNWg0wx6pA43KdE7uc78AuQZoS8=;
        b=YM133wwaVH39fucMo6X3ZlQlkhhpo9jSYn1YzS2Vc2bEMkpdxVZ+lmw90LBK9Vz1ZI
         XFh0qkD3fgPNloNjDSGisFo8wcsluO7oodfFgYfVrgUe8Z+knlFHmHanQwmyMLv7Mb1o
         Ci9N9SIh8DcHkkr7v5lETjG4rHQTGbSbpgOmvugOFcj4nGUXn91THbpZFOlsvzUOwcyw
         QnqwBlBJJpi94X2Gx6WfeoWa+ARXDZUhbbt3jg/bwcBRCPWaZuLRAUJ7wCZuXQXSw6vo
         sbUNwiit/qYUDKvu5t5hZtIk9nK+fCQCyoD34wNa35ubABAJesdDNT/GxabcV4YwN1OJ
         3flA==
X-Forwarded-Encrypted: i=1; AJvYcCVOP/iKlwvKUCNP+ULMscoVM1bPOZCBKTK3lAwD9ruB8igvTCi6JFShjkee/ewf0oksDMX4IIK3BGe1DaUH@vger.kernel.org
X-Gm-Message-State: AOJu0YxLJblGnTVyfpXbkiqbcDkkd8foQEAzYCoKM+9hJRLQX8LSto+m
	W3TS07aG+Q1YEM6+BZUFyKpth4EhsiNr97s0t1xgq20s5oXEUqBOOxx2ejFzdukYCmn8d5EXXXM
	2o/oBF5YIDk/g5DS3MLsZLZxyO6o=
X-Google-Smtp-Source: AGHT+IGVk5TmZ7H1YpTwGww1u11+pv3OGDsxzVatU/N8uKd+Y/CdMF6bcLjWsx6WYZUMKKN3F2hlbmCPwb1YRj3wqpo=
X-Received: by 2002:a05:6a20:6c89:b0:1c4:21c0:ea0f with SMTP id
 adf61e73a8af0-1cc8b5916c4mr6364264637.33.1724642906607; Sun, 25 Aug 2024
 20:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322195418.2160164-1-jcmvbkbc@gmail.com> <5b51975f-6d0b-413c-8b38-39a6a45e8821@westnet.com.au>
 <CAMo8Bf+RKVpYT309ystJKVHDqDaK4ZavGe3e-a_jvG7AOcqciw@mail.gmail.com>
 <a0293b2d-7a43-49b7-8146-c20fd4be262f@westnet.com.au> <CAMo8Bf+GWXxHVorNvE=UWQDXfRvLE1MsK-dRwh_aZrd=ARxm2w@mail.gmail.com>
In-Reply-To: <CAMo8Bf+GWXxHVorNvE=UWQDXfRvLE1MsK-dRwh_aZrd=ARxm2w@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 25 Aug 2024 20:28:15 -0700
Message-ID: <CAMo8BfKcjAvGB9yYr6osoeA38K6fnRx652m3b_2E-oYHA4_rbA@mail.gmail.com>
Subject: Re: [PATCH] binfmt_elf_fdpic: fix /proc/<pid>/auxv
To: Greg Ungerer <gregungerer@westnet.com.au>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Tue, Aug 13, 2024 at 11:28=E2=80=AFAM Max Filippov <jcmvbkbc@gmail.com> =
wrote:
> On Mon, Aug 12, 2024 at 9:53=E2=80=AFPM Greg Ungerer <gregungerer@westnet=
.com.au> wrote:
> > On 13/8/24 04:02, Max Filippov wrote:
> > > On Sun, Aug 11, 2024 at 7:26=E2=80=AFPM Greg Ungerer <gregungerer@wes=
tnet.com.au> wrote:
> > >> On 23/3/24 05:54, Max Filippov wrote:
> > >>> Althought FDPIC linux kernel provides /proc/<pid>/auxv files they a=
re
> > >>> empty because there's no code that initializes mm->saved_auxv in th=
e
> > >>> FDPIC ELF loader.
> > >>>
> > >>> Synchronize FDPIC ELF aux vector setup with ELF. Replace entry-by-e=
ntry
> > >>> aux vector copying to userspace with initialization of mm->saved_au=
xv
> > >>> first and then copying it to userspace as a whole.
> > >>>
> > >>> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> > >>
> > >> This is breaking ARM nommu builds supporting fdpic and elf binaries =
for me.
> > >>
> > >> Tests I have for m68k and riscv nommu setups running elf binaries
> > >> don't show any problems - I am only seeing this on ARM.

I see the following:
- the issue with the change is caused by unaccouncounted AUX vector
  entry AT_HWCAP2 that is defined for ARM, but not for any other
  architecture that you tested.
- in the original code this off-by-one error resulted in the last entry of =
the
  AUX vector being set to zero. Below are the stack dumps from the ARM
  kernels built by your script, one with my change (left) and the other whe=
re
  this change is reverted (right):

argc:
00000001  00000001

argv:
00b8ffde  00b8ffde
00000000  00000000

envp:
00b8ffe4  00b8ffe4
00b8ffeb  00b8ffeb
00000000  00000000

auxv entries:
00000010  00000010
000001d7  000001d7
0000001a  0000001a
00000000  00000000
00000006  00000006
00001000  00001000
00000011  00000011
00000064  00000064
00000003  00000003
00980034  00a00034
00000004  00000004
00000020  00000020
00000005  00000005
00000007  00000007
00000007  00000007
00a40000  00a40000
00000008  00000008
00000000  00000000
00000009  00000009
00984040  00a04040
0000000b  0000000b
00000000  00000000
0000000c  0000000c
00000000  00000000
0000000d  0000000d
00000000  00000000
0000000e  0000000e
00000000  00000000
00000017  00000017
00000000  00000000
0000001f  0000001f
00b8fff6  00b8fff6
0000000f  00000000
00b8ffcc  00000000
00000000  00000000
00000000  00000000

The fix is in correct accounting of space for the AT_HWCAP2 entry.

--=20
Thanks.
-- Max

