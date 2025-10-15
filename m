Return-Path: <linux-fsdevel+bounces-64317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 806DABE0A25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 22:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59D71A200DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 20:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270202D640F;
	Wed, 15 Oct 2025 20:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igerKaBd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19C42C15B1
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 20:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760560133; cv=none; b=Kjr9xGrZcmZ7lyCFIqGfOfXvkf7lIg7IouzfPjDAO4MYgvHjwPThZjDkPDKLKPKywWEuiFSYpiziYKyhZUG9PsCHdW3hPysj5hNBEFvDIocYGwKGLJi/YBhPhUuNRnNbZNWWxX4kzULKx03D1hHz3lJzD5L2w7Xby2a24+4khqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760560133; c=relaxed/simple;
	bh=GfW7nLyntXDYIXKIQ+YtakbDrhIW2xPxJZieBsO6EQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRQWfRmm1VcmPbWx/f7WqvfDuMtU6gkRkTRQFGAWgIuI+Q48Ue8uHXFcTRmOLLrlxF6oPeMt8mwlkiEf2xu7R2+dC8FIHKM3mMA34LMWYRuZM8I80EuWowT+GE4Uk6g0wWPRwRK6Vixnai5HaYgCy2bVa6YtmyJEibp8ds7lleU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igerKaBd; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8593bcdd909so972625385a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 13:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760560131; x=1761164931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCtklihtbOhFVtWrXC87SZH/yrccGP2P2vSXXm4fCXM=;
        b=igerKaBdmzGtmODBpCySu/CGD3dt9wc/VUwWa1RoFFVzQf3bNRXh4jwQ03sNSICFq1
         B6TX/GQdKChZJIEpA2aM7jqE+Xjlx2SU3WDuZZR9HR15QNIPQGygRKsCJ/mi2i/B1x6Z
         npVMA2PyXrCH5B8AJsgICxN5FD+yZqyb0m7Ef7cVP8K75CWn5QnATCJSLUtV4rIvBvEq
         YWrbON0Bfb8U6LDxZhtoJ8DAUP2TnvTHzyV0/00HU9WqFirRJQ6ygyQzs53yWH2teQVD
         Rhmiw1NoGfwF0Bq2q8j64GSZu5XbfXDmEXwpfYlIplZtXgs/hoQTqkfsTHwXJaqJ3yAn
         5L6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760560131; x=1761164931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCtklihtbOhFVtWrXC87SZH/yrccGP2P2vSXXm4fCXM=;
        b=GgVNsAB72OHulkS9aPhz9Cz9nEb88tzOelkTjgK7DRLbqE1FKtAY6QJ0G4oiP2roPZ
         Lfh30ESwsNSrGPGcBRozkx6U4Z3D/JqQU9Vam+vvPEFw2PYeYyQmXdDL30J+HwBtTwrU
         a2sn9h1R1KkY0J4E9OGoDsyxKQN74NHvaOc4dWINFc2hj2UUFjpPHZrQ4hSIozXGkCAT
         u5+D1R0drsvLZ9d6KUeL2BFpkeqDNhhe+SIoWUWAzg8hMf5vPn5Yz/AeKBomfRwsnek8
         HeLkGfWXrdIuKgNFatjXsyZcsmnRl/1Kq9nuZFb5TDRDZ7laWo92Jx+c+6Ml3dILnURC
         hGXA==
X-Forwarded-Encrypted: i=1; AJvYcCVqfb/rowPfiw1N9m1mhIsxLeCKGbMLsIY+9FMrmvF/q1wHtsHZ7LOL9HKeL5H16gQdSeZYzZ83iJaim0ZG@vger.kernel.org
X-Gm-Message-State: AOJu0YwZJ43KHJRQCxK7Rmzhjkc6y6eykCytLgXL2I9cGjmZSX2Oo7qJ
	EDopy2KggozJC+/b+5pHryIqmf+lEei0aukXONuDsczAbO4Bfqk/dtLruNAhZ+1b2vwUmyiDlEi
	fTrHHOEk7q7yPmwOjS3QATfFDRnTU/tU=
X-Gm-Gg: ASbGnctvhdRNAJZrLUkrfWV7/n5usZmMfjBoMkEjth+wOWP5A8ECs5kegGg3cbbl6jd
	Y16S04Kw548r2id182zzDnlcUO5H9bX+tO6Dh0ZQY1U006+TTDkM8NdLIyGid2jtaYqqlGuPG7T
	Wt3L1g19KrgTxzsk4lD+JLEOUkzewFGXX9+C5X8BFjx1qsko2jOI3JFNhAs7rbYBSClPJmEczqg
	9+wvoOg8nNQwT8j7erxmAqMEahvAvz6IXqqs5u8qwalJW5gDdNaxa2Mo+6YAL91gsZS/HQubmGu
	D4LSG+O0+KFQ26jT
