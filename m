Return-Path: <linux-fsdevel+bounces-64055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0D8BD6C27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 01:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811183B3CC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 23:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D26C2DAFC3;
	Mon, 13 Oct 2025 23:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGJI0VVD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A25296BD4
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 23:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760399045; cv=none; b=pmrBohx25wEDEZWZ00Jsx3+mG77+DrMgVcfLLr+qTL83No+UOqS4BbRusGwcHmRh7f2eFtGb4JJzv8pKDJy7Rnw2J7pHIjhfdkPR7mhyROcpjBjx6fMJWP0e24+IDnGjciMR1kWAW93rI87rNwrUWngKCNF64OgAOSHTLxk0wvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760399045; c=relaxed/simple;
	bh=lTN/4dshYHJS8Xf6C8+IwFRQ+h3IoZkrC+4p2EDmC9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MK0c7GD3bcjp8jRO1PrUa/zqpiW2B9wpA8vJYkrbh/cAdIWfeiNx3XK26+5HarHovXJhO+vsRBr+c41E+Ob/oUi2CZ5hkYQC8GhVz/ClGNmUyWAD/8SiEQQu6M029+JhmoJP46xTjyaPWrvWNpABwGcmEUBDnxW/8J1IuG2HdWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGJI0VVD; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-862cbf9e0c0so582108485a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 16:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760399043; x=1761003843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fcfq3wYKPKDfuovKB/bu4SSwaXNU472P6ItWUY1vQSs=;
        b=UGJI0VVDOPj+yB2ck7yETxDd+YgYSWB+To85sRS9pZS0R/rFukUMPDMNBaa+xK5Kyn
         vXo35G3DvkWyuG6nhWWrBPlEc+r2Ofv1A5n6bLymyaq4eTsPBTe7t6FQIXkuBu7qnu4D
         PeZJqfseA85mzIg6Z2r6hDQLTwq5lPK6DV74muCvtodDpyKRPC7qm+oaUF51YN1fF6Q7
         ffbmwtDepDU+yJOFZbNE9X23wQm4BtJzO9erRsHWQdaz5TLaW/NZ4fcRA//ktpw/2c33
         w0eAjb1sUsKhqoY22Ds6u4nD8UM9bUQ49Zyu3eCwucsXPKt6vIXIiy5ysHJqnTteNmJV
         VXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760399043; x=1761003843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fcfq3wYKPKDfuovKB/bu4SSwaXNU472P6ItWUY1vQSs=;
        b=OYFNgdmFlWMvVgghSG1xzOJlZ4JZ8/HEyQKSG+1jGz+9eCvobyQTzOtk4LeY/XVLd5
         zEy1063ktEP6mD0YaZpMq1+upk7MLq0FlPoMjxZs+PXNDCYIl60EURuKG14PbuWIGlxK
         zByD5F2zAhPAFdRcr6l79HtKRSguvOnLACGAJt3mhI4y1ZT+Yrb8160NfcZPP3TbfrsV
         zWuQhxcLsKjnJpxbk8d0gwQhxEJGRUxYatOhSAp96ox61uS07dN41T2ABAaZ+HhhLIIY
         dOB2NEnOA7E4Evz07TSRWOVc7G+SVrN+6mNZzQfWpzVAMS8NK4PoKyaDbkTBPILW8L5p
         YnKA==
X-Forwarded-Encrypted: i=1; AJvYcCVqXpKbiornYnFV7IB8znYYDsPBKNRN0Pk0bfoMKk7I8vB9GBPVcH7ffDIYBLEhSOOqhS9OXIMAA/WtObgf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3b+w5uYM586jxpIGYGP++Q4Bi4qRlyyGxJLJScpqtmcK2byT6
	bwC74hNMC8i64gCRzfk4rnSOvVUmR9I53NFSuH6n/2LdzvJOkODWQlz5TscROMRWi5M66hvek3l
	n/3CDCaca+OIqjxzHrtxnts3DcdkwGPk=
