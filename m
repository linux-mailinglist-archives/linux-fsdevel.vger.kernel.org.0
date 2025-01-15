Return-Path: <linux-fsdevel+bounces-39340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D877A12DE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 22:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46FE3A5A04
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 21:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966D31DA636;
	Wed, 15 Jan 2025 21:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NkgTlQtE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696421D5CC7
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 21:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736977644; cv=none; b=hPpt8/F6zUtVWsf6il/dmaQ9tiYQRxVjKYg3vGjJ/spSvw9I94TK0h/wa36F66pSokbqr+c2N4LFHTDDBrrjBahLSILEEuCIdmcz1q5k+q8jyP869XwQRwGgO4DXNpKXeL7ASAz/goKlamhUD8M0FYtwTU9wIbdo/Fr5v36mJTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736977644; c=relaxed/simple;
	bh=45dVOnxBFMRIfoiWqTEIPP+1eu4bxw46dGNIwYgiuSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cX/ZOIpFhCajc60CkWRJmSzPk9OZu54MftzXCqfKxleXUXKv5zfhsenTOk0n+meYPzAQtUrns7kIjXtT9uiJP5D9vl5Xc/BceIaQAbL5PKA2NnN7dIzS7jYkwh89yRn3bIPadBuXbxzlWGsf6mGdw+nq4oYcH9EZ9BGCdPUXAMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NkgTlQtE; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86112ab1ad4so46733241.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 13:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736977641; x=1737582441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltmn9Mm22yVt64ua+/2W5DkLu4FvUvXKpZxg/TWxbvY=;
        b=NkgTlQtEkLYEBC10MzU4mdryhHYg4wsPquhFKN5WSKi6D3/wBiYHz8shmOjrG99ICt
         bV94i4pPQ+7GX96/q8xi3Te2b/jjUQF7v3/5T5ewESQnFfP7W/U5pT5k8q317ihEKsm6
         MhAy1VJYV67IO3IaD5WGlkG8ptdgvKPqxhl1/Swb+PsRxvGoWTjlgiKdTjchZSWjPk6V
         QT7g602vVNm/k0J5dqM7dVCf1Z+YBgDxj1zhzQtP/qDcxFq0NR9ELxmr8749OukfcGLw
         XywO/A4f6QVZI90+xc8fxTq5I9ctTPiZK0N1z1zj2J8MvJ6o+KKSe9T3OmHCxhmzsUpj
         oRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736977641; x=1737582441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltmn9Mm22yVt64ua+/2W5DkLu4FvUvXKpZxg/TWxbvY=;
        b=KTtmn+SpzEMAgmVyE9aoEhKIf9fLBgMVhiiagXtnfnlsEgpsEojyuPJsx3tRWJ/h2C
         loey6+1+B//wPvNcXXnbTNbwf29KeN4WKCp3EaR4KSgQi9I6wuZ7GbgCTY08rJ/evvqy
         W5yE0CXdznS9Rai8iWCo33CLO1+N5PNy00uXcAiZ2IvlW+mQaC3ZcNP/HM5YOKe6kUpm
         EVkQzXMMKEppTIK/vW2a/LzdKkGQJ5ZH9lvKeXzo2HiazpISJa+G1yuwwOIP7BmA7v5i
         oRBQS5zFwYdg9i/9ogyORXB3eSEQHoS9nh+be/K4GINaH5DMwwc4k7pMCGzTVdr5S3Pm
         0xDw==
X-Forwarded-Encrypted: i=1; AJvYcCUGsz7MG0484GbJCjcKM73vPlD4zZw6aScEIJqgcoBGmrMUbyTPQ6bHxF3489XJ9qs4iq0v215ICMGu+l2l@vger.kernel.org
X-Gm-Message-State: AOJu0YxiCttgghMQYORuE4UcMnHbAVrIMqtlhkwFcB2CYkG6/91rOAiC
	BNMhoRKdu4n2nNY+pQGQudWhRKXUS+hu06LT+63Is/W6EYa58DP36lZTWCm7N+2F7mcMhC/LnjJ
	ccRkGvJARpRdndmi++BHHDhXoqrm7mwWxEzSw
X-Gm-Gg: ASbGncuYnemkZHngxFD6KDd66eW6sC62DiGAeSefnVhq6ykJzc0GMjy6CXQfBHV6pHu
	85B4+WgM2YIem8UWd9KeDi2Cazwty9eFgrt929/lUOBbA1v5NkeUP4oEwkAbdcQyekmMt
