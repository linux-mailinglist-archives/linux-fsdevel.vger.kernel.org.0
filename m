Return-Path: <linux-fsdevel+bounces-34492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5692A9C6312
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 22:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19664B30590
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 17:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B514521315C;
	Tue, 12 Nov 2024 17:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OKQBu4Yt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2877D2123EF
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731432478; cv=none; b=nKfc5QkJyJOx9qqV1+JMrGhaDroLrfFdGMWOt+fZD3+34+SVVLjsJ8kgyZbRUHmScZGPra6butnCL2nV0CzmIBUa8hfuorh7VpVktDTPArpCRdpi5MihHi5GVwab5EWV/ym+56HWHxEhOtckwdDJ9ikFwq188e6DPtzAwqOcQkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731432478; c=relaxed/simple;
	bh=px+7a3QkMgWt8ftIDbqK58JaIp37LqLw6la2OdVdyBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nTnCAd1t83xOMtkbIxXmCjl5tOVnwbhQ0HdqiudgeZOXgwjy2XydUEGOZTvV/meLoUCJ6skzgua9D/CFFbnA9+Nr3Gu7/z0rWpuESX1+MnoldFOqourFtbgHgoXxMz/UrbVqEAY6qjqemmSb0GfLNBLatC3x2MP0nzOAZ3a7Uso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OKQBu4Yt; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa1e633b829so127635166b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 09:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731432474; x=1732037274; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dK/MMj0H2RSiPw19obXeOOxGeZ8Rb9qzE6d1Em7Vf64=;
        b=OKQBu4YtH46CepSha2s9v9o3RfC6f6oyuyAlplrHLuu6gyNkwThaKF52NYjMfJuHYK
         6ExDAo3v478lNVVOct11YIhvt/LrL13UP5yW9N8uqCZKEUeyhA+itIgJou0JNrGzQWqS
         dk3YQDI3DvAe/Dh9J/5EU4mZGYTYqRE5QZVoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731432474; x=1732037274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dK/MMj0H2RSiPw19obXeOOxGeZ8Rb9qzE6d1Em7Vf64=;
        b=oILt9b5RaSudZeaSTSh4ztwvfi9AZq5Hx4F3+ABPhT46DcLIJnuFVGOc3sshPZOJ2A
         lpZRa+GtIc+u/55itna68XJ8nPADeRzz5LXn8tfo/NF+/B7Zo/GA4LauK3iKsOJqTAbF
         Adby0JovipFFzveAJLsaSiIS9FtoKK3OnQiVMPW3Zsvph8Xh/K+Ripde9Moj5S6D1V0I
         IUMGfxSHbW+sY0SoMo1ngCA4ulS8VN2TNa3N7KXgNgMDIXLIhAH/HxrB8M9VxUXKsZIO
         qRleE2zwgXdyYzDZWf2B8NmN58c09vPzM3R9qQBMCHVJ2szSk71PWsJjqti/QEP9kQIk
         Sc6g==
X-Forwarded-Encrypted: i=1; AJvYcCWUVhyVRxDJMRra+Ae6p4HQINM41CXLtuWYxfoW3MVHPY6NBXfTAm8yHyGEPxiuSP5579DdvmCF8lllkGCx@vger.kernel.org
X-Gm-Message-State: AOJu0YwYxH9JAT/r7dElXMB4ZShlkIsPDv9Z/vUQAprW11+/7v0mM93g
	kLn3/8zWOkTfmp7EqZND+2ELUIDrvq7w3DosQi2WsUqhO/QXi45M6jN9FBetmFPLocoVvOl+nHf
	h9raLFw==
X-Google-Smtp-Source: AGHT+IEDpD17O+6RDvAmVNxtiE1HdUKE+EuU5vmt2iw91iJD00kJCfcQQBOhnWpsgcMI1aY6aKY0Zg==
X-Received: by 2002:a17:907:72c3:b0:a9e:df65:372b with SMTP id a640c23a62f3a-a9ef001fdb7mr1570361566b.52.1731432474186;
        Tue, 12 Nov 2024 09:27:54 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc528bsm741974266b.94.2024.11.12.09.27.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 09:27:52 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa1e633b829so127629766b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 09:27:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUV9YPQF6/KrmrOhVGngXqeqcXaurecZozywP9sBVW5ebfI9GIsXZsV2XMJ86PAp6ep9x+dNtcoTWcFJf48@vger.kernel.org
