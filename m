Return-Path: <linux-fsdevel+bounces-50603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862B1ACDAE4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 11:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB3616B16C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 09:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7CA28C849;
	Wed,  4 Jun 2025 09:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGyY7i9k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D437B26156F;
	Wed,  4 Jun 2025 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749028969; cv=none; b=sz1Cu5GIP2D+7Vkx2Apdy2pDGY7M7rYKI8NGTME9ac2MAjtRbCDqbAZR+UtFAlOOLRepcIXOdmq3eujbMhK+greST8Wmd+4d2oaQJOqVDgrSA1aJ6Zo1VmT+gWCtw5wyOmN4XExRwStlAIoYa/Ad/RyyqutBTgt/tzMEQ2m+KdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749028969; c=relaxed/simple;
	bh=A+Hb+IYZVbIrHhgOikz8cYlE64YeroKilPbQiRKqru4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSOhWiZv8ckkmt2dd5mAh81ein+UxSJvnbNVbuCVYBkohP40KyGlUa3tK3mUAT1PN4+M12jLzhU066uWC4gj6ausu8fR77bXzi41rIYx9+G9wZHEQ7yTkccpu9xm6bOrCfRhc/b6lq1Y3w4QsBFBjwO+B4JpWZIi3hDlB2JkmTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGyY7i9k; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad89333d603so1249030466b.2;
        Wed, 04 Jun 2025 02:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749028966; x=1749633766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxD+BS5BNW9JlEJcYvio44SXpqyv8Wmatgad1UAi7lM=;
        b=WGyY7i9kyt34dfZ26K5bRH2uPAk3d8i14krVC3MeyB7qmiGIPnsbzO9AFs+zxqjpSh
         OwpwwNmi7fKW2hrM3vFA7JFm/knSas9JWjINjDMW9m6bSZHwJaFENWntQcEhfT46jDKG
         ZGE4AAztKgsrjCX7/w3lw/dalngGRREGyhPY07MhxGZjRvmoqcBHrE3e5lZOgW4xbzOO
         tQH4zoIiQGTs1OYCuShfafmxmyg2SJbvLsfFIeeL/593LbYf4FVkV3EQbhpaBdXPv1l2
         +AJQeP5e8hReLNk9qf1105owScYLx1Sb5IUPszir83Uc+VrKrgm6Wq4focg9I8AIKxnQ
         YhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749028966; x=1749633766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxD+BS5BNW9JlEJcYvio44SXpqyv8Wmatgad1UAi7lM=;
        b=qJ8kYYkdiu/6DlNnGVW+kFhBI45M6ayGmf7gzfOX3g9gGqUODH6A2FDZV499IOvpVZ
         zUaKI9ESA66+AG9cCRfLKUG3/Unh6iiO9Qwmeg+UVTBa6jfJv0GtdV7kiGuNUq7BDFbb
         b77G0/V7Pb6Zwe5utkNJ1p8Dugru33owvfHoNO7J4e0f+1//HWZv7/tLiIYaOPhHB6wK
         8ty1FTAFmgMj/XvNPx10yUQAhE6wQrccfBHLqjpKEOX+uvGZTJN/KatrhGS6qGJANAaF
         fpo9yvxkEF3ET2e/CDXvuqtlJ2KrrskBxDh1bq45S8Wp5Ksc6o5bCOqUjIFWzv5VUCBb
         efJA==
X-Forwarded-Encrypted: i=1; AJvYcCUhEpCFPqfLcbXoyBbezGlFh+E5/vigFqEImROKr7621SJ6tmZ3oqGZ4q9+5BnQVWMThI0wtDZXF1Kw@vger.kernel.org, AJvYcCXsVIN7d6KJaJW4TMTTdirKlfyCFi3qBFdP+aWFFxzAfgNn05Tb3FstO+rwoLccj7aAUoOcvQQykFagsPZy@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7mkNMYEybWeqjxY3lZAdJvciH593Jt7rxlMcWz3OXS0SkSaCP
	IGnrH6fkKdjgk+XjES67RvBakpP2q/CvDw0fqsLEL6XxFd4C/hii/v9iyYGaL9WYyA32kF2jBT0
	ItpMLPLbgoTpZmuoP9oUu68UlYS49DdQ=
