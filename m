Return-Path: <linux-fsdevel+bounces-26392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C178E958DE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 20:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811401F23500
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 18:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBB81C37A4;
	Tue, 20 Aug 2024 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5MKs0KG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7831990B5
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724178077; cv=none; b=uFJgFpCT7Gh7sBvHfbtG0QqbxBrwFG7BrLoAbjWDunozHeupaj1fgGfnhJtbB3f2pBQYJchhFTXQxEqRSbe+F/+Vd3FPQgZgG2eIkVj8MjJq1y76J/5TD0pjuJ7PqY2vEpp2YZ6JMJTbYby9sSBL03GA2gfOqAafcie3sRihUeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724178077; c=relaxed/simple;
	bh=tGnKR3EdSCXJUGm0ylQwuAW3GbynvklW/jxSgD8UwCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVotIiJqXaUitW/2I+AVGVslQNa66fbBBmROnfG0MDCQ+JYZBi70OK6Na0vOSGY9zeD2QKjMgttdRE9HWGCeDgujd6bRLDKfqbqBkJwYwKq91gilZkw72ON+5mVkLr+4TFz7W5Inu5cmxsp/ZvjROf3pLUV5iVnvYaqFCxSRfmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5MKs0KG; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-44fe9cf83c7so32629101cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 11:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724178074; x=1724782874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0X0+yqRvCxdbSJzsqCCAhCXIQW9wdQ1IgSaO9uCusc=;
        b=Q5MKs0KGKFsYQC7hGq10t+qTlUgN3xV5WssYE43ms3I0PhBwLCaWch3nEghlHfAxj2
         U2ibwdwHNh31PyMFiHNXrDObSDM05b2dooOpOJQiwTeL3x3jGNvTQJVH+Yr0Dh5hTeVa
         U1BF4bLmTlj/131R2bp/CfgunS09InkmFrRYrwomRyMBcG/cuEHrtP5pLQsV3BYCvPdh
         Qtgtu4KaS3IwLvDCj315QL40WfT4TH7qNwmjLz4SDh1fqj3Ql1f8ZEDLaKPDo8ZSBmba
         U/x+/tllMDAef/zPcfT3Hd7i09jjMssxnY6TOlhRm2VGFsLD0E1t6U4pATZ+SlN4RIyS
         QnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724178074; x=1724782874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0X0+yqRvCxdbSJzsqCCAhCXIQW9wdQ1IgSaO9uCusc=;
        b=HXIj+TdRtRn7tu5u/qq+x4WhHQBu1dwWhSjHiGoZ2e8oZGpAaCfam2RnbirbosxC6B
         RTQXZrj8rGc5trnwcznJXMPcQ6ePb22aMqzoq+f3vZDnYpMIfWEOMPGdl+e5YwBDBJDd
         1BKi5dH8V5SHCsQpt5crH+ZvllbBqhCfl7xKjrnfzP3MV5bLZl1mpoUJLG2glLAtdbgy
         v/LOsuVhd9fyCPKGcS4jH9AytFw2X42WHj4bIXN+fZyMWhEGtmaCBhBKwWTfBMKUDugK
         MgfWlrcTfbQQ+6xAa0Y8PakkyNs/ccldEdwLVer49Gd9pOD5uKuqWwAc5LWdeZVHquu8
         /gxA==
X-Forwarded-Encrypted: i=1; AJvYcCWzYcdE74E6l6wU1lFVAn6sBD0j/ZAJmJHsvXoyIgzQYluVBfbzXf9TTb+9+YkjG4d7EBmYz1ilwuLQOBoBsEmR7xrsGSKbtXyM7pIT5A==
X-Gm-Message-State: AOJu0YyTzgP7x0552y8v5Ao+BC28Cts9nrgCCXLA5Rg2CUw5BPpGfLAT
	/77uScSkuDU92Apg51ckI7XVsImiyWuYFzeNwz/9DHYIZ1xYgpz83SKNj5JFwy7emif9mUXX5Q+
	RsHz0lUUkWjc8QMMGnm/DCq81lH4=
X-Google-Smtp-Source: AGHT+IHiIeFQjCGRuEm64jIL/fS96Pd3qxXG9KaUHEEr/AkbFEtzDbX2ewQNXGwoMhtEbaX/A6jn+r8fgBwdApQtk0o=
X-Received: by 2002:a05:622a:510b:b0:453:1e13:4e88 with SMTP id
 d75a77b69052e-453743acaf2mr179088041cf.39.1724178074305; Tue, 20 Aug 2024
 11:21:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819182417.504672-1-joannelkoong@gmail.com>
 <20240819182417.504672-2-joannelkoong@gmail.com> <b17f0ab0-af46-4d0c-ab4c-44d1ee858c26@linux.alibaba.com>
In-Reply-To: <b17f0ab0-af46-4d0c-ab4c-44d1ee858c26@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 20 Aug 2024 11:21:03 -0700
Message-ID: <CAJnrk1ZbT3MhQS+_2eP2GdEVFJnWRyzb_n82hw6Z+Sxi9a+-Yw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: update stats for pages in dropped aux writeback list
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 7:10=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.c=
om> wrote:
>
>
>
> On 8/20/24 2:24 AM, Joanne Koong wrote:
> > In the case where the aux writeback list is dropped (eg the pages
> > have been truncated or the connection is broken), the stats for
> > its pages and backing device info need to be updated as well.
> >
> > Fixes: e2653bd53a98 ("fuse: fix leaked aux requests")
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/file.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 63fd5fc6872e..7ac56be5fee6 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -1831,10 +1831,11 @@ __acquires(fi->lock)
> >       fuse_writepage_finish(wpa);
> >       spin_unlock(&fi->lock);
> >
> > -     /* After fuse_writepage_finish() aux request list is private */
> > +     /* After rb_erase() aux request list is private */
> >       for (aux =3D wpa->next; aux; aux =3D next) {
> >               next =3D aux->next;
> >               aux->next =3D NULL;
> > +             fuse_writepage_finish(aux);
> >               fuse_writepage_free(aux);
> >       }
> >
>
> LGTM.
>
> Besides, there is similar logic of decreasing stats info for replaced
> aux (temp) request inside fuse_writepage_add(), though without waking up
> fi->page_waitq.
>
> I wonder if we could factor out a new helper function, saying
> fuse_writepage_dec_stat(), which could be called both from
> fuse_writepage_add() and fuse_send_writepage().

This sounds good to me. I'll add this refactoring when I resubmit this
patch series.

Thanks,
Joanne

>
>
> --
> Thanks,
> Jingbo