X-Google-Smtp-Source: AGHT+IHddxhJJTm91TzdAwSi6uafTRzEfEyn82rLSJiZKUTard4Bp+c3/yQxdvAEMnMOjsCchFbxw41UJMogIcZ05rQ=
X-Received: by 2002:a05:6102:54a4:b0:4b0:ccec:c9de with SMTP id
 ada2fe7eead31-4b3d0ecc1ecmr29653773137.24.1736977641130; Wed, 15 Jan 2025
 13:47:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115093135.3288234-1-kirill.shutemov@linux.intel.com>
 <20250115093135.3288234-6-kirill.shutemov@linux.intel.com> <Z4gqJqcO8wau0sgN@casper.infradead.org>
In-Reply-To: <Z4gqJqcO8wau0sgN@casper.infradead.org>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 15 Jan 2025 14:46:44 -0700
X-Gm-Features: AbW1kvYmgQZAQoh1evl_F-cwT96TWCJNKl3oZphib0Y46aUVpuxrrUuhtwKH4hA
Message-ID: <CAOUHufZ42ZV1SU+rGLM-2j2Hp43Q9eLY_yFYg8jsifOfcPHUgQ@mail.gmail.com>
Subject: Re: [PATCHv2 05/11] mm/truncate: Use folio_set_dropbehind() instead
 of deactivate_file_folio()
To: Matthew Wilcox <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Andi Shyti <andi.shyti@linux.intel.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Christian Brauner <brauner@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dan Carpenter <dan.carpenter@linaro.org>, 
	David Airlie <airlied@gmail.com>, David Hildenbrand <david@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Josef Bacik <josef@toxicpanda.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Nhat Pham <nphamcs@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Ran Xiaokai <ran.xiaokai@zte.com.cn>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, 
	Steven Rostedt <rostedt@goodmis.org>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Vlastimil Babka <vbabka@suse.cz>, Yosry Ahmed <yosryahmed@google.com>, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 2:35=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Jan 15, 2025 at 11:31:29AM +0200, Kirill A. Shutemov wrote:
> > -static void lru_deactivate_file(struct lruvec *lruvec, struct folio *f=
olio)
> > -{
> > -     bool active =3D folio_test_active(folio) || lru_gen_enabled();
> > -     long nr_pages =3D folio_nr_pages(folio);
> > -
> > -     if (folio_test_unevictable(folio))
> > -             return;
> > -
> > -     /* Some processes are using the folio */
> > -     if (folio_mapped(folio))
> > -             return;
> > -
> > -     lruvec_del_folio(lruvec, folio);
> > -     folio_clear_active(folio);
> > -     folio_clear_referenced(folio);
> > -
> > -     if (folio_test_writeback(folio) || folio_test_dirty(folio)) {
> > -             /*
> > -              * Setting the reclaim flag could race with
> > -              * folio_end_writeback() and confuse readahead.  But the
> > -              * race window is _really_ small and  it's not a critical
> > -              * problem.
> > -              */
> > -             lruvec_add_folio(lruvec, folio);
> > -             folio_set_reclaim(folio);
> > -     } else {
> > -             /*
> > -              * The folio's writeback ended while it was in the batch.
> > -              * We move that folio to the tail of the inactive list.
> > -              */
> > -             lruvec_add_folio_tail(lruvec, folio);
> > -             __count_vm_events(PGROTATED, nr_pages);
> > -     }
> > -
> > -     if (active) {
> > -             __count_vm_events(PGDEACTIVATE, nr_pages);
> > -             __count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE,
> > -                                  nr_pages);
> > -     }
> > -}
>
> > +++ b/mm/truncate.c
> > @@ -486,7 +486,7 @@ unsigned long mapping_try_invalidate(struct address=
_space *mapping,
> >                        * of interest and try to speed up its reclaim.
> >                        */
> >                       if (!ret) {
> > -                             deactivate_file_folio(folio);
> > +                             folio_set_dropbehind(folio);
>
> brr.
>
> This is a fairly substantial change in semantics, and maybe it's fine.
>
> At a high level, we're trying to remove pages from an inode that aren't
> in use.  But we might find that some of them are in use (eg they're
> mapped or under writeback).  If they are mapped, we don't currently
> try to accelerate their reclaim, but now we're going to mark them
> as dropbehind.  I think that's wrong.
>
> If they're dirty or under writeback, then yes, mark them as dropbehind, b=
ut
> I think we need to be a little more surgical here.  Maybe preserve the
> unevictable check too.

Right -- deactivate_file_folio() does make sure the folio is not
unevictable or mapped. So probably something like below would the
change in semantics be close enough?

  if (!folio_test_unevictable(folio) && !folio_mapped(folio))
    folio_set_dropbehind(folio);

