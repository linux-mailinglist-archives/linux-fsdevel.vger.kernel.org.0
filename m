Return-Path: <linux-fsdevel+bounces-21454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710CB90424D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 19:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDDD1C24357
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 17:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D05482ED;
	Tue, 11 Jun 2024 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="T29diAYW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9856742052
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126386; cv=none; b=oAdDr1gb67fE+oZdWz3yDOsWQp7UKmAEhjmdPTycUR6QPrStyGdJ7OH2O/ZHETw1PkjImiyO2dQKND9X6MqoYQbJV989vX1X+QzzCcpuitzlVmJMreapu+qViqNI3sNPfuYpe2nUBxx+OCAlemm3lLhWnkXyeEtNyu7MG5vaQck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126386; c=relaxed/simple;
	bh=c0Hu3eDQNUHdzMWHOZviKhvIvMHCcuBZbeevCnua86U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZIWW8CZosLE4Mn5o7akjtq31Hgknu0cn778fXk0ICCDkHtQ5v1e4n9PWpsshEUdFYw/xXp/jJtrGvFFeYD08gNEP47tLrM2AzuKkWj2MeQev80DCIw/xr8DLVX6HNkw3BxqKF9BNCaUqLuhB78NBiTQVi0+WmuXTodQJuR50tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=T29diAYW; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dfa6e0add60so5822778276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 10:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718126383; x=1718731183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9ogFLxbLWp/7JKp4IH1qADojIschvT679JCf6moq4c=;
        b=T29diAYWUnPRLlv83N9dKpZuDxlytRJnk6hS2w82SGvLUKjj4Kq6ntUFi+qCrd2lQP
         T22EOHyAqkQsLo86q+sd0vbDpN0edfxzHDjcnCc3bGiHRHKHER/QFwNbSsHqhZDrw8TJ
         KO0U4UvNgYkfAoC5MTBCXm8IwRmZtCellVJfaWE/KMDElgxJWt9j1dVshPSqkf+uTDmW
         JVYzdZBk47BE16irAIRBTD+PSvWF1V5LK25zGBsCceSKOrLhfhZJQoA0TDQ8pRRLjnmk
         oY+YOLAZ0MVn3ewUcnJ6D6L6IOzSHJNLcAzY2fVLPB/ftz5PrMzgx2lNAQS1RtbMwXum
         bvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718126383; x=1718731183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9ogFLxbLWp/7JKp4IH1qADojIschvT679JCf6moq4c=;
        b=ahA8+bLK7RVMktj+grFo3on6bxNd4tvVr9fgBBN8fxoLTS4KeKSXrjQQfCa0zOmz7L
         NPqCJFd3hFF9r0vM2j8fvIDrHeo1FsLnAofi0ZfM3MGglVTidHgmb2e3mQsjB+92hgjV
         SkTXVUCKYiHQpMzk8Fgm2yYs6mCLQ20IoALrqFBLugvS/dGT6/+i9ElbO4UwhUedAJHq
         3B9uXcaq16kwKnGmkoH0nhuWHpYGzEU9BMs7Ft8p9lExohZguD6xlI5ER6BrH1/OFhs5
         7+Wr5Ne118CLVfgtn4XuZi3vmFBYqJD7S/rF2C+a8JgJM4wvOqKbOCF63ytOq+s7J5XC
         7oNg==
X-Forwarded-Encrypted: i=1; AJvYcCUbrMWWBUBZ5Ypftb4K9tVNqJlGLl5DqbNkGlClzN6vli/c0JzpXPr1Q668Vf3FP5GlNKxhmFnW272BZccKbEuUykwX+Y68TNLFUuxfxA==
X-Gm-Message-State: AOJu0YyVIxaGBM947ONy0pSjTmInx0U7yx+jHxKO9DnfF9NKHQuR7Acy
	tlcn7FUxPvlKkLqLtCYGgDusltcqFc0n1v6OfOn9Zbmyl1nBI2mgaHfV6BHick48k8I9ulosBLE
	zji+2I5GxtaJVsjnus7ZI8K1CCHrBKmyH+iTz
X-Google-Smtp-Source: AGHT+IEdDn6ha3s1+w4VrQk0fxK1wz6Q1fTrUfNyPSzmZbTczlAzPMLTr9NS3aslGjyW4jmQxcE6FAM1ugrcNSNTbXc=
X-Received: by 2002:a25:84c8:0:b0:dfa:582f:8b93 with SMTP id
 3f1490d57ef6-dfaf6492e0dmr11875248276.10.1718126383599; Tue, 11 Jun 2024
 10:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <894cc57c-d298-4b60-a67d-42c1a92d0b92@I-love.SAKURA.ne.jp>
 <ab82c3ffce9195b4ebc1a2de874fdfc1@paul-moore.com> <1138640a-162b-4ba0-ac40-69e039884034@I-love.SAKURA.ne.jp>
 <202402070631.7B39C4E8@keescook> <CAHC9VhS1yHyzA-JuDLBQjyyZyh=sG3LxsQxB9T7janZH6sqwqw@mail.gmail.com>
 <CAHC9VhTTj9U-wLLqrHN5xHp8UbYyWfu6nTXuyk8EVcYR7GB6=Q@mail.gmail.com>
 <76bcd199-6c14-484f-8d4d-5a9c4a07ff7b@I-love.SAKURA.ne.jp>
 <202405011257.E590171@keescook> <CAHC9VhTucjgxe8rc1j3r3krGPzLFYmPeToCreaqc3HSUkg6dZA@mail.gmail.com>
 <7445203e-50b1-49a6-b7a3-8357b4fe62ab@I-love.SAKURA.ne.jp>
In-Reply-To: <7445203e-50b1-49a6-b7a3-8357b4fe62ab@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 11 Jun 2024 13:19:32 -0400
Message-ID: <CAHC9VhQEq=8j-EW_DX9ebm1dO9m5gvRV+CcjV0aaemUuzu_t0g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] LSM: add security_execve_abort() hook
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Eric Biederman <ebiederm@xmission.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Serge Hallyn <serge@hallyn.com>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 9:10=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2024/06/11 5:44, Paul Moore wrote:
> >> diff --git a/fs/exec.c b/fs/exec.c
> >> index 40073142288f..7ec13b104960 100644
> >> --- a/fs/exec.c
> >> +++ b/fs/exec.c
> >> @@ -1532,6 +1532,7 @@ static void do_close_execat(struct file *file)
> >>
> >>  static void free_bprm(struct linux_binprm *bprm)
> >>  {
> >> +       security_bprm_free(bprm);
> >>         if (bprm->mm) {
> >>                 acct_arg_size(bprm, 0);
> >>                 mmput(bprm->mm);
> >>
> >
> > Tetsuo, it's been a while since we've heard from you in this thread -
> > are you still planning to work on this?  If not, would you object if
> > someone else took over this patchset?
>
> You are going to merge static call patches first (though I call it a regr=
ession),
> aren't you?

That is the plan, although we need another revision as the latest
draft has a randstruct casting problem.

> For me, reviving dynamically appendable hooks (which is about to be
> killed by static call patches) has the higher priority than adding
> security_bprm_free() hook.

Unfortunately, dynamic hooks do not appear to be something we are
going to support, at least in the near term.  With that understanding,
do you expect to be able to work on the security_bprm_free() hook
patchset?

--=20
paul-moore.com

