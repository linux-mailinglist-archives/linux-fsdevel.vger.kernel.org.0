Return-Path: <linux-fsdevel+bounces-37465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7CB9F2873
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 03:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA63188525E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 02:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9771A270;
	Mon, 16 Dec 2024 02:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GB8euJaX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCE93B19A
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 02:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734315392; cv=none; b=jES8pKkS3iN8t8SIGinaIyCQs0tUNABJbJrEIzvOKQPBycxCONBQ7eSDaIoCVdUnGuPJIfLxE7rsqYSIgrT/GivHAZjjuEISna1f8uN3A3SrXBqXFrIGyH91ABAaksSEXW1w4F9D2mNS2cWXNRKZwbYhpbWPsJXYjt04Il2l0kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734315392; c=relaxed/simple;
	bh=ds0fQUKHOpGTU/56COJ0XEoKzOTyzmm8tLgTer7yQUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0m270mtUPjy9g5th+7OGXZgk0vFQHDOd4KdpRJ/vXmbF2lXarhDr/rHHVKCMI1lzLvGZztnwPOoFsxhXRXKtbPs7iz2P3ZVatFCh5MDhN0EXt917U83zeIIlzjQTDE5i4HDzXmFXU6Dd5/W+hyZcSwqYum6jZF7H3wTy88IQuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GB8euJaX; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-467b086e0easo10722381cf.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Dec 2024 18:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734315389; x=1734920189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kxPfABLbRlik2r7mhRDVgYSjOi3qcj+YxJUcTF/Too=;
        b=GB8euJaXM8AkFEvssScbvqGatD0VuEll9HSI8ukh3IsAlGtBcY7bsJtCrvi0VqZkg4
         JnPARoQBiSonHL7NaN9DNPUmB/ghZyKJqmzqOyyDLKyGyHYWg/CZDyV2iePl3JzaPJxZ
         uD248M4+ZHxK4oooZduclYX18LPE0g3Eyz+kZo6jlfoWl2MS8Za8t8/x/wvdYMZD1jv2
         VvBdRfhAdXlbZjVLZ5VRCEmBZSajvwSywfuoR8o236OvYlPWWoZldA+/TDDrJtbdH9SZ
         JCdlYlFcjBaTVxghKyoNDUOhM7J1nTWouvyPHNsOml/hsjjp2q6tAVeS4yjIKtKiopqW
         CxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734315389; x=1734920189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kxPfABLbRlik2r7mhRDVgYSjOi3qcj+YxJUcTF/Too=;
        b=ngQDFhzx85ySFF+ezlmy2ShY3bIndM7+BLMq3kx/bbNAIvtah0KOwPZdViw0Tql8E3
         I0dwmpE9vCSH6+tM6v6A5NdKDUsf+4LTIbVWN1my/i4TD7D1y4bH+tjT4mefoNDTz519
         6KSkCdEpGoYmpeejEo7roBsQWj5gld6AUPkjj8pB+0/CnwhvM93ql9Y5G/RIVe3CgeUP
         R0fQb2tQUrkDMSLCOXBBA8bGYcAkmsgZ6TDm2Xw5/gQJb7BKLASX0qhnaG8SOD5mEacZ
         ob+Py+OrEJv8GqI25jAnD4j3VfWon9cE0svB2aGT+L2X/p9HlJBpJq7NzZrORTuitxlk
         MffQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc/e4BJH9h3X98b0nyVEqa6KSQdAGeXT0NIM5dOKyTcHLM5Ke6ijmr2QJr9txCRmm9iuo+Dml88AEdwNO4@vger.kernel.org
X-Gm-Message-State: AOJu0YxYO1kD+MPL94+NoOoNSzqtaEprPL2Utp5h9iS/KYQrczr9a0f9
	4+nXd0xMkFn6ckGM83fQJJvea5O5tDGkW3KQqLWN6XD/4zN3fmMo03my03EVDJ3XN/2TD9+l4hX
	8DSPbkO7HOLrfQsG3hd+FfWORJpw=
X-Gm-Gg: ASbGncuM/vwVCzhgpp2sGMlFB+L10g0ijR6cmm2VadBSLgIIL7Xj74NMilSp3ZMJTQN
	MinHAUT9VwFhZ1WZOFzJqCQhrH/4c2yAdWuHLpUg=
