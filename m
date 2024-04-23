Return-Path: <linux-fsdevel+bounces-17510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004DC8AE845
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 15:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1361F229FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 13:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A16D136658;
	Tue, 23 Apr 2024 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9p8qZQD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5839818E28;
	Tue, 23 Apr 2024 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713879255; cv=none; b=vDuIMIpt0/qvl5c2wVd06CI9kXGtXR7JQhrsYpqPNwOlXdwxkE92iuakit4byfkAnGsDVWLfJ1bxvqayiXXe0tq9veAZ7YAhkjs1LdOg61psPVdWS0ZKzt7DZZS0RucmLGR07iJ2MwT5ez2WHOLue3BppASs6x16G01kAejFEmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713879255; c=relaxed/simple;
	bh=eg6CHXM+1oDdRKlyGE4oIWweBZixWe12oxL3KrdPI2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFxG82h2AZpMQhIo1WEsNDGPkGDLUxX2rEn4vkrxmz14PPp33UC2ZxUOqDLqg61HO/IAFlFa49mxY0mtH9Yu5u8sF96DNsidlur7tw4vV3YvPooJHuDFukCzNTGtOxKzDYKDrwGDoG5n2+vhOAZuwdyNp7ieai7QpaAJRC6eDdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9p8qZQD; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2dd6c14d000so29955771fa.0;
        Tue, 23 Apr 2024 06:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713879251; x=1714484051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bc0c4MIvRavnylcD7Rjn0guOwInCRxicWBFGidWWE0=;
        b=C9p8qZQDb7b+1lsRlH1KWfEivrzri4xjAzwLruURaXLYYtrxh23+8Dq0BFbWDgP9VB
         dvzTe+E7fglEIYhG7CZUFQId76jNA1U2pnnV/hZeoTZFLdLtAIHFe0v7nHyt0Qo6JCwK
         qYnlpd4hYc32KptEIK0+SmfvD9CQjW2gh7c/6xM90ERstaAhL3PxNvX++mtZb57fP34x
         DXA99oV1aUhVO3Kdk5IWhiZAEyY7CMwItAErprNpA1hRlUHQ8FmM3WrAZPm4FQ1DHus5
         COaDm1G5NnRXDOK98MK9p5ArbI42hlxVlSglRY57CBmSqe1dqEgUMV5AEea6s5O1jLmU
         gYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713879251; x=1714484051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bc0c4MIvRavnylcD7Rjn0guOwInCRxicWBFGidWWE0=;
        b=mv2OBuDEunIFvkMSHFZh9HiwnbYRfvWB/JbZMx2sm+u0/dUWTm439M5qHB6kEdCvUD
         GCXIS9K/qchiJmsffiWBVDiOUXvNx/ulvjaN+BInbPWU0RDZWws3rSE6neyslK0A2o8U
         U4iceh4HYUiWs/xnritXPKqVC+1RmBATOQELE3siK8J454yp1BvXpPcpkpiBelgYVB1u
         d6mboZ2uqr4wu0tv3mUVdEtY4RQAdHdAWlPvjHwk4b/2bBod68WdzVhwjksNyAjENTvK
         BQIfV2dj9Nmh3uI9vk1b4e5GEWBSt4XLNlfjMOZGCHCWek+BSLtrb9Jzh3fpqRAtVzvy
         ALVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgkJJdnf0PraJQDcBGJfe64M51/iupBhRnlAdniLCjk2gsrwVf6df5zx1gWbWnJY0gElp6LFLXZREIv3SFA5HJMrbWzcPYYUU8FgzBt/V8Brp6wbP1dnCtFSL32Z3HbYWpYEac5cW73sy0Xw==
X-Gm-Message-State: AOJu0YzC5UIURx62rywDnAE/9bpGVbW+FxzBLtshVAd12rlfqGM0a0bp
	GTU3sr1kLqECfVvlpUg/FRZj0D1jT9tWFUy4GSBUvjiJKYQYv3F7OYB285WwZDq2LXnmSOb60xj
	DM5IVuEhhvaa4kXyWI1LltwMMDGw=
