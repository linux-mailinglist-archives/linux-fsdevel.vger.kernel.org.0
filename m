Return-Path: <linux-fsdevel+bounces-51079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E78AAD2AB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 01:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808F83AF23C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 23:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA03D22FE0C;
	Mon,  9 Jun 2025 23:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnH+GVcz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4001DF25A;
	Mon,  9 Jun 2025 23:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749513276; cv=none; b=V7ICwBqPAl0BTgar7GcnB3LEKlUmb+8HgWufoY45SyujSPLfnPQoedgELhmwbGyQNvU0kZHDAPp5gh2wGaDX2zhiTe51ROZIT0B7C3wWanr0lrYREVU42lRAh7MghsGVVJRrtrdDBe2YCTDLUlJoy9B1PXBm5yWbWOFYkFk1yp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749513276; c=relaxed/simple;
	bh=TfiTokhSvZDRFtsMqphG9ReG9nAWQpi/eq74dWHtPk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nptsC5tUwKYMwKtHqJikMeZTR9rlr2ePZk1wnkp5mgV8CfdHbpD1/DDIczv1ADu2QZsVzbd6PHhIX2oF5cRpZPcfirExhD98hh1FsWfXXesZODwFLa40FlJQDwz4m96Ddo6bh2sU2sy559ldP/9ULE1MCSMWp8v5sUuNQpxZPSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnH+GVcz; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3ddd68aeb4fso26424785ab.2;
        Mon, 09 Jun 2025 16:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749513274; x=1750118074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2retAMPgjoe+SW987bSchHfnyt3raITKgOpuzu4AP0=;
        b=fnH+GVczMOgrXeQTiDnomNM/YKvGlTxSRMDi8U/P3VGeaZWHx/A0/QhvCdK6d3cgdQ
         +NQmDPUOYlVHmwJtnNfWaq7jdd1QLDAU+D243uqLhV4iJ1d+sAFD9paWNQ4eUI6J/4dR
         NzsPvYC9IOxJYmNdYWhyAsN8mVotfhsqxde2Cie1JbvxGi2AQjtRr53MnM5/WaSKBODU
         aFNJUMLQPdK8BEvCUcSGlwgDB2JWnlOAB4OGOQIIE87Rt6HtCZziP08/FOi6hZqZv3k1
         uqj6iUALcKqDiNrwAdPkXGC4C2N3SVR3/nUMPw7QR+kc8RmDyDIJCN5Ppmo9kNfGLdip
         4/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749513274; x=1750118074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2retAMPgjoe+SW987bSchHfnyt3raITKgOpuzu4AP0=;
        b=wul0F15myzFx9IPnMzrJ506HLxZY0ivrZCg5XmHfzxxRMYkUa2V/1zIU2x9TV7leZR
         KgIiJ5FGb3LIqKqwEUKw5zLbzcpQmULWs9dtLxT/JUh1jpCNLz56v2pcD9ryzv7clSTm
         NAth59JPk5mPsCXlv6lzipRth6jBVK9278fEEzI0rgrMzGZj+PDouXmOsYTDuvGqwi3f
         nTJtcTES4LaFyGVCA8dExSBynkqvmcclaD7IfeGBKae/q7uF4tR4C8B/7DGWWvjPNY//
         gCNyniHeYp74GtAN3OnhcguCm5nLIt8FtnAsaD4KMqgnVO2/U6p1BKfi/lnIgXkxyOpC
         BS7w==
X-Forwarded-Encrypted: i=1; AJvYcCVTSNnfcHpeoESTF0coyDUJTziZfCamUAtgSxCwiSn7WO+5R98y0B0Py74n5yt/K8JJm+ZN9T5NNUVLDFvl@vger.kernel.org, AJvYcCWl/Fv9GZrZThNMwDsWaBx9NMa/aFB//hCSLkuz5yh5hUtyvFJPi+dr3nCc6VK3qUTmk3Uk1nFXQO7n@vger.kernel.org
X-Gm-Message-State: AOJu0Yz12XUdcy4FrNY7sFENaq40CuyWFnpcO1BH7GrmS+sO03/vQPEj
	9kzL8aXuu9sQsqAeIvH19p74GPJnD7vqtEOjkyGJzzBpXkTpe8UY6zfFk2SGXcMpPuOEuLOa87B
	cU2EHbh2HaghVJwo+bRtw4bmepgxOXikrBTCEv4s=