X-Google-Smtp-Source: AGHT+IFCn7H/zNcXBxMpbrNmnQeoIxLu56FopThW4xhIHn56Aba+VqVESsjEtwVMcEHmuG8hzRQAx2vIJIxHR6DsZYo=
X-Received: by 2002:a05:622a:995:b0:4b4:9489:8ca9 with SMTP id
 d75a77b69052e-4e6ead5afc4mr367197571cf.54.1760560130795; Wed, 15 Oct 2025
 13:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aO06hoYuvDGiCBc7@bfoster> <CAJfpegs0eeBNstSc-bj3HYjzvH6T-G+sVra7Ln+U1sXCGYC5-Q@mail.gmail.com>
 <aO1Klyk0OWx_UFpz@bfoster> <CAJfpeguoN5m4QVnwHPfyoq7=_BMRkWTBWZmY8iy7jMgF_h3uhA@mail.gmail.com>
 <CAJfpegt-OEGLwiBa=dJJowKM5vMFa+xCMZQZ0dKAWZebQ9iRdA@mail.gmail.com>
 <CAJnrk1Z26+c_xqTavib=t4h=Jb3CFwb7NXP=4DdLhWzUwS-QtQ@mail.gmail.com>
 <aO6N-g-y6VbSItzZ@bfoster> <CAFS-8+Ug-B=vCRYnz5YdEySfJM6fTDS3hRH04Td5+1GyJJGtgA@mail.gmail.com>
 <CAJfpegsiREizDTio4gO=cBjJnaLQQNsmeKOC=tCR0p5fkjQfSg@mail.gmail.com>
 <CAJnrk1b=UMb9GrU0oiah986of_dgwLiRsZKvodwBoO1PSUaP7w@mail.gmail.com> <aO_6g9cG1IVvp--D@bfoster>
In-Reply-To: <aO_6g9cG1IVvp--D@bfoster>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 15 Oct 2025 13:28:39 -0700
X-Gm-Features: AS18NWBUad1fkce9hs92YgRf8HsxWvhoWh_6BAI1le74rtdPJ69SePpQwXy3Svs
Message-ID: <CAJnrk1Y+rdH11k_n947Z2rofu39=9=C5CRK5USi7Z1CnEG7fcg@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Brian Foster <bfoster@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, lu gu <giveme.gulu@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 12:44=E2=80=AFPM Brian Foster <bfoster@redhat.com> =
wrote:
>
> On Wed, Oct 15, 2025 at 10:19:15AM -0700, Joanne Koong wrote:
> > On Wed, Oct 15, 2025 at 7:09=E2=80=AFAM Miklos Szeredi <miklos@szeredi.=
hu> wrote:
> > >
> > > On Wed, 15 Oct 2025 at 06:00, lu gu <giveme.gulu@gmail.com> wrote:
> > > >
> > > > >  Attaching a test patch, minimally tested.
> > > > Since I only have a test environment for kernel 5.15, I ported this
> > > > patch to the FUSE module in 5.15. I ran the previous LTP test cases
> > > > more than ten times, and the data inconsistency issue did not reocc=
ur.
> > > > However, a deadlock occur. Below is the specific stack trace.
> > >
> > > This is does not reproduce for me on 6.17 even after running the test
> > > for hours.  Without seeing your backport it is difficult to say
> > > anything about the reason for the deadlock.
> > >
> > > Attaching an updated patch that takes care of i_wb initialization on
> > > CONFIG_CGROUP_WRITEBACK=3Dy.
> >
> > I think now we'll also need to always set
> > mapping_set_writeback_may_deadlock_on_reclaim(), eg
> >
> > @@ -3125,8 +3128,7 @@ void fuse_init_file_inode(struct inode *inode,
> > unsigned int flags)
> >
> >         inode->i_fop =3D &fuse_file_operations;
> >         inode->i_data.a_ops =3D &fuse_file_aops;
> > -       if (fc->writeback_cache)
> > -               mapping_set_writeback_may_deadlock_on_reclaim(&inode->i=
_data);
> > +       mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_data);
> >
> >
> > Does this completely get rid of the race? There's a fair chance I'm
> > wrong here but doesn't the race still happen if the read invalidation
> > happens before the write grabs the folio lock? This is the scenario
> > I'm thinking of:
> >
> > Thread A (read):
> > read, w/ auto inval and a outdated mtime triggers invalidate_inode_page=
s2()
> > generic_file_read_iter() is called, which calls filemap_read() ->
> > filemap_get_pages() -> triggers read_folio/readahead
> > read_folio/readahead fetches data (stale) from the server, unlocks foli=
os
> >
> > Thread B (writethrough write):
> > fuse_perform_write() -> fuse_fill_write_pages():
> > grabs the folio lock and copies new write data to page cache, sets
> > writeback flag and unlocks folio, sends request to server
> >
> > Thread A (read):
> > the read data that was fetched from the server gets copied to the page
> > cache in filemap_read()
> > overwrites the write data in the page cache with the stale data
> >
> > Am i misanalyzing something in this sequence?
> >
>
> Maybe I misread the description, but I think folios are locked across
> read I/O, so I don't follow how we could race with readahead in this
> way. Hm?

Ah I see where my analysis went wrong - the "copy_folio_to_iter()"
call in filemap_read() copies the data into the client's user buffer,
not the data into the page cache. The data gets copied to the page
cache in the fuse code in fuse_copy_out_args() (through
fuse_dev_do_write()), which has to be under the folio lock. Yeah
you're right, there's no race condition here then. Thanks for clearing
this up.

>
> Brian
>
> > Thanks,
> > Joanne
> > >
> > > Thanks,
> > > Miklos
> >
>

