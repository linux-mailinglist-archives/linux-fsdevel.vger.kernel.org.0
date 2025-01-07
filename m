Return-Path: <linux-fsdevel+bounces-38592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF08A045C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 17:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58691665AA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 16:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8D41F4714;
	Tue,  7 Jan 2025 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="UaSTDCiV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC361F03DB
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266559; cv=none; b=d4uPX5yDCUMt05kcx2rPwTyamJRVZuXDGcdK8c4bVPNsY/xmCv09m5Kjd1g+bXMJzkYBYTDHpU1ELnoigxkNFDCMrSb7KC9T4Keq7ME0KfuMpu6ItClIuKTr+LOJJWDYTvVTINQmBFXxn0g63mXf4H58KA+vUKQrrdrI3pvcwZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266559; c=relaxed/simple;
	bh=uhlwxdGLVevVWY0ddGH77zh9bUE9cf3TAGQVcSHsi8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5sOZdMeygb9o6xPBwmaJNC29ZFGNJauPEN//Laaw3KtDsvZyl5yhsQQpyUrlB5kQJxKv+OZn8aGBCiIaTlsVKrkRqkvL7FnUpqzEAdcpsLGKPCBfDNwYUDrLO22NhRRHrBRO1ABcLtk7SK5nhZeb3LDhpfZSfJjfW5bjFg0IDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=UaSTDCiV; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-467a3f1e667so92589461cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2025 08:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1736266553; x=1736871353; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w8HTQC2dY09JVji1mK3JWq1qA3dc8JRC619x9fLvkYo=;
        b=UaSTDCiV75+PuMB95vyzop7g7+mrrpIaoI4ytLTvk5phFqI+ZxwARoh91QoFV0sv33
         S5j2IlnRxWlTXdo5tONzic5XLQoR2QpfyjhrTndQGW8zxY60X8z6TaUSp0KilYri6/Tz
         bf4UTgIAjJrIf/j4kabVFDjpDcd5JiXJT8V9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736266553; x=1736871353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8HTQC2dY09JVji1mK3JWq1qA3dc8JRC619x9fLvkYo=;
        b=CJODHRiXyCDjit4DXVHGq4E3sJsXybYCiZ7O0rbDwEQF3loLX4ts/zAnK/XpxLxNTl
         Hvt/s3n/bDkG1folCYzgZ6fE+HMTFXQAOg5ZMTHA9HCyXmdV2ciUbOD2pkMFYUWO1hBW
         lRiMd2iZR52gJ6FdXvcSkuM+/XFW/4+NqhmyAMpQG5JFZs1Mc4KxsUYACeTHUk/3B/9Y
         v/iMM8hO6Hmxe0XJk6l2MWZBC2Iw0KdPSTbtS8uwtyDcWUqRNU7AT8rSwe9Nw596tg2L
         /1eagI4/CZJ3rGakmh7n51/W0r8Fy+mSjEFRqdPR6fbKmzTxRrMMDzsnETLyfE7qCFVJ
         BAOw==
X-Forwarded-Encrypted: i=1; AJvYcCXwWre+JsJKpU7x9ySsYad5R6L/db6fJgMpqE4wQaYEYyfugDkgBU4iAGqs0M5iQrZxAZQfTOYIRsP08Ix7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5oqrWCsn7ShTJgX9ovj2mZALEuKX8Yt8SAbFsGqCxuntElumV
	0H8UxOuLE6ppnrF4BNuf+BGjlK+E7du1J+qtckHxEnX422N0iTOq1Nj4xfNl8//6zTtoqFY6wVF
	zlrWhL8rfBkVmROZnRQbRoe1GMe7b7Cz2fS5H3A==
X-Gm-Gg: ASbGncvK+U/iJzuUjqqO7UqhVW9yHU3x481YzB+2WY1+43OTJu7C2oRgV6oC4JbyiIq
	p0TbO/ipBMDjQ3kgisAnKukH5z52+JKRKC315tw==
