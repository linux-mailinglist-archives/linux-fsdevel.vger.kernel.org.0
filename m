Return-Path: <linux-fsdevel+bounces-65876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 279AEC12E29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 05:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CCDF1AA6FCE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 04:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A873B273D9A;
	Tue, 28 Oct 2025 04:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uE75PAx+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087EB26D4F6
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 04:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761627410; cv=none; b=kcTIlyaz1jgLePaPoSjciqZ03ngZZmXZeqGpxUp0A/4SW7jgLbIpg+CycKBvTIX8Z1gW34a2cWYOFASKmhS9YlAnTzTYbqxG4LsCumL9//xvzZ/b0EYpL797G5AAeCgFkQgMgd6/roxtg9s5MYHsEXzMOiCpRzgg5GUNnv+IKY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761627410; c=relaxed/simple;
	bh=2AyDC4RkIXJleMnUJKcRk3adoYUh83U4Z9TJrjNAbo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTtLqoAKbkzvGyLqN7bs4BSvc1GDw9uqX6X8p02j4NuERddhbAkGsIoJMdFXJpyoN0sbKaFIsP4pRaoQ0zuf6/A+Jyd7sJl/Z1ZQeJdzdpZLkx6AA1twibYekM/PXb13tr/YsHHVR8Qd2n6AqQg/yge1IKvaFo2G4948i+Jjm9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uE75PAx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9313EC113D0
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 04:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761627409;
	bh=2AyDC4RkIXJleMnUJKcRk3adoYUh83U4Z9TJrjNAbo0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uE75PAx+VUrTAomWqKmzr7cM4TC6FdvWR1kDO/StyTjvHyzi0U/CXe5F89N8qCB7x
	 bJc6Mx70Soe+6IsyZH9vPZEEtCrnLgRRXJ5Z5RrpGvTjMrvI7dWB61BYcFAITfLHV5
	 wJHUENUtgT+cpUHEnUMdDqOeS9M8neaDgZWo3M8fmRR+OUv81njzRUV4AIh7pUKZm4
	 k4XkugCEtQAq98HNWqpz7s0i8oUX/mdBYols6oDusdDNiOIsBHOmDi7LjbYVY5qMnt
	 lmYliCBIucL+q54fLuZyptYfF30qpcsQNkfRzYxKevnWP0xSK2GjrkvmQ9UFXD0Oza
	 CV6ecussqjQqw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c3c7d3d53so8409148a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 21:56:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVujOnYNwRKNPbnfXJuTillBXQNlacPSQVq6a+IDHsNWSRfwy9cv+dRFWoLfxOjQQlGOjyPVDikDrD10cby@vger.kernel.org
X-Gm-Message-State: AOJu0YxyqYEKEK4F+tjYsFo+EjTGKBnoThAoqdy9WAky78f3Fn7HHm1d
	MriL1twFIQT7nFWWMsBiMhlgcSl+KItwzKxU++1/aZLzaPcOgvY4l/oi5rr17MPITUPgcBB0pLd
	MwkpN3mS7ZOp19VyTr1O3AbB8/QjLumw=
X-Google-Smtp-Source: AGHT+IEZ/QKOoLG/1vgs3E+VFCNLoSdKVE05NscKH7bzXoKQIr0L4VhdDe3VzWPpvq5gXLYaAyi+Ne1r3qSXZf2vhIo=
X-Received: by 2002:a05:6402:2787:b0:63e:155c:3ae with SMTP id
 4fb4d7f45d1cf-63ed7e081bamr2225735a12.6.1761627408178; Mon, 27 Oct 2025
 21:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027090340.2417757-2-Yuezhang.Mo@sony.com>
In-Reply-To: <20251027090340.2417757-2-Yuezhang.Mo@sony.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 28 Oct 2025 13:56:35 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9=YFXF+HhLGjGwgmtDZb37uPcJj=k+tsOp4A6mEM1e=A@mail.gmail.com>
X-Gm-Features: AWmQ_bl15MhkHC1b26k6eSeEMYd3bEENLf4hnJofP5DAOwrj3xXnI07r16BA7WY
Message-ID: <CAKYAXd9=YFXF+HhLGjGwgmtDZb37uPcJj=k+tsOp4A6mEM1e=A@mail.gmail.com>
Subject: Re: [PATCH v1] exfat: zero out post-EOF page cache on file extension
To: Yuezhang Mo <Yuezhang.Mo@sony.com>
Cc: sj1557.seo@samsung.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 6:16=E2=80=AFPM Yuezhang Mo <Yuezhang.Mo@sony.com> =
wrote:
>
> xfstests generic/363 was failing due to unzeroed post-EOF page
> cache that allowed mmap writes beyond EOF to become visible
> after file extension.
>
> For example, in following xfs_io sequence, 0x22 should not be
> written to the file but would become visible after the extension:
>
>   xfs_io -f -t -c "pwrite -S 0x11 0 8" \
>     -c "mmap 0 4096" \
>     -c "mwrite -S 0x22 32 32" \
>     -c "munmap" \
>     -c "pwrite -S 0x33 512 32" \
>     $testfile
>
> This violates the expected behavior where writes beyond EOF via
> mmap should not persist after the file is extended. Instead, the
> extended region should contain zeros.
>
> Fix this by using truncate_pagecache() to truncate the page cache
> after the current EOF when extending the file.
>
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Applied it to #dev.
Thanks!