X-Gm-Gg: ASbGnctjnCPCiWPAWEKDkFtnewqjsBMz8FqcMMafKxcPX+uSLImajs61O6MrwOS7KJT
	kkjQoTAslKbu2SqTydanijerSE+pU0oZOlV+Ks2TImyhV6V3s07H+6fnSLSqbhLIHZRqm6OWFFd
	EEt3GmEg+VkR6pC8pP7anV0v48zJxUYFIwuFu07PSk0bk=
X-Google-Smtp-Source: AGHT+IH03ti8Si96egktPqBkH4XltNBMZvSTqGkEfxgNTMWSddG1U/FlRvm4BSZZkixPi5eBwNqGg1IFWLeBAiw7B30=
X-Received: by 2002:a05:622a:8c8:b0:494:a2b8:88f0 with SMTP id
 d75a77b69052e-4a70acbfdc8mr9181241cf.33.1749513261315; Mon, 09 Jun 2025
 16:54:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-6-joannelkoong@gmail.com> <aEZoau3AuwoeqQgu@infradead.org>
 <20250609171444.GL6156@frogsfrogsfrogs>
In-Reply-To: <20250609171444.GL6156@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 9 Jun 2025 16:54:10 -0700
X-Gm-Features: AX0GCFv8kTY6nXxm5yZ_BALKLU_dSXpCuQzLVqF877vN7trwyx-VyuwSWUXZZ_4
Message-ID: <CAJnrk1Yv+Jm4zMqQ+O1jdOE5V-T0m+aZ3Xr6H+e=_22s7fNxdg@mail.gmail.com>
Subject: Re: [PATCH v1 5/8] iomap: add iomap_writeback_dirty_folio()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, miklos@szeredi.hu, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 10:14=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Sun, Jun 08, 2025 at 09:51:54PM -0700, Christoph Hellwig wrote:
> > On Fri, Jun 06, 2025 at 04:38:00PM -0700, Joanne Koong wrote:
> > > Add iomap_writeback_dirty_folio() for writing back a dirty folio.
> > > One use case of this is for folio laundering.
> >
> > Where "folio laundering" means calling ->launder_folio, right?
>
> What does fuse use folio laundering for, anyway?  It looks to me like
> the primary users are invalidate_inode_pages*.  Either the caller cares
> about flushing dirty data and has called filemap_write_and_wait_range;
> or it doesn't and wants to tear down the pagecache ahead of some other
> operation that's going to change the file contents and doesn't care.
>
> I suppose it could be useful as a last-chance operation on a dirty folio
> that was dirtied after a filemap_write_and_wait_range but before
> invalidate_inode_pages*?  Though for xfs we just return EBUSY and let
> the caller try again (or not).  Is there a subtlety to fuse here that I
> don't know about?
>

This is something I've been confused about too, as to why there even
is a launder_folio() and why some filesystems (eg orangefs, nfs,
btrfs, fuse) call it but others don't.

It was added in commit e3db7691 ("[PATCH] NFS: Fix race in
nfs_release_page()") but I fail to see how that commit fixes the race
condition described in the commit message.

My theory is that it's only needed by remote/network filesystems
because maybe they need stronger data consistency guarantees? Out of
the ones that implement launder_folio(), btrfs is the anomaly but when
I checked with the person who added it to btrfs, they said it was a
hack for something else because it got called at the right time.

Looking forward to being enlightened on this as well.

> (Both of those questions are directed at hch or joanne or anyone else
> who knows ;))
>
> --D
>
> > > @@ -1675,7 +1677,8 @@ static int iomap_writepage_map(struct iomap_wri=
tepage_ctx *wpc,
> > >      * already at this point.  In that case we need to clear the writ=
eback
> > >      * bit ourselves right after unlocking the page.
> > >      */
> > > -   folio_unlock(folio);
> > > +   if (unlock_folio)
> > > +           folio_unlock(folio);
> > >     if (ifs) {
> > >             if (atomic_dec_and_test(&ifs->write_bytes_pending))
> > >                     folio_end_writeback(folio);
> >
> > When writing this code I was under the impression that
> > folio_end_writeback needs to be called after unlocking the page.
> >
> > If that is not actually the case we can just move the unlocking into th=
e
> > caller and make things a lot cleaner than the conditional locking
> > argument.
> >
> > > +int iomap_writeback_dirty_folio(struct folio *folio, struct writebac=
k_control *wbc,
> > > +                           struct iomap_writepage_ctx *wpc,
> > > +                           const struct iomap_writeback_ops *ops)
> >
> > Please stick to the usual iomap coding style:  80 character lines,
> > two-tab indent for multiline function declarations.  (Also in a few
> > other places).
> >
> >

