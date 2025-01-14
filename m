Return-Path: <linux-fsdevel+bounces-39169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACA9A11091
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 19:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA663A0384
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 18:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5BD1FBC8A;
	Tue, 14 Jan 2025 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNpw2bOI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB8D18952C
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 18:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736881099; cv=none; b=hKYUJhnTWH3Uuus1z7vLre+r74D4gZZ2km67aO2VxR6pHqg4NiXWr8RSIjSZfRgAOqDLB9DS+miD7rgjum1xZ3VhkiS/QufvcwPS4SVqOOmvO1KTohewqxd8Ln+sVsZesmcdIaVsfCTzJhG7guAh/O9QJxibBT7oFsYrD4u0nF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736881099; c=relaxed/simple;
	bh=cj9ROOQqXmFKAqAEW5rjcqnaKh2f2YkwwgT+wO1DlZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XD06Z9RZdUJ7i+KXppodNMJjgXTkkZ9dequd835OUjoTuBZXrmvxZcqWb+EvPqhYA4JrN6FuxThUAXxItfDTIMPVBdvHi3IylboaOGugnb3x6Fi5Mi+qT5oxQ1IAqiEePGeedGLfT9HDGpn1r3OUUuyeTAtYZhSiBccipV3+v6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNpw2bOI; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b6edb82f85so690629185a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 10:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736881097; x=1737485897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7AHvURHt1sKIC0K/sgbG2CCAchF8Mz6y7cTbsB1kc0=;
        b=XNpw2bOI+OhJsmfJ7igksmlHvrQiGIxXe9YteUPM3GmFcQDQb3bDiABCBkHUPl6UaL
         Nce4RKayDOUuATgEp3+R1LxqullWaZMEHulxYUI0P8Pbu4r5OWO31M3a/JVK4/g8SBzG
         poFy/eDfevjCxXBEAbyekHHkXvAVeF9DP+7Itv1zR0plyDaj7dVMW9hhpmD2ARhTkU8C
         8FgZ5PAYwUfgmzPNjnnrOwaXgSxTuqojMblQ/d+Fy3cQbIiO7cA5TWvy645C5g+1TxtX
         ZE2VuWhmenNyXPfSSQwL9KVzNQ7kFUc8/8HzUdIUJb8iYkg4YDfiQTe0DGBxGNtzrPSr
         8vZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736881097; x=1737485897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7AHvURHt1sKIC0K/sgbG2CCAchF8Mz6y7cTbsB1kc0=;
        b=Bukg5bzZs6zx/+2tXiaGzalIWpfM9FbQMFLpXlz/9Yt3E+PRbR/OYgTzqZUIC9J+FR
         nrANO33psh0JmDZaS552nUH0gTUXdHDq2n2PSNxEHV/K83PPtXBxNnJ463kD1VdeoxZL
         QWGuaG5hnliNQpZpVmmO6w5YYrsbAplzC79Qe+QP+YldVr+l98JjO/uixqtIK8tObGKA
         AFtChVv9ubCXhu/xW2Hr2M2v72kBmVuj8D2xAvBKmUu/aW3EW0cnTuQTCZhSPDXOTVw2
         Z1zRsUBUj5cxDD17FecE4TCB32Db6WwySO3i/k8Tm722iIRTsrLjRpSPw0LmDCcmRxOw
         NiJw==
X-Forwarded-Encrypted: i=1; AJvYcCVaVEYny0PCjrp5+chVy5e/5vuksUdGmwtGy/SfcLO4nrshEcG3vQOtXwkKvjUYNFf+dc7dTNGFgoAgZGMH@vger.kernel.org
X-Gm-Message-State: AOJu0YwS4TAANaD5bOJ7m4BMe88Ho8Ag751D/UINrxQH7zdnF6sYjlJR
	Jq2h0OWjfO7PNCUVfPEDBiVZKqZrJMbrvvQh9tr6PSUoCzfljPP8HCwkGGfmjkxxeyMSGWSAoUy
	BwIbZzpqSr32Q0ysCyyW3fMvSlto=
X-Gm-Gg: ASbGncsuQPmRm7vgCnWESHbCrUv0pyt0LtMQZT5Nfyan2fS/VCP6MPtE0Lma5RvfD5O
	1cFggAwdU/o/5LMszqZfDW9Sk596apLfhQGT1NAY=
