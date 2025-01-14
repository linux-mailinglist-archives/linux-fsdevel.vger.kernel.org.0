Return-Path: <linux-fsdevel+bounces-39173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 951D9A110EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 20:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B1C1697DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 19:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0D51FBCBD;
	Tue, 14 Jan 2025 19:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcGKWn+U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7D01C1AAA
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 19:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736881976; cv=none; b=ShgBz5paSPFtr0eSe8SvQEO/s5Kt4nLUfRr8Dr8yEQ5IHfTIuBVDHUKlxodu5rRpgXBEGRoYL2Wy7EvwX+YLeRLjVh3MrHqaZK0RhxdHEsM9gR3sh9NYtl7jSAPzCuRfB+fKQMoM3cny2ZCYHKtOG26lC8+D1Q2LqmeKiCp7S3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736881976; c=relaxed/simple;
	bh=QjKyOEwaVxsSIYT8T13lx2+SXIWS+fCHgYiZTEobhcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sElCMaJfOIAVel1JBShG5iaLl5Ikyl3qFgtYeumdOVq9bo57lum8otoLns/QxIBxpO6alGFsE1PDgTvAP4KrY1yZ0NIdG99QokKRo/ejzW+inTJSSvl3k6ervLzx3M6LkO5cBwXv2mqC4wyPb3ke2NCWh3vaIwH3pM10ACUi0DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcGKWn+U; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4679d366adeso954381cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 11:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736881973; x=1737486773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mBS0wqI+0SGqangzQFwVg3w3sgRgLH5mRc/giHD7Bo=;
        b=WcGKWn+Ut0fds6UsiEQUxWHN3/yVmX8GxLonIzLlWlvjJDHmju/5Rsv9OthXiMwVBx
         OMgZIIRBRo1XjatxzYe6PDDH1aj2fYaCt7VP+gDO3z15y5NywNozRYWCkd53xXgnCbGO
         Or+mzuoWzQljBkXGIJVCmawUMpGiMg2J38VBZO5z39SoPwQWYFvlGGGqLaIeWOft7sm6
         PVA0xArqjUbM3vTwWLSpcqYKWOEq1JIgXGC3HFrWGJ37SAN0tVmdwLiuojqlBe+bIFP1
         V6P858+BPJL2SWjbjVNCeMaqAJdgeGHpq4doVQxGTEa3MvDB18/yTX98dpGqwr+XoHCZ
         jpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736881973; x=1737486773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mBS0wqI+0SGqangzQFwVg3w3sgRgLH5mRc/giHD7Bo=;
        b=odVXKtYihBts0OIUGovAzBzcmeynCORA/bhGIRO3Az5+XBkva88EaChe1TPgyESU1Y
         de/1Oixg+Y9KsBMG8u0+L4YOxwebYdOuZe9tdUBR6RqhWjYx6kVdiDbm+zb7I7h2po+8
         oze/AOUHHT0MUfuMDXUJzanfkR3OMWqBayic/dc33KRBsv/xldli/ZjzgRDcfIUXJdSl
         5eBH5odh3VNi4cl69hyKbGfu3a6IX8yM4amfgIsBRa4CQiHwd9G3bc041WnCooTjWkNi
         gjrV6lev1Zyd5+EyzzF7L1SjY1fgHJr6MuP+V2fnm5E9L08On8p3BCmLtxHbhzdOiidP
         TypA==
X-Forwarded-Encrypted: i=1; AJvYcCWUyTZSfb7NxA5HDYzdhGBRmZVD2IGgPLCX3EHLpP9RjQSIvJxiOPCUd/AB4pNZVl77hKPXXQ4aXNT0MAwg@vger.kernel.org
X-Gm-Message-State: AOJu0YxSF8EKU48pgiYkHEoB3CNor6j2zn2hXCRigobD1VMCWLJix3Qe
	G+0sddIuUhcEJ4vUSZtBTNpKm9zgS34upK2gh3RQlhHEilssEby42Ti7pq4YQG54girr2Akr8n4
	2krYb+H0oWT2FnyCC0t7dRWBbUa4=
X-Gm-Gg: ASbGncvQGBQwiqrre2m6LWmyAReYwjIvODdyOTpv+ZxsHm6iobk16NZKae4kLHAn3QI
	uysQvJjuoNbqsVAfpGn9SP1a+Qxdbp3bR15KW7cE=