X-Received: by 2002:a17:906:c112:b0:a9e:7ca7:78b1 with SMTP id
 a640c23a62f3a-a9eeff0ea38mr1725668166b.23.1731432472450; Tue, 12 Nov 2024
 09:27:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731355931.git.josef@toxicpanda.com> <b509ec78c045d67d4d7e31976eba4b708b238b66.1731355931.git.josef@toxicpanda.com>
 <CAHk-=wh4BEjbfaO93hiZs3YXoNmV=YkWT4=OOhuxM3vD2S-1iA@mail.gmail.com>
 <CAEzrpqdtSAoS+p4i0EzWFr0Nrpw1Q2hphatV7Sk4VM49=L3kGw@mail.gmail.com>
 <CAHk-=wj8L=mtcRTi=NECHMGfZQgXOp_uix1YVh04fEmrKaMnXA@mail.gmail.com> <20241112152415.GA826972@perftesting>
In-Reply-To: <20241112152415.GA826972@perftesting>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Nov 2024 09:27:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgtGE9ZvqwJo8sUzX4Vzkke5O_sTFTGdQNwH1+TxOCyYQ@mail.gmail.com>
Message-ID: <CAHk-=wgtGE9ZvqwJo8sUzX4Vzkke5O_sTFTGdQNwH1+TxOCyYQ@mail.gmail.com>
Subject: Re: [PATCH v6 06/17] fsnotify: generate pre-content permission event
 on open
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 07:24, Josef Bacik <josef@toxicpanda.com> wrote:
>
> But this was an entirely inappropriate way to communicate your point, even with
> people who have been here a while and are used to being yelled at.

Fair enough.

I was probably way too frustrated, because I spent some of the last
few weeks literally trying to remove two cache misses from the
permission checking path.

And those two cache misses were for features that are in POSIX made
worse because of uid translations infrastructure used for containers.

Those are both things that people actually *use* in major ways.
Admittedly the particular optimization was exactly to _not_ bother
with looking up the exact uid details when we could tell early that it
was all unnecessary, but the point was that this was to optimize
something real, something important, and not some special case.

And here's an example of a profile I've been looking at (this is a
real load: the profile is literally my "make allmodconfig" build with
not a lot of actual rebuilding needed):

  1.30%  avc_has_perm_noaudit
  1.24%  selinux_inode_permission
  1.18%  link_path_walk.part.0.constprop.0
  0.99%  btrfs_getattr
  0.82%  clear_page_rep
  0.82%  security_inode_permission
  0.60%  dput
  0.60%  path_lookupat
  0.60%  __check_object_size
  0.54%  strncpy_from_user
  0.51%  inode_permission
  0.50%  generic_permission
  0.47%  kmem_cache_alloc_noprof
  0.47%  step_into
  0.46%  btrfs_permission
  0.45%  cp_new_stat
  0.44%  filename_lookup

and hey, you go "most of those are just around half a percent". Sure.
But add those things up, and you'll see that they add up to about 12%.

And yes, that 12% is 1/8th of the whole load. So it's not some "just
12% of the kernel footprint". It's literally 12% of one of the main
loads I run day-to-day, which is why I care about these paths so
deeply.

And look at the two top offenders. No, they aren't fsnotify. But guess
what they are? They are hooks in the VFS layer that the VFS code
cannot do anything about and cannot optimize as a result. They do
ABSOLUTELY NOTHING on this load, and they add no actual value.

If they had some kind of "I don't have any special security label"
test, the two top offenders (and down that list you can find a third
one) would likely just not exist at all. But they aren't "real" VFS
functions, they are just hooks into a black hole with random semantics
that is set by user-supplied tables, so we don't have that.

So this is why I'm putting my foot down. No more badly coded and badly
designed hooks that the VFS layer can't just optimize away for the
common case.

I can't fix the existing issues. But I can say "no more". If you want
new hooks, they had better have effectively *ZERO* overhead when they
aren't relevant.

And yes, I was too forceful. Sorry. But my foot stays down.

If you want a specialty hook for specialty uses, that hook needs to be
so *fundamentally* low-cost that I simply don't need to worry about
it.

It needs to have a flag that doesn't take a cache miss that says
"Nobody cares", and doesn't call out to random pointless functions
that cause I$ misses either.

I really wish I had made that requirement for the security people all
those years ago. Because 99% of the time, all that stupid selinux
noise is literally worthless and does nothing. But we don't have the
flag that says "nothing to see".

               Linus

