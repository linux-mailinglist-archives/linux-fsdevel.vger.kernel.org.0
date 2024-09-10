Return-Path: <linux-fsdevel+bounces-29044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCD4973E5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 19:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861AD1F22107
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 17:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721311A257C;
	Tue, 10 Sep 2024 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pnl8S/l6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588FE4A02
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988417; cv=none; b=RBtqgJWHKu/0N4xeg4Gd0nBmanVlTOqVvjXo2SJFD6yhSxtu+NAx/qBZpqv2wseAXAbijR4zGAmKDtiMQxgpXzenDoOmNoVquLE3ss6ECiKlhWoQRDX276ohpAlEoyADVb0xWuwKM6rvswid1TlxCnT1+nhVrcG0xnMXJrdMJbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988417; c=relaxed/simple;
	bh=n4zZaevy8DK6c9QDGJzAyp6jF0uMBsOhi8OfhVq6138=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QX7Er2/sWBSzj1hrQ9K5U2UEJzvfEbqflUA+1jjkMwjFdXUwOu6f+amwyKIBgHm8QNIiYM/U7TD9Hyf8C8hTJImmaCiodQIgEuXNifJONTUB9ylM/gAHe/3oJwgrH5T2Tw2Po0H6hCo+jwqZh+PH7DrnZ5UOjrdLAepB+ZuCbpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pnl8S/l6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725988414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3RXH2sS5iclmDvWYqk9mvzPNJZ9viOAgQZIm7N1DXqk=;
	b=Pnl8S/l6yyNZ9Y+R7iCzpWMnvxlVAomKaZpJjfEfb8mWNvn3x72nR7wwI7Q3qniP1A/VsD
	qez6KSD4A8kFpZkrcVLqn5YZj1qONfN/HayFiDNIOLfGL/+mr+ZswdiEul8Fiek9IZF9hH
	H//tSQjbzYoFIJB1PExNeb9H3stlHIw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-_5_K45HiNteMwCLLszX_SA-1; Tue, 10 Sep 2024 13:13:30 -0400
X-MC-Unique: _5_K45HiNteMwCLLszX_SA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-53659c3c9bdso831240e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 10:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725988409; x=1726593209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RXH2sS5iclmDvWYqk9mvzPNJZ9viOAgQZIm7N1DXqk=;
        b=jTfK0FWdJHOeSZdG1VcLf5nTaxPo+oJAgQcXdRd/nMwggdNgNZB+F6ZVhVZcJaeKk3
         ZUj+YxRBZT5QTlrD+h30jkvkIcfTOMbYe69t9L/TuY/YqFVXl4y7Q0eBg5pjYFKvoZ2z
         RgHEJ402ouB4iobLQPFEf0KV2NX/ba7wKkhrQ2/MNfYZevuJ3Kgsd+o8OQDs80UKSWpm
         hvLEpqf+1IMHhqRuyKt5Ym2BxqFWssyuUO1i92eunQ6upgA6K2Ic0Vr2/ojvadmVNln8
         wxbwguau1YYV4IuGA+TjwGxA01pSPDCvIYe0Lbd1oOvMuLY9hmrhmeCu1DLpuC/mhFAJ
         p5AA==
X-Forwarded-Encrypted: i=1; AJvYcCWDdguyS5mYBnJY4PoWzcReithNcW+b11zxzDOZV1cHwS68IINoOQM2BxGjCldyr4gGrLMV2weaGUds5zW8@vger.kernel.org
X-Gm-Message-State: AOJu0YxLmib/XLWCE38fbg+G19BqcecNv32ZZQX1ZEdrFzWXJDiteo4w
	u+YJOaS+HvzijgeNi7ueK4sFkHQex/YPI6UPpF+eP6m6WVnndcMWPRLGz4ZlfRYMYzp/xL6f9hM
	kLyN3BMHEFZzd7KtB03zccnBjtDs3Hb6NCVaLvgF3LTQ39JL55gO2JgzVMlDxnwSxwZeCPdBDMJ
	SaAu6kEarxjMBaIAiiv1nJ8+PxbYwtjyUL/vSgeg==
X-Received: by 2002:ac2:4e07:0:b0:533:ad6:8119 with SMTP id 2adb3069b0e04-53673b5f064mr172027e87.14.1725988408510;
        Tue, 10 Sep 2024 10:13:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7ySxuNWPQGln69KgqCAVhtOxPzmcFRNPXTjKg1h6ROp6mcK5RDm1KHgp+4i8j7FgQQ7/bGi2Y7FFjJpCceEI=
