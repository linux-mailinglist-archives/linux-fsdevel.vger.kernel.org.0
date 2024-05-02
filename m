Return-Path: <linux-fsdevel+bounces-18494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3B18B97CB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 11:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9971C220DD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 09:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CD254FA0;
	Thu,  2 May 2024 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8xJ0qLi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CD7537FF;
	Thu,  2 May 2024 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642347; cv=none; b=SysyLWEwOm1vbw3yXNUARi7GcrvaBmdDHMlG5qyzJX8nboBnlGM00p/C1V9DJOVAR4B683YkK+ZlrnWqq4MBEYJGVkT91R/t3jNrjtFtOhfIO/xwm+76PbZAYeIlpXauc2b/WGMO+U3z/nbqYkLQMLoFukEwX6Wx5MqMGTxGekQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642347; c=relaxed/simple;
	bh=Z3lZtPpMKSUcjo/JnGTaHgDn+jnpLLkH19fhzoM/SDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pj+Tv8Tsdkli5KaTdqtrc5RpFdj76xYnuJUxbUUVFvR8VuiOiw3zi/TuHee5/3ILVzcw/QrpHd5yzMEIugX1O4JUy3o1YqnVOuoCuiLG25R2RQNQbzL0H04L1UPHEpDrMBRcIrZf0F4r1UidZQ6zyPtlnZZJ17vILHenJfaqb84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8xJ0qLi; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2db7c6b5598so100166761fa.1;
        Thu, 02 May 2024 02:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714642344; x=1715247144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3lZtPpMKSUcjo/JnGTaHgDn+jnpLLkH19fhzoM/SDs=;
        b=K8xJ0qLiDX2qerX84o7tbYH3MY6PiJtLpQcTYpOf14FFoWHUbYQvUzdXFPW/rDk6wm
         lcY99v7Le15UG+6DTT0AMz6YB8ki/wLcPruRoSBOflueI6IDADnPQmaJrX14reWxcLe5
         Wwvaf11k6b/D3y0qS+FYGgrP9rjbw5ZE/LO9+ZAw1vWcKEH+9rCGkXR1Xx8p0iTZdwvg
         FATorODRVm7uypaiYwcdjepeGlolvmUigVatdvyOg/Gn8aWVO9uoUSCqbpDOX5kjyRog
         05VD8lTufIe3uMrdX9cLitJbTeamSTRhj+4Q3TpJd2twviiyLccJmLGJRAczD94Xyafo
         fXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714642344; x=1715247144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3lZtPpMKSUcjo/JnGTaHgDn+jnpLLkH19fhzoM/SDs=;
        b=oi0xAE+mxUITTNO2ejNqY7AyVQW9GlPyXFi7BCblsDHXPYmIw3KZpbMPPiQ0rCXGyl
         wQ/dgo+HpNkDUccXkEKBhvp0FLCFsUde71RJSJLOYkyeS0uuxBH6qsIQQ8XJ9v/UXsqJ
         Xo5/GBFehEZInZtGhTNj+zs2Sj5HkwwI6mGCKxGaMKWdTQ8e8QvBxl+eo2TF7L495Wfx
         DRzHIGoqOrnCeUyXB0LV0KH4oJDh5BX8V0J6brEYT/Tqv5UD3ieliREagywrCcsv8PTK
         uC+Z5dPyhKO3WqEBJV/20SaxD3N+JbxZGHR+ESNyfEzncMO4hWYm0j1AdmgTh0BKCYmj
         mMRA==
X-Forwarded-Encrypted: i=1; AJvYcCXdUvSNoJoS4lZoutAhOhWP9qR0E0ql/vYguNV9kqumjr86UbFrZ7gsJ2RhP9+MAG9TinjMNK2Fk6VgXuwxrZHoKZYEp85FYWM+01qrfk82UYwJBmLr1hYttpL5A4lU2sfYso9yGrO5EtGj6Q==
X-Gm-Message-State: AOJu0YyMp5oZhbTwkbcHTuwSTlbfL2UkjaoX6IpW+Zl1owDWJyIlj9Jw
	rpyrskRdJ2TIIJJytTQlC07HGsVJ95MqyUQvyZCBrh1iIU383rGXjS45BlkZGFTi7QTU9aNCZrH
	BTRjNN53dMVqcPUbfurIhYNd6F7o=
X-Google-Smtp-Source: AGHT+IGCzOhkTfJRi4C5pjOm7iTIkpXmJVWJcWAimRSBIoNi/DSth1zP+hvlFVbxsvIwktZfamO0hBQVH3TYe+RbVkk=
X-Received: by 2002:a2e:950e:0:b0:2d8:57a4:968d with SMTP id
 f14-20020a2e950e000000b002d857a4968dmr2959202ljh.12.1714642343841; Thu, 02
 May 2024 02:32:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502084609.28376-1-ryncsn@gmail.com> <20240502084939.30250-4-ryncsn@gmail.com>
 <7636ada9-fdf0-4796-ab83-9ac60a213465@redhat.com>
In-Reply-To: <7636ada9-fdf0-4796-ab83-9ac60a213465@redhat.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 2 May 2024 17:32:07 +0800
Message-ID: <CAMgjq7CD=r9TP4PSe2MqR=r-+PnMB-N6yYbFRr9U=B5ZBvTPtA@mail.gmail.com>
Subject: Re: [PATCH v4 11/12] mm: drop page_index and convert folio_index to
 use folio
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Matthew Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 5:12=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 02.05.24 10:49, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > There are two helpers for retrieving the index within address space
> > for mixed usage of swap cache and page cache:
> >
> > - page_index
> > - folio_index (wrapper of page_index)
> >
> > This commit drops page_index, as we have eliminated all users, and
> > converts folio_index to use folio internally.
>
> The latter does not make sense. folio_index() already is using a folio
> internally. Maybe a leftover from reshuffling/reworking patches?

Hi, David,

folio_index calls swapcache_index, and swapcache_index is defined as:

#define swapcache_index(folio) __page_file_index(&(folio)->page)

Where it casts the folio to page first, then call __page_file_index,
__page_file_index is a function and works on pages.

After this commit __page_file_index is converted to
__folio_swap_cache_index. This change is a bit of trivial but we get
rid of the internal page conversion.

I can simplify the commit message, just say drop page_index to make
the code cleaner, if this is confusing.

