Return-Path: <linux-fsdevel+bounces-26865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAB195C399
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 05:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49474283A1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 03:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EE3381DF;
	Fri, 23 Aug 2024 03:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W/pN3PmW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6637026AC6
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 03:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724382361; cv=none; b=YiHt/xn+AzSj9fvuqcsW89zjwHcmTIKk06mwJ8NMX+fmNRfUfCQKlWgdfQY/1ydAr0rAyKGRdDkbY5rWo9MVBwuspiZCB2laICS1Qm6x1WNuV4+hKuA0yyRy35bbw7RrUoMT9oR+O0p8XPXIF4BiX0CEgLeopQSIQNXfAwGJ7jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724382361; c=relaxed/simple;
	bh=77qJaKC4fPT95Qd762bP6a+wdqwtDlZJBG3SBWkc4aA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGMTVNFEPw3d4J8t9eAwooL/Z/hlLiiGCHaP4EMhGugkYcHigE7rNkkXI9NVvIO5hfa0yygf6v7QYA8yDsPjmorHPAQgUWh9gBdEAHHWk1TaaxanHJZbiWfydLNhRq6NDTeVQrVdciikZJfbrSBFSioGvD5cOI3HoiimroLjJls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W/pN3PmW; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5bb85e90ad5so1572845a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 20:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724382356; x=1724987156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j5hlm45AqSM3i+v1k8NPIQ9XsDGMERklx309l77f1KM=;
        b=W/pN3PmWGk5TMaeG8YbdbUuSM6M3sBKcVT10NLU/FCHjTGmpx3v6dv/JSuZUEh+oVs
         6qoppdgAimRMWrtWxuajUkRAFMbrYc62KzpkL9odSWMAIKJszDGakz0Bee/myOlmpF+q
         sh96aRvQETczeBFzilQ7FzM8+P5v/kR+E1+WA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724382356; x=1724987156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5hlm45AqSM3i+v1k8NPIQ9XsDGMERklx309l77f1KM=;
        b=sDfpSjdof5n2+xPxtBs6ama20FtAMR9hwZ1QADV5FHOSYBj3qN2zFUwgFreaejn+ls
         6sIWkNJbZqD7/sLmzcP+kdXB5qLabEWp4RHFt+8LtuKFbpsjipup3PdBpLdSMyhYMCru
         opKO9p7wlBGwrm93vXC6mZL4mfoXZiyssAFAMJQnfX6NgT4PAorCQe9fVk7cu3XnEmhb
         jxNa+r/kaCcVe+QQA5ktwYtL3607eUp4n2X8FLJD0ugojRD8+Z4Rj6TAkPrjq3HrjTHs
         2A1BeOyyJrmrsD2vqTd6e6YHnr0KH2dtcD//rXWLgPfZYenWaJlY6Ux2I3wSssw2UhHW
         +7Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUXobaNjyd2uQjQroQsoozx4NUfYiiAb0T956dIKvg/JuRnviXX/UHSrPsWlNNbTK6dTOscNU7Wlm27BRhk@vger.kernel.org
X-Gm-Message-State: AOJu0Ywefu8ChFWKaf2Ri2eHu/oUzh1zNw28qSoixIDXCJXwlGUo/IqI
	CYs3qD6G7/vTIuEKpvNW1p4EXxAj0i9ZDOXaXUCk+HhGdHyyv4h92h64uXmrA1TdwvetN6dMOPB
	NQmblBg==
X-Google-Smtp-Source: AGHT+IGdtAx25xQ1dRs8ZAw96jR3X8eRK8jhREgBhx8pAhu1ZVax6gOWCAXs9wwrpfRWZrmO9X9emg==
X-Received: by 2002:a05:6402:2789:b0:5be:fc2e:b7d4 with SMTP id 4fb4d7f45d1cf-5c0891696aemr366396a12.13.1724382356125;
        Thu, 22 Aug 2024 20:05:56 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c044ddbb8fsm1548521a12.1.2024.08.22.20.05.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 20:05:55 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bf0261f162so2128153a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 20:05:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHThqRUAp14q0DOLLHwuV8Rhrwknn3oqG4cMDtkI7YPwZZJvbunmK/g2j1+iJmwejqObK8mHWhDY79rEcQ@vger.kernel.org
X-Received: by 2002:a05:6402:5187:b0:5a1:2735:2378 with SMTP id
 4fb4d7f45d1cf-5c0891a14dcmr354986a12.30.1724382354537; Thu, 22 Aug 2024
 20:05:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822-knipsen-bebildert-b6f94efcb429@brauner>
 <172437209004.6062.17184722714391055041@noble.neil.brown.name> <CAHk-=wjTYN4tr9cjc2ROA1AJP5LzMh6OoNAz8pVSUMP0Kd7AFA@mail.gmail.com>
In-Reply-To: <CAHk-=wjTYN4tr9cjc2ROA1AJP5LzMh6OoNAz8pVSUMP0Kd7AFA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Aug 2024 11:05:38 +0800
X-Gmail-Original-Message-ID: <CAHk-=wjwOFTLviM2zB9M-BtsK7spLP9XYZ=bAL_Pospi--QyPg@mail.gmail.com>
Message-ID: <CAHk-=wjwOFTLviM2zB9M-BtsK7spLP9XYZ=bAL_Pospi--QyPg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/6] fs: add i_state helpers
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Aug 2024 at 10:52, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The wake_up_var() infrastructure that the inode code uses is a bit
> more involved. Not only can the variable be anything at all (so the
> operations you can do on it are obviously largely unbounded), but the
> inode hack in particular then uses one thing for the actual variable,
> and another thing for the address that is used to match up waits and
> wakeups.

.. btw, that doesn't mean we can't have helpers for the common cases.
They might have to be macros (so that they just work regardless of the
type), but having a

    set_var_and_wake(var, value);

macro that just expands to something like (completely untested "maybe
this works" macro):

  #define set_var_and_wake(var,value) do {        \
        __auto_type __set_ptr = &(var);          \
        *(__set_ptr) = (value);                 \
        smp_mb();                               \
        wake_up_var(__set_ptr);                 \
  } while (0)

doesn't sound too bad for at least some common patterns.

Looking around, we do seem to have a pattern of

   smp_store_release() -> wake_up_var()

instead of a memory barrier. I don't think that actually works. The
smp_store_release() means that *earlier* accesses will be bounded by
the store operation, but *later* accesses - including very much the
"look if the wait queue is empty" check - are totally unordered by it,
and can be done before the store by the CPU.

But I haven't thought deeply about it, that was just my gut reaction
when seeing the pattern. It superficially makes sense, but I think
it's entirely wrong (it's a "smp_load_acquire()" that would order with
later accesses, but there is no "store with acquire semantics"
operation).

              Linus

