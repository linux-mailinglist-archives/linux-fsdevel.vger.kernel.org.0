Return-Path: <linux-fsdevel+bounces-10702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D215884D757
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 01:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09AC21C22C31
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 00:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96E212E55;
	Thu,  8 Feb 2024 00:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HAffjzdj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBA614F7F
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 00:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707353849; cv=none; b=kew+oH+X1up1crWoixG80M/IBZ3KSXcxuus2FZXq/RH0f5qxmG9l+cj6XLZOB5FYDPQpb88k2Z/5Qi7hlishPJJhfPHN2352Vk5y9C8ZI1Qid6CLc/GFbR4MQ6RPtAtC29tqqQHt9hNHODANab72AYVMKgmzj7Z5s3y4eN1UilQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707353849; c=relaxed/simple;
	bh=5rzBR40j85GN64DttI9QF8dovqFWnPsmrhGZ4XP4f5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WnAteqGKbmkYlQEkH69pr2cIODYYlvgAhekUclFKIDsJQ5eGPkZRRjo0ABeFSHxrYfKfYFvuvG1/3SKJ/yLi8iE9QEX5M8NZBhQ6wDPiOcXQTjL300iy9Nrn15Wfa45/qqmmxiSQ/YXIo/B0/17kPjvDlWTgcb/xmIkBkZx2qdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HAffjzdj; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-60498c31743so11403227b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 16:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707353846; x=1707958646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YrEg2rNCoVlCXajfENN1lI3JlSqoiORMZh++WxQ9Oo=;
        b=HAffjzdjvRXMUQxwnkhHJWj4HHtMoKI73XvSowUhh6v6F+fhtZLZiJS15jB4pDgh07
         vG9rXwCGqjvTUaX+eoU2SY7GmmAvDs72UlZOuCBFaa5W3QDka1n8ja5R6nLoXdIWrZ71
         QYPeV2Zzcheer3aGixt2FWnCEqbMT3TP3e8XlITrVxx3O0bGVhOaz9u9BCLX0AcWMUet
         4AyPe7DYmN+J2A8inkuzUWWeyHghBB+isYOBEIZopRR0MexOtXIk8YKCmovK8/5kbE1I
         HGPGCv8wdZXjxqu/aBk2giWUsGfEAFnUkspnu0s7lrSF9NQGR5NrS7kBGrcEDJrwN8+K
         dm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707353846; x=1707958646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YrEg2rNCoVlCXajfENN1lI3JlSqoiORMZh++WxQ9Oo=;
        b=p5I7/7Iz98fwRWk5DC1sT1XK4/Oa+CISTRfSxs1ccU3eBX9BjsjLVE1M1ONXjz/BPv
         RuxEHI3uF8shteXonuNnmw1ODg64VNRkCysTzauybRNQf3WgrX+g5HWMzWIdXpcVRHnk
         CvjZuHDtkw+CogRDEzoWA9WntcNuAM2rlVSC4F1+Gn1qUS0cwpMYhbrVVB4I8NCr/aOy
         uthL1HuXLa4pfk1TV8HB6xFcKGKVbZ2QF+aRQnRGcfZzO0Kl7AqhbCKrBxwR75ire9zU
         vpTe3oCIZ+X/iwPvorbwdcXrHKKbqsTQ48sMWTnYH7jm8+xKlb8Ud8JcVzxW4gDuAWw5
         dgCw==
X-Forwarded-Encrypted: i=1; AJvYcCUtGOm+D2mdsc9+GiG2cpPbwb0mkPF9QqKeIJ9ZHXnsUqVBde7X6W+6dob7DVfYXJaNsxCTBEJB368SzkFCfGiRM+z52lB3kGE6goVHYg==
X-Gm-Message-State: AOJu0Yy+zlW3GLreEjzLh2/faRMRetxjGeUVCxa1sj6RbzydZm2sHnFr
	9ckYxK4LjlGO53LJX7XGrYVDI6n44143kI32jPDmAN0vuukaHvKGOk5gZn7uQr7MCqDClLQKMih
	HOVyuIWGzuVjtYv/5TFMHbpJLvcZuVZAbtdEV
X-Google-Smtp-Source: AGHT+IFmH+dP6BAf5+6H4fHAw8GKxdIg12Zbn50hUBo89UP0SMhSBXIOobLXRDQ+0CKVwqEmJEFEnJm0Mkg18dfZeKA=
X-Received: by 2002:a25:c513:0:b0:dc6:d7cc:8a97 with SMTP id
 v19-20020a25c513000000b00dc6d7cc8a97mr6765016ybe.3.1707353846137; Wed, 07 Feb
 2024 16:57:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8fafb8e1-b6be-4d08-945f-b464e3a396c8@I-love.SAKURA.ne.jp>
 <999a4733-c554-43ca-a6e9-998c939fbeb8@I-love.SAKURA.ne.jp>
 <202402070622.D2DCD9C4@keescook> <CAHC9VhTJ85d6jBFBMYUoA4CrYgb6i9yHDC_tFce9ACKi7UTa6Q@mail.gmail.com>
 <202402070740.CFE981A4@keescook> <CAHC9VhT+eORkacqafT_5KWSgkRS-QLz89a2LEVJHvi7z7ts0MQ@mail.gmail.com>
 <CAHk-=whSMoFWCw=p1Nyu5DJ2hP2k=dYmPp-WjeY8xuc7O=ts7g@mail.gmail.com> <824bbb77-588b-4b64-b0cd-85519c16a3fb@I-love.SAKURA.ne.jp>
In-Reply-To: <824bbb77-588b-4b64-b0cd-85519c16a3fb@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Feb 2024 19:57:15 -0500
Message-ID: <CAHC9VhSaHMoNaNpRQWD03Wa7mKRih0FXQkoCRA7Jt1b=KB-tQA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] LSM: add security_execve_abort() hook
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	Eric Biederman <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 5:23=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2024/02/08 2:57, Linus Torvalds wrote:
> > On Wed, 7 Feb 2024 at 16:45, Paul Moore <paul@paul-moore.com> wrote:
> >>
> >> Okay, let's get confirmation from Tetsuo on the current state of
> >> TOMOYO in Linus' tree.  If it is currently broken [..]
> >
> > As far as I understand, the current state is working, just the horrid
> > random flag.
>
> Yes, the current state is working.

Thanks for confirming that Tetsuo.

--=20
paul-moore.com

