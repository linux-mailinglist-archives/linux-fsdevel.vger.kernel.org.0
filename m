Return-Path: <linux-fsdevel+bounces-39126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1B7A1032F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 10:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6463D7A3658
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 09:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6E724334E;
	Tue, 14 Jan 2025 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jBk0rMOG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C6022DC5D
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736847631; cv=none; b=M/F2uOfKMYsWzbA2cp5M1VV1vMsR/IN6W3J3B3JXFu0PMzPa/he1q/k0IT5LKxLeNWhksiOtSMvOft6y3Gw4N5tM5HNE4fmMUrod2KWhk63kgFtTIuKxQeRxqLlRZpCNbg4uYVAgn7V0FJtHefSZhcebbhpIHtaIq+4gdq56YoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736847631; c=relaxed/simple;
	bh=aZ8FuGNqZ+3iV51Cb1i5vgeCEtICB6sGbemIZemD+0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=liFPUqm9ZPuhJyYynVMynDjKGfO+owuHro3rsC7ZlzqNxAioW5d4Qvu+n96PahpZa0r6BCu7d146Ee7o6jsEV8k/r14mkQTqP3L9wIneSL3FsXR53toeewrwXwpbAlJSmqhudRJ2b/z+BJqv55BkcIDFAZjHBevKL9Q8ERMxn3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jBk0rMOG; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-467918c360aso60021891cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 01:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1736847628; x=1737452428; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HgPy2eorjQtqOTgVzB2y5cAsY+IvT0FtA9XMxPuPMDA=;
        b=jBk0rMOGiUp4o4hbjVlrpcN40UU3uNfUFXlluq+ePIsnf7KjHJZFyG/EdKOiTpZ015
         hITOxPOAvaq9LygTaFUiI/2z1LWE34skGPzZVeewG250xv+VebQqYN+8e59DfUczSNZL
         zFCfqA+TS33XUD3ipqTkrTDhXsn3a2iuU685g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736847628; x=1737452428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HgPy2eorjQtqOTgVzB2y5cAsY+IvT0FtA9XMxPuPMDA=;
        b=iFGVvNwceMFELvmQpMb2SCA8A2STosGMPWO5kv+1N65/sz078sm2xiIGiGabyeE4Vk
         xlz0DnlrQeHoqHCBFp3aSlZUd38gsdGowi9qMg9KXlA6LI9DtuAaA5lqd/8x81hf9VZK
         BYAqhL4qfKIzqV9pGaQoo+dytZ0K4C5zVi5ARYtQKi7YfKXzQOuTTAvEN2q0FXbiUfQZ
         f8me9DNsHGICjPKfCaQ1M5363rw+GH7lNQTQMzEuBfwF2MOVxOiPFO0ZiMFkjrOcmRLH
         m95rJLzmKP5ElECHE42hcCOM9J9p+QXWfHm3TbzQy1006YJWlpTpjQ3uletqBrXeF+RD
         JVvw==
X-Forwarded-Encrypted: i=1; AJvYcCV9QWMYya7tWGO3PLCPsgJUhN9kCM6O6UfqVuNQiYDZFeaVn3/NZaEhMzYnundaCDd7AwynNx1iAoYdx2VE@vger.kernel.org
X-Gm-Message-State: AOJu0YxvAYPzDRrtKY+++J1qB0LEk4Rqo25yKMqes0zzgA+MCfjurbH0
	W0BNFua+lmSFSBFPvQ8IRzsJ/Tm/M+nceBA4nAQ8X3sEVDfK4/gdpAUbx1nv1pJl3XcPRgt2hLK
	mkJ7k7FhCFEBN0U3CXRYogE9bUvIuL6YDskf8kQ==
X-Gm-Gg: ASbGncuSaMuTdQYmFquMVO2jHVfrjbWrxnQF2ReVVyFdAUMisTuh3b7VHUsu60LGsf0
	AECR1cCpaHA4pCrNuaQZj+EppN8UnO7hWIKeb
X-Google-Smtp-Source: AGHT+IH5zcZYV4uugUlC0KgfwH0v4ZvazwCDkLcLzwd/+LyEAh5KxIisX+gUXKeRn1fXcoK5aOWBXn/ZrSX1cT3C4M0=
X-Received: by 2002:ac8:7c4e:0:b0:466:ac8d:7341 with SMTP id
 d75a77b69052e-46c710841e4mr356199921cf.35.1736847627940; Tue, 14 Jan 2025
 01:40:27 -0800 (PST)
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
In-Reply-To: <CAJfpegs_YMuyBGpSnNKo7bz8_s7cOwn2we+UwhUYBfjAqO4w+g@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 14 Jan 2025 10:40:17 +0100
X-Gm-Features: AbW1kvYXIdAjEYEuwiuhLrszud5yTv1k-6o5wyMwr9_6HvXpRPUCw9p-BVpd0Eg
Message-ID: <CAJfpeguSXf0tokOMjoOP-gnxoNHO33wTyiMXH5pQP8eqzj_R0g@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Jeff Layton <jlayton@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Zi Yan <ziy@nvidia.com>, linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com, 
	Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>, 
	Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Jan 2025 at 09:38, Miklos Szeredi <miklos@szeredi.hu> wrote:

> Maybe an explicit callback from the migration code to the filesystem
> would work. I.e. move the complexity of dealing with migration for
> problematic filesystems (netfs/fuse) to the filesystem itself.  I'm
> not sure how this would actually look, as I'm unfamiliar with the
> details of page migration, but I guess it shouldn't be too difficult
> to implement for fuse at least.

Thinking a bit...

1) reading pages

Pages are allocated (PG_locked set, PG_uptodate cleared) and passed to
->readpages(), which may make the pages uptodate asynchronously.  If a
page is unlocked but not set uptodate, then caller is supposed to
retry the reading, at least that's how I interpret
filemap_get_pages().   This means that it's fine to migrate the page
before it's actually filled with data, since the caller will retry.

It also means that it would be sufficient to allocate the page itself
just before filling it in, if there was a mechanism to keep track of
these "not yet filled" pages.  But that probably off topic.

2) writing pages

When the page isn't actually being copied, the writeback could be
cancelled and the page redirtied.  At which point it's fine to migrate
it.  The problem is with pages that are spliced from /dev/fuse and
control over when it's being accessed is lost.  Note: this is not
actually done right now on cached pages, since writeback always copies
to temp pages.  So we can continue to do that when doing a splice and
not risk any performance regressions.

Am I missing something?

Thanks,
Miklos

