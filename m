Return-Path: <linux-fsdevel+bounces-32613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 602099AB662
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 21:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01BD9B23C89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 19:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406EB1CB332;
	Tue, 22 Oct 2024 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="GI2fQ5+Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DE019DF9E
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729623743; cv=none; b=m1jjR79QFvr+okGXrE+RoyccuwdfUkF64zEngFU6qGi+Rl6Jr6iRX7JLHx7zdVK/zwwSS8Q9NkacKkAvFU+PPDnPZLHWadyuN/xICvdudTaQrolGiQMjUBHHgO3SyO2d8WepZz6HJ5wC2nQ5wdOrdznYj8ZJLUvtHX2GkVUzGTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729623743; c=relaxed/simple;
	bh=cipdGQLWeabSJmS+rps5RY9Wx9YIjctQRKwsbU6kEBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQuIqfx2I1aSmKRCFZVNBYUoN2euoMsfMdyXza1tNG9nUQTvBk/g+6vXCAL6n8te2GN7dWeHmyHAcidgVeoam40lEzsrbIVcLEyXfGkjzD5jLTrSwN/SjqJ7Yc8lq3DivqV7ByBheSZU+cXiC1c7xm+jO5+CnuyfxZmlc35zCdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=GI2fQ5+Z; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7183a3f3beaso1180999a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 12:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1729623740; x=1730228540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHkFENIEludgcQYUwWLw1l+x2BOlw4j78pBbvF4jV9w=;
        b=GI2fQ5+ZkG7EWnnEpguP41kPdRbfLCJBARyi9FexOzuQ3zwn2ro/ZNTWOcFB4WKpVQ
         /LN3UFltm8tDPXEn0IjdRj7Mgudn1vwi3zFnEaHq5aCxsxkh/NxbKNctKowArLO+EOct
         9fhR7f9Zp1PDawJ7kd0nSbfGKdnqD0UZMFkxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729623740; x=1730228540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHkFENIEludgcQYUwWLw1l+x2BOlw4j78pBbvF4jV9w=;
        b=TidlOE5qBM7d+9rVriZsiYk2t8xuPHep3K3oTgMlINkdvNW/OHdKChpZxu73yhhpS1
         ftH7ZL4Mb2dWL+GrrGpTOwWK9mVix42+F46WA0fPN4ibkzzXxKY15QAaZ26Si6doRkO4
         bsk5DwcMkSZOf/gJULxJvZis6Fo8otLkMC7J+jrngYtRTEX7Llb5gHiuOgMLozqdMOKg
         ufJnRWg3KhN87NgLM9I/44hgpUz7wF062ApXbW3WNkA/l02SiS1qcQqyNOZr3xRRGL+4
         NodM/2u7w8GdumwwoLLSE/XGkMJfs/i4VNUJP6nCoBhiHktMgOPqMkiotShUojDSJNrl
         SwkA==
X-Forwarded-Encrypted: i=1; AJvYcCX1nV+m8uaZ8nGR4pPNdw5pRRi99HYCDl4QJ2bnQv0yzp3wFLTcDdldn7xcfc/d/PfiQEgDcyiLuC00VEXI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7bOPG7XIMJbunycIdviIeeB//K20nApBn12hB3ir4vvpDEVnu
	lCHzDx7g63g3raVlAE6z97dd1Ckp6w1z8/ND5VYbCnwAp8BBzq4TNiKELTeURq/v03J0uBkQZ20
	DqcUn5Lbdegwt7muH0KbQrvJCOPEQBjCeDQHmSg==
X-Google-Smtp-Source: AGHT+IE3iY0Di4GQ8Yag3rTeVnxdAOts9zvjd9o/85oc2h4spujRgXAdOhjzE7V2+cQ5fyS+ZmLcs+FfMez5dVXNdJo=
X-Received: by 2002:a05:6359:4c90:b0:1bc:2e87:f1a3 with SMTP id
 e5c5f4694b2df-1c39dfecaa3mr682204455d.16.1729623739847; Tue, 22 Oct 2024
 12:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021103340.260731-1-mszeredi@redhat.com> <CAOQ4uxgUaKJXinPyEa0W=7+qK2fJx90G3qXO428G9D=AZuL2fQ@mail.gmail.com>
 <20241021-zuliebe-bildhaft-08cfda736f11@brauner> <CAOQ4uxi-mXSXVvyL4JbfrBCJKnsbV9GeN_jP46SMhs6s7WKNgQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxi-mXSXVvyL4JbfrBCJKnsbV9GeN_jP46SMhs6s7WKNgQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 22 Oct 2024 21:02:08 +0200
Message-ID: <CAJfpegsYanxpkYt9oHdqBuCkxe4p5usSU=u+3rNZZ=T=HmpJug@mail.gmail.com>
Subject: Re: [PATCH v2] backing-file: clean up the API
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Oct 2024 at 20:57, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Oct 21, 2024 at 2:22=E2=80=AFPM Christian Brauner <brauner@kernel=
.org> wrote:
> >
> > On Mon, Oct 21, 2024 at 01:58:16PM +0200, Amir Goldstein wrote:
> > > On Mon, Oct 21, 2024 at 12:33=E2=80=AFPM Miklos Szeredi <mszeredi@red=
hat.com> wrote:
> > > >
> > > >  - Pass iocb to ctx->end_write() instead of file + pos
> > > >
> > > >  - Get rid of ctx->user_file, which is redundant most of the time
> > > >
> > > >  - Instead pass iocb to backing_file_splice_read and
> > > >    backing_file_splice_write
> > > >
> > > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > > > ---
> > > > v2:
> > > >     Pass ioctb to backing_file_splice_{read|write}()
> > > >
> > > > Applies on fuse.git#for-next.
> > >
> > > This looks good to me.
> > > you may add
> > > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > >
> > > However, this conflicts with ovl_real_file() changes on overlayfs-nex=
t
> > > AND on the fixes in fuse.git#for-next, so we will need to collaborate=
.
> > >
> > > Were you planning to send the fuse fixes for the 6.12 cycle?
> > > If so, I could rebase overlayfs-next over 6.12-rcX after fuse fixes
> > > are merged and then apply your patch to overlayfs-next and resolve co=
nflicts.
> >
> > Wouldn't you be able to use a shared branch?
> >
> > If you're able to factor out the backing file changes I could e.g.,
> > provide you with a base branch that I'll merge into vfs.file, you can
> > use either as base to overlayfs and fuse or merge into overlayfs and
> > fuse and fix any potential conflicts. Both works and my PRs all go out
> > earlier than yours anyway.
>
> Yes, but the question remains, whether Miklos wants to send the fuse
> fixes to 6.12-rcX or to 6.13.
> I was under the impression that he was going to send them to 6.12-rcX
> and this patch depends on them.

Yes, the head of the fuse#for-next queue should go to 6.12-rc, the
cleanup should wait for the next merge window.

So after the fixes are in linus tree, both the overlay and fuse trees
can be rebased on top of the shared branch containing the cleanup,
right?

Thanks,
Miklos

