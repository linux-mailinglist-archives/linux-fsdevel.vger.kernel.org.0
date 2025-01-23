Return-Path: <linux-fsdevel+bounces-39985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35819A1A91B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 18:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2076D188A02F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 17:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96715156861;
	Thu, 23 Jan 2025 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JU1MoDTa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755F41494BF
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737654404; cv=none; b=WNXtyE1vl03GOfcl9nTeGtKjqOfjgQ2oMw8nW9P6gwgu48kvLMeqCLxafhi7xDLASn2SR7g1nslENC6W4ODEB+v2B2sgZnWAD1nqtIffTnCL9RGuYgrfu9YatBCFUUiOGcKnxbbnH6F7rMfQeR9RIZqz2lEg1exp666nv2MTWtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737654404; c=relaxed/simple;
	bh=BuShac5PMRQuRzTxvxR5pt7P+mhVL7M2844BdeFajHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FF9fwS3wtRrL9c3ReSaKbqmYf+7b/0NYZjRolaeR1++BLwGIBr1wS7ZmLJgff0G1Ssvpg7OGtRx9cbJJB1zye36NvE7UuWZ4LdkzBya3K2zXGHUgp+OYx/HvUo6PB6u04hzsShLXO/O7k9lvWwZpU7AqXkDl/DwEYBHSGp9D5gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JU1MoDTa; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4678c9310afso1211cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 09:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737654401; x=1738259201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrlv9bvuLVdAcLvAk4Tcl1flaXn6F0NFVsxyfsj51MI=;
        b=JU1MoDTaKu0ape9QGj87TD/HGQJL7KceOpbMiuQJ4Ku47p72Ji8234ySMcA7mETyED
         t1jKeSzCyY6kI6JUUVFQWiZNUdaf5PrvAGJrtKe5Fo2vRQOyeWWg/jC/QUZKyWQIfXt6
         f+Wz/9hy9Itp09ZCa9SZzKELCUeFGllGNnZIiviFKjhkuGAyxcIPOfkoCFIgJ6f+Ii3X
         Q9WLpYhRaZCK1IDdqGKlvB72gETsT/2xfL1L1RYkcdPGnoIQHFa42tkSniOx6S/3cF3c
         nVi2NANZoVECZ3fun/upbYM3m5iJpCjWuE4ufk9P9JuCU6nULquV2WFpWdbx6c7Rlg3Z
         /Gew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737654401; x=1738259201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrlv9bvuLVdAcLvAk4Tcl1flaXn6F0NFVsxyfsj51MI=;
        b=ldJpi265nhHTMktrhliwOMNhO0uWRIGD8LHWdaxGAcEUDsYKVNuV/jFrfekvha0qRF
         6rKoyCgZLfjYwfUlKC65gPhxC/tAe5AgPLG23l+7jO8sTy8PRcWMkvr/+yy11w/ypFRi
         N54lo7kA7ZI2msfUMgf1NWXbi+YvvXukgaOibHkH8r7MsxOkebZ0NDUcyIwJi3u18NKf
         xkLL64MgHmePxDc4fho7eEXHkgpntflRvkuT8Sk3pWzlU5padbtZzs5qI3B7GhB1oo5B
         hxgU0zm9njrVbPa2wj+qGHj1T7lyUc9NQ+UP2QV/Zpank72n1IJx1sK+tI/HKAz3og9F
         SGLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuJWzx9+4XZilB3ubSpD9zkeRI/FYkNFH0sW2Ed0BcSFMt4IjGr3tl5mxyY8eOTwtrJFIv/CC1tGMc+iI0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+g8UF+0yKrnO7gpofoOCGx5Y2qEKZ3S6RtepWQpkP4WkYsPtR
	vYGxQL86KnUceXQvUkOadr1WhQiKSyOK55GQJw1kPXATXpjrHa6TU6VQJ+sZjxWU9CKKQuQODLW
	unpWiVOjlAStGlcP3kUky3krdcl6/i6J/yWrP
X-Gm-Gg: ASbGncuFEle2q4vGZ63MoiI07YxH6QTCWUta0ZnPoO59ZAma+dvrVxPNDChrRAXKyvZ
	/yGLpFDb6bcBeuExGANElQMbhNapoylxT/a4SEaa4QHw8yETSEy9WgzLFiwdex31ECA+3q0cO4W
	sKFY0TseuKonQS07Fd
X-Google-Smtp-Source: AGHT+IEn4udzSqij9W5TtY168fZ3ISFGTuwhi8IFIrEr1ddSwx4c84+jssbVKhdPt2W/Kzz4tpbpwatrQE4H4KrUWCg=
X-Received: by 2002:a05:622a:6090:b0:467:82de:d949 with SMTP id
 d75a77b69052e-46e5c0f91a5mr4787321cf.12.1737654401102; Thu, 23 Jan 2025
 09:46:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215182756.3448972-5-lokeshgidra@google.com>
 <20250123041427.1987-1-21cnbao@gmail.com> <6aee73c6-09aa-4c2a-a28e-af9532f3f66c@lucifer.local>
 <7a4f8c38-13a1-4a28-b7ce-ad3bb983dd69@redhat.com>
In-Reply-To: <7a4f8c38-13a1-4a28-b7ce-ad3bb983dd69@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 23 Jan 2025 09:46:30 -0800
X-Gm-Features: AbW1kva8LK6Oxl7iQk-wTWwjvZt1uKYq-oQd8CI-0vr3J2eS5f5rcXJCLlw0J98
Message-ID: <CAJuCfpF2iCo+ZKrqYam6wjqn7LYu4cnDeqDKrd-LpHerc5WHVw@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] userfaultfd: use per-vma locks in userfaultfd operations
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Barry Song <21cnbao@gmail.com>, 
	lokeshgidra@google.com, Liam.Howlett@oracle.com, aarcange@redhat.com, 
	akpm@linux-foundation.org, axelrasmussen@google.com, bgeffon@google.com, 
	jannh@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ngeoffray@google.com, peterx@redhat.com, rppt@kernel.org, 
	ryan.roberts@arm.com, selinux@vger.kernel.org, timmurray@google.com, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 9:15=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> >>
> >>           =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90TASK_SIZE
> >>           =E2=94=82            =E2=94=82
> >>           =E2=94=82            =E2=94=82
> >>           =E2=94=82            =E2=94=82mmap VOLATILE
> >>           =E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> >>           =E2=94=82            =E2=94=82
> >>           =E2=94=82            =E2=94=82
> >>           =E2=94=82            =E2=94=82
> >>           =E2=94=82            =E2=94=82
> >>           =E2=94=82            =E2=94=82default mmap
> >>           =E2=94=82            =E2=94=82
> >>           =E2=94=82            =E2=94=82
> >>           =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
> >>
> >> VMAs in the volatile region are assigned their own volatile_mmap_lock,
> >> which is independent of the mmap_lock for the non-volatile region.
> >> Additionally, we ensure that no single VMA spans the boundary between
> >> the volatile and non-volatile regions. This separation prevents the
> >> frequent modifications of a small number of volatile VMAs from blockin=
g
> >> other operations on a large number of non-volatile VMAs.
> >
> > I think really overall this will be solving one can of worms by introdu=
cing
> > another can of very large worms in space :P but perhaps I am missing
> > details here.
>
> Fully agreed; not a big fan :)

+1. Let's not add more coarse-grained locks in mm. Discussing this at
LSFMM as Liam suggested would be a good idea. I'm definitely
interested.

>
> --
> Cheers,
>
> David / dhildenb
>

