Return-Path: <linux-fsdevel+bounces-17613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296518B04B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 10:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BB19B25E34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 08:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B449158A14;
	Wed, 24 Apr 2024 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2NwAL2I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DE3D29E;
	Wed, 24 Apr 2024 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713948546; cv=none; b=eg9oNKez8vw5UKjMxhmDL1efWhMox1hNlRcOu/m2NZCHm7PHX8tDwnqr0LyRGL4DB1aJkw6uv+XbMWgFb/MIdWAZQ0WF88PQ0NOCZrxexenV/MJBYp4rAOTV9El6yXl0nFkNJrSkPGFKt2VU58il4s5JAFzgGuyGuoNWTxxYvoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713948546; c=relaxed/simple;
	bh=Xm6NxcEd3ZnINqVPRreRGDQC7HahRju6fclnxD6CacM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjoBwVNNH2qujTnA+4Kc86f70rgcbFSgqm4PtGKkxQLnEwuENAcPXsXnUYaCS5GyasyapCRNATURy3QjNLYp2NODQNrkx9qt7F6Ymo5f4b+EZWqkoPBgr4crDiUqT9KER9gKgJaqnidFwxmEEYpoRemIQTJ5BmTrchVu0+84ROY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2NwAL2I; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2db6f5977e1so86973121fa.2;
        Wed, 24 Apr 2024 01:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713948543; x=1714553343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kFQR8E+rQp7uC9yW6Ow4kuJJBmzBQxe59gx0jzroTg=;
        b=J2NwAL2IXzafeNEeZfNuHkYmff6fq82dIPFvHh31C19LgwZhSCI1I65otlzlQMhGst
         uWNTwuN9osJ0lTyr9KpwrUltg510uX7Q4AjORJUCCOfQmUIanBLiWVAijQuHv4KsFZBv
         VsnSB1ocGPwyOuEo+7TwCFM25y4d9JWM+J7JPbB3TFIkjzU5w+OKNH74lAC+3wIcYU9E
         0NFsfMRZKUhjLfzAbQ9JRAGzrnQAVNlTvAhGR0cKYmn0iUZpMkTEp1sdDgVVpcOeQ0IS
         J/hjevR3Y2nu6a+zVqeno72OjEEVjT37RCQvH0RjEGmsmvW5vcejepJf0Vgl6jQAI06M
         +oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713948543; x=1714553343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kFQR8E+rQp7uC9yW6Ow4kuJJBmzBQxe59gx0jzroTg=;
        b=kh9GM9Bd6Lj5FygFbl4/7nmP6v/sYrUZIty0N0ACgJdO5QdKQup8S10duj/xwwJ9fB
         /j37u3xHdX+SWDR9qY6KAKYdFXCQHzH2R47A3c6XTmxdTWQ9mCMkf6Ren0mK6EDiH/oC
         r2PUsaYqqWNVK6lZKfBxc9wMKvWW8U3e72UfhL0KnWgDeXUy+W/FgRUQqMGOONIqFA0L
         kXbZUL4DaMl9vbafr1Hj8k4jej2/85W2KXnndLs+BxWnlIhZ0XejodzJTTR26R2cRXuU
         M3yc0WH4/K78p23vRxc0/3e5VvJuclbTfNS85bLBaEE8C5YVEjLXv2LaGFMKQMlCJeF+
         Jnmw==
X-Forwarded-Encrypted: i=1; AJvYcCXpSAoFsx0M+D/5Gcv1E/NGT54GwqB4/joAxzf3CMbxpvMAxSTwK1Xs0+Z2DckS6ncu/m1KrB2JG52kPS9VM5iOiMO+JGMbq7dHzeCTBWnAeEJs7SP0etVTRylfsDU8u17WUQ6YKNOIxn67jRdNTCebxxCEf0g/LnLnuVFlr52pE/8I4O+N9g==
X-Gm-Message-State: AOJu0YzyfLy8u/ZZCK5Tu1q6hZTDgqNN52lm3erj2h7ZCS+mIJ/O9FST
	OP/vTvUfdaClaT1sdpKuoIKvDahJ7BKlMNfq3qhnE+761GXHB7HZu8hcIgf9enbH/n9JfZWDihQ
	wf4meYSzkZ98iHY22GOVejSgZFv0=
X-Google-Smtp-Source: AGHT+IHWBLhdfxJmQz/AuelJzR0hT0UyUTcb1wFB00Jyxy3z+kUkHuir+BrO9+R3ccWtp+R2htlrw6iIzlqkMNtzqWs=
X-Received: by 2002:a05:651c:49d:b0:2d8:3d69:b066 with SMTP id
 s29-20020a05651c049d00b002d83d69b066mr978648ljc.7.1713948543126; Wed, 24 Apr
 2024 01:49:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423170339.54131-1-ryncsn@gmail.com> <20240423170339.54131-8-ryncsn@gmail.com>
 <87sezbsdwf.fsf@yhuang6-desk2.ccr.corp.intel.com> <ZiiFHTwgu8FGio1k@casper.infradead.org>
In-Reply-To: <ZiiFHTwgu8FGio1k@casper.infradead.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 24 Apr 2024 16:48:46 +0800
Message-ID: <CAMgjq7Cu8q9ed_HY2K_iHwm7gKvYWkadS+Zj-GR1CaVwDMwqNQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] mm: drop page_index/page_file_offset and convert
 swap helpers to use folio
To: Matthew Wilcox <willy@infradead.org>
Cc: "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	linux-afs@lists.infradead.org, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 12:06=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Wed, Apr 24, 2024 at 10:17:04AM +0800, Huang, Ying wrote:
> > Kairui Song <ryncsn@gmail.com> writes:
> > >  static inline loff_t folio_file_pos(struct folio *folio)
> > >  {
> > > -   return page_file_offset(&folio->page);
> > > +   if (unlikely(folio_test_swapcache(folio)))
> > > +           return __folio_swap_dev_pos(folio);
> > > +   return ((loff_t)folio->index << PAGE_SHIFT);
> >
> > This still looks confusing for me.  The function returns the byte
> > position of the folio in its file.  But we returns the swap device
> > position of the folio.
> >
> > Tried to search folio_file_pos() usage.  The 2 usage in page_io.c is
> > swap specific, we can use swap_dev_pos() directly.
> >
> > There are also other file system users (NFS and AFS) of
> > folio_file_pos(), I don't know why they need to work with swap
> > cache. Cced file system maintainers for help.
>
> Time for a history lesson!
>
> In d56b4ddf7781 (2012) we introduced page_file_index() and
> page_file_mapping() to support swap-over-NFS.  Writes to the swapfile wen=
t
> through ->direct_IO but reads went through ->readpage.  So NFS was change=
d
> to remove direct references to page->mapping and page->index because
> those aren't right for anon pages (or shmem pages being swapped out).
>
> In e1209d3a7a67 (2022), we stopped using ->readpage in favour of using
> ->swap_rw.  Now we don't need to use page_file_*(); we get the swap_file
> and ki_pos directly in the swap_iocb.  But there are still relics in NFS
> that nobody has dared rip out.  And there are all the copy-and-pasted
> filesystems that use page_file_* because they don't know any better.
>
> We should delete page_file_*() and folio_file_*().  They shouldn't be
> needed any more.

Thanks for the explanation! I'll update the series, and just delete
paeg_file_offset and folio_file_pos with more auditing, to make the
code cleaner. Should I add a suggest-by for the removal?