X-Gm-Gg: ASbGncurseNg1TCIo54iPF56G66pj0LU8oCbFFlb5SObYi39S3oGtGSoJvnHXxREbrb
	9Yeilx3MtYw28uf9wdLAa02BbitGQTfdXlCRPTAqOKMmbQWW/8AYlfiob1bPKt80QwD+4c97LbU
	9IxfWbb9Ahs3Bg4V9IW5xFJf6e4FDk+xyw6bDA+RFjPIAqDdtSh/3T0fkjCazsz/qwvt1tZP4lA
	XMaKHEJC99JixiWprDyIza9L0LNQP+BD/F8xlGIrdG5+tFqgJw3NfEjDPa1VzwKUiJa
X-Google-Smtp-Source: AGHT+IFjGz+7Ld7bHpzh1nixgdGnpIiA9pK5zlIGJfWjhkQSHIELBmg0ooOGVC8rB2hVOh1Ke+sHjkAe1jdnj845UHw=
X-Received: by 2002:a05:622a:507:b0:4e5:8180:d4fa with SMTP id
 d75a77b69052e-4e6ead4a78cmr312347421cf.39.1760399043010; Mon, 13 Oct 2025
 16:44:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009110623.3115511-1-giveme.gulu@gmail.com>
 <CAJnrk1aZ4==a3-uoRhH=qDKA36-FE6GoaKDZB7HX3o9pKdibYA@mail.gmail.com>
 <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com> <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
In-Reply-To: <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 13 Oct 2025 16:43:51 -0700
X-Gm-Features: AS18NWDK8t9_4iv2EwgPQOgbWcCzxf5sTyBiih-mxZtZOyOvQr6d1022tqdpMmQ
Message-ID: <CAJnrk1YRNw5M2f1Nxt619SG+wUkF+y2JrMZZCyLqWVd59+-gjA@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: lu gu <giveme.gulu@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brian Foster <bfoster@redhat.com>, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 6:40=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Fri, 10 Oct 2025 at 10:46, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > My idea is to introduce FUSE_I_MTIME_UNSTABLE (which would work
> > similarly to FUSE_I_SIZE_UNSTABLE) and when fetching old_mtime, verify
> > that it hasn't been invalidated.  If old_mtime is invalid or if
> > FUSE_I_MTIME_UNSTABLE signals that a write is in progress, the page
> > cache is not invalidated.
>
> [Adding Brian Foster, the author of FUSE_AUTO_INVAL_DATA patches.
> Link to complete thread:
> https://lore.kernel.org/all/20251009110623.3115511-1-giveme.gulu@gmail.co=
m/#r]
>
> In summary: auto_inval_data invalidates data cache even if the
> modification was done in a cache consistent manner (i.e. write
> through). This is not generally a consistency problem, because the
> backing file and the cache should be in sync.  The exception is when
> the writeback to the backing file hasn't yet finished and a getattr()
> call triggers invalidation (mtime change could be from a previous
> write), and the not yet written data is invalidated and replaced with
> stale data.
>
> The proposed fix was to exclude concurrent reads and writes to the same r=
egion.
>
> But the real issue here is that mtime changes triggered by this client
> should not cause data to be invalidated.  It's not only racy, but it's
> fundamentally wrong.  Unfortunately this is hard to do this correctly.
> Best I can come up with is that any request that expects mtime to be
> modified returns the mtime after the request has completed.
>
> This would be much easier to implement in the fuse server: perform the
> "file changed remotely" check when serving a FUSE_GETATTR request and
> return a flag indicating whether the data needs to be invalidated or
> not.

Doesn't this still lead to a problem if the data does need to be
invalidated? If the data changed remotely, then afaict the page cache
would have the new updated data but the newest write data would still
be missing in the page cache.

Thanks,
Joanne

>
> Thoughts?
>
> Thanks,
> Miklos