X-Google-Smtp-Source: AGHT+IFiIxOlvB8lDyVw/m7sW1RJZ7gKbI3UdUNxukr+1+8wdSz5lf+oCipdcEJsMULkB24xvQwwG1hSi4vHoYxTWfA=
X-Received: by 2002:a05:622a:8f1c:b0:467:73bf:e2ca with SMTP id
 d75a77b69052e-467a582be46mr171901661cf.46.1734315389489; Sun, 15 Dec 2024
 18:16:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214022827.1773071-1-joannelkoong@gmail.com>
 <20241214022827.1773071-2-joannelkoong@gmail.com> <8d0e50812e0141e24855f99b63c3e6d7cb57e7f8.camel@kernel.org>
 <rw7ictyycbqrxuosmr2irzqgtxyfv2pprgvps6tjihbypnxcyc@qqkpoiq65ly3> <b282ea2126d9349ffcbf0682d71684f000fbc091.camel@kernel.org>
In-Reply-To: <b282ea2126d9349ffcbf0682d71684f000fbc091.camel@kernel.org>
From: Etienne Martineau <etmartin4313@gmail.com>
Date: Sun, 15 Dec 2024 21:16:18 -0500
Message-ID: <CAMHPp_RjXKsPmKqYOA+ZAFwyora9FebaqYGWa3y68oYgkv259A@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] fuse: add kernel-enforced timeout option for requests
To: Jeff Layton <jlayton@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	tfiga@chromium.org, bgeffon@google.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 7:08=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Sun, 2024-12-15 at 17:25 +0900, Sergey Senozhatsky wrote:
> > On (24/12/14 07:09), Jeff Layton wrote:
> > > > +void fuse_check_timeout(struct work_struct *work)
> > > > +{
> > > > + struct delayed_work *dwork =3D to_delayed_work(work);
> > > > + struct fuse_conn *fc =3D container_of(dwork, struct fuse_conn,
> > > > +                                     timeout.work);
> > > > + struct fuse_iqueue *fiq =3D &fc->iq;
> > > > + struct fuse_req *req;
> > > > + struct fuse_dev *fud;
> > > > + struct fuse_pqueue *fpq;
> > > > + bool expired =3D false;
> > > > + int i;
> > > > +
> > [..]
> > > > +
> > > > +fpq_abort:
> > > > + spin_unlock(&fpq->lock);
> > > > + spin_unlock(&fc->lock);
> > > > +abort_conn:
> > > > + fuse_abort_conn(fc);
> > > > +}
> > > > +
> > > > @@ -2308,6 +2388,9 @@ void fuse_abort_conn(struct fuse_conn *fc)
> > > >           spin_unlock(&fc->lock);
> > > >
> > > >           end_requests(&to_end);
> > > > +
> > > > +         if (fc->timeout.req_timeout)
> > > > +                 cancel_delayed_work(&fc->timeout.work);
> > >
> > > As Sergey pointed out, this should be a cancel_delayed_work_sync().
> >
> > My worry here is that fuse_abort_conn() can also be called from the
> > deferred work handler, I'm not sure if we can cancel_delayed_work_sync(=
)
> > from within the same WQ context, sounds deadlock-ish:
> >
> > WQ -> fuse_check_timeout() -> fuse_abort_conn() -> cancel_delayed_work_=
sync()
> >
> > When fuse_abort_conn() is called from somewhere else (umount, etc.) the=
n
> > we can safely sync(), but fuse_check_timeout() is different.
> >
>
> Very good point.
>
> > Maybe fuse_abort_conn() can become __fuse_abort_conn(), which
> > fuse_check_timeout() will call directly, for the rest fuse_abort_conn()
> > can be something like:
> >
> >       static void __fuse_abort_conn()
> >       {
> >               ....
> >       }
> >
> >       void fuse_abort_conn()
> >       {
> >               cancel_delayed_work_sync()
> >               __fuse_abort_conn();
> >       }
>
> That seems like a reasonable solution. It already doesn't requeue the
> job when calling fuse_abort_conn(), so that should work.
> --
> Jeff Layton <jlayton@kernel.org>

I'm not sure this is going to work either.
What happens if say fuse_check_timeout() is running and is about to
requeue the work and
at the same time umount->fuse_abort_conn->cancel_delayed_work_sync() comes.
The cancel will correctly wait for the actual work to finish but won't
prevent it from getting
queued again no?
thanks,
Etienne