X-Received: by 2002:ac2:4e07:0:b0:533:ad6:8119 with SMTP id
 2adb3069b0e04-53673b5f064mr172012e87.14.1725988407935; Tue, 10 Sep 2024
 10:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230823213352.1971009-1-aahringo@redhat.com> <20230823213352.1971009-2-aahringo@redhat.com>
 <B38733D3-6F54-42DF-BD5B-716F0200314F@redhat.com> <1490adc3ae3f82968c6112bb6f9df3c3f2229b04.camel@kernel.org>
In-Reply-To: <1490adc3ae3f82968c6112bb6f9df3c3f2229b04.camel@kernel.org>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 10 Sep 2024 13:13:16 -0400
Message-ID: <CAK-6q+g4jgeLRQy5WeUHeKGtT0y_anSO=u6cxWxXFiUuEji=7Q@mail.gmail.com>
Subject: Re: [PATCH 1/7] lockd: introduce safe async lock op
To: Jeff Layton <jlayton@kernel.org>
Cc: Benjamin Coddington <bcodding@redhat.com>, linux-nfs@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	teigland@redhat.com, rpeterso@redhat.com, agruenba@redhat.com, 
	trond.myklebust@hammerspace.com, anna@kernel.org, chuck.lever@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 10, 2024 at 11:45=E2=80=AFAM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Tue, 2024-09-10 at 10:18 -0400, Benjamin Coddington wrote:
> > On 23 Aug 2023, at 17:33, Alexander Aring wrote:
> >
> > > This patch reverts mostly commit 40595cdc93ed ("nfs: block notificati=
on
> > > on fs with its own ->lock") and introduces an EXPORT_OP_SAFE_ASYNC_LO=
CK
> > > export flag to signal that the "own ->lock" implementation supports
> > > async lock requests. The only main user is DLM that is used by GFS2 a=
nd
> > > OCFS2 filesystem. Those implement their own lock() implementation and
> > > return FILE_LOCK_DEFERRED as return value. Since commit 40595cdc93ed
> > > ("nfs: block notification on fs with its own ->lock") the DLM
> > > implementation were never updated. This patch should prepare for DLM
> > > to set the EXPORT_OP_SAFE_ASYNC_LOCK export flag and update the DLM
> > > plock implementation regarding to it.
> > >
> > > Acked-by: Jeff Layton <jlayton@kernel.org>
> > > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > > ---
> > >  fs/lockd/svclock.c       |  5 ++---
> > >  fs/nfsd/nfs4state.c      | 13 ++++++++++---
> > >  include/linux/exportfs.h |  8 ++++++++
> > >  3 files changed, 20 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> > > index c43ccdf28ed9..6e3b230e8317 100644
> > > --- a/fs/lockd/svclock.c
> > > +++ b/fs/lockd/svclock.c
> > > @@ -470,9 +470,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_fi=
le *file,
> > >         struct nlm_host *host, struct nlm_lock *lock, int wait,
> > >         struct nlm_cookie *cookie, int reclaim)
> > >  {
> > > -#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
> > >     struct inode            *inode =3D nlmsvc_file_inode(file);
> > > -#endif
> > >     struct nlm_block        *block =3D NULL;
> > >     int                     error;
> > >     int                     mode;
> > > @@ -486,7 +484,8 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_fi=
le *file,
> > >                             (long long)lock->fl.fl_end,
> > >                             wait);
> > >
> > > -   if (nlmsvc_file_file(file)->f_op->lock) {
> > > +   if (!export_op_support_safe_async_lock(inode->i_sb->s_export_op,
> > > +                                          nlmsvc_file_file(file)->f_=
op)) {
> >
> > ... but don't most filesystem use VFS' posix_lock_file(), which does th=
e
> > right thing?  I think this patch has broken async lock callbacks for NL=
M for
> > all the other filesystems that just use posix_lock_file().
> >
> > Maybe I'm missing something, but why was that necessary?
> >
>
> Good catch. Yeah, I think that probably should have been an &&
> condition. IOW:
>
>         if (nlmsvc_file_file(file)->f_op->lock &&
>             !export_op_support_safe_async_lock(inode->i_sb->s_export_op,
>
> Alex, thoughts?

The question is here if we ever want that posix_lock_file() receives a
posix lock that has flc_flags and the FL_SLEEP set. As mentioned, may
"posix_lock_file()" can just deal with it and will not block?

This patch indeed broke it as posix_lock_file() will never see a lock
request with FL_SLEEP set, but I remembered that nfs is only polling
locks and "probably" never set FL_SLEEP?

Thanks.

- Alex