X-Google-Smtp-Source: AGHT+IE4Rh/65OQNsqN594Fzvl9PsXE8GDgTzXWH2A1d9OdMFSVVx2oCrnq5vsEhCqmx2aLdBGxS2pkGyg/ZFOdXlPc=
X-Received: by 2002:a05:622a:1a83:b0:467:5d0b:c750 with SMTP id
 d75a77b69052e-46c7100592amr438305131cf.22.1736881096201; Tue, 14 Jan 2025
 10:58:16 -0800 (PST)
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
 <CAJfpegs_YMuyBGpSnNKo7bz8_s7cOwn2we+UwhUYBfjAqO4w+g@mail.gmail.com> <d2c2df64510d2c3fd5d3cae5b06e8d553e291367.camel@kernel.org>
In-Reply-To: <d2c2df64510d2c3fd5d3cae5b06e8d553e291367.camel@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 14 Jan 2025 10:58:04 -0800
X-Gm-Features: AbW1kvYm6u6PzLmjyHjCePO02piHbTxSPKYgO94EhEVGoQp0QMSeqzJZVjdSzfg
Message-ID: <CAJnrk1aJYsXc9HfaJj23eSbbwGD14SkLYFD4AxsdujMq5HmNkA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Jeff Layton <jlayton@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, David Hildenbrand <david@redhat.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Zi Yan <ziy@nvidia.com>, linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com, 
	Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>, 
	Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 7:44=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Tue, 2025-01-14 at 09:38 +0100, Miklos Szeredi wrote:
> > On Mon, 13 Jan 2025 at 22:44, Jeff Layton <jlayton@kernel.org> wrote:
> >
> > > What if we were to allow the kernel to kill off an unprivileged FUSE
> > > server that was "misbehaving" [1], clean any dirty pagecache pages th=
at
> > > it has, and set writeback errors on the corresponding FUSE inodes [2]=
?
> > > We'd still need a rather long timeout (on the order of at least a
> > > minute or so, by default).
> >
> > How would this be different from Joanne's current request timeout patch=
?
> >
>
> When the timeout pops with Joanne's set, the pages still remain dirty
> (IIUC). The idea here would be that after a call times out and we've
> decided the server is "misbehaving", we'd want to clean the pages and
> mark the inode with a writeback error. That frees up the page to be
> migrated, but a later msync or fsync should return an error. This is
> the standard behavior for writeback errors on filesystems.

I think the pages already get cleaned and the inode marked with an
error in the case of a timeout. The timeout calls into the abort path,
so the abort path should already be doing this. When the connection is
aborted, fuse_request_end() will get invoked, which will call the
req->args->end() callback which for writebacks will be
fuse_writepage_end(). In fuse_writepage_end(), the inode->i_mapping
gets set to the error code and the writeback state will be cleared on
the folio as well (in fuse_writepage_finish()).

>
> > I think it makes sense, but it *has* to be opt in, for the same reason
> > that NFS soft timeout is opt in, so it can't really solve the page
> > migration issue generally.
> >
>
> Does it really need to be though? We're talking unprivileged mounts
> here. Imposing a hard timeout on reads or writes as a mechanism to
> limit resource consumption by an unprivileged user seems like a
> reasonable thing to do. Writeback errors suck, but what other recourse
> do we have in this situation?
>
> We could also consider only enforcing this when memory gets low, or a
> migration has failed.
>

I think there's a case to be made here that this "resource checking"
of unprivileged mounts should be behavior that already exists (eg
automatically enforcing timeouts instead of only by opt-in). The only
issue with this I see is that it might potentially break
backwards-compatibility, but I think it could be argued that
protecting memory resources outweighs that. Though the timeout would
have to be somewhat large, and I don't know if that would be
acceptable for migration.


Thanks,
Joanne

> > Also page reading has exactly the same issues, so fixing writeback is
> > not enough.
> >
>
> Reads are synchronous, so we could just return an error directly on
> those.
>
> > Maybe an explicit callback from the migration code to the filesystem
> > would work. I.e. move the complexity of dealing with migration for
> > problematic filesystems (netfs/fuse) to the filesystem itself.  I'm
> > not sure how this would actually look, as I'm unfamiliar with the
> > details of page migration, but I guess it shouldn't be too difficult
> > to implement for fuse at least.
> >
>
> We already have a ->migrate_folio operation. Maybe we could consider
> pushing down the PG_writeback check into the ->migrate_folio ops? As an
> initial step, we could just make them all return -EBUSY, and then allow
> some (like FUSE) to handle the situation properly.
> --
> Jeff Layton <jlayton@kernel.org>

