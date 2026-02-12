Return-Path: <linux-fsdevel+bounces-76987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGQuNv1EjWlj0gAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 04:11:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 11964129DD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 04:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C292300D0AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 03:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3276423957D;
	Thu, 12 Feb 2026 03:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lE7CEE2p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C7823184A
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 03:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770865907; cv=pass; b=kRIctGSvdU2OuTMM43HLI+gAeLBnbs3lmyP9SjnLBae7YwR4h7SMR+aODA9DxEh5nAHrAIzV7e0+nKmotIVptEB7JwXba82ahIrYPr+31m1hDy5DqxSEoaRYv8l+2F/07dox2d7Cp7XrymxOK/v7CCslfjoOkCUNJJrgKlntFvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770865907; c=relaxed/simple;
	bh=FFhGBD3AhdKqNrATKr4zHaapfoCV5LSiIWI9pbeugw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyuYrk3g5fq0RiqJzQXJoy3b0NqZjD83zDg/XtG21HisPDklh9JEB3ziKgoExRypDJeTcHn8Zumumw9xnCq6qx8GtY3tb2srT1RgqigXzhmB1N4jJP9xIrHrufXzxRbzqC188NGrMiuLM0ig45KUai0g94clbFAhnlfm87BjBoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lE7CEE2p; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4806b0963a9so26365e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 19:11:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770865905; cv=none;
        d=google.com; s=arc-20240605;
        b=i2blMUgUI6tO/Tbb+yhyG5J8wEcy6XljVGWhWGFDi9mtTfeUt13Dc9pWGSHYiAEjbs
         nBOUWeaGzY0IzA6q2UuOgI7n+HCrJEg1w9QU0F1xL+j/w1zMLlnEueHxO/4jTgZ1qcFE
         JsleLpoA19soPGhwXmvHDZoqUUWN9PziNfAJH8IdSLdzdLT6KVeZqAJAI64nrjkGrMsl
         jDzbXKpp0YFEgEi5EQ1vdQ05B9zUAL4xEsEpNWXuaPujoP63XGB3aBK+yw/NqP0NlqwB
         TzReS8gaT9M20BPTDcwvRe6Z89jnAOK88Ma36xkL7eJxBuLVsn0/bJcRs4QJ6XQVOEXk
         WKUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FFhGBD3AhdKqNrATKr4zHaapfoCV5LSiIWI9pbeugw4=;
        fh=QZhOJxKirruezAm8rFwOJN4udxaPZw6WAq94vDHyVVk=;
        b=P3ewjqmrxz/+magSgDCWI1ZtkFi9PyWnQTAE+9KQQLAs0c982TRei3B9vLv6CCcEl6
         yHUfw4e90ijoZ2y077h0LWb45eBGf7SWlOwyisfkuyyLaPZxCMsYIr6Rh/KsDUruPAg0
         rK/QjFvcD+rOvXDRgicrMgOMjmE1au28TMf+VbMTZgjQB19XcfyBr1FFtEmlUN2K14Ij
         SFNFy8sFoaV2gOp8eqcOaGtX4XhQss3vmgkLqJV8AXNs93iXCiFVBz3sOQHrxp1mg+tL
         saHDj7+72DrkDt0UCF1hoXbgvBeOmp5MQSCgI9jn2EhJxMUX74pFY3krZ2P5CrvWmGxB
         S4KQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770865905; x=1771470705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFhGBD3AhdKqNrATKr4zHaapfoCV5LSiIWI9pbeugw4=;
        b=lE7CEE2pUvg6oJswNZnbYJ12l5mYcOs6r+fsH2atsjdEWcQNn9UwkefOk5cAp5WbKn
         3EOQubxeeQp9RA6MUfDfz68rtV6FD+oZ42IwMTU2r4x1rE3XsvTlMStI4B+CHZgiFhGb
         KiAU7yOXvWTAJW2nMs8hMQf8gvLSldBssRqSzxhlZ+y7zkfZp9u+LVF825/LbbWNwBUc
         M6j13T54Hnaj0E16R5z42vhb+9OFeJyK+Z+78fRTiGQadx8tLEzSR4uQwr8i/4P+XYT8
         Cg/reU5Ql3LgV6hmoxUnLo6fGBHcBswiyJUPc7YMr12PQlIL2/mWka9+WS697s+EnDQ1
         ibvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770865905; x=1771470705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FFhGBD3AhdKqNrATKr4zHaapfoCV5LSiIWI9pbeugw4=;
        b=E130m8nQNLwsFMGaFZYv2hoHZlqeO95pebcdOoQ0nQDfFjIdND2xYH1aMRZ/Z4v59w
         NkGJ2740zLFIj9mngEpNkgwqrT9BqKOJ4JatYhyZXuTccfXq2LkhNanyBpyr6MZouruM
         ud5i49eWUdpwN5FVGlcvvxCywN8e9fHQT+OqwLPQXfCTlXAZlGqaQ701ffq4AxYq//8V
         uuEJwy03Lb2MEoylNXJyjAF4kSJz1B8vqSRqJ9LRSMXgn4gdsCm9XZyvEknu6Hk5APEI
         cb4JQZDfsBFLqoXGeWcTtCvulgyJwbmkterFOOXtRew6eQ+o2614DioxmQM1ffjze5Wo
         XBWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt15nr+vpyC0ThMMWM3D2QZVUuOTeHujnYW1vELNY566kdThNU7JB/Vco2whJUBiayAkE+ZWo9EnCbZ5Nd@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz2o3s26IYZLOqK5lIi/essR563EHqcPQaRkd/Jh24fqDjMcnK
	IDAUuefA3Fbx5mAFShzC1o27OPA5iTEkjMt2wWpyKuNNpRudpvi5FqPD7zYq6a1IcmKotP+oiLG
	RSTy4Aw2QCkmLEtVNVyAQdaOS9qhOeUL2rgHf/21Y
