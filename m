Return-Path: <linux-fsdevel+bounces-60131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B45FB41885
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 10:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EED41A80BF2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 08:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E528D2ECE87;
	Wed,  3 Sep 2025 08:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EhYOLid+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5F72ECD12
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 08:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888133; cv=none; b=ahLZbDPH8339MtFY0qjTd/d8iUa2H5yldPM7m1L1hxk6AybsxnSQqtz5SdB75xBl9RESfd6MRDk17GlCwdKe8dJE4NwBobf1Hka5vcYZtmaR3GnQXUdX8gnNpo350V1NmhtcRI+wHD9J/OZCg8eP/wWuoJj7GXyeNpYjQIJjMd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888133; c=relaxed/simple;
	bh=AY+7ko2gNvuN0XuehA6wPYfLN3DvbUbDT9bIC2ND47c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMy3vPXMKdhf3j0Pa60/bimEcB5LGXWOQmKi7QaKChrJMX7iuzQV2+8cArmmevyyky5zELdOUSJ4/ueFIRve7VOn/zGzHDyRFLvtF+vg/Rzcu/Zw4UtvyE7PjCpIMWMuZd5mJRg8ihXSwyT8jT00mNbq5jveqq1FAyY709asgbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EhYOLid+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756888130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AY+7ko2gNvuN0XuehA6wPYfLN3DvbUbDT9bIC2ND47c=;
	b=EhYOLid+EPWJKqvKC82/03tVwUngXRjvK4NaIHKXV6C/1d4SeV6UHO09gqilIboVxeoc/b
	VzheOeRVmbwFd/rNOAdbIq09C76c+NfJrkt8B18TaRn/nQ2q1GKOxZbAL91o9/6KtgydUO
	TT9MPQtkBCLz20avXhqtTbOd0n5cUxA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-1B6k5z6yNwmMvvAUxduXQw-1; Wed, 03 Sep 2025 04:28:49 -0400
X-MC-Unique: 1B6k5z6yNwmMvvAUxduXQw-1
X-Mimecast-MFC-AGG-ID: 1B6k5z6yNwmMvvAUxduXQw_1756888128
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-71d603c7e05so88093127b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 01:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756888128; x=1757492928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AY+7ko2gNvuN0XuehA6wPYfLN3DvbUbDT9bIC2ND47c=;
        b=l0KKtL5lbGwLIU/yvrdCKzqBrByuZt8IPkUzytVpq8Jw+GlvrLnL9g0RVCGB9cAoTQ
         MLQL8NfnqvJblUHrRYtgDvSJxpEIyuqAu30udTLw9aw7Xu0kqjXr990xP7wGNvVsUUzW
         Q2hj0vRtPEb2Me7xFAEAp748tCBsn5QAvNMjXzNiojXi5GCeTtpGYZRPUr0DgPOWOmA6
         uv6DPCH8tKWqesnJQswZIa+aZGz9M3gy3Cy5hDhO5a3AfsVuz6uWtVLzvfra+RkOB3aw
         G7r6THBO8JX8kJzysxJxnmyMi4dX13r+evaRkgBffKCW4GjV+VBrWI9xomwTwTe5rW0m
         UJZg==
X-Forwarded-Encrypted: i=1; AJvYcCUEco6RXlETjaYpcNs9vuKtGr0HsUzsVH7TCLSnO8Lrn/bDhdob9/GMbKH3QI/2e4y+yMRbDQpP4bEm94+4@vger.kernel.org
X-Gm-Message-State: AOJu0YyfwWpGfW4A0UaASPQkV/wJSLxNOl6MP/ttIHiAyxk+Wm+QMPAJ
	v868PYqLjRPPpcNsIHdh7EbxDhnhtkOfK/sdSd3KnjojXl7D+6loLoZvj227h+6ZWYrtPYvcFKL
	mNEU4fvtFs2H/NzV34vbVmXaxWUli7Qzj2ygdyJVJ+4OVBLkCuKl6L1oiY9jwFIFWQSRdhCs956
	lN86e51YUwV6sbu0CNY4PS2p2DtA/KYsWiOYj+w3/L5g==
X-Gm-Gg: ASbGnct32aEubd601kQoWBeIu/D7l/DcDKYspd6DzSHTJkJtbtQf4ymwuD7NUMOa0sl
	oWtXFzSmdQ24kpxvPfozTVx7sh8Nq1aINmeS17YZ08FbL/+1MJEplIzaOVJQiUJ1npnStypmOvK
	wd1l5viLFzBMLyDp1kUVsrB1g=
X-Received: by 2002:a05:690c:7244:b0:71f:e538:9d3b with SMTP id 00721157ae682-722764eff7fmr166457637b3.26.1756888128558;
        Wed, 03 Sep 2025 01:28:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuYG1aLTZAojkV67Ys8INIr4fhAsoDsqd/5OIuV3VuDUxLodstA7ei+5D3jLjj9I8dZDMccgIc3EmQHN35EXA=
X-Received: by 2002:a05:690c:7244:b0:71f:e538:9d3b with SMTP id
 00721157ae682-722764eff7fmr166457477b3.26.1756888128234; Wed, 03 Sep 2025
 01:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <345d49d2-5b6b-4307-824b-5167db737ad2@redhat.com>
 <20250902095250.1319807-1-nogikh@google.com> <20250902154043.7214448ff3a9cb68c8d231d5@linux-foundation.org>
 <20250903090934.4b5479d8@canb.auug.org.au>
In-Reply-To: <20250903090934.4b5479d8@canb.auug.org.au>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Wed, 3 Sep 2025 10:28:37 +0200
X-Gm-Features: Ac12FXwfp66OxV2wPvU3kcSifrwN6wBBZVCwf5GBxB_zYjlveqlVWbBCkVqp5nA
Message-ID: <CAOssrKe7CzU3295uZa5OTyfGM4PObvFTL2rm2LBCKSf0LDTtgg@mail.gmail.com>
Subject: Re: [PATCH] mm: fix lockdep issues in writeback handling
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, Aleksandr Nogikh <nogikh@google.com>, david@redhat.com, 
	joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, m.szyprowski@samsung.com, 
	willy@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 1:16=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
>
> Hi Andrew,
>
> On Tue, 2 Sep 2025 15:40:43 -0700 Andrew Morton <akpm@linux-foundation.or=
g> wrote:
> >
> > Perhaps Stephen can directly add it to linux-next for a while?
>
> I will add it to linux-next from today (until Miklos sorts it out).
> Note that the fuse tree was updated since yesterday's linux-next, but
> this patch is still not included.

Sorry, I just didn't realize this was fixing a patch in my tree.

Added now.

Thanks,
Miklos


