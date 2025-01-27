Return-Path: <linux-fsdevel+bounces-40146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F11A1D949
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 16:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5D13A81B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 15:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F41A165F01;
	Mon, 27 Jan 2025 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQYX/YYG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EFE13CA81;
	Mon, 27 Jan 2025 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990878; cv=none; b=PngE0+OPqFujXhoZjyRH3HFRUQn2rUS2ILreYvAdPH86s0XcqJOT5M5zZTcMoyzQI7QIJZAwnRKYaWzDxYEnf05691uIqJeXrxHEcLMn09FgY1kAevfi9wnZ4aUHAJLOGH/pvoxAEAyjAPr/YNpGWl6UZPv3lJYWrr8GLcHu4Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990878; c=relaxed/simple;
	bh=VpiVbnqCOrmY5SGmdXwaKYWHrqAFlTK+vn/3gB4wpMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krM0XAQHswFsnMxWZw797y3T7K/p3NEDa7+dlaJAo6+jq1K4VTAYsdC8XjxLkAdIvnf9FZ+aOZlP9a285wNDa6tDIphd6o/lc8+iiwIgWiQ3xyDQ/GfnKaDQXEggPS3VJrprpf22D+/S7X4XE7IFriu4OSjEoEK64btpZle1BGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQYX/YYG; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ee8e8e29f6so6028832a91.0;
        Mon, 27 Jan 2025 07:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737990877; x=1738595677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wblQpx+6gffsbQIq400BrdsSaygTfoWvxOhkC4R2KVE=;
        b=CQYX/YYGlYc349nUhJS1wDnAp7U79d/CdqYauF4hwqgws+HhlgP9ixIMQ8cmAz5v9K
         oKUf48aR78L+LWO1RtYAlRpFmc626Owwlp9Bq0QojCCT9aLozkvwHI7pQiAgUBcah56p
         sxKh0Xj2pYyV37V920WnnBQD5MBSBdxx/hyfmHNOYvYnOcrLNwKjKtDQoq5Guc380g3N
         Ky/xHKdTfBQ0qYOcG9jaUjo51BB2MCuJGf8HMxD0eYrdJ9DVfZVDOKWFzFmfPd98jqpb
         sYeQHPkLTqcGCJroLaX9JARTInlclRfxmPcqDrhU9Ma7qxBbz+ODieRU9J5L8CpxYEbu
         E7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737990877; x=1738595677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wblQpx+6gffsbQIq400BrdsSaygTfoWvxOhkC4R2KVE=;
        b=EVYbud7VkOHOaD3xQtySj089AeSD4ll9NQBgHbg4CSbOqgRVW/uioZDha62v10R9Sy
         7NwZPhmV2qSXag01nvKh3xTG273ZbVUs6QUgYgIPpE1jj/VF9ED/vHy9zdWyYAjBzWPN
         lFuqzBr3kY3JZnfc9BvU1D5wKKFNIaGkFFFlRZuqLGOK5tjFCsNsglNeG/VtlIM0XVWW
         SO9kUHqSVbbbPW9bCxdk/MNNJVS6gEPcOGL9CMFX/ovRMoKfNVfSHTdO1/p3uRIkKwnO
         pJnQoCeSpx0jqvHWePpUmbyNqt7jY6dnmYDGDehx+TwdkZZVbRUFcLfdNYjQhitbAvpX
         rDEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmmlACq4Ex4Vn6Dfo0DV8Cva26ELWPUaks1X1QX5rX+qYNcMq3ZiHrP+ibrdRuXxGNrSF3MQzjJwyLHsuYqg==@vger.kernel.org, AJvYcCWa6bQhTq9kQtxiq3RT9s0SUpAvvjAEiNxAVyPlNo6LxKeZnJSSJ/6D5spttEdQwfZXgRbH+mccOzmI@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi5Roq3M/6zTcHrCINVsq8WOuwz/KJs464tNb/x6p9bHuxQj3q
	R0xb9P9rdr93bgRtAvF5pu5HZQ+2AGepBGlt55/jGUtlDKTkkw+9sPjcwQOaEC0PG7RMFts3lMI
	rCwocONcpIAR5VwsviP9Z2f/nsCU=
X-Gm-Gg: ASbGncuwwqZEJymZgHxqhebndxaPVsWUjfm8IxgMc7dl3gF+hO/lrlJT4JCZWhDkD7c
	04aLGcY2xPxtt4NVc2QfPqCOpG7mEkwaOHRFmVdr5CULM6bEANxhl0Nsay07SlAkKseq+LKWQ
X-Google-Smtp-Source: AGHT+IGIYyCARvHHsfi1J8eavFeyhi7AzrtICHwY7kYCRUMbKR28JO0C0SQ0E60YxTVi0c1hFfx9eb5KZanEOjk/jZQ=
X-Received: by 2002:a17:90a:d00b:b0:2ee:a4f2:b311 with SMTP id
 98e67ed59e1d1-2f782c907ffmr58799523a91.8.1737990876522; Mon, 27 Jan 2025
 07:14:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124194623.19699-1-slava@dubeyko.com> <CA+2bHPbkATtMp_BgX=ySuPZkMSqd5EwjoRdsAsoOOxuoN3wzTw@mail.gmail.com>
In-Reply-To: <CA+2bHPbkATtMp_BgX=ySuPZkMSqd5EwjoRdsAsoOOxuoN3wzTw@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 27 Jan 2025 16:14:24 +0100
X-Gm-Features: AWEUYZnoZBGM4f_u-5-f5T3tgI-x62QjVA1JmrZiVXOvXF7O4E8Z4SUEl88Gr1E
Message-ID: <CAOi1vP8B9Js4ZwG++TJnRfmsnCFW2qftFKqL0gG+LUYZNjQJGQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: exchange hardcoded value on NAME_MAX
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, amarkuze@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 9:51=E2=80=AFPM Patrick Donnelly <pdonnell@redhat.c=
om> wrote:
>
> On Fri, Jan 24, 2025 at 2:46=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko=
.com> wrote:
> >
> > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> >
> > Initially, ceph_fs_debugfs_init() had temporary
> > name buffer with hardcoded length of 80 symbols.
> > Then, it was hardcoded again for 100 symbols.
> > Finally, it makes sense to exchange hardcoded
> > value on properly defined constant and 255 symbols
> > should be enough for any name case.
> >
> > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > ---
> >  fs/ceph/debugfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> > index fdf9dc15eafa..fdd404fc8112 100644
> > --- a/fs/ceph/debugfs.c
> > +++ b/fs/ceph/debugfs.c
> > @@ -412,7 +412,7 @@ void ceph_fs_debugfs_cleanup(struct ceph_fs_client =
*fsc)
> >
> >  void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
> >  {
> > -       char name[100];
> > +       char name[NAME_MAX];
> >
> >         doutc(fsc->client, "begin\n");
> >         fsc->debugfs_congestion_kb =3D
> > --
> > 2.48.0
> >
> >
>
> Reviewed-by: Patrick Donnelly <pdonnell@ibm.com>

Applied.

Thanks,

                Ilya

