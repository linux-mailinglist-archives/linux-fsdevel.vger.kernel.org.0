Return-Path: <linux-fsdevel+bounces-38340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 398349FFEEA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 19:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02186160F0A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 18:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A5B1917ED;
	Thu,  2 Jan 2025 18:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmicEsnC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B9A7E782
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jan 2025 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844057; cv=none; b=qf5HS90GbPxEczRVLA63Halh9gYs80UC9sdGCZSXvs4s7dq6B1HvVsHyxzOBN2cDBxybUhbaCDq8RW9hv38mEIusQtXGlOFZE7Q3p59TfwAHDtikqWtYr9yl4SZk/AmACDMEQesU6Zl6rooxhYYo9Z/tIjt+RVu+Wqfr95XLQxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844057; c=relaxed/simple;
	bh=+Qs6xMGr55p17XkDku0NKUz2RFSdFUS3pnWF6VgBGyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edMpLCwM4khBsTZSYVr1WsxuDm2Lr8j/k8Ul9HfqSAM71mOhz4QQcpJky7zIZOdoay29yi4B8NeVtsIt3jDvBsyNtUrrQJ5/1uKijtSyM32ZYA7SHf09cH8ms/GHW9REQKzOhqWDMGlHAAWXNvStadQiwQipKoWaCtzLnielxww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmicEsnC; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4678cce3d60so117150311cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jan 2025 10:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735844055; x=1736448855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Qs6xMGr55p17XkDku0NKUz2RFSdFUS3pnWF6VgBGyc=;
        b=fmicEsnC5OajRYdm3G72VOE7lxSikd3kUaDCRJK56Rqak1kzKTVfvfB4bTS8d6RttJ
         y/pOWB43LJCAPVSq1ZYgz83b9uYKTNuL0nCYraC6tR3EegYZbbJmvHjEVOCYbdqlbBl0
         thv05A6DstVxY9UUZ0gQKuCtD5iDU4onJ3Z+Qq5vLB91opb1PpMad3Vx//mXwEus80IX
         sjHp9rfd75/Eiz+aS/j7b0zr7yHOzVNNwQdQQ1CnkUEHMVxYtAcFUr0SP4FOrzFQk/v7
         Pg7xCANnigr0Dabx4aNQAQeYbdNY4SxgrdqLtVFKhRxqO/OuNLQ2ch9lNMTCFn6OCRCm
         GSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735844055; x=1736448855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Qs6xMGr55p17XkDku0NKUz2RFSdFUS3pnWF6VgBGyc=;
        b=C8DvtIVDuThUYsMdxLgvHOJxppWdjur9CAIVX4GAc/C08cT/Q3rKp3RiXjcnn2T0WP
         1hdz9/O5qC3UaLZa4v0zDbEai8mNO8+WAAQdxmbrqcTyaq0D3Qz3pIOqhDBmqajzNyUK
         uAdIff7bYlBTmrzk3T3RaSjsquxubRMRrX5wKJBW39LokHus+TMuEv7JxIhygRIA6i0/
         /3PecSMcMAFo80jehWwGE4NxmU0hZ5J9msbfKJZoFDIAXBBQONdG6Gjl94VPqIQ5sglF
         QbqWwyvUacd3khEKsW26J+ksvK4iObnEizUZAWpgt4gnGl5U/Mj8Pn5n8UEq6kz2EP0O
         K/ag==
X-Forwarded-Encrypted: i=1; AJvYcCXPX3dhKXso/9uUo2WzzqE0tvMJnpb2hjerIlg6+k0I4dC3gDo/YrD1T/iSpvbO79SyQIXOfRxLyTD0Iv0w@vger.kernel.org
X-Gm-Message-State: AOJu0YyQtBSP/343Mcl0N8uY1Us8fznIelhwi0uk+39aDwoof9UJfhj/
	ZurTY8JCpHdso5ihy4I8Nl6WStcMw6TBIgD29GnPUKeSb26Ech8kFQbOnbmupkGBBc8uyri9beD
	cmHye+Pu1x/zlG28oL7Jw+SV7+hs=
X-Gm-Gg: ASbGncvuBffdTCGuDjaCN3RnzUgthwr5tEXU2j9SFjmypOutXgDfG8UH6yeNsOliMYy
	RXsHWJA4IjsQzFwTVqYOJzF43qZbTy5lSoi5AgCw=