X-Google-Smtp-Source: AGHT+IHcGTmZHEOrIhZSVAH27HOvMiVHDiMwPl5ZaJV4e+FbQeZnWOfsfMYvzZFDGpBxKFn26o7uZbAMkFAw1v26gqU=
X-Received: by 2002:a2e:9699:0:b0:2d9:e54d:81eb with SMTP id
 q25-20020a2e9699000000b002d9e54d81ebmr9744299lji.12.1713879251195; Tue, 23
 Apr 2024 06:34:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417160842.76665-1-ryncsn@gmail.com> <20240417160842.76665-7-ryncsn@gmail.com>
 <87mspkx3cy.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87mspkx3cy.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 23 Apr 2024 21:33:54 +0800
Message-ID: <CAMgjq7CH0xCEXF6nwsNZYW7Rcx0YF1+7Sb_ycXe2k10hbZc_tA@mail.gmail.com>
Subject: Re: [PATCH 6/8] mm/swap: get the swap file offset directly
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 9:43=E2=80=AFAM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > folio_file_pos and page_file_offset are for mixed usage of swap cache
> > and page cache, it can't be page cache here, so introduce a new helper
> > to get the swap offset in swap file directly.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/page_io.c | 6 +++---
> >  mm/swap.h    | 5 +++++
> >  2 files changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/page_io.c b/mm/page_io.c
> > index ae2b49055e43..93de5aadb438 100644
> > --- a/mm/page_io.c
> > +++ b/mm/page_io.c
> > @@ -279,7 +279,7 @@ static void sio_write_complete(struct kiocb *iocb, =
long ret)
> >                * be temporary.
> >                */
> >               pr_err_ratelimited("Write error %ld on dio swapfile (%llu=
)\n",
> > -                                ret, page_file_offset(page));
> > +                                ret, swap_file_pos(page_swap_entry(pag=
e)));
> >               for (p =3D 0; p < sio->pages; p++) {
> >                       page =3D sio->bvec[p].bv_page;
> >                       set_page_dirty(page);
> > @@ -298,7 +298,7 @@ static void swap_writepage_fs(struct folio *folio, =
struct writeback_control *wbc
> >       struct swap_iocb *sio =3D NULL;
> >       struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> >       struct file *swap_file =3D sis->swap_file;
> > -     loff_t pos =3D folio_file_pos(folio);
> > +     loff_t pos =3D swap_file_pos(folio->swap);
> >
> >       count_swpout_vm_event(folio);
> >       folio_start_writeback(folio);
> > @@ -429,7 +429,7 @@ static void swap_read_folio_fs(struct folio *folio,=
 struct swap_iocb **plug)
> >  {
> >       struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> >       struct swap_iocb *sio =3D NULL;
> > -     loff_t pos =3D folio_file_pos(folio);
> > +     loff_t pos =3D swap_file_pos(folio->swap);
> >
> >       if (plug)
> >               sio =3D *plug;
> > diff --git a/mm/swap.h b/mm/swap.h
> > index fc2f6ade7f80..2de83729aaa8 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -7,6 +7,11 @@ struct mempolicy;
> >  #ifdef CONFIG_SWAP
> >  #include <linux/blk_types.h> /* for bio_end_io_t */
> >
> > +static inline loff_t swap_file_pos(swp_entry_t entry)
> > +{
> > +     return ((loff_t)swp_offset(entry)) << PAGE_SHIFT;
> > +}
> > +
> >  /* linux/mm/page_io.c */
> >  int sio_pool_init(void);
> >  struct swap_iocb;
>
> I feel that the file concept for swap is kind of confusing.  From the
> file cache point of view, one "struct address space" conresponds to one
> file.  If so, we have a simple file system on a swap device (block
> device backed or file backed), where the size of each file is 64M.  The
> swap entry encode the file system (swap_type), the file name
> (swap_offset >> SWAP_ADDRESS_SPACE_SHIFT), and the offset in file (lower
> bits of swap_offset).
>
> If the above definition is good, it's better to rename swap_file_pos()
> to swap_dev_pos(), because it returns the swap device position of the
> swap entry.

Good suggestion! The definition looks good to me, swap_dev_pos also
looks better, "swap_file" looks confusing indeed.

>
> And, when we reaches consensus on the swap file related concept, we may
> document it somewhere and review all naming in swap code to cleanup.
>
> --
> Best Regards,
> Huang, Ying

