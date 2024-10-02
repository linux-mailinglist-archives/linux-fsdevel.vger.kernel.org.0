Return-Path: <linux-fsdevel+bounces-30783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E017898E45A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 22:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FF8EB2413E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 20:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1841F217315;
	Wed,  2 Oct 2024 20:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMuqwufo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200BC1D0F64;
	Wed,  2 Oct 2024 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727901936; cv=none; b=Wp8GfM7uwVaFiOhdN97k0URWLKPEKh6Cj/aXOgfFW6QiBsEoC7Tnl6U2NMvIt5TeLaSa5QnIp4MqhSy9jPX/bJRj3pReLOznzeklDHKA/ToRiWMNXfzEzXnPtGeA3oGvm8t/qJovntrlefEGIIOfEq5iyI7dFKCsMz+j1cdlSlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727901936; c=relaxed/simple;
	bh=r5ua7STwZTPVMtH1PGVZOozH3aM5m0l2oOhzZM++RYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6o89orol2iZirz2JJCuJs1AtDUzz2SPCVuQN/ILr2/NkEDoFRvkMO44H6/ZGImeDqnOPtPK4AP6nks4HWkdOpJQgMg8C2vnpG5L6IFWWQHNnx66stX/Iq7oXVhRDbFtW5ppaJXrPWPiqPhKmjc81NBAFm7xVM3ge7mCxMr5oSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMuqwufo; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7acd7d9dbefso18045585a.3;
        Wed, 02 Oct 2024 13:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727901934; x=1728506734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5ua7STwZTPVMtH1PGVZOozH3aM5m0l2oOhzZM++RYA=;
        b=LMuqwufo62px8iQ9e4qUmyKTmG0LFCF/tJYbeopQ/u+qeSKD4jc0383k/pOum9QbTk
         0yxpyEULbC7MpqwBeRD8dSTUBFd2MVdCcZU4Wa/MttvW6HZ1Y80S6kKKK53SWPHaxkD0
         L+3s5k62Nqgv1qYpRHVtPxZY/TaYV8wwnO3ViK/V49xTtaW7bkUYQjw3YSE3glUdqgdU
         zghtnO+hVeKRcNK5w7c7u/hNw41YH5+S1YzHyPcTRswBxBdxL2986wwE+XLJfqQOSYuY
         /qlQMjgEONPXx+GX2HzhDGfNobbVAGY3K+VFa0d7qb2VnoeFKK6ri9NwD5n6lAj7smPN
         JdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727901934; x=1728506734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5ua7STwZTPVMtH1PGVZOozH3aM5m0l2oOhzZM++RYA=;
        b=hR5BS6wzm8C26zfBkkZxqPqdR6IxzvjuHs5o2gLH+pmtyouJ228ma7gT/SLCS9aLJC
         8useqBsV3wBLLqQ9dCFAQzx/Qp/yD3xJhzcdEVegF/TaUnwMjF6Fmd/9y4GxcTmNBQaS
         0pN8d7e57K0VXfniWC2IzZcOuPmaOS9ByXOYtyl0cMWoGury9Z7ax4gqrrpUOityQQx1
         2nXEzEGUnxYA+j+cjZCk/93v0sYUYUtKxdJbmqk5keo4W7dI8aqU0EIuaWZ1cLkM6VHw
         wRRyFG6JrzX64EkXUdkDsOYE4OhG4PFR5JeXwf/qTo43fn9erCs39eEcHhZSm008icsr
         p24w==
X-Forwarded-Encrypted: i=1; AJvYcCXPugGXeejGOEuqS7Yi1dxwAKHODx+r3EhH9xtO+SWPcq3CmhJ2wbp/XavshZm+lTXlxnPTitO8CQI+635t@vger.kernel.org
X-Gm-Message-State: AOJu0YwsU0bZOleyEjB0JG3GC0FDqDt/DN+fIeX7xKltBq3+z+rA/qdb
	OnC7M2O+5sEt1qYXHgrV7GNIVh8bvyGJXrzhBV5ur5XSB44tUyr7can1ZTSKEDUlJMXaTCy29Zs
	LFaSObUepqsXPnqQpwL1JV1VrlEoTsRWwyiTGdQ==
X-Google-Smtp-Source: AGHT+IFvRf0Pxcb3wJuPeJTsK8vYkAQv91LEsZobHX9BvFAeqsRLRIv43cHdKoLCTjXDYXArXPEueCLHvEMn7+L8RS8=
X-Received: by 2002:a05:6214:53c9:b0:6c5:5384:96b3 with SMTP id
 6a1803df08f44-6cb81cc379fmr56780016d6.52.1727901933943; Wed, 02 Oct 2024
 13:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsOPwuoNOqSMmAvWO2Fz4TEmPnjFj-b7iF+XFRu1h7-+Dg@mail.gmail.com>
 <CABXGCsOw5_9o1rCweNd6i+P_R3TqaJbMLqEXqRO1NfZAVGyqOg@mail.gmail.com>
 <f6bd472e-43d9-4f66-8fc2-805905b1a8d9@lucifer.local> <302fd5b8-e4a4-4748-9a91-413575a54a9a@lucifer.local>
In-Reply-To: <302fd5b8-e4a4-4748-9a91-413575a54a9a@lucifer.local>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 3 Oct 2024 01:45:23 +0500
Message-ID: <CABXGCsOsZ5TyEjSWTk6e=FU30a27N4J0gqNCat65gweyKPtZ_A@mail.gmail.com>
Subject: Re: 6.12/BUG: KASAN: slab-use-after-free in m_next at fs/proc/task_mmu.c:187
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, linux-fsdevel@vger.kernel.org, 
	Liam.Howlett@oracle.com, Andrew Morton <akpm@linux-foundation.org>, 
	Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 10:56=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> We can reliably repro it with CONFIG_DEBUG_VM_MAPLE_TREE, CONFIG_DEBUG_VM=
, and
> CONFIG_DEBUG_MAPLE_TREE set, if you set these you should see a report mor=
e
> quickly (let us know if you do).

mikhail@primary-ws ~/dmesg> cat .config | grep 'CONFIG_DEBUG_VM_MAPLE_TREE'
# CONFIG_DEBUG_VM_MAPLE_TREE is not set
mikhail@primary-ws ~/dmesg> cat .config | grep 'CONFIG_DEBUG_VM'
CONFIG_DEBUG_VM_IRQSOFF=3Dy
CONFIG_DEBUG_VM=3Dy
# CONFIG_DEBUG_VM_MAPLE_TREE is not set
# CONFIG_DEBUG_VM_RB is not set
CONFIG_DEBUG_VM_PGFLAGS=3Dy
CONFIG_DEBUG_VM_PGTABLE=3Dy
mikhail@primary-ws ~/dmesg> cat .config | grep 'CONFIG_DEBUG_MAPLE_TREE'
# CONFIG_DEBUG_MAPLE_TREE is not set

Fedora's kernel build uses only CONFIG_DEBUG_VM and it's enough for
reproducing this issue.
Anyway I enabled all three options. I'll try to live for a day without
steam launching. In a day I'll write whether it is reproducing without
steam or not.

On Thu, Oct 3, 2024 at 1:32=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> Out of curiosity, what GPU are you using? :)

The issue reproduces on all my machines.
One has an AMD Radeon 6900 XT and a second AMD Radeon 7900 XTX.

--=20
Best Regards,
Mike Gavrilov.

