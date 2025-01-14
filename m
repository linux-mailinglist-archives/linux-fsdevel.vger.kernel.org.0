Return-Path: <linux-fsdevel+bounces-39175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232A3A11198
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 21:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C6693A1E57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 20:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D521FBCA9;
	Tue, 14 Jan 2025 20:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="DAYT05gc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6618493
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736884869; cv=none; b=oo4y0oTcfRrEvV7PkU/kL1W9tPNQrosiEfEjjQ+0+nb2HvQKMwfGX9qYeM0hyZV03pejwUZVgmIy2okDV8oaVDjv5QDkz7wXuTZNrA8pPIb3FaZQMYqXWl7WTuFjqYdBZLfqwSk9XLC6XVFVkfI72h9pcXLwSE4kDWvIyDmAMBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736884869; c=relaxed/simple;
	bh=ZHd+rRX4f26BkyN0FGG2UtQyut13eyjg4ut19XWw5LI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYJpO6Vshq/MHJhrm29cSezJMQFUGtT5NIEQD32SfcWPujgSLSoO///kKGH7hwLBN2ioK/5FkwsvIjMPhhJGFUpYSLjjm615nqS9tH4YqJpwN8GcC8IhWfAwXgpgVr8qTVQvvjOiDr0S3U4bI9rU9mr76h1myoKX4sfgb4GI2GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=DAYT05gc; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4678afeb133so1618901cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 12:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1736884866; x=1737489666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jGFr9sGZpIt5cN+9vntCHPUXNxuo0ib6aqThpsLGnEg=;
        b=DAYT05gcgtAfk8TaOop+x2HhCIxrDgyH89ACi1rMBKQBRIhk9jFKeX7El7tjDramZy
         6Z4yXLOScy65hchY+17z5LqXbugHPuGwr3Q0bi4Y4v8pWk0I0MBojfn9M+njm3EmI8O/
         KikNRoaC5lOx7ae0DFEsvd4aZZexaMiHFSBL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736884866; x=1737489666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGFr9sGZpIt5cN+9vntCHPUXNxuo0ib6aqThpsLGnEg=;
        b=k+6qtd361wMg7bg/nkr06m8TzZqqyLdW4sjqu07WflM3t7uuv3MKXJJSb8ZwOVdACY
         t8ScxywdCtum6hvhWzYpoTdkl/Cgx1AUDV5oX4P/HLxDzdg9rlEAzhKkN1bYEPuewKBp
         dM1anEf5XyYQ2I7/iHRyPGpvLwJSaWayrpbNjr8mZKUcg5KgqdAXzUFiwpSYnaWvsYdk
         tS0mRSKdg0ohdoX5A5o6zCrGqO9/KkmIP8X4S+aW6oETsklA2Lg8XExry3elW0sx20o9
         MXBXUmPdspDjpdVaXPGwpkAMxrSDsbUiYPmwR/Z0Z+E2+mQfoAQiiC7Dd7K64e++myKZ
         q4ng==
X-Forwarded-Encrypted: i=1; AJvYcCXR2ZLfW4MfIt1SAQWbKWYM1slMWsCAC/vxhZIaE9l24upYLIB60y7qGVkuf8JRy0JDG3ILhye33RJCJTim@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1XY4P6XJdT/2+erugSjL9N0sfGGcfUkO9SeFQvBdjI26QO2lc
	IVuIOnz5cocOPgCAVaWik554T/9NM0kJ9+zcgZ0/IymugFSyP1Ri4pUOxfn3LhIR9puBu2P4egU
	j/d7hZXbV/pWc3Vfd+fkJ7PoUSNE5Il8XDKFQog==
X-Gm-Gg: ASbGnctFtYi1sz+J74jKFN9iuEMoqKSMRBur4x1HYRZ2+/kVRP54Hcnbi9ZhXV+yj90
	JXuP4Dcco0F6qXT99VTJvLL47adDJzP/SYsCp
X-Google-Smtp-Source: AGHT+IGsNiYzTVVI8MDJSlYf7hVTIqig6jg284DT6Vyb+WdqzT6QOwHNGBk5QophEC9PjZ5p5NMajIlNiGphROJNr1s=
X-Received: by 2002:a05:622a:3cb:b0:466:93f3:5bf1 with SMTP id
 d75a77b69052e-46df5661dcdmr5058041cf.1.1736884866684; Tue, 14 Jan 2025
 12:01:06 -0800 (PST)
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
 <CAJnrk1ZP4yZZDR0fZghBmuN-N=JfrbJZALBH0pdaC5_gGWFwEw@mail.gmail.com>
 <CAJfpegvqZnMmgYcy28iDD_T=bFgeXgWD7ZZkpuJfXdBmjCK9hA@mail.gmail.com> <CAJnrk1Y14Xn8y2GLhGeVaistpX3ncTpkzSNBhDvN37v7YGSo4g@mail.gmail.com>
In-Reply-To: <CAJnrk1Y14Xn8y2GLhGeVaistpX3ncTpkzSNBhDvN37v7YGSo4g@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 14 Jan 2025 21:00:55 +0100
X-Gm-Features: AbW1kvZIbaY8yr45F5FQPamVY8i3T8PpfIf_rUSauH1zAJbBRwND1-UeHpCqnEQ
Message-ID: <CAJfpeguRGgfNnnDWxtQ4L1vuOA+fPe0KLtMLaUCiDeHdpq0CKg@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Jeff Layton <jlayton@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Shakeel Butt <shakeel.butt@linux.dev>, Zi Yan <ziy@nvidia.com>, 
	linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com, 
	Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>, 
	Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Jan 2025 at 20:12, Joanne Koong <joannelkoong@gmail.com> wrote:

> If we copy the cache page, do we not have the same issue with needing
> an rb tree to track writeback state since writeback on the original
> folio would be immediately cleared?

Writeback would not be cleared in that case.   The copy would be to
guarantee that the page can be migrated.  Starting migration for an
under-writeback page would need some new mechanism, because currently
that's not possible.

But I realize now that even though write-through does not involve
PG_writeback, doing splice will result in those cache pages being
referenced for an indefinite amount of time, which can deny migration.
Ugh.   Same as page reading, this exists today.

Thanks,
Miklos