X-Google-Smtp-Source: AGHT+IH0NZ+gCvxNDFQIWosoMmhOwNrAe8SZr2ALLTzinSxgkzv6mxbZ9MEZ9zk1QkDFGzCc1gK1ZLVCuEYWCkQUXMg=
X-Received: by 2002:a05:622a:1651:b0:466:9507:624d with SMTP id
 d75a77b69052e-46a4a8fbb8dmr750549081cf.27.1735844053474; Thu, 02 Jan 2025
 10:54:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm>
 <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com> <qsytb6j4j6v7kzmiygmmsrdgfkwszpjudvwbq5smkhowfd75dd@beks3genju7x>
 <3f3c7254-7171-4987-bb1b-24c323e22a0f@redhat.com> <kyn5ji73biubd5fqbpycu4xsheqvomb3cu45ufw7u2paj5rmhr@bhnlclvuujcu>
 <c91b6836-fa30-44a9-bc15-afc829acaba9@redhat.com> <h3jbqkgaatads2732mzoyucjmin6rakzsvkjvdaw2xzjlieapc@k6r7xywaeozg>
 <0ed5241e-10af-43ee-baaf-87a5b4dc9694@redhat.com> <CAJnrk1ZYV3hXz_fdssk=tCWPzD_fpHyMW1L_+VRJtK8fFGD-1g@mail.gmail.com>
 <446704ab-434e-45ac-a062-45fef78815e4@redhat.com> <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
In-Reply-To: <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 2 Jan 2025 10:54:02 -0800
Message-ID: <CAJnrk1aPCCjbKm+Ay9dz3HezCFehKDfsDidgsRyAMzen8Dk=-w@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: David Hildenbrand <david@redhat.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Zi Yan <ziy@nvidia.com>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	jefflexu@linux.alibaba.com, josef@toxicpanda.com, linux-mm@kvack.org, 
	kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>, 
	Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2024 at 12:11=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Mon, Dec 30, 2024 at 08:52:04PM +0100, David Hildenbrand wrote:
> >
> [...]
> > > I'm looking back at some of the discussions in v2 [1] and I'm still
> > > not clear on how memory fragmentation for non-movable pages differs
> > > from memory fragmentation from movable pages and whether one is worse
> > > than the other. Currently fuse uses movable temp pages (allocated wit=
h
> > > gfp flags GFP_NOFS | __GFP_HIGHMEM), and these can run into the same
> >
> > Why are they movable? Do you also specify __GFP_MOVABLE?
> >
> > If not, they are unmovable and are never allocated from
> > ZONE_MOVABLE/MIGRATE_CMA -- and usually only from MIGRATE_UNMOVBALE, to
> > group these unmovable pages.
> >
>
> Yes, these temp pages are non-movable. (Must be a typo in Joanne's
> email).

Sorry for the confusion, that should have been "non-movable temp pages".

>
> [...]
> >
> > I assume not regarding fragmentation.
> >
> >
> > In general, I see two main issues:
> >
> > A) We are no longer waiting on writeback, even though we expect in sane
> > environments that writeback will happen and we it might be worthwhile t=
o
> > just wait for writeback so we can migrate these folios.
> >
> > B) We allow turning movable pages to be unmovable, possibly forever/lon=
g
> > time, and there is no way to make them movable again (e.g., cancel
> > writeback).
> >
> >
> > I'm wondering if A) is actually a new issue introduced by this change. =
Can
> > folios with busy temp pages (writeback cleared on folio, but temp pages=
 are
> > still around) be migrated? I will look into some details once I'm back =
from
> > vacation.
> >

Folios with busy temp pages can be migrated since fuse will clear
writeback on the folio immediately once it's copied to the temp page.

To me, these two issues seem like one and the same. No longer waiting
on writeback renders it unmovable, which prevents
compaction/migration.

>
> My suggestion is to just drop the patch related to A as it is not
> required for deadlock avoidance. For B, I think we need a long term
> solution which is usable by other filesystems as well.

Sounds good. With that, we need to take this patchset out of
mm-unstable or this could lead to migration infinitely waiting on
folio writeback without the migrate patch there.


Thanks,
Joanne

