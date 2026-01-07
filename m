Return-Path: <linux-fsdevel+bounces-72691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 670BCD00617
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 00:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A8AC300FFB3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 23:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2D32EA473;
	Wed,  7 Jan 2026 23:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLHpiCmM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786AD2609E3
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 23:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767828063; cv=none; b=tyBVsXrx5CuDnMedUJdxewyU1wInfv7/HYbqDGPn5R88F+TpQt/ou+QgT0Dm8ODdXowZgbP7srZZyipUNB2XyfNwWHSaVdqU0oGkYifm00tFEgfn5/4aPe57+MDsZ+99NNYfzSKWMmsLHweEjsvIHh0cScaUeL3azZk3utQQ+Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767828063; c=relaxed/simple;
	bh=+IiIYk6tyq8dn+kFWd93D1ClEiKTPKlKcVrqsM5QbR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nELZM6dZYxZ2/QsOaXGxVXqJtCJ3mMXB3Ts1WlxR+GuI2YOGIl0keFSd/pV+aR8XTQfGr2iH5K0kCt0FpFibSt1gAQgbRHlSWBgfe+m399JDXEUXqVFOBefEMBvXNx3lnNK3rcWrPSmd17bSzID0F4xKnjaEUpR2tKvlkV4zQhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLHpiCmM; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4eda6a8cc12so28076401cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 15:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767828059; x=1768432859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCrjzEZQwv01G+U0WIfJQs+VO9PryBUCb3CgwRj0lP0=;
        b=PLHpiCmMD6n85Yj0HEKJuT7fWVqqEfnp0pqwBnJCS3F/EdmGfjdcPv3AxeqgppxXPx
         Qb43t8sSmr5xtt/K4UJmgAJMbkb5qBvvhdj1ImLDxs2qRnRJ4p7bnwqmg9AXiysx9qIR
         yXsPK3yd71Q3Bkkergyd6dS9eKkHCi6gWD4xHO+LULNHOzp3+ksok8vWqg7/8njbNDjX
         TmYURQCDCQn1m0MO/KOF1VKpS1PMGt9foJcIkJsad26LLC7/zLrTlofQ/feeah7J0fpd
         R/jBgBXnS/LEbFO3G+3+S1Ok6jJ8hT7sLAzjZTQyYyu7OLB5CxnULF/o5Ig1CYIe3ghi
         SiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767828059; x=1768432859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dCrjzEZQwv01G+U0WIfJQs+VO9PryBUCb3CgwRj0lP0=;
        b=U5hesFinDzll8G+7uw0i3ESVgrliYA16+yLDT7YSzU+vAO5NZB6dW+8jDWtogTZ3mx
         DLNZpAKyC8vOzRFC9QMGd8P/b//gQWo8XScg9n7I9hFJcI3Iy+CiREThP++ypUcdQzHl
         Sy7nI5dxiPCI/UV9rCtAQJss1Y0Y5AZKoBmQWPBdO2W4U+vwJ3EeAty8BHvLUCzF9m7C
         a6xXBALBNE3VPHLNwqF1mXhSqQNAhORMn3uYINDNCLfbzcLzMTZzSlgrwYyECz4mkHhM
         XNMR2Pw8RhRRQAMIh7pcHiujgNxU36w9XamkbQmUAmNXlwrvV8TIE6NCK52bwPuQzXmJ
         cDiA==
X-Forwarded-Encrypted: i=1; AJvYcCUsAQ+fwNy5E/rcZ15tmuqucB6o+c5h6yfYR8KzUsA2Cz8/XWBjxtQfetkoZrjWfO8FtBnJbvS6D6HpevY4@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrf79RpGIslmBiLRF3PRuQP64dk2p19VSTDB6yjtY7+n4jlPEy
	WaLGVxtcERM9QNDAjiXinst8auBoEx1jTpqhnHvDv5leVmTFGxAAJXl5Z0zTheIV5jIhlGVrRrU
	99Y/msVNHngg+gH206LzDT8J36FG6CGRbZrTClO8=
X-Gm-Gg: AY/fxX6mDuK4hqLVJ1UvoMlIyfQT3wihVfsbWxugMVkZHBaml77c4fAcJuHTA7YxKDo
	AbmxKaeo4MZ73RMzpWQ88wr2bylugfm2B4JEQcA2g2xGTjf69uAM7bUqYieT1NvBaSYtUWx8fzo
	bQhwxhTf3UqLHV+hL3xkEu1pLcHqgKz7wQ+cY2o8EcE9+ypsSJBecXQorGJ+jZyQJccagRz5UE6
	Z8sNioDDlyINoKMCEAOSlTvMM9ZX0BIccOyrdp6OwHlDrPr3b9S/6nVlcGYVC74es2Jhg==