X-Google-Smtp-Source: AGHT+IGiwyO0VH+7z+OXe/zmO+Jj4kFyEAI533AFV+pb9IosvNedi4FrEvDQ7+OaefzrkOx0AwsXySXp5mVmtxJ/CIc=
X-Received: by 2002:a05:622a:1184:b0:466:b1b2:6f0d with SMTP id
 d75a77b69052e-46a4a98a262mr1004907511cf.36.1736266553449; Tue, 07 Jan 2025
 08:15:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <kyn5ji73biubd5fqbpycu4xsheqvomb3cu45ufw7u2paj5rmhr@bhnlclvuujcu>
 <c91b6836-fa30-44a9-bc15-afc829acaba9@redhat.com> <h3jbqkgaatads2732mzoyucjmin6rakzsvkjvdaw2xzjlieapc@k6r7xywaeozg>
 <0ed5241e-10af-43ee-baaf-87a5b4dc9694@redhat.com> <CAJnrk1ZYV3hXz_fdssk=tCWPzD_fpHyMW1L_+VRJtK8fFGD-1g@mail.gmail.com>
 <446704ab-434e-45ac-a062-45fef78815e4@redhat.com> <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
 <CAJnrk1aPCCjbKm+Ay9dz3HezCFehKDfsDidgsRyAMzen8Dk=-w@mail.gmail.com>
 <c04b73a2-b33e-4306-afb9-0fab8655615b@redhat.com> <CAJfpegtzDvjrH75oXS-d3t+BdZegduVYY_4Apc4bBoRcMiO-PQ@mail.gmail.com>
 <gvgtvxjfxoyr4jqqtcpfuxnx3y6etbgxfhcee25gmoiagqyxkq@ejnt3gokkbjt>
In-Reply-To: <gvgtvxjfxoyr4jqqtcpfuxnx3y6etbgxfhcee25gmoiagqyxkq@ejnt3gokkbjt>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 7 Jan 2025 17:15:42 +0100
X-Gm-Features: AbW1kvbpEUXzpI4gujIL0BzsqsO803aPdUPT5KniHw52BwvyoC2ZwLH6S3opfkI
Message-ID: <CAJfpegthP2enc9o1hV-izyAG9nHcD_tT8dKFxxzhdQws6pcyhQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: David Hildenbrand <david@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Bernd Schubert <bernd.schubert@fastmail.fm>, Zi Yan <ziy@nvidia.com>, 
	linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com, 
	Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>, 
	Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Jan 2025 at 19:17, Shakeel Butt <shakeel.butt@linux.dev> wrote:
>
> On Mon, Jan 06, 2025 at 11:19:42AM +0100, Miklos Szeredi wrote:
> > On Fri, 3 Jan 2025 at 21:31, David Hildenbrand <david@redhat.com> wrote:
> > > In any case, having movable pages be turned unmovable due to persistent
> > > writaback is something that must be fixed, not worked around. Likely a
> > > good topic for LSF/MM.
> >
> > Yes, this seems a good cross fs-mm topic.
> >
> > So the issue discussed here is that movable pages used for fuse
> > page-cache cause a problems when memory needs to be compacted. The
> > problem is either that
> >
> >  - the page is skipped, leaving the physical memory block unmovable
> >
> >  - the compaction is blocked for an unbounded time
> >
> > While the new AS_WRITEBACK_INDETERMINATE could potentially make things
> > worse, the same thing happens on readahead, since the new page can be
> > locked for an indeterminate amount of time, which can also block
> > compaction, right?
>
> Yes locked pages are unmovable. How much of these locked pages/folios
> can be caused by untrusted fuse server?

A stuck server would quickly reach the background threshold at which
point everything stops.   So my guess is that accidentally this won't
do much harm.

Doing it deliberately (tuning max_background, starting multiple
servers) the number of pages that are permanently locked could be
basically unlimited.

Thanks,
Miklos

