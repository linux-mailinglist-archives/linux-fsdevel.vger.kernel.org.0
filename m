Return-Path: <linux-fsdevel+bounces-59113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 378D6B34940
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 19:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41FE418992DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 17:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90F63090D0;
	Mon, 25 Aug 2025 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="X93HcYfG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1CF3093BC
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143979; cv=none; b=gzUObqNRCY7IRAqIn4T8IaV5FaTCgHD182aFDAUpRZW6X56AxhDyLznOB8S16u3jHpLhRwLRrfGLXdwrRUbUDfX9IW+DU+xmz0djuUqrESGK74btUWJSMz+UTD7lNdqxi6WYN7mSQizG8UqFrJAiA9+kPbsls7gqcTe9CGLjed8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143979; c=relaxed/simple;
	bh=8j6IUxq5806WXRPBFyKZVCp7nDA/VilwXVXm5ZjcDCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gxl0iwwOJaIE4f32X4Q9R37wd22aPnYZ0pcJE8ognUbFIryADx3o5EUDfb1o3tQkF5Ox3YGmHcLjB5+Pd06bj7A8LKtFyn2B6IztRu8vggDcty/ZR1jV/3xMagTIjRJ67NuhGzSrD8++1Jgp8v3choECRzOMwJVmFG0bSCgn/fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=X93HcYfG; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e96c5eb69b0so1201273276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 10:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756143955; x=1756748755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OT/3jnBTfte7HdviQkf1yIS7M/qS42669Lv6VXZMcY=;
        b=X93HcYfG01tEohs8PmKxyE8SZuDn54yu69o43BdPRRbRKUosdudkfrfR5qzMFCzSkT
         if60xzq/ZKeOXj3B3ystNETNfGMYx+/8Ax8PwJQtPRaGpfvOdboyt9myrJDCeIPDTAfs
         OpfKeAzSzdTbnDBe7FIdxhhi8Fiji9/exnCw2WbhNJJcMv9xOlHAekEn0gj3vAOA4rnn
         alIHzfQJIAU5tZTWztMh+SLKqtYJKqMYlCBQ2H64mwgHm9B1fc/yEcwK2OqqbQ6wlOCy
         +3Wmt61c09uuW/FkZyLLIiwsX0ydDbVOKiqWmnte7GiL6S6Z64g5lEAFiq2hloPLeXOR
         TJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756143955; x=1756748755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OT/3jnBTfte7HdviQkf1yIS7M/qS42669Lv6VXZMcY=;
        b=H6nljXqf3S5y7paS9Zyb5+D1iNH79m/mFv7bYSuQbr2EcnazZS01cLNgxdMCudZu53
         0VJFK6PM+qdEMfBpR6vAjbemgYWv0eqqrTPeK3uDIAy+l1SE6U1mwU4Ol0Tk+ypBhbMk
         iFZySIp3j5ufEMSI2FCWf227idY16nqNsMdfBTCGJthm5hVt8vQ7kP3DoyO0QW3CnpVj
         hkLyGqKDwNxhZjUBsTthYE9+x/UjHRcqX9xe54TW8YwaDiUNMhxuLv950dW94IGpm9ad
         hqKbrbS4bb6ULooDt/IZ5PsyaMoXNAmUHJXxMod8uel6C0vahJZ+HKlSmdd7zXXnfp9T
         N82g==
X-Gm-Message-State: AOJu0Ywva2bVOV8yNY4blX/KXXmg5rj4A9/kqzV3FPCSjsWkKsihZjMe
	oCVwA4xK+Nc+z88biKbz716Vz+Hs7UIVDyuBqsUzBcafWmDXgd+ngxc3i3HvadVsL7oPToWCNmx
	jusYhojuPeaWQGjZmdfCchWRF7+qKi/FO0RfFn+0vhg==
X-Gm-Gg: ASbGncu0xlgoPIYEwI6X081J7nB4RfzbBZgXkdsZUyTbWKjt2iGUYW88Sl8gxTCrxI+
	xEB8A4cDdfeQv9kmWlq0ln/S4ZGx2i+ZAwT5Grt1kuwOnjag38de1h1j5+kzoJx3BK2io35fHBN
	iPmSMKHpNQ+pjgyAxd6fB8k5dlmFgnqbXzhaLHyC1G2reUwf2gJG0D7MNfwas5tiMCQQVYVBu1C
	cz+U9VTkZGO
X-Google-Smtp-Source: AGHT+IEewseEoi5RyIQ11sFXi1Dz+0DgF+bccMhvM5suWzRi9juSFrm3PhDgSwCeoDygtX1TkgND9JR8BfJWU3XKEdk=
X-Received: by 2002:a05:690c:3802:b0:71f:b107:4dc2 with SMTP id
 00721157ae682-71fdc2dd2e4mr147859917b3.13.1756143955410; Mon, 25 Aug 2025
 10:45:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820111940.4105766-1-sunjunchao@bytedance.com>
 <20250820111940.4105766-4-sunjunchao@bytedance.com> <aKY2-sTc5qQmdea4@slm.duckdns.org>
 <CAHSKhtf--qn3TH3LFMrwqb-Nng2ABwV2gOX0PyAerd7h612X5Q@mail.gmail.com>
 <aKdQgIvZcVCJWMXl@slm.duckdns.org> <CAHSKhtdhj-AuApc8yw+wDNNHMRH-XNMVD=8G7Mk_=1o2FQASQg@mail.gmail.com>
 <aKds9ZMUTC8VztEt@slm.duckdns.org> <f1ff9656-6633-4a32-ab32-9ee60400b9b0@bytedance.com>
 <aKivUT2fSetErPMJ@slm.duckdns.org>
In-Reply-To: <aKivUT2fSetErPMJ@slm.duckdns.org>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Tue, 26 Aug 2025 01:45:44 +0800
X-Gm-Features: Ac12FXz-noqncD7Sg6rActzzOUu7I8FaVkMIzxJKc6Jc3poEaZnSiD5yWERwbak
Message-ID: <CAHSKhtc3Y-c5aoycj06V-8WwOeofXt5EHGkr4GLrU9VJt_ckmw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] memcg: Don't wait writeback completion
 when release memcg.
To: Tejun Heo <tj@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tejun

On Sat, Aug 23, 2025 at 1:56=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Aug 22, 2025 at 04:22:09PM +0800, Julian Sun wrote:
> > +struct wb_wait_queue_head {
> > +     wait_queue_head_t waitq;
> > +     wb_wait_wakeup_func_t wb_wakeup_func;
> > +};
>
> wait_queue_head_t itself already allows overriding the wakeup function.
> Please look for init_wait_func() usages in the tree. Hopefully, that shou=
ld
> contain the changes within memcg.

Sorry for having misunderstood what you meant before. I=E2=80=99m afraid th=
at
init_wait_func() cannot work the same way. Because calling
init_wait_func() presupposes that we are preparing to wait for an
event(like wb_wait_completion()), but waiting for such an event might
lead to a hung task.

Please correct me if I'm wrong.
>
> Thanks.
>
> --
> tejun


Thanks,
--=20
Julian Sun <sunjunchao@bytedance.com>

