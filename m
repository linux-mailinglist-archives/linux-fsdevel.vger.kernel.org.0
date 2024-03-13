Return-Path: <linux-fsdevel+bounces-14372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D638687B475
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 23:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3B0AB214FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 22:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4149C5B697;
	Wed, 13 Mar 2024 22:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="AAvDmDtL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F5259B4B
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710369514; cv=none; b=iBQDzLBloBkAhX8yFoO2hldT1u8H901Y9V9wOPFfFK08xYENbkHVNpTBhjZKDOn0sV7RBh0+fgAW3g8bBZ2jlk/cIf6REtAxo0R8QpSt+c+fb942ThxEKkyoD5XyxbzLUsXDrEdI0tN1zlw0VyY1uZWWpP+0pVCH+PmstyECr8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710369514; c=relaxed/simple;
	bh=/AeK6IryRQEcZsy2w1FTI8NpS8Vj9IE8PhmQeFns2gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ce+fxYIVTSW8z2uVKYGOCAQWWJJcq8sfnZNozRLC1r+IUvFxONFG4Yqkz0rNt0pVIiSz9jbqdI7UD7A4k0ZjyKty3tA13zT1+uZl7+KaBPm+L3+kCHFOk5YSKS2rQmhDO3S7RzrKqxkL99BZj5PIm07CU8zD7VRkBQgHw9KzKWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=AAvDmDtL; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60a046c5262so3807477b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 15:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710369512; x=1710974312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AeK6IryRQEcZsy2w1FTI8NpS8Vj9IE8PhmQeFns2gg=;
        b=AAvDmDtLRvPhQjkNy4GbjNZNH7YnTwOMBjzjqLls2aTQnvALkCWDfq3sBRmYtY66NT
         8mvwm2h4p0nD2RN3MdjD6Ym6M6zunbIawW9Jdcloem2jeb17WGcXdy7X30CxLPh7EXkq
         rabuDO4SlRVoR0PUvYNDDq9/9VBBL82caRRQXSip2tDHJeGXvNPmSxZiqIBZ0TPYZFcY
         oLl9i6Fol6c/uC7tDy9lt6k2lS2uQyZ0eEsaErQjRu5hbM7iAW1DNkWSbMtDi0jXxi49
         7jBZwYD0OiuPkIozy1PiE7b6Xr0g6cFB9OuTOgxJK9YlqoKsiTHtpZKygu7HV20j089g
         JV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710369512; x=1710974312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AeK6IryRQEcZsy2w1FTI8NpS8Vj9IE8PhmQeFns2gg=;
        b=N2yAmzfG63GdFjAZIVhRY1BGp8ZqmNcsh8HmwUoGiIKUEmKWoEVnpUNBG+vRbbsM3c
         Vj8tLJGg5ZroEj+E2LJ2fmEwfsHOYvNqK6fTVtVMg8+GhuW2lzUtXClYtzB4HK1ATuMY
         OoV496dHSUzCg7W/ECVh1VszcyT493KqviA3P1sFL3aH/ZSx1VGysxBGMm/M26J+/Jvi
         mm5WSE8C+28UvwIVGaigZmx1IDZ1NcFKU+42GlPVx/m9vgkZtL3M+bxt7SZ/gUYdovJV
         2vn4QoOhk9FYkfV6tdlqj/9qYkZbaA7ZmF8oP3gk/i5IuRhGFhp7dEP5PLS2deG3wuYc
         FqWw==
X-Forwarded-Encrypted: i=1; AJvYcCW4zR49AoVpN5TGkEoLGS5qL00qjYUMHbMglIm3SauuCwesyyTa+Cxfow/lbfvKPdoAy5RyGuGrEXNjZ0YP9Yy8AgcP49OJrPgyeTG+zw==
X-Gm-Message-State: AOJu0Yz1d63XXlVqD9wdb+GFkOIYimarpXwkPhtYnlXQAnjn1HTm1J4m
	RoUBahXCB3DCr0KzCDrLHr4fMFO4knjpdjCPzzTvFriLQO8mB6U3rIaN80sNaJd7lG28abE/HNT
	PIHEVoJqISydK3HfBWc7KqEXYFNa2VP7HW7q9Vw==
X-Google-Smtp-Source: AGHT+IH5HYI6/U5oWgLdvGxeY0fpFg8OXqHHr5ZUzkK1XxyJyiWCmyb/BKEtIMTTf0er7LlSWB8J4HGSxys17t9+Qmk=
X-Received: by 2002:a81:830a:0:b0:60c:a4b7:139e with SMTP id
 t10-20020a81830a000000b0060ca4b7139emr13653ywf.16.1710369512263; Wed, 13 Mar
 2024 15:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220214558.3377482-1-souravpanda@google.com>
 <20240220214558.3377482-2-souravpanda@google.com> <CAAPL-u-0RekH-ptg9U2pzPJxCAR+jMTxKTZU49LR_isjNkSPWg@mail.gmail.com>
In-Reply-To: <CAAPL-u-0RekH-ptg9U2pzPJxCAR+jMTxKTZU49LR_isjNkSPWg@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 13 Mar 2024 18:37:55 -0400
Message-ID: <CA+CK2bAqdFL-kGmTR8msdy_FSr4Zt7+riJgjdTxX+FN+-M0pLA@mail.gmail.com>
Subject: Re: [PATCH v9 1/1] mm: report per-page metadata information
To: Wei Xu <weixugc@google.com>
Cc: Sourav Panda <souravpanda@google.com>, corbet@lwn.net, gregkh@linuxfoundation.org, 
	rafael@kernel.org, akpm@linux-foundation.org, mike.kravetz@oracle.com, 
	muchun.song@linux.dev, rppt@kernel.org, david@redhat.com, 
	rdunlap@infradead.org, chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, 
	tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com, 
	yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com, 
	kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com, 
	adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 1:12=E2=80=AFPM Wei Xu <weixugc@google.com> wrote:
>
> On Tue, Feb 20, 2024 at 1:46=E2=80=AFPM Sourav Panda <souravpanda@google.=
com> wrote:
> >
> > Adds two new per-node fields, namely nr_memmap and nr_memmap_boot,
> > to /sys/devices/system/node/nodeN/vmstat and a global Memmap field
> > to /proc/meminfo. This information can be used by users to see how
> > much memory is being used by per-page metadata, which can vary
> > depending on build configuration, machine architecture, and system
> > use.
>
> /proc/vmstat also has the system-wide nr_memmap and nr_memmap_boot.
> Given that nr_memmap in /proc/vmstat provides the same info (in
> different units) as Memmap in /proc/meminfo, it would be better to
> remove Memmap from /proc/meminfo to avoid duplication and confusion.

There are many items both in meminfo and in vmstat. Given that
/proc/meminfo covers all kmem memory, it is beneficial to keep the
kmem part of memmap in meminfo as another classification item.

Pasha