X-Google-Smtp-Source: AGHT+IEsfYngC2BAm00C0vhfxNAqFwj4YJQhBle+uDFlA1uBjfHUWgl7UbH7TSTR79c69OT4TA0h0qs+2gMtHFWS/f4=
X-Received: by 2002:a05:622a:1483:b0:467:6563:8b1d with SMTP id
 d75a77b69052e-46df5671d1amr1888271cf.6.1736881973496; Tue, 14 Jan 2025
 11:12:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
 <CAJnrk1aPCCjbKm+Ay9dz3HezCFehKDfsDidgsRyAMzen8Dk=-w@mail.gmail.com>
 <c04b73a2-b33e-4306-afb9-0fab8655615b@redhat.com> <CAJfpegtzDvjrH75oXS-d3t+BdZegduVYY_4Apc4bBoRcMiO-PQ@mail.gmail.com>
 <gvgtvxjfxoyr4jqqtcpfuxnx3y6etbgxfhcee25gmoiagqyxkq@ejnt3gokkbjt>
 <791d4056-cac1-4477-a8e3-3a2392ed34db@redhat.com> <plvffraql4fq4i6xehw6aklzmdyw3wvhlhkveneajzq7sqzs6h@t7beg2xup2b4>
 <1fdc9d50-584c-45f4-9acd-3041d0b4b804@redhat.com> <54ebdef4205781d3351e4a38e5551046482dbba0.camel@kernel.org>
 <ccefea7b-88a5-4472-94cd-1e320bf90b44@redhat.com> <e3kipe2qcuuvyefnwpo4z5h4q5mwf2mmf6jy6g2whnceze3nsf@uid2mlj5qfog>
 <2848b566-3cae-4e89-916c-241508054402@redhat.com> <dfd5427e2b4434355dd75d5fbe2460a656aba94e.camel@kernel.org>
 <CAJfpegs_YMuyBGpSnNKo7bz8_s7cOwn2we+UwhUYBfjAqO4w+g@mail.gmail.com>
 <CAJfpeguSXf0tokOMjoOP-gnxoNHO33wTyiMXH5pQP8eqzj_R0g@mail.gmail.com>
 <060f4540-6790-4fe2-a4a5-f65693058ebf@fastmail.fm> <CAJfpegsrGX4oBHmRn_+8iwiMkJD_rcVEyPVH5tBAAByw4gSCQA@mail.gmail.com>
 <CAJnrk1ZP4yZZDR0fZghBmuN-N=JfrbJZALBH0pdaC5_gGWFwEw@mail.gmail.com> <CAJfpegvqZnMmgYcy28iDD_T=bFgeXgWD7ZZkpuJfXdBmjCK9hA@mail.gmail.com>
In-Reply-To: <CAJfpegvqZnMmgYcy28iDD_T=bFgeXgWD7ZZkpuJfXdBmjCK9hA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 14 Jan 2025 11:12:42 -0800
X-Gm-Features: AbW1kvYfIptYB80d0Obh6Tcvl_vocwIUR7F5ngQt6KtSP6gHy7FIJTyuSL5hIYI
Message-ID: <CAJnrk1Y14Xn8y2GLhGeVaistpX3ncTpkzSNBhDvN37v7YGSo4g@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Jeff Layton <jlayton@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Shakeel Butt <shakeel.butt@linux.dev>, Zi Yan <ziy@nvidia.com>, 
	linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com, 
	Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>, 
	Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 10:58=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Tue, 14 Jan 2025 at 19:08, Joanne Koong <joannelkoong@gmail.com> wrote=
:
>
> > - my understanding is that the majority of use cases do use splice (eg
> > iirc, libfuse does as well), in which case there's no point to this
> > patchset then
>
> If it turns out that non-splice writes are more performant, then
> libfuse can be fixed to use non-splice by default.   It's not as clear
> cut though, since write through (which is also the default in libfuse,
> AFAIK) should not be affected by all this, since that never used tmp
> pages.

My thinking was that spliced writes without tmp pages would be
fastest, then non-splice writes w/out tmp pages and spliced writes w/
would be roughly the same. But i'd need to benchmark and verify this
assumption.

>
> > - codewise, imo this gets messy (eg we would still need the rb tree
> > and would now need to check writeback against folio writeback state
> > and against the rb tree)
>
> I'm thinking of something slightly different: remove the current tmp
> page mess, but instead of duplicating a page ref on splice, fall back
> to copying the cache page (see the user_pages case in
> fuse_copy_page()).  This should have very similar performance to what
> we have today, but allows us to deal with page accesses the same way
> for both regular and splice I/O on /dev/fuse.

If we copy the cache page, do we not have the same issue with needing
an rb tree to track writeback state since writeback on the original
folio would be immediately cleared?


Thanks,
Joanne

>
> Thanks,
> Miklos

