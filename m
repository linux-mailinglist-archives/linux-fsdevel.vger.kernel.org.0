Return-Path: <linux-fsdevel+bounces-63499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DF3BBE58C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 16:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A6DE4EE6B8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 14:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECA22D5921;
	Mon,  6 Oct 2025 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ci3p08+M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A142D2489
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 14:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760978; cv=none; b=cccW5BZ1RdbjgEFLTVNUX5j3+JAYXtn44QaWAokMJZRAkBfeEnbW6ItS6nrNRzYVxVCpiLpPfniEdWFyn9oVO7wg3oh5nZOFd4NKrTbOtnwgvLkCt9wAp5WnFqIUQRyDH2Gkyf+cPhTOV+CFaP8vYx+XfvMzWLSWdoT0bUgrx7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760978; c=relaxed/simple;
	bh=E1oFUaetIN3J9BbLXWw81KQZaVbHVxYOQAA3OKovtV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9OooSJaMgyT7LVQSpsAcUiryE4z2YGz3dcnLSoPbUQbsw/j8rV+m/6Ghm/i0BlcSDh+H/prZ/0tzO2s1qYHrW71spC633CzmH1XQGSQgTI6VBF43JzRGM9xiaix5ZXzJRwUtjfHNtAdzy6t/YjsoFN8D2Y09rBgolOcfjlN7Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ci3p08+M; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-635349b6fe6so4060259d50.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Oct 2025 07:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759760975; x=1760365775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJnug6q8HPEpXIFL/wDOLMWojEn9p0rWq/or/bnemmM=;
        b=Ci3p08+M8xpkARtZPZOS4iqS+RdaAaX6AZD/lwE432f1Lqx4Fl2472Ane9CwZXTnDa
         wr2j2Y3EFtPvgwwhhhEmfxR9/MDJbWyp/JLmBNJ3SprOERHkkgubb2J5fzfIMFn/oLzu
         J/e1TfjjlRlBHST8/mT/P9V7wTLk+ny28zIMqMXhidLR8+d9D66tfLKlXgryJVd+aANC
         AX9uxmykc8l6kvwEhFICry+Rimb9EORnfzBPm6NQv/oIhXESm8HEOc+32Pz+LEWzz9hy
         wKYEALLo87qRB/+fJ6hKXSOytfVEbkwoa1hFDnl7LwxKtkt/4StIc8mYVB/JbcuCVmkj
         qRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759760975; x=1760365775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJnug6q8HPEpXIFL/wDOLMWojEn9p0rWq/or/bnemmM=;
        b=jNjw76DYdIib/W2DiFDp9LB9lo51wYYfU2we2/d60nBra3GtjGbjDsbdmKegMpOlG+
         MzHI1vsoevWQmzQ16GeCmMo135fEalRwR/YqaEDDS55c65wuclWJK/b/HXGOQoLdKWLg
         f0vmZ+MxVytqJBc+tqKxcSqDb1ywqnbdPnRQjShixAmMR6ABvPivph5lL4rez7T7PfrO
         32o5bsXvEZRxuDEJWY64RPGauwZrGz/GIZJt5FAsNgec/+UOeEe8ik2ftB/SwL8ypUQY
         Pa9L2ZHpW05eSMDQX4tHvILjYey8Ge5ZrEseLuEBlg/XQ+owcaFo4ukQ3gssti9Cy4Di
         1VHw==
X-Gm-Message-State: AOJu0Yxz9hPXXfIYdDinedLXNBuM/qJElGsAqIgUo0XmV4CU9LsH2TOV
	X8xW6l2Amwfo8Q9+ZrzTwf7Sqi/h8+i4fCsy9fxvGF9jslJJNW1NpLZ6YQBVPAtSgzmaMHNDIg3
	KTXBh4/WyDj33SZ7bDh2x9ZvHmt2va7yrwffyubc9W4QZhCJ5gkPrE8Q=
X-Gm-Gg: ASbGnctijUBsTNQ9wQUfNGD+KZByKIYh2iykx9ZmjqytPN3PGwQheBBd1Pq0BgfrAYA
	NR1z0c4wvaQR3fXG20jlo/mCkVwxSfsjNP8c0dzAeM+422uWF/Qg9GMEdbapCpA+WO4r7pb1Lw/
	Ft5WIw62wArv0oWLtHgBcr8uBkClGMWs61OlR7Yjt5iOdRTS2E0syzPeGqwuA7tyKYg1e2NzPbi
	eFdqyeagfit4IG3FHz17X2LmhBVGSWEgeJonP01Qr/i3rmqKA==
X-Google-Smtp-Source: AGHT+IEphe+jpr4i9iNOYvMrbl6mnzcpI8NSqKVNsLCn2RITk7Tut1rz1dRJ62vywpRLtrLtjwpgHodNVUg3+fDBx0Y=
X-Received: by 2002:a53:ac48:0:b0:63a:d45a:8a55 with SMTP id
 956f58d0204a3-63b9a0f4993mr9638461d50.42.1759760975073; Mon, 06 Oct 2025
 07:29:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930065637.1876707-1-sunjunchao@bytedance.com> <20251006-zenit-ozonwerte-32bf073c7a02@brauner>
In-Reply-To: <20251006-zenit-ozonwerte-32bf073c7a02@brauner>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Mon, 6 Oct 2025 22:29:23 +0800
X-Gm-Features: AS18NWDjbDOol8a1ZfvjT51FTwV90CBDkU9pBegkp2IEyx7dcFVL0jp3S6uVzJw
Message-ID: <CAHSKhte2naFFF+xDFQt=jQ+S-HaNQ_s7wBkxjaO+QwKmnmqVgg@mail.gmail.com>
Subject: Re: [External] Re: (subset) [PATCH v3 1/2] writeback: Wake up waiting
 tasks when finishing the writeback of a chunk.
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

It looks like an earlier version of my patch was merged, which may
cause a null pointer dereference issue. The latest and correct version
can be found here:
https://lore.kernel.org/linux-fsdevel/20250930085315.2039852-1-sunjunchao@b=
ytedance.com/.

Sorry for the confusion, and thank you for your time and help!

Best,


On Mon, Oct 6, 2025 at 6:44=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Tue, 30 Sep 2025 14:56:36 +0800, Julian Sun wrote:
> > Writing back a large number of pages can take a lots of time.
> > This issue is exacerbated when the underlying device is slow or
> > subject to block layer rate limiting, which in turn triggers
> > unexpected hung task warnings.
> >
> > We can trigger a wake-up once a chunk has been written back and the
> > waiting time for writeback exceeds half of
> > sysctl_hung_task_timeout_secs.
> > This action allows the hung task detector to be aware of the writeback
> > progress, thereby eliminating these unexpected hung task warnings.
> >
> > [...]
>
> Applied to the vfs-6.19.writeback branch of the vfs/vfs.git tree.
> Patches in the vfs-6.19.writeback branch should appear in linux-next soon=
.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-6.19.writeback
>
> [1/2] writeback: Wake up waiting tasks when finishing the writeback of a =
chunk.
>       https://git.kernel.org/vfs/vfs/c/334b83b3ed81



--=20
Julian Sun <sunjunchao@bytedance.com>

