Return-Path: <linux-fsdevel+bounces-59129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B100B34AC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 21:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D641F7AD659
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 19:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FEF13D503;
	Mon, 25 Aug 2025 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KEZ3InvS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6951527AC45
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 19:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756148796; cv=none; b=MTQxmX97AgLAYPG7YxFYuGMYeH/P2lIIUzw6XTT3OgczZN1SVuTuWcM+kwh2feT2d5ScPbOdoX6/Nu08pP/Xll+aNyWbXGJloYxUnY0UOxviZGX0SMW+OuLAMu9znKQtF70rgUlB7PY/QbxEPBLrKMMRKXNlCgRI/IEKyJTmfS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756148796; c=relaxed/simple;
	bh=nXiXNC/n8XD4tIUmtofTDePq023F7QUJyqo+465Hjng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUUA4UoYhotpdIkceFvBuXt+yKjKlu5D4hVhOSgbXBvM66msoJ/EBRUAnzv2ckImQHivcO0k+d0tA17JGP1dcFImwqKuAt65j4nb0eZVqh9hqCn2ducJXifBqGxkLlW+yNSRPLWVTw0OH9+1+EDzHcuwVNchXRkCZdPzB9ylUg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KEZ3InvS; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e96c77b8f45so835715276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 12:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756148793; x=1756753593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJCy6pMSth5ID8mVL8dsxoueMmqHKyc8szHkL4OXcuI=;
        b=KEZ3InvSCRa4aKJ7kuuRBns5B2ECBjq7e/rkawApTOedR18ol1aJacp/yhyNDP1OXb
         kzA5S2qh87p41xTIgVxaHhKo8cUoKE4ZCTUfaP993rMetBUERSDrL9RHtme2uwsjX3HG
         w8tlUNFleqSahOzKbniM3ubMe6EKvXKsrKxW69dojuu9dUQ85jol50pnIWOtvbva2XqU
         xEPHS9bD8B5zjnd7bmrh3NEhi3frXeO1fzZVE48h+67kHSwbPZgIN9rEUVuk1Xzdoza0
         z/wvH3YmFkS+I75S/yq4BvMk2jnKBR15Cn897P5iwMWLGKgD8DVhF2gUIRvkBdXxunEh
         4/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756148793; x=1756753593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJCy6pMSth5ID8mVL8dsxoueMmqHKyc8szHkL4OXcuI=;
        b=rl7sIgY2/zo4Mg15GE6jQgRY/JbFlupueqyDEWx6Ht+oGgnQr8HtEFoUdR5PkUWFbe
         RUrfb4XukDyQ4Q8hZf+ZGqeE4VGqoUP0rjs00TMlJiwHDvsy3ZoLVuyghGAlatzmg0Ej
         bWaGhDP6b+YV509PLPmnlAHaxcIx/ptbq32p0mr3C5ip3wKI0riCoHPwf6HnS7IIaO9N
         RtaxaV3UgGQKpCsIFKdYGlgyQ+IuTEeZfcfSdePNoVZKgUZmi3c09jm8cscpvbcwXnCn
         Zut0OwhyaGzKoF/9SZvEzfQaN8xHSoIv4JqAbTqmeBpUL+X2NNw6lVUcne3EWvMVl0oZ
         FDkg==
X-Gm-Message-State: AOJu0YwhnVS5vmm3YApJYCtpbWF619KqG4XBunMBPYlaJNQSWOBrRUds
	lkxITtwYMVKvawh8yY2tWJhIPQDQCBXBJsFo8UFDkOpXpxrXs4GhAFll2EbfzwHUBhdk6A32wUe
	1qquwZVJKcWQc5MyXwZsi/G/XgN1fG6892gbfUEdWtQ==
X-Gm-Gg: ASbGncuKMlbH/0M2/+gi7WMKnaH3K0vMRj9dCVjhdC7MY75NVUss92wXi7SUnzT2t6i
	svMWBd6OfA7IOtlV+kl8EEeuhdszBcWSoWhoQ+yaJZWn7MnkBmZYxCjC5bnBmRooIeTDgIe4Iog
	CV5fbu91SzIUSnm8cfgaXd8YwZDWrGTWooWzT/SGcGW+a2kzSLdXxMCQ4DMMFUQZgmHAzjxvcUE
	IQ49/dRaxwm
X-Google-Smtp-Source: AGHT+IHAgyL1whKyieTbABDi2quj1+wuaVqtUcIrZ53ZFQBjV5RtdnhIK0bQ7dnHbDffx2GPfxlJyS52gocXhCBCiEk=
X-Received: by 2002:a05:6902:3411:b0:e90:6c6c:dc3a with SMTP id
 3f1490d57ef6-e951c33207dmr12818324276.34.1756148793135; Mon, 25 Aug 2025
 12:06:33 -0700 (PDT)
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
 <aKivUT2fSetErPMJ@slm.duckdns.org> <CAHSKhtc3Y-c5aoycj06V-8WwOeofXt5EHGkr4GLrU9VJt_ckmw@mail.gmail.com>
 <aKyxE6QOR_PtQ0mT@slm.duckdns.org>
In-Reply-To: <aKyxE6QOR_PtQ0mT@slm.duckdns.org>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Tue, 26 Aug 2025 03:06:22 +0800
X-Gm-Features: Ac12FXxwKjce8jxJNNwjCY1pe1qCpWBlapoFKM06--smM3L7BAjrjrvgrdd62yE
Message-ID: <CAHSKhtcdRysJGAUOOXMUdm=dymQ3scJFUQ2nc+ShmXku+SAb0A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] memcg: Don't wait writeback completion
 when release memcg.
To: Tejun Heo <tj@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 26, 2025 at 2:53=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Aug 26, 2025 at 01:45:44AM +0800, Julian Sun wrote:
> ...
> > Sorry for having misunderstood what you meant before. I=E2=80=99m afrai=
d that
> > init_wait_func() cannot work the same way. Because calling
> > init_wait_func() presupposes that we are preparing to wait for an
> > event(like wb_wait_completion()), but waiting for such an event might
> > lead to a hung task.
> >
> > Please correct me if I'm wrong.
>
> Using init_wait_func() does not require someone waiting for it. AFAICS, y=
ou
> should be able to do the same thing that you did - allocating the done
> entries individually and freeing them when the done count reaches zero
> without anyone waiting for it. waitq doesn't really make many assumptions
> about how it's used - when you call wake_up() on it, it just walks the
> queued entries and invoke the callbacks there.

Ah, yeah, this sounds great, many thanks for your clarification.  I=E2=80=
=99ll
send v2 of the patch after testing.
>
> Thanks.
>
> --
> tejun


Thanks,
--=20
Julian Sun <sunjunchao@bytedance.com>