X-Gm-Gg: AZuq6aKXeF+Y8z0tjU2HaD+uJIRYIie/ZTsaIfEVHAWBWBty41OiOjCSE8LnmeC8mRw
	4a8ia2MJNBV2r4GvfbVm2vnrJfTcBzqgKrHHgfgVL6bTlGxXOq7O9Fo+B+W1dv5188iBtXp2yFN
	jth/mUigxS4zbnFZXnO78C/jZQMB+sd467RQMUyW0OaSmUSWghlTM+GiBk3Rn9GdcUMMhUoDZ5h
	0LvLc2Sa9jss2FCmbMNTW3VjeaQmcCDPu7lkE6tgolgCFftMlGzxXRwIafdjUacbgWn5N5UX2YE
	wcCqtnmrN4fUXmDZqyc1Br0c4KBdP+6PyBcWSq7k
X-Received: by 2002:a05:600c:5704:b0:477:76ea:ba7a with SMTP id
 5b1f17b1804b1-48366d4ce09mr192135e9.3.1770865904372; Wed, 11 Feb 2026
 19:11:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203192352.2674184-1-jiaqiyan@google.com> <20260203192352.2674184-3-jiaqiyan@google.com>
 <5c4927af-120e-4c6b-9473-95490f4fcc90@oracle.com>
In-Reply-To: <5c4927af-120e-4c6b-9473-95490f4fcc90@oracle.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Wed, 11 Feb 2026 19:11:33 -0800
X-Gm-Features: AZwV_Qi3lwPEjdm2Mw887DAZh3QRbXiCmUAvRWCHdZdEClqeZBM3MxkXXhz_C-k
Message-ID: <CACw3F51CdeGzTRgmFgoPA3GxnjUXHHhBkCj73pS+kEMhQ=XnNA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] selftests/mm: test userspace MFR for HugeTLB hugepage
To: William Roche <william.roche@oracle.com>
Cc: linmiaohe@huawei.com, harry.yoo@oracle.com, jane.chu@oracle.com, 
	nao.horiguchi@gmail.com, tony.luck@intel.com, wangkefeng.wang@huawei.com, 
	willy@infradead.org, akpm@linux-foundation.org, osalvador@suse.de, 
	rientjes@google.com, duenwen@google.com, jthoughton@google.com, 
	jgg@nvidia.com, ankita@nvidia.com, peterx@redhat.com, 
	sidhartha.kumar@oracle.com, ziy@nvidia.com, david@redhat.com, 
	dave.hansen@linux.intel.com, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76987-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiaqiyan@google.com,linux-fsdevel@vger.kernel.org];
	FREEMAIL_CC(0.00)[huawei.com,oracle.com,gmail.com,intel.com,infradead.org,linux-foundation.org,suse.de,google.com,nvidia.com,redhat.com,linux.intel.com,linux.dev,kvack.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 11964129DD6
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 9:53=E2=80=AFAM William Roche <william.roche@oracle.=
com> wrote:
>
>
> On 2/3/26 20:23, Jiaqi Yan wrote:
> > Test the userspace memory failure recovery (MFR) policy for HugeTLB:
> >
> > 1. Create a memfd backed by HugeTLB and had MFD_MF_KEEP_UE_MAPPED set.
> >
> > 2. Allocate and map 4 hugepages to the process.
> >
> > 3. Create sub-threads to MADV_HWPOISON inner addresses of the 1st hugep=
age.
> >
> > 4. Check if the process gets correct SIGBUS for each poisoned raw page.
> >
> > 5. Check if all memory are still accessible and content valid.
> >
> > 6. Check if the poisoned hugepage is dealt with after memfd released.
> >
> > Two configurables in the test:
> >
> > - hugepage_size: size of the hugepage, 1G or 2M.
> >
> > - nr_hwp_pages: number of pages within the 1st hugepage to MADV_HWPOISO=
N.
> In this version, you are introducing this new test argument
> "nr_hwp_pages" to indicate how many of the pre-defined offsets we want
> to poison inside the hugepage (between 1 and 8).
> But is there any advantage to give the choice to the user instead of
> testing them all ?

Yeah, nr_hwp_pages doesn't seem very useful. It was useful when I want
the test to run in two modes: single page vs multple pages. Let me
just make the test to testing 8 pages.

>
> As a suggestion, should we have this test program setting or verifying
> the minimal number of hugepages of the right type, instead of relying on
> the user to set them manually ?

Yeah, I agree, we can just run for 2 different hugepagesize.

> And at the end, should we try to unpoison the impacted pages ? So that
> the lab machine where the tests run can continue to use all its memory ?

Good point, we can include this as a test cleanup step.

>
> Thanks for your feedback,
> William.
>

