Return-Path: <linux-fsdevel+bounces-34124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D27F9C28C3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 01:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977801C21342
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 00:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E9453A7;
	Sat,  9 Nov 2024 00:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWyWtIP8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960FA81E
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Nov 2024 00:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731111746; cv=none; b=YGvFsynoOp/PwC3m1VlOPUCctt8BgGZ3UOxr4Et289bZ1K2r9O0K1f77PG0TO+Rz1xn1Hd2lKbBoUDpBrAocsSlz9UnXGJZ59NWRwEnwaaqnH/XHf2hNPjq2kjOEQGc8r9yl26yrsCVnTZsv8B4D00zwBLOBcpZ5EF6hf+Psjfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731111746; c=relaxed/simple;
	bh=wjRNSCxtkGJZXlCWeOBAsLyJsahGorDXrNpC9RkKHl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpVZgXMRmFZShNqnVX+S7TFqvVac/GptQPC9CrRDHN3Q/0ofr5XePUD3n2MukaNqyBxlP2J0XZL6IB+N7CcDkuoJFpQA/uaHKX7HbzVRMq/AkVbOFTqNTrIFTQHpgf6Ma2cG5jk+P+yysc2UN/PPyCjzx/cyPnxFF3m5qrrCYQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWyWtIP8; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b155cca097so232411085a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 16:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731111743; x=1731716543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBd+oAh5dNaRfRGbRZeXnaegt8mnkVkCHw4kgzh4lsI=;
        b=CWyWtIP8kcpN1zmAHu/848Vt3NMPxltUlj15F1vvhT0zJLcspoQg1WWEHogmK43Slb
         1MkV6wtzNUbXzyoWEf7H1rT/EC56Yz9Iv72XhaQngVqi9fOMtX+2rSsauwulOx5UUyWA
         SYTUwLzqeUr+yo0Ehf1b5yH5nyberIXw7qm/kPhQvJV4lyC7QQCE1PNo7MrDNyOKBRvu
         yB83q4a9/lh1yPZjaWMJNcXQ268onbhqZa1bwS+JTc1v1BrNlXSE/MRrhlRoB6+V8vzs
         CQqSbEG0gDQXpBTbSTE9/6EbJ5uEcbqIIbHsrRGT/Y0ceOoOW9WpfOMdW9cKwYgE8HmH
         xPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731111743; x=1731716543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBd+oAh5dNaRfRGbRZeXnaegt8mnkVkCHw4kgzh4lsI=;
        b=pWY8QQXS0Lrvg1ZHcp5cKOnF3V6TegVQIRst3PtvhuyQplgBQcxNRxh+UHw8hYp3SZ
         EAStbdWKaUzIeOylpyMmoJWfGht0cIaaVlJP2CY1VMnym5PitTKQmrUU44pBOJjcRhcA
         Ned3rOSs8lSfVG/HLyWFYB70rkT4BkDPjt9Y0ybvC9o/TcfPErOZ1iX9tLn3BU3vaZaa
         TQiee1+ZEfPoEIKawz7trDxHwJkmBrRBAliHJBiGYIjtPv4WDWP/5TJw7O7sDYQpyy/4
         GFjgpVbz9mDL99vjINlofwWWfRaOmv8PzY9csN3LpAdOykmJcZ5H1+tJlZqfZ5CJ3sgM
         43Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXvVp2yLeY9Ux1xTjntqjCrfAoMPz88H7QY7qn30jJY5qrj6ZVNaZzKOcJxxzDERfCpkEVjWibEJYWJdVTk@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcl6CQkYCYP7P9lm59nBKrqGhmApPMHp2rTNfvt6KFMBlm+1Nc
	q2NKllEycQd9tKmoqYISKS3F/zl9z+PkHyDTqnQnThYfKqawPUE1YjPXrmSbOMc6kGkF286mBq8
	0G/nBlxb/IHaAYxNcGd7e7qQO1uX1BKDM
X-Google-Smtp-Source: AGHT+IEtG1hxPVbIqj3BTPexvZZpxB5v2yhTfu6L8w8AQHcYKAof0l3lMm37tklitxR435ipzFgsENrT4KO7SXqBLbc=
X-Received: by 2002:a05:620a:28ca:b0:7a9:abdf:f517 with SMTP id
 af79cd13be357-7b33192edfbmr956202885a.25.1731111743483; Fri, 08 Nov 2024
 16:22:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109001258.2216604-1-joannelkoong@gmail.com>
In-Reply-To: <20241109001258.2216604-1-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 8 Nov 2024 16:22:12 -0800
Message-ID: <CAJnrk1ZhK6kAvPzjnzZYFg7XyytBKR=6d4ED9=dTDVwuskosxg@mail.gmail.com>
Subject: Re: [PATCH 00/12] fuse: support large folios
To: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, bernd.schubert@fastmail.fm, 
	jefflexu@linux.alibaba.com, willy@infradead.org, shakeel.butt@linux.dev, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 4:13=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> This patchset adds support for folios larger than one page size in FUSE.
>
> This patchset is rebased on top of the (unmerged) patchset that removes t=
emp
> folios in writeback [1]. (There is also a version of this patchset that i=
s
> independent from that change, but that version has two additional patches
> needed to account for temp folios and temp folio copying, which may requi=
re
> some debate to get the API right for as these two patches add generic
> (non-FUSE) helpers. For simplicity's sake for now, I sent out this patchs=
et
> version rebased on top of the patchset that removes temp pages)
>
> This patchset was tested by running it through fstests on passthrough_hp.

Will be updating this thread with some fio benchmark results early next wee=
k.

>
> [1] https://lore.kernel.org/linux-fsdevel/20241107235614.3637221-1-joanne=
lkoong@gmail.com/
>
> Joanne Koong (12):
>   fuse: support copying large folios
>   fuse: support large folios for retrieves
>   fuse: refactor fuse_fill_write_pages()
>   fuse: support large folios for non-writeback writes
>   fuse: support large folios for folio reads
>   fuse: support large folios for symlinks
>   fuse: support large folios for stores
>   fuse: support large folios for queued writes
>   fuse: support large folios for readahead
>   fuse: support large folios for direct io
>   fuse: support large folios for writeback
>   fuse: enable large folios
>
>  fs/fuse/dev.c  | 131 +++++++++++++++++++++++-----------------------
>  fs/fuse/dir.c  |   8 +--
>  fs/fuse/file.c | 138 +++++++++++++++++++++++++++++++------------------
>  3 files changed, 159 insertions(+), 118 deletions(-)
>
> --
> 2.43.5
>