X-Google-Smtp-Source: AGHT+IEiFeqiqTBVau2o0UwF1CseRs5J2I2K15YUqe72E1rmIA/k0t28m+0gQwUsMjLpxytNmWX8UDtYFxSJ2+hi2Ac=
X-Received: by 2002:a05:622a:64a:b0:4ee:1f5b:73bc with SMTP id
 d75a77b69052e-4ffb4a76ceemr59244041cf.66.1767828059316; Wed, 07 Jan 2026
 15:20:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215030043.1431306-1-joannelkoong@gmail.com>
 <20251215030043.1431306-2-joannelkoong@gmail.com> <ypyumqgv5p7dnxmq34q33keb6kzqnp66r33gtbm4pglgdmhma6@3oleltql2qgp>
 <CAJnrk1aYpcDpm8MpN5Emb8qNOn34-qEiARLH0RudySKFtEZVpA@mail.gmail.com> <ucnvcqbmxsiszobzzkjrgekle2nabf3w5omnfbitmotgujas4e@4f5ct4ot4mup>
In-Reply-To: <ucnvcqbmxsiszobzzkjrgekle2nabf3w5omnfbitmotgujas4e@4f5ct4ot4mup>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 7 Jan 2026 15:20:48 -0800
X-Gm-Features: AQt7F2rD2bYE74fC-BJPB9hchw_T0Hhn5OrF8uZDPNCgSz0wuN8d7B-9zslHZs4
Message-ID: <CAJnrk1b-77uK2JuQaHz8KUCBnZfnQZ6M_nQQqFNWLvPDDdy4+Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
 in wait_sb_inodes()
To: Jan Kara <jack@suse.cz>
Cc: akpm@linux-foundation.org, david@redhat.com, miklos@szeredi.hu, 
	linux-mm@kvack.org, athul.krishna.kr@protonmail.com, j.neuschaefer@gmx.net, 
	carnil@debian.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 2:12=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 06-01-26 15:30:05, Joanne Koong wrote:
> > On Tue, Jan 6, 2026 at 1:34=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> > > [Thanks to Andrew for CCing me on patch commit]
> >
> > Sorry, I didn't mean to exclude you. I hadn't realized the
> > fs-writeback.c file had maintainers/reviewers listed for it. I'll make
> > sure to cc you next time.
>
> No problem, I don't think it's formally spelled out anywhere. It's just
> that for changes in fs/*.c people tend to CC VFS maintainers / reviewers.
>
> Thanks for the historical perspective, it does put some more peace into m=
y
> mind that things were considered :)
>
> > For the fsync() and truncate() examples you mentioned, I don't think
> > it's an issue that these now wait for the server to finish the I/O and
> > hang if the server doesn't. I think it's actually more correct
> > behavior than what we had with temp pages, eg imo these actually ought
> > to wait for the writeback to have been completed by the server. If the
> > server is malicious / buggy and fsync/truncate hangs, I think that's
> > fine given that fsync/truncate is initiated by the user on a specific
> > file descriptor (as opposed to the generic sync()) (and imo it should
> > hang if it can't actually be executed correctly because the server is
> > malfunctioning).
>
> Here, I have a comment. The hang in truncate is not as innocent as you
> might think. It will happen in truncate_inode_pages() and as such it will
> also end up hanging inode reclaim. Thus kswapd (or other arbitrary proces=
s
> entering direct reclaim) may hang in inode reclaim waiting for
> truncate_inode_pages() to finish. And at that point you are between a roc=
k
> and a hard place - truncate_inode_pages() cannot fail because the inode i=
s
> at the point of no return. You cannot just detach the folio under writeba=
ck
> from the mapping because if the writeback ever completes, the IO end
> handlers will get seriously confused - at least in the generic case, mayb=
e
> specifically for FUSE there would be some solution possible - like a
> special handler in fuse_evict_inode() walking all the pages under writeba=
ck
> and tearing them down in a clean way (properly synchronizing with IO
> completion) before truncate_inode_pages() is called.

Hmm... I looked into this path a bit when I was investigating a
deadlock that was unrelated to this. The ->evict_inode() callback gets
invoked only if the ref count on an inode has dropped to zero. In
fuse, in the .release() callback (fuse_release()), if writeback
caching is enabled, write_inode_now() is called on the inode with
sync=3D1 (WB_SYNC_ALL). This does synchronous writeback and returns (and
drops the inode ref) only after all the dirty pages have been written
out. When ->evict_inode() -> fuse_evict_inode() is called, I don't
think there can be any lingering dirty pages to write out in
trunate_inode_pages().

Thanks,
Joanne

>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