X-Gm-Gg: ASbGncvrZ9phtoSGARd6UclFnUS6wXFrrGO1pBjow+Xv59vnE7ZBc/L6GFFHDTossWn
	2EgxCpL72C//JpjtzigSvrlEAWzfEDxpmaH9/DDOOPy1c0pi6JDdxnrA2m91/Nt3oGQ7RjeSItU
	zMqJiAvXGsNf7P3wAyid4H2AJqUULE+/UE25D7cf+lD4Rjt6pDJYHxdYGkiWMtjjI0ft94fc5UD
	ilj
X-Google-Smtp-Source: AGHT+IFtmWSVIfRymSX8p9O1DuQ9uGU3imVuqryH0lzpbx4dWpXx940NayRL5XU/iX+3A15SSf0ibjMq2HLSlqBsVEw=
X-Received: by 2002:a17:906:a995:b0:add:fa4e:8a61 with SMTP id
 a640c23a62f3a-addfa4e8f2bmr123364566b.38.1749028965818; Wed, 04 Jun 2025
 02:22:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250529113215epcas5p2edd67e7b129621f386be005fdba53378@epcas5p2.samsung.com>
 <20250529111504.89912-1-kundan.kumar@samsung.com> <20250602141904.GA21996@lst.de>
 <c029d791-20ca-4f2e-926d-91856ba9d515@samsung.com> <20250603132434.GA10865@lst.de>
 <CACzX3AuBVsdEUy09W+L+xRAGLsUD0S9+J2AO8nSguA2nX5d8GQ@mail.gmail.com>
In-Reply-To: <CACzX3AuBVsdEUy09W+L+xRAGLsUD0S9+J2AO8nSguA2nX5d8GQ@mail.gmail.com>
From: Kundan Kumar <kundanthebest@gmail.com>
Date: Wed, 4 Jun 2025 14:52:34 +0530
X-Gm-Features: AX0GCFsIp4hEknwUTt7cvxyvZfmfYSDQ8XVwMfEKcuya3JVRf5uqzsLfTt2zwvo
Message-ID: <CALYkqXqVRYqq+5_5W4Sdeh07M8DyEYLvrsm3yqhhCQTY0pvU1g@mail.gmail.com>
Subject: Re: [PATCH 00/13] Parallelizing filesystem writeback
To: Anuj gupta <anuj1072538@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, "Anuj Gupta/Anuj Gupta" <anuj20.g@samsung.com>, 
	Kundan Kumar <kundan.kumar@samsung.com>, jaegeuk@kernel.org, chao@kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, 
	agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org, 
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org, 
	clm@meta.com, david@fromorbit.com, amir73il@gmail.com, axboe@kernel.dk, 
	ritesh.list@gmail.com, djwong@kernel.org, dave@stgolabs.net, 
	p.raghav@samsung.com, da.gomez@samsung.com, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
	gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > > For xfs used this command:
> > > xfs_io -c "stat" /mnt/testfile
> > > And for ext4 used this:
> > > filefrag /mnt/testfile
> >
> > filefrag merges contiguous extents, and only counts up for discontiguou=
s
> > mappings, while fsxattr.nextents counts all extent even if they are
> > contiguous.  So you probably want to use filefrag for both cases.
>
> Got it =E2=80=94 thanks for the clarification. We'll switch to using file=
frag
> and will share updated extent count numbers accordingly.

Using filefrag, we recorded extent counts on xfs and ext4 at three
stages:
a. Just after a 1G random write,
b. After a 30-second wait,
c. After unmounting and remounting the filesystem,

xfs
Base
a. 6251   b. 2526  c. 2526
Parallel writeback
a. 6183   b. 2326  c. 2326

ext4
Base
a. 7080   b. 7080    c. 11
Parallel writeback
a. 5961   b. 5961    c. 11

Used the same fio commandline as earlier:
fio --filename=3D/mnt/testfile --name=3Dtest --bs=3D4k --iodepth=3D1024
--rw=3Drandwrite --ioengine=3Dio_uring  --fallocate=3Dnone --numjobs=3D1
--size=3D1G --direct=3D0 --eta-interval=3D1 --eta-newline=3D1
--group_reporting

filefrag command:
filefrag  /mnt/testfile

